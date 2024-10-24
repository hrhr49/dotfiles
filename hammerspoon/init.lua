hs.window.animationDuration = 0
units = {
  right30     = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
  right50     = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  right70     = { x = 0.30, y = 0.00, w = 0.70, h = 1.00 },
  left70      = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
  left50      = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  left30      = { x = 0.00, y = 0.00, w = 0.30, h = 1.00 },
  top50       = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50       = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  bottomright = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  topright    = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  bottomleft  = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  topleft     = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  maximum     = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 },
  centered    = { x = 0.25, y = 0.00, w = 0.50, h = 1.00 }
}

moveWindowAbs = function(unit)
  hs.window.focusedWindow():move(units, nil, true)
end

moveWindowBoundary = function(dx, dy)
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

moveMouseRel = function(dx, dy)
  local p = hs.mouse.getRelativePosition()

  p.x = p.x + dx
  p.y = p.y + dy
  hs.mouse.setRelativePosition(p)
end

-- mash = { 'shift', 'ctrl', 'cmd' }
mash = { 'ctrl', 'option' }
mash2 = { 'ctrl', 'option' , 'shift'}
mash3 = { 'ctrl', 'option' , 'cmd'}

hs.hotkey.bind(mash, 'l', function() hs.window.focusedWindow():move(units.right50, nil, true) end)
hs.hotkey.bind(mash, 'h', function() hs.window.focusedWindow():move(units.left50, nil, true) end)
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():move(units.top50, nil, true) end)
hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():move(units.bot50, nil, true) end)

-- hs.hotkey.bind(mash2, 'l', function() hs.window.focusedWindow():move(units.right30, nil, true) end)
-- hs.hotkey.bind(mash2, 'h', function() hs.window.focusedWindow():move(units.left30, nil, true) end)
-- hs.hotkey.bind(mash2, 'k', function() hs.window.focusedWindow():move(units.top30, nil, true) end)
-- hs.hotkey.bind(mash2, 'j', function() hs.window.focusedWindow():move(units.bot30, nil, true) end)

hs.hotkey.bind(mash2, 'l', function() moveWindowBoundary(0.1, 0) end)
hs.hotkey.bind(mash2, 'h', function() moveWindowBoundary(-0.1, 0) end)
hs.hotkey.bind(mash2, 'k', function() moveWindowBoundary(0, -0.1) end)
hs.hotkey.bind(mash2, 'j', function() moveWindowBoundary(0, 0.1) end)

hs.hotkey.bind(mash3, 'l', function() hs.window.focusedWindow():move(units.right70, nil, true) end)
hs.hotkey.bind(mash3, 'h', function() hs.window.focusedWindow():move(units.left70, nil, true) end)
hs.hotkey.bind(mash3, 'k', function() hs.window.focusedWindow():move(units.top70, nil, true) end)
hs.hotkey.bind(mash3, 'j', function() hs.window.focusedWindow():move(units.bot70, nil, true) end)

-- hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():sendToBack() end)
--
hs.hotkey.bind(mash, 'o', function() hs.mouse.setRelativePosition({x = 0.5, y = 0.5}) end)
hs.hotkey.bind(mash, 'p', function() hs.mouse.setRelativePosition({x = -10, y = 100}) end)
-- hs.hotkey.bind(mash, 'u', function() moveMouseRel(0, -1) end)
hs.hotkey.bind(mash, 'u', function() resizeWindowRel(10, -10) end)
-- hs.hotkey.bind(mash, 'd', function() moveMouseRel(0, 1) end)

hs.hotkey.bind(mash, '1', function() hs.window.focusedWindow():move(units.topleft, nil, true) end)
hs.hotkey.bind(mash, '2', function() hs.window.focusedWindow():move(units.topright, nil, true) end)
hs.hotkey.bind(mash, '3', function() hs.window.focusedWindow():move(units.bottomleft, nil, true) end)
hs.hotkey.bind(mash, '4', function() hs.window.focusedWindow():move(units.bottomright, nil, true) end)

-- hs.hotkey.bind(mash, 'c', function() hs.window.focusedWindow():move(units.centered, nil, true) end)
hs.hotkey.bind(mash, 'm', function() hs.window.focusedWindow():move(units.maximum, nil, true) end)


hs.hotkey.bind(mash, 'r', function()
  hs.reload()
  -- hs.alert.show('Config loaded')
  hs.notify.show('Config loaded', '', '', '')
end)

-- https://github.com/Hammerspoon/Spoons/blob/master/Source/AppLauncher.spoon/init.lua#L33
-- hs.hotkey.bind(mash, '9', function()
--   hs.application.launchOrFocus('Google Chrome')
-- end)

switcher = hs.window.switcher.new()
hs.hotkey.bind(mash, 'tab', '', function()
  switcher:next()
end)



hs.hotkey.bind(mash, 'a', '', function()
  local table = hs.spaces.allSpaces()
  hs.alert.show('hello')
  hs.alert.show(#table)
  for key, value in pairs(table) do
    hs.alert.show(key)
  end
  hs.alert.show(hs.spaces.focusedSpace())
end)
