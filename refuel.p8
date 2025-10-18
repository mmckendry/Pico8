pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init() 
  screenwidth=127
  screenheight=127
  scene = 1
end
function _update()
end
function _draw()
    cls()
    if(scene == 1) then 
        title_draw()
    end
    if(scene == 2) then 
        scene_draw()
    end
end
function _update60()
end

function title_draw()
  local title="refuel"
  local message="pump the fuel!"
  display_scene(title, message,9,8)
  if(btnp(❎)) then 
    scene = 2
  end 
end

function scene_draw()
    local title="now"
    local message="the pressure is on!"
    display_scene(title, message,9,8)
    if(btnp(🅾️)) then 
    scene = 1
  end 
end

function display_scene(title,message,fg_colour,bg_colour)
  rectfill(0,0,screenwidth,screenheight,fg_colour)
  print(title,hcenter(title),vcenter(screenheight),bg_colour)
  print(message,hcenter(message),(vcenter(screenheight))+(screenheight/2),bg_colour)
end

function hcenter(s)
  return (screenwidth/2)-flr((#s*4)/2)
end

function vcenter(s)
  return (screenheight/4)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
