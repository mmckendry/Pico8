pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init() 
    screenwidth=127
    screenheight=127
    scene = 1
    fuel = 100
    refuel_trigger = false
    engine_distance = 0
    engine_delay = 0
end

function _update()
    fuel = calculate_fuel_burn()
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
    display_scene(title, message,15,8)   
    handle_fuel_trigger()
    print("fuel: " ..fuel.." ltrs", 10, 10, 8)
    if(btnp(🅾️)) then 
    scene = 1
  end 
end

function handle_fuel_trigger()
    local up_buttton_colour = 8
    local down_button_colour = 8
    
    if refuel_trigger then 
        up_buttton_colour = 9
        if btnp(⬆️) then
            refuel_trigger = toggle()
        end
    elseif not refuel_trigger then 
        down_button_colour = 9
        if btnp(⬇️) then 
            refuel_trigger = toggle()
        end
    end 
    
    print("⬆️", 60, 60, up_buttton_colour)
    print("⬇️", 60, 70, down_button_colour)
end

function toggle()
    return not refuel_trigger
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

function calculate_fuel_burn()
  engine_delay = interval(engine_delay, 0.5, "engine")
  local fuel_burn = engine_distance / 4
  return ceil(100 - fuel_burn)
end

function interval(delay_arg, modifier, distance)
  local time = modifier * 5
  if(delay_arg<time)then 
      delay_arg+=1
  end
  if(delay_arg>=time)then
    delay_arg=0
    if (distance == "engine") then 
      engine_distance += 1
    end
  end
  return delay_arg
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
