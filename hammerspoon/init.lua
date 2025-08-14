-- vim:set foldmethod=marker foldlevel=0:
local alert = require("hs.alert")
local application = require("hs.application")
local caffeinate = require("hs.caffeinate")
local canvas = require("hs.canvas")
local chooser = require("hs.chooser")
local drawing = require("hs.drawing")
local eventtap = require("hs.eventtap")
local geometry = require("hs.geometry")
local hotkey = require("hs.hotkey")
local image = require("hs.image")
local logger = require("hs.logger")
local mouse = require("hs.mouse")
local pasteboard = require("hs.pasteboard")
local screen = require("hs.screen")
local styledtext = require("hs.styledtext")
local timer = require("hs.timer")
local window = require("hs.window")
----------------------

local myLogger = logger.new('MyScript', 'debug')

myLogger.i("MyScript Start")

-- mash = { 'shift', 'ctrl', 'cmd' }
local mash = { 'ctrl', 'option' }
local mash2 = { 'ctrl', 'option', 'shift' }
-- local mash3 = { 'ctrl', 'option' , 'cmd'}
----------------------

-- Utils {{{

local charRange = function(startChar, endChar)
  local range = {}
  for c = string.byte(startChar), string.byte(endChar) do
    table.insert(range, string.char(c))
  end
  return range
end

-- "A", "B", "C", ..., "Z"
local largeAlphabets = charRange("A", "Z")
-- "a", "b", "c", ..., "z"
local smallAlphabets = charRange("a", "z")
-- "0", "1", "2", ..., "9"
local numberChars = charRange("0", "9")

local function camelToTitle(str)
  -- 小文字＋大文字の組み合わせの間にスペースを挿入
  -- "hogeFugaPiyo" -> "Hoge Fuga Piyo"
  -- "fooBar"       -> "Foo Bar"
  -- "HelloWorld"   -> "Hello World"
  local spaced = str:gsub("([a-z])([A-Z])", "%1 %2")
  -- 各単語の先頭を大文字に変換
  local titled = spaced:gsub("(%w)(%w*)", function(first, rest)
    return first:upper() .. rest:lower()
  end)
  return titled
end
-- fuzzy スコア計算
-- query: 検索文字列、target: 候補文字列
-- 戻り値: score (higher better) または nil（マッチしない）
--
-- #query * #target の計算量でDPアルゴリズム使えば最大スコア出せそうだけど
-- 処理が重くなるのが嫌なので、一旦その案は保留
local function fuzzyScore(query, target)
  if query == "" then return 0 end
  local qi = 1
  local score = 0
  local lastPos = 0
  -- 連続した文字にヒットしたときのボーナス
  local contiguousBonus = 3
  -- 1文字目にヒットしたときのボーナス
  local headBonus = 10
  -- 単語の先頭文字(つまり大文字)にヒットしたときのボーナス
  local wordHeadBonus = 5

  for ti = 1, #target do
    if qi <= #query and target:sub(ti, ti):lower() == query:sub(qi, qi):lower() then
      -- 基本点：文字が見つかるたびに +1
      score = score + 1

      -- もし先頭に近ければボーナス
      if ti == 1 then score = score + headBonus end

      -- 単語の先頭(つまり大文字)ならボーナス
      if target:sub(ti, ti) == target:sub(ti, ti):upper() then
        score = score + wordHeadBonus
      end

      -- 連続マッチならさらにボーナス
      if lastPos == ti - 1 then
        score = score + contiguousBonus
      end
      lastPos = ti
      qi = qi + 1
    end
  end

  if qi <= #query then
    return nil -- 全ての query 文字が見つからなかった -> 不一致
  end

  -- 距離ペナルティ（マッチが散らばっているほど減点）
  -- local span = lastPos - (lastPos - (score - (#query + headBonus/1))) -- rough
  -- 最低限のスコアは #query を基準にしておく（ってことでここではそのまま返す）
  return score
end
-- マッチ部分を太字にする（hs.styledtext）
local function highlightMatch(original, query)
  local lowOrig = original:lower()
  local q = query:lower()
  local qi = 1
  local parts = {}
  local acc = ""

  local normalStyle = {
    font = { name = "Menlo", size = 24 },
    color = { hex = "#aaaaaa" },
    paragraphStyle = { minimumLineHeight = 32 },
  }
  local hittedStyle = {
    font = { name = "Menlo-Bold", size = 24 },
    color = { hex = "#e9a326" },
    paragraphStyle = { minimumLineHeight = 32 },
  }

  for i = 1, #original do
    local ch = original:sub(i, i)
    if qi <= #q and lowOrig:sub(i, i) == q:sub(qi, qi) then
      -- flush acc as normal
      if acc ~= "" then
        table.insert(parts, { text = acc, style = normalStyle })
        acc = ""
      end
      -- matched char as bold
      table.insert(parts, {
        text = ch,
        style = hittedStyle,
      })
      qi = qi + 1
    else
      acc = acc .. ch
    end
  end
  if acc ~= "" then table.insert(parts, { text = acc, style = normalStyle }) end

  -- 組み立て
  local styled = styledtext.new("")
  for _, p in ipairs(parts) do
    styled = styled .. styledtext.new(p.text, p.style)
  end
  return styled
end

-- 実際の queryChangedCallback：query が変わるたびに候補を作り直す
local function fuzzyQueryChanged(chooserObj, origChoices, query)
  local q = (query or "")
  local choices = {}

  for _, item in ipairs(origChoices) do
    local target = item.text
    local sc = fuzzyScore(q, target)
    if sc ~= nil then
      table.insert(choices, {
        text = highlightMatch(item.text, q),
        subText = item.subText,
        score = sc,
        raw = item, -- 元データ残す
      })
    end
  end

  -- スコア降順、同スコアならuuid順
  table.sort(choices, function(a, b)
    if a.score == b.score then return a.raw.uuid < b.raw.uuid end
    return a.score > b.score
  end)

  chooserObj:choices(choices)
end

-- }}}
-- Window Operation{{{
window.animationDuration = 0

local moveWindow = function(rect)
  window.focusedWindow():move(rect, nil, true)
end

local moveWindowEdge = function(dx, dy)
  local win = window.focusedWindow()
  local s = win:screen()
  local f = win:frame()
  f = s:toUnitRect(f)

  if f.x + f.w > 0.99 then
    f.x = f.x + dx
    f.w = 1 - f.x
  else
    f.w = f.w + dx
  end

  if f.y + f.h > 0.99 then
    f.y = f.y + dy
    f.h = 1 - f.y
  else
    f.h = f.h + dy
  end

  f = s:fromUnitRect(f)
  win:setFrame(f)
end

local windowLeftHalf = function()
  moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 1.00 })
end

local windowRightHalf = function()
  moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 1.00 })
end

local windowTopHalf = function()
  moveWindow({ x = 0.00, y = 0.00, w = 1.00, h = 0.50 })
end

local windowBottomHalf = function()
  moveWindow({ x = 0.00, y = 0.50, w = 1.00, h = 0.50 })
end

local windowCenterHalf = function()
  moveWindow({ x = 0.25, y = 0.00, w = 0.50, h = 1.00 })
end

local windowFirstThird = function()
  moveWindow({ x = 0.00, y = 0.00, w = 0.33, h = 1.00 })
end

local windowCenterThird = function()
  moveWindow({ x = 0.33, y = 0.00, w = 0.33, h = 1.00 })
end

local windowLastThird = function()
  moveWindow({ x = 0.67, y = 0.00, w = 0.33, h = 1.00 })
end

local windowFirstTwoThirds = function()
  moveWindow({ x = 0.00, y = 0.00, w = 0.67, h = 1.00 })
end

local windowLastTwoThirds = function()
  moveWindow({ x = 0.33, y = 0.00, w = 0.67, h = 1.00 })
end

local windowEdgeLeft = function()
  moveWindowEdge(-0.1, 0)
end

local windowEdgeRight = function()
  moveWindowEdge(0.1, 0)
end

local windowEdgeTop = function()
  moveWindowEdge(0, -0.1)
end

local windowEdgeBottom = function()
  moveWindowEdge(0, 0.1)
end

local windowTopLeft = function()
  moveWindow({ x = 0.00, y = 0.00, w = 0.50, h = 0.50 })
end

local windowTopRight = function()
  moveWindow({ x = 0.50, y = 0.00, w = 0.50, h = 0.50 })
end

local windowBottomLeft = function()
  moveWindow({ x = 0.00, y = 0.50, w = 0.50, h = 0.50 })
end

local windowBottomRight = function()
  moveWindow({ x = 0.50, y = 0.50, w = 0.50, h = 0.50 })
end

local windowMaximize = function()
  moveWindow({ x = 0.00, y = 0.00, w = 1.00, h = 1.00 })
end
-- }}}
-- Mouse Operation{{{
-- local moveMouseRel = function(dx, dy)
--   local p = mouse.getRelativePosition()

--   p.x = p.x + dx
--   p.y = p.y + dy
--   mouse.setRelativePosition(p)
-- end

-- hotkey.bind(mash3, 'l', function() moveMouseRel(15, 0) end)
-- hotkey.bind(mash3, 'h', function() moveMouseRel(-15, 0) end)
-- hotkey.bind(mash3, 'k', function() moveMouseRel(0, -15) end)
-- hotkey.bind(mash3, 'j', function() moveMouseRel(0, 15) end)
-- hotkey.bind(mash3, 'return', function() eventtap.leftClick(mouse.absolutePosition()) end)
-- hotkey.bind(mash3, 'm', function() eventtap.leftClick(mouse.absolutePosition()) end)
-- hotkey.bind(mash3, ',', function() eventtap.middleClick(mouse.absolutePosition()) end)
-- hotkey.bind(mash3, '.', function() eventtap.rightClick(mouse.absolutePosition()) end)

-- hotkey.bind(mash, 'o', function() mouse.setRelativePosition({x = 0.5, y = 0.5}) end)
-- hotkey.bind(mash, 'p', function() mouse.setRelativePosition({x = -10, y = 100}) end)
-- hotkey.bind(mash, 'u', function() moveMouseRel(0, -1) end)
-- hotkey.bind(mash, 'd', function() moveMouseRel(0, 1) end)
-- }}}
-- Grid Click{{{
local gridMode = hotkey.modal.new(nil) -- トリガーキーは 'alt-ctrl + o'

-- スクリーン情報とグリッド設定
local screenFrame = screen.mainScreen():fullFrame()
local overlayCanvas = nil
-- どの文字列が入力されたらどこの座標をクリックするか
local keyMap = {}
local inputBuffer = ""   -- 入力を保持するバッファ
local inputBufferMax = 0 -- 入力を保持するバッファの最大サイズ
local step = 1           -- 何回目のステップか

local grids = {
  -- {
  --   { "AA", "AB", "AC", ..., "AZ", },
  --   { "BA", "BB", "BC", ..., "BZ", },
  --   { "CA", "CB", "CC", ..., "CZ", },
  --   ...
  --   { "ZA", "ZB", "ZZ", ..., "ZZ", },
  -- }
  (function()
    local rows = {}
    for _, rowAlphabet in ipairs(largeAlphabets) do
      local row = {}
      for _, colAlphabet in ipairs(largeAlphabets) do
        table.insert(row, rowAlphabet .. colAlphabet)
      end
      table.insert(rows, row)
    end
    return rows
  end)(),
  {
    { "A", "B", "C", "D", "E", "F", },
    { "G", "H", "I", "J", "K", "L", },
    { "M", "N", "O", "P", "Q", "R", },
  }
}

local unshowGrid = function()
  if overlayCanvas then
    -- overlayCanvas:delete()
    -- overlayCanvas = nil
    overlayCanvas:hide()
  end
  inputBuffer = "" -- バッファをクリア
  inputBufferMax = 0
  keyMap = {}      -- キーマップ初期化
end

-- overlayCanvas, keyMap, inputBufferMax
local cache = {}

local showGrid = function(x, y, w, h, gridIndex)
  local cacheKey = x .. "," .. y .. "," .. w .. "," .. h .. "," .. gridIndex

  if not cache[cacheKey] then
    local grid = grids[gridIndex]
    local gridRows = #grid
    local gridCols = #grid[1]
    local gridSizeY = h / gridRows
    local gridSizeX = w / gridCols

    local newKeyMap = {}
    local newInputBufferMax = 0
    local elements = {}

    for ty = 1, gridRows do
      for tx = 1, gridCols do
        local posX = x + (tx - 1) * gridSizeX
        local posY = y + (ty - 1) * gridSizeY
        local label = grid[ty][tx]
        newInputBufferMax = math.max(newInputBufferMax, #label)

        -- グリッドセルの描画
        table.insert(elements, {
          type = "rectangle",
          action = "stroke",
          strokeColor = { white = 1.0, alpha = 0.5 },
          frame = {
            x = posX,
            y = posY,
            w = gridSizeX,
            h = gridSizeY
          }
        })

        table.insert(elements, {
          type = "text",
          text = label,
          textSize = gridSizeY * 0.75,
          textColor = { white = 1.0, alpha = 0.8 },
          withShadow = true,
          frame = {
            x = posX,
            y = posY,
            w = gridSizeX,
            h = gridSizeY
          },
          textAlignment = "center"
        })

        -- ラベルの描画
        newKeyMap[label] = {
          clickPos = { x = posX + gridSizeX / 2, y = posY + gridSizeY / 2 },
          x = posX,
          y = posY,
          w = gridSizeX,
          h = gridSizeY,
        }
      end
    end

    local newOverlayCanvas = canvas.new(screenFrame)
    newOverlayCanvas:replaceElements(elements)

    cache[cacheKey] = {
      newOverlayCanvas,
      newKeyMap,
      newInputBufferMax,
    }
  end

  overlayCanvas, keyMap, inputBufferMax = table.unpack(cache[cacheKey])
  overlayCanvas:show()
end

-- オーバーレイの表示
function gridMode:entered()
  step = 1
  showGrid(0, 0, screenFrame.w, screenFrame.h, step)
end

-- オーバーレイの非表示
function gridMode:exited()
  unshowGrid()
end

-- キー入力の処理
function gridMode:keyInput(key)
  inputBuffer = inputBuffer .. key
  local cell = keyMap[inputBuffer]
  if cell then
    step = step + 1
    if step <= #grids then
      mouse.absolutePosition(cell.clickPos)
      unshowGrid()
      showGrid(cell.x, cell.y, cell.w, cell.h, step)
    else
      eventtap.leftClick(cell.clickPos) -- 指定座標をクリック
      gridMode:exit()                   -- 操作終了
    end
  elseif #inputBuffer >= inputBufferMax then
    -- 最大サイズまで入力を受けても該当がなければ終了
    gridMode:exit()
  end
end

-- モード中のキー操作
gridMode:bind('', 'escape', function() gridMode:exit() end) -- Escでキャンセル
for _, key in ipairs(largeAlphabets) do
  gridMode:bind('', key, function() gridMode:keyInput(key) end)
end
for _, key in ipairs(numberChars) do
  gridMode:bind('', key, function() gridMode:keyInput(key) end)
end

local mouseGridClick = function() gridMode:enter() end
-- }}}
-- Clipboard History{{{

-- クリップボード履歴を保持するテーブル

local clipboardHistoryChoices = {}

local clipboardChooser = chooser.new(function(choice)
  if choice then
    local origChoice = choice.raw
    pasteboard.setContents(origChoice.text)
    eventtap.keyStroke({ 'cmd' }, 'v')
  end
end)
clipboardChooser:queryChangedCallback(function(query)
  fuzzyQueryChanged(clipboardChooser, clipboardHistoryChoices, query)
end)

-- クリップボード監視
pasteboard.watcher.new(function(content)
  -- myLogger.i(content)
  local timestamp = os.date("%Y-%m-%d %H:%M:%S")
  if content then
    -- if #clipboardHistoryTable == 0 or clipboardHistoryTable[1] ~= content then
    table.insert(clipboardHistoryChoices, 1, { text = content, uuid = timestamp })

    if #clipboardHistoryChoices > 20 then
      table.remove(clipboardHistoryChoices)
    end
    -- end
  end
end):start()

local clipboardHistory = function()
  clipboardChooser:query("")
  clipboardChooser:show()
end
-- }}}
-- Others {{{
local hammerspoonConfigReload = function()
  hs.reload()
end
local sleepMac = function()
  timer.doAfter(0.5, function() caffeinate.systemSleep() end)
end
-- ショートカットよく忘れるので用意
local focusMenuBar = function()
  eventtap.keyStroke({ 'ctrl', 'fn' }, 'f2')
end
local focusDock = function()
  eventtap.keyStroke({ 'ctrl', 'fn' }, 'f3')
end
local showDesktop = function()
  eventtap.keyStroke({ 'fn' }, 'f11')
end
-- }}}
-- Command Palette{{{

local function keyText(mods, key)
  -- キーボードショートカットを見やすいように
  -- Command等のキーを記号表示にする。
  -- アルファベットは大文字にする。

  local text = ""
  if mods and key then
    local keyTextMap = {
      cmd = "\u{2318}",        -- ⌘ Command
      command = "\u{2318}",    -- ⌘ Command
      rightcmd = "\u{2318}",   -- ⌘ Command
      leftcmd = "\u{2318}",    -- ⌘ Command

      shift = "\u{21E7}",      -- ⇧ Shift
      rightshift = "\u{21E7}", -- ⇧ Shift
      leftshift = "\u{21E7}",  -- ⇧ Shift

      option = "\u{2325}",     -- ⌥ Option
      alt = "\u{2325}",        -- ⌥ Option
      rightalt = "\u{2325}",   -- ⌥ Option
      leftalt = "\u{2325}",    -- ⌥ Option

      ctrl = "\u{2303}",       -- ⌃ Control
      control = "\u{2303}",    -- ⌃ Control

      caps = "\u{21EA}",       -- ⇪ Caps Lock

      enter = "\u{21A9}",      -- ↩ Return/Enter
      ["return"] = "\u{21A9}", -- ↩ Return/Enter

      delete = "\u{232B}",     -- ⌫ Delete
      escape = "\u{238B}",     -- ⎋ Escape
    }
    for _, metaKey in ipairs(mods) do
      if keyTextMap[metaKey] then
        text = text .. keyTextMap[metaKey]
      else
        text = text .. metaKey .. " "
      end
    end

    if keyTextMap[key] then
      text = text .. keyTextMap[key]
    else
      text = text .. key:upper()
    end
  end
  return text
end


local commandPaletteCommands = {}
local commandPaletteChoices = {}
local commandChooser = chooser.new(function(choice)
  if not choice then return end
  local origChoice = choice.raw

  if origChoice.uuid then
    commandPaletteCommands[origChoice.uuid].fn()
  end
end)
commandChooser:queryChangedCallback(function(query)
  fuzzyQueryChanged(commandChooser, commandPaletteChoices, query)
end)

-- ホットキーで呼び出し（例：Ctrl + Space）
local commandPalette = function()
  commandChooser:choices(commandPaletteChoices)
  commandChooser:query("")
  commandChooser:show()
end

commandPaletteCommands = {
  -- Window Resize
  windowLeftHalf          = { mods = mash, key = 'h', fn = windowLeftHalf },
  windowRightHalf         = { mods = mash, key = 'l', fn = windowRightHalf },
  windowTopHalf           = { mods = mash, key = 'k', fn = windowTopHalf },
  windowBottomHalf        = { mods = mash, key = 'j', fn = windowBottomHalf },
  windowCenterHalf        = { mods = nil, key = nil, fn = windowCenterHalf },
  windowTopLeft           = { mods = mash, key = '1', fn = windowTopLeft },
  windowTopRight          = { mods = mash, key = '2', fn = windowTopRight },
  windowBottomLeft        = { mods = mash, key = '3', fn = windowBottomLeft },
  windowBottomRight       = { mods = mash, key = '4', fn = windowBottomRight },
  windowFirstThird        = { mods = mash, key = '5', fn = windowFirstThird },
  windowCenterThird       = { mods = mash, key = '6', fn = windowCenterThird },
  windowLastThird         = { mods = mash, key = '7', fn = windowLastThird },
  windowFirstTwoThirds    = { mods = mash, key = '8', fn = windowFirstTwoThirds },
  windowLastTwoThirds     = { mods = mash, key = '9', fn = windowLastTwoThirds },
  windowMaximize          = { mods = mash, key = 'm', fn = windowMaximize },

  -- Window Edge
  windowEdgeLeft          = { mods = mash2, key = 'h', fn = windowEdgeLeft },
  windowEdgeRight         = { mods = mash2, key = 'l', fn = windowEdgeRight },
  windowEdgeTop           = { mods = mash2, key = 'k', fn = windowEdgeTop },
  windowEdgeBottom        = { mods = mash2, key = 'j', fn = windowEdgeBottom },

  -- Grid Click
  mouseGridClick          = { mods = mash, key = 'o', fn = mouseGridClick },

  -- Command Palette
  commandPalette          = { mods = mash, key = 'p', fn = commandPalette },

  -- Clipboard
  clipboardHistory        = { mods = mash, key = 'v', fn = clipboardHistory },

  -- Others
  hammerspoonConfigReload = { mods = mash, key = 'r', fn = hammerspoonConfigReload },
  sleepMac                = { mods = nil, key = nil, fn = sleepMac },
  focusMenuBar            = { mods = nil, key = nil, fn = focusMenuBar },
  focusDock               = { mods = nil, key = nil, fn = focusDock },
  showDesktop             = { mods = nil, key = nil, fn = showDesktop },
}

for name, command in pairs(commandPaletteCommands) do
  local text = camelToTitle(name)
  local totalWidth = 48

  if command.mods and command.key then
    hotkey.bind(command.mods, command.key, command.fn)
    local tmpKeyText = keyText(command.mods, command.key)

    text = text .. string.rep(" ", totalWidth - #text) .. tmpKeyText
  end
  table.insert(commandPaletteChoices, { text = text, uuid = name })
end
-- }}}
-- Dock App Launcher {{{

-- Dockの順番からアプリのバンドルIDを取得
local function getDockAppBundleIDs()
  local output = hs.execute("defaults read com.apple.dock persistent-apps")
  local bundleIDs = {}

  -- persistent-apps の中の _CFURLString をパース
  for appPath in output:gmatch("_CFURLString\" = \"file://(.-)\";") do
    -- URLエンコードをデコード
    local decodedPath = appPath:gsub("%%(%x%x)", function(hex)
      return string.char(tonumber(hex, 16))
    end)
    decodedPath = decodedPath:gsub("/$", "") -- 末尾のスラッシュ除去

    -- バンドルIDを取得
    local info = application.infoForBundlePath(decodedPath)
    if info and info.CFBundleIdentifier then
      table.insert(bundleIDs, info.CFBundleIdentifier)
    end
  end
  return bundleIDs
end


-- 中央にアプリのアイコンを一瞬表示
local function showAppIcon(bundleID)
  local path = application.pathForBundleID(bundleID)
  if not path then return end

  local icon = image.imageFromAppBundle(bundleID)
  if not icon then return end

  local mainScreenFrame = screen.mainScreen():frame()
  local size = 192
  local x = mainScreenFrame.x + (mainScreenFrame.w - size) / 2
  local y = mainScreenFrame.y + (mainScreenFrame.h - size) / 2

  local imageDrawing = drawing.image(geometry.rect(x, y, size, size), icon)
  imageDrawing:setAlpha(0.9)
  imageDrawing:show()

  -- 0.3秒後に削除
  timer.doAfter(0.3, function()
    imageDrawing:delete()
  end)
end

-- DockのアプリのバンドルID配列を取得
local dockBundleIDs = getDockAppBundleIDs()

-- Command+数字にバインド（1〜9）
for i = 1, 9 do
  local bundleID = dockBundleIDs[i]
  if bundleID then
    -- local appPath = application.pathForBundleID(bundleID)
    -- if not appPath then return end
    -- local appName = hs.fs.displayName(appPath)

    local callback = function()
      local app = application.get(bundleID)
      local frontApp = application.frontmostApplication()

      if app then
        if app:bundleID() == frontApp:bundleID() then
          app:hide()
        else
          app:activate()
          showAppIcon(bundleID)
        end
      else
        application.launchOrFocusByBundleID(bundleID)
        showAppIcon(bundleID)
      end
    end
    -- alert(appName)
    -- commandPaletteCommands[appName] = { mods = {'cmd'}, key=tostring(i), fn=callback}
    hotkey.bind({ "cmd" }, tostring(i), callback)
  end
end
-- }}}

----------------------
alert('Hammerspoon Config Loaded')
myLogger.i('MyScript End')
----------------------
