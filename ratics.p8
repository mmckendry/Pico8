pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init()
    engine_mode = { {"lean", 3, selected=false, colour=2}, {"normal", 2, selected=false, colour=2}, {"rich", 1, selected=false, colour=2}}
    pace_mode = {{"conserve", 3, selected=false, colour=3}, {"normal", 2, selected=false, colour=3}, {"push", 1, selected=false, colour=3}}
    tyre_compound = {soft=1.06, medium=1.0, hard=0.97}
    -- pick = flr(rnd(3)) + 1
    engine_select = 2
    pace_select = 2
    display = false
    count = 0
    speed = 0
    base_speed = 10
    fuel = 100
    tyre_wear = 100
    tyre_distance = 0
    engine_distance = 0
    tyre_delay = 0
    engine_delay = 0
    bg_colour = 1
end 

function _update()
x = 0
y = 0


 
should_pit = trigger_pitstop()
change_engine_mode()
change_pace_mode()
speed = calculate_speed(base_speed, engine_mode[engine_select][2], pace_mode[pace_select][2], tyre_compound.medium, tyre_wear)
if (tyre_wear != 0)then 
    tyre_wear = calculate_tyre_wear(tyre_compound.medium)
end
if (fuel != 0)then 
fuel = calculate_fuel_burn()
end
end

function _draw()
cls()
print("speed: " ..speed, x, y, 1)
print("fuel: " ..fuel.." lTR", x, y+8, 1)
print("tyer wear: " ..tyre_wear.."%", x, y+24, 1)
print("should pit: " ..tostring(should_pit), x, y+32, 1)
print("engine mode: " ..engine_mode[engine_select][1], x, y+48, bg_colour)
print("pace mode: " ..pace_mode[pace_select][1], x, y+64, 1)

print("engine lean selected: " ..tostring(engine_mode[1]['selected']), x, y+72, engine_mode[1]['colour'])
print("engine normal selected: " ..tostring(engine_mode[2]['selected']), x, y+80,  engine_mode[2]['colour'])
print("engine rich selected: " ..tostring(engine_mode[3]['selected']), x, y+88,  engine_mode[3]['colour'])

print("pace conserve selected: " ..tostring(pace_mode[1]['selected']), x, y+104, pace_mode[1]['colour'])
print("pace normal selected: " ..tostring(pace_mode[2]['selected']), x, y+112, pace_mode[2]['colour'])
print("pace push selected: " ..tostring(pace_mode[3]['selected']), x, y+120, pace_mode[3]['colour'])

end

function trigger_pitstop()
    if(tyre_wear <= 20 or fuel < 20) then 
     return true
    end
    return false
end

function change_engine_mode() 
    display = true
    local a = 0
   local count = count_simple_table(engine_mode)
    if(btnp(➡️))then
        engine_select += 1
        if (engine_select > count) then 
            engine_select = 1
        end
    end 
        if(btnp(⬅️))then
        engine_select -= 1
        if (engine_select <= 0 ) then 
            engine_select = count
        end
    end 
    for a=1, count do
        engine_mode[a]['selected'] = false
        engine_mode[a]['colour'] = 2
    end
    engine_mode[engine_select]['selected'] = true
    engine_mode[engine_select]['colour'] = 8
end

function change_pace_mode() 
    display = true
    local a = 0
    local count = count_simple_table(pace_mode)
    if(btnp(⬇️))then
        pace_select += 1
        if (pace_select > count) then 
            pace_select = 1
        end
    end 
        if(btnp(⬆️))then
        pace_select -= 1
        if (pace_select <= 0 ) then 
            pace_select = count
        end
    end
        for a=1, count do
        pace_mode[a]['selected'] = false
        pace_mode[a]['colour'] = 3
    end
    pace_mode[pace_select]['selected'] = true 
    pace_mode[pace_select]['colour'] = 11 
end

function calculate_speed(base_speed, engine, pace, compound, tyre_health)
    return base_speed 
            * (engine)
            * (compound)
            * (pace)
            * (tyre_health >= 30 and (0.75 + 0.0025 * tyre_health) or (0.615 + 0.007 * tyre_health))
end

function calculate_fuel_burn()
    engine_delay = interval(engine_delay, engine_mode[engine_select][2], "engine")
    local fuel_burn = engine_distance / 4
    return ceil(100 - fuel_burn)
end

function calculate_tyre_wear(compound)
    tyre_delay = interval(tyre_delay, pace_mode[pace_select][2], "tyre")
    local tyre_wear = compound * tyre_distance / 2 
    return ceil(100 - tyre_wear)
end

function count_simple_table(table)
    local i = 0
    repeat i = i + 1 until 
        table[i] == nil
    return i - 1
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
        if (distance == "tyre") then 
            tyre_distance += 1
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
