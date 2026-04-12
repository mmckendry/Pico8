pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

function _init()
	intialise_values()
end

function _update()
	delay_in_seconds(time_value, update_fuel)
	update_posture()
	delay_in_seconds(time_value, generate_random_number)
	
end

function _draw()
	cls()
	print("rat ai")
	display_metrics()
end 

function intialise_values()
	time_value = 0.3
		timer={
		elapsed=0,
		delay = 0
	} 

	fuel = 100
	state = "racing"
	posture = "aggressive"
	is_pitting = false
	random_number = 0
end

function display_metrics()
	print("fuel: " ..fuel, 0, 10, 7)
	print("state: " ..state, 0, 20, 7)
	print("posture: " ..posture, 0, 30, 7)
	print("is pitting: " ..tostring(is_pitting), 0, 40, 7)
	print("random number: " ..random_number, 0, 50, 7)
end

function update_state() 
	state = "pitting"
end

function update_fuel()
	fuel = fuel - 1
end

function update_posture()
	if (fuel <= 50) then
		posture = "conserve"
		update_state()
	end
end

function update_is_pitting()
	if (state == "pitting") then 
		return not is_pitting
	end
end

function generate_random_number() 
	random_number = flr(rnd(4)) + 1 --random number between 1 and 4
end

function delay_in_seconds(time_value, method, arg)
	local seconds = time_value * 30
		print("time elapsed "..timer.elapsed/30)
		if (timer.delay >= seconds) then
			method(arg)
			timer.elapsed = 0
			timer.delay = 0
		end
	timer.delay += 1
	timer.elapsed += 1
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
