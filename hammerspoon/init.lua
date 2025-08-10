-- vim:set foldmethod=marker foldlevel=0:

local canvas = require "hs.canvas"
local eventtap = require "hs.eventtap"

local logger = hs.logger.new('MyScript', 'debug')
logger.i("MyScript Start")

-- mash = { 'shift', 'ctrl', 'cmd' }
local mash = { 'ctrl', 'option' }
local mash2 = { 'ctrl', 'option' , 'shift'}
local mash3 = { 'ctrl', 'option' , 'cmd'}

-- Window Operation{{{
hs.window.animationDuration = 0

local moveWindowEdge = function(dx, dy)
  local win = hs.window.focusedWindow()
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
  hs.window.focusedWindow():move({ x = 0.00, y = 0.00, w = 0.50, h = 1.00 }, nil, true)
end

local windowRightHalf = function()
  hs.window.focusedWindow():move({ x = 0.50, y = 0.00, w = 0.50, h = 1.00 }, nil, true)
end

local windowTopHalf = function()
  hs.window.focusedWindow():move({ x = 0.00, y = 0.00, w = 1.00, h = 0.50 }, nil, true)
end

local windowBottomHalf = function()
  hs.window.focusedWindow():move({ x = 0.00, y = 0.50, w = 1.00, h = 0.50 }, nil, true)
end

local windowCenterHalf = function()
  hs.window.focusedWindow():move({ x = 0.25, y = 0.00, w = 0.50, h = 1.00 }, nil, true)
end

local windowFirstThird = function()
  hs.window.focusedWindow():move({ x = 0.00, y = 0.00, w = 0.33, h = 1.00 }, nil, true)
end

local windowCenterThird = function()
  hs.window.focusedWindow():move({ x = 0.33, y = 0.00, w = 0.33, h = 1.00 }, nil, true)
end

local windowLastThird = function()
  hs.window.focusedWindow():move({ x = 0.67, y = 0.00, w = 0.33, h = 1.00 }, nil, true)
end

local windowFirstTwoThirds = function()
  hs.window.focusedWindow():move({ x = 0.00, y = 0.00, w = 0.67, h = 1.00 }, nil, true)
end

local windowLastTwoThirds = function()
  hs.window.focusedWindow():move({ x = 0.33, y = 0.00, w = 0.67, h = 1.00 }, nil, true)
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
  hs.window.focusedWindow():move({ x = 0.00, y = 0.00, w = 0.50, h = 0.50 }, nil, true)
end

local windowTopRight = function()
  hs.window.focusedWindow():move({ x = 0.50, y = 0.00, w = 0.50, h = 0.50 }, nil, true)
end

local windowBottomLeft = function()
  hs.window.focusedWindow():move({ x = 0.00, y = 0.50, w = 0.50, h = 0.50 }, nil, true)
end

local windowBottomRight = function()
  hs.window.focusedWindow():move({ x = 0.50, y = 0.50, w = 0.50, h = 0.50 }, nil, true)
end

local windowMaximize = function()
  hs.window.focusedWindow():move({ x = 0.00, y = 0.00, w = 1.00, h = 1.00 }, nil, true)
end
-- }}}
-- Mouse Operation{{{
-- local moveMouseRel = function(dx, dy)
--   local p = hs.mouse.getRelativePosition()

--   p.x = p.x + dx
--   p.y = p.y + dy
--   hs.mouse.setRelativePosition(p)
-- end

-- hs.hotkey.bind(mash3, 'l', function() moveMouseRel(15, 0) end)
-- hs.hotkey.bind(mash3, 'h', function() moveMouseRel(-15, 0) end)
-- hs.hotkey.bind(mash3, 'k', function() moveMouseRel(0, -15) end)
-- hs.hotkey.bind(mash3, 'j', function() moveMouseRel(0, 15) end)
-- hs.hotkey.bind(mash3, 'return', function() eventtap.leftClick(hs.mouse.absolutePosition()) end)
-- hs.hotkey.bind(mash3, 'm', function() eventtap.leftClick(hs.mouse.absolutePosition()) end)
-- hs.hotkey.bind(mash3, ',', function() eventtap.middleClick(hs.mouse.absolutePosition()) end)
-- hs.hotkey.bind(mash3, '.', function() eventtap.rightClick(hs.mouse.absolutePosition()) end)

-- hs.hotkey.bind(mash, 'o', function() hs.mouse.setRelativePosition({x = 0.5, y = 0.5}) end)
-- hs.hotkey.bind(mash, 'p', function() hs.mouse.setRelativePosition({x = -10, y = 100}) end)
-- hs.hotkey.bind(mash, 'u', function() moveMouseRel(0, -1) end)
-- hs.hotkey.bind(mash, 'd', function() moveMouseRel(0, 1) end)
-- }}}
-- Grid Click{{{
local gridMode = hs.hotkey.modal.new(nil) -- トリガーキーは 'alt-ctrl + o'

-- スクリーン情報とグリッド設定
local screenFrame = hs.screen.mainScreen():fullFrame()
local overlayCanvas = nil
-- どの文字列が入力されたらどこの座標をクリックするか
local keyMap = {}
local inputBuffer = "" -- 入力を保持するバッファ
local inputBufferMax = 0 -- 入力を保持するバッファの最大サイズ
local step = 1 -- 何回目のステップか

local grids = {
  {
    {"AA", "AB", "AC", "AD", "AE", "AF", "AG", "AH", "AI", "AJ", "AL", "AK", "AM", "AN", "AO", "AP", "AQ", "AR", "AS", "AT", "AU", "AV", "AW", "AX", "AY", "AZ",},
    {"BA", "BB", "BC", "BD", "BE", "BF", "BG", "BH", "BI", "BJ", "BL", "BK", "BM", "BN", "BO", "BP", "BQ", "BR", "BS", "BT", "BU", "BV", "BW", "BX", "BY", "BZ",},
    {"CA", "CB", "CC", "CD", "CE", "CF", "CG", "CH", "CI", "CJ", "CL", "CK", "CM", "CN", "CO", "CP", "CQ", "CR", "CS", "CT", "CU", "CV", "CW", "CX", "CY", "CZ",},
    {"DA", "DB", "DC", "DD", "DE", "DF", "DG", "DH", "DI", "DJ", "DL", "DK", "DM", "DN", "DO", "DP", "DQ", "DR", "DS", "DT", "DU", "DV", "DW", "DX", "DY", "DZ",},
    {"EA", "EB", "EC", "ED", "EE", "EF", "EG", "EH", "EI", "EJ", "EL", "EK", "EM", "EN", "EO", "EP", "EQ", "ER", "ES", "ET", "EU", "EV", "EW", "EX", "EY", "EZ",},
    {"FA", "FB", "FC", "FD", "FE", "FF", "FG", "FH", "FI", "FJ", "FL", "FK", "FM", "FN", "FO", "FP", "FQ", "FR", "FS", "FT", "FU", "FV", "FW", "FX", "FY", "FZ",},
    {"GA", "GB", "GC", "GD", "GE", "GF", "GG", "GH", "GI", "GJ", "GL", "GK", "GM", "GN", "GO", "GP", "GQ", "GR", "GS", "GT", "GU", "GV", "GW", "GX", "GY", "GZ",},
    {"HA", "HB", "HC", "HD", "HE", "HF", "HG", "HH", "HI", "HJ", "HL", "HK", "HM", "HN", "HO", "HP", "HQ", "HR", "HS", "HT", "HU", "HV", "HW", "HX", "HY", "HZ",},
    {"IA", "IB", "IC", "ID", "IE", "IF", "IG", "IH", "II", "IJ", "IL", "IK", "IM", "IN", "IO", "IP", "IQ", "IR", "IS", "IT", "IU", "IV", "IW", "IX", "IY", "IZ",},
    {"JA", "JB", "JC", "JD", "JE", "JF", "JG", "JH", "JI", "JJ", "JL", "JK", "JM", "JN", "JO", "JP", "JQ", "JR", "JS", "JT", "JU", "JV", "JW", "JX", "JY", "JZ",},
    {"LA", "LB", "LC", "LD", "LE", "LF", "LG", "LH", "LI", "LJ", "LL", "LK", "LM", "LN", "LO", "LP", "LQ", "LR", "LS", "LT", "LU", "LV", "LW", "LX", "LY", "LZ",},
    {"KA", "KB", "KC", "KD", "KE", "KF", "KG", "KH", "KI", "KJ", "KL", "KK", "KM", "KN", "KO", "KP", "KQ", "KR", "KS", "KT", "KU", "KV", "KW", "KX", "KY", "KZ",},
    {"MA", "MB", "MC", "MD", "ME", "MF", "MG", "MH", "MI", "MJ", "ML", "MK", "MM", "MN", "MO", "MP", "MQ", "MR", "MS", "MT", "MU", "MV", "MW", "MX", "MY", "MZ",},
    {"NA", "NB", "NC", "ND", "NE", "NF", "NG", "NH", "NI", "NJ", "NL", "NK", "NM", "NN", "NO", "NP", "NQ", "NR", "NS", "NT", "NU", "NV", "NW", "NX", "NY", "NZ",},
    {"OA", "OB", "OC", "OD", "OE", "OF", "OG", "OH", "OI", "OJ", "OL", "OK", "OM", "ON", "OO", "OP", "OQ", "OR", "OS", "OT", "OU", "OV", "OW", "OX", "OY", "OZ",},
    {"PA", "PB", "PC", "PD", "PE", "PF", "PG", "PH", "PI", "PJ", "PL", "PK", "PM", "PN", "PO", "PP", "PQ", "PR", "PS", "PT", "PU", "PV", "PW", "PX", "PY", "PZ",},
    {"QA", "QB", "QC", "QD", "QE", "QF", "QG", "QH", "QI", "QJ", "QL", "QK", "QM", "QN", "QO", "QP", "QQ", "QR", "QS", "QT", "QU", "QV", "QW", "QX", "QY", "QZ",},
    {"RA", "RB", "RC", "RD", "RE", "RF", "RG", "RH", "RI", "RJ", "RL", "RK", "RM", "RN", "RO", "RP", "RQ", "RR", "RS", "RT", "RU", "RV", "RW", "RX", "RY", "RZ",},
    {"SA", "SB", "SC", "SD", "SE", "SF", "SG", "SH", "SI", "SJ", "SL", "SK", "SM", "SN", "SO", "SP", "SQ", "SR", "SS", "ST", "SU", "SV", "SW", "SX", "SY", "SZ",},
    {"TA", "TB", "TC", "TD", "TE", "TF", "TG", "TH", "TI", "TJ", "TL", "TK", "TM", "TN", "TO", "TP", "TQ", "TR", "TS", "TT", "TU", "TV", "TW", "TX", "TY", "TZ",},
    {"UA", "UB", "UC", "UD", "UE", "UF", "UG", "UH", "UI", "UJ", "UL", "UK", "UM", "UN", "UO", "UP", "UQ", "UR", "US", "UT", "UU", "UV", "UW", "UX", "UY", "UZ",},
    {"VA", "VB", "VC", "VD", "VE", "VF", "VG", "VH", "VI", "VJ", "VL", "VK", "VM", "VN", "VO", "VP", "VQ", "VR", "VS", "VT", "VU", "VV", "VW", "VX", "VY", "VZ",},
    {"WA", "WB", "WC", "WD", "WE", "WF", "WG", "WH", "WI", "WJ", "WL", "WK", "WM", "WN", "WO", "WP", "WQ", "WR", "WS", "WT", "WU", "WV", "WW", "WX", "WY", "WZ",},
    {"XA", "XB", "XC", "XD", "XE", "XF", "XG", "XH", "XI", "XJ", "XL", "XK", "XM", "XN", "XO", "XP", "XQ", "XR", "XS", "XT", "XU", "XV", "XW", "XX", "XY", "XZ",},
    {"YA", "YB", "YC", "YD", "YE", "YF", "YG", "YH", "YI", "YJ", "YL", "YK", "YM", "YN", "YO", "YP", "YQ", "YR", "YS", "YT", "YU", "YV", "YW", "YX", "YY", "YZ",},
    {"ZA", "ZB", "ZC", "ZD", "ZE", "ZF", "ZG", "ZH", "ZI", "ZJ", "ZL", "ZK", "ZM", "ZN", "ZO", "ZP", "ZQ", "ZR", "ZS", "ZT", "ZU", "ZV", "ZW", "ZX", "ZY", "ZZ",},
  },
  {
    {"A", "B", "C", "D", "E", "F",},
    {"G", "H", "I", "J", "K", "L",},
    {"M", "N", "O", "P", "Q", "R",},
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
  keyMap = {} -- キーマップ初期化
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
          hs.mouse.absolutePosition(cell.clickPos)
          unshowGrid()
          showGrid(cell.x, cell.y, cell.w, cell.h, step)
        else
          eventtap.leftClick(cell.clickPos) -- 指定座標をクリック
          gridMode:exit() -- 操作終了
        end
    elseif #inputBuffer >= inputBufferMax then
      -- 最大サイズまで入力を受けても該当がなければ終了
      gridMode:exit()
    end
end

-- モード中のキー操作
gridMode:bind('', 'escape', function() gridMode:exit() end) -- Escでキャンセル
for j = 0, 25 do
    local key = string.char(65 + j) -- A-Z
    gridMode:bind('', key, function() gridMode:keyInput(key) end)
end
for j = 0, 9 do
    local key = string.char(48 + j) -- 0-9
    gridMode:bind('', key, function() gridMode:keyInput(key) end)
end

local mouseGridClick = function() gridMode:enter() end
-- }}}
-- Clipboard History{{{
local function camelToTitle(str)
    -- 小文字＋大文字の組み合わせの間にスペースを挿入
    local spaced = str:gsub("([a-z])([A-Z])", "%1 %2")
    -- 各単語の先頭を大文字に変換
    local titled = spaced:gsub("(%w)(%w*)", function(first, rest)
        return first:upper() .. rest:lower()
    end)
    return titled
end

-- -- 動作確認
-- print(camelToTitle("hogeFugaPiyo")) -- "Hoge Fuga Piyo"
-- print(camelToTitle("fooBar"))       -- "Foo Bar"
-- print(camelToTitle("HelloWorld"))   -- "Hello World"
-- クリップボード履歴を保持するテーブル

local clipboardHistoryTable = {}


local clipboardChooser = hs.chooser.new(function(choice)
    if not choice then return end
    if choice.text then
        hs.pasteboard.setContents(choice.text)
    end
end)

clipboardChooser:choices(commands)

-- クリップボード監視
hs.pasteboard.watcher.new(function(changeType)
  if changeType then
    local content = hs.pasteboard.getContents()
    if content then
      table.insert(clipboardHistoryTable, 1, { text = content })
      if #clipboardHistoryTable > 20 then
        table.remove(clipboardHistoryTable, 21)
      end
    end
    clipboardChooser:choices(clipboardHistoryTable)
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
  hs.timer.doAfter(0.5, function() hs.caffeinate.systemSleep() end)
end
-- }}}
-- Command Palette{{{

local commands = {}
local choices = {}
local commandChooser = hs.chooser.new(function(choice)
    if not choice then return end

    if choice.uuid then
      commands[choice.uuid].fn()
    end
end)

-- ホットキーで呼び出し（例：Ctrl + Space）
local commandPalette = function()
  commandChooser:query("")
  commandChooser:show()
end

commands = {
  -- Window Resize
  windowLeftHalf          = {mods = mash, key = 'h', fn = windowLeftHalf},
  windowRightHalf         = {mods = mash, key = 'l', fn = windowRightHalf},
  windowTopHalf           = {mods = mash, key = 'k', fn = windowTopHalf},
  windowBottomHalf        = {mods = mash, key = 'j', fn = windowBottomHalf},
  windowTopLeft           = {mods = mash, key = '1', fn = windowTopLeft},
  windowTopRight          = {mods = mash, key = '2', fn = windowTopRight},
  windowBottomLeft        = {mods = mash, key = '3', fn = windowBottomLeft},
  windowBottomRight       = {mods = mash, key = '4', fn = windowBottomRight},
  windowFirstThird        = {mods = mash, key = '5', fn = windowFirstThird},
  windowCenterThird       = {mods = mash, key = '6', fn = windowCenterThird},
  windowLastThird         = {mods = mash, key = '7', fn = windowLastThird},
  windowFirstTwoThirds    = {mods = mash, key = '8', fn = windowFirstTwoThirds},
  windowLastTwoThirds     = {mods = mash, key = '9', fn = windowLastTwoThirds},
  windowMaximize          = {mods = mash, key = 'm', fn = windowMaximize},

  -- Window Edge
  windowEdgeLeft          = {mods = mash2, key = 'h', fn = windowEdgeLeft},
  windowEdgeRight         = {mods = mash2, key = 'l', fn = windowEdgeRight},
  windowEdgeTop           = {mods = mash2, key = 'k', fn = windowEdgeTop},
  windowEdgeBottom        = {mods = mash2, key = 'j', fn = windowEdgeBottom},

  -- Grid Click
  mouseGridClick          = {mods = mash, key = 'o', fn = mouseGridClick},

  -- Command Palette
  commandPalette          = {mods = mash, key = 'p', fn = commandPalette},

  -- Clipboard
  clipboardHistory        = {mods = mash, key = 'v', fn = clipboardHistory},

  -- Others
  hammerspoonConfigReload = {mods = mash, key = 'r', fn = hammerspoonConfigReload},
  sleepMac                = {mods = nil, key = nil, fn = sleepMac},
}

for name, command in pairs(commands) do
  local subText = nil
  if command.mods and command.key then
    hs.hotkey.bind(command.mods, command.key, command.fn)
    subText = table.concat(command.mods, " ") .. " " .. command.key
  end
  table.insert(choices, {text = camelToTitle(name), subText = subText, uuid = name})
end

commandChooser:choices(choices)
-- }}}
hs.alert("Hammerspoon Config Loaded")
logger.i("MyScript End")
