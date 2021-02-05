pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
 delay=0
 pitmessage=""
 is_pit_confirmed = false
 pit_initiated = false
 fuel=10
 textlabel = "testing"
 
 function drawtrack()
   map(0,0,0,0,128,32)
 end
 
 function _update()
  move_player()
  userinput()
  pathfinding()
 end
 
 function pitstop_initiate()
  pitmessage = "box box box!"
  pit_initiated = true
  out_of_fuel()
 end
 
 function pitstop_confirm()
 if (pit_initiated) then
  pitmessage = "understood"
  delay = 0
  fuel = 10
   pit_initiated = false
  end 

 end 
 
 function update_pit_message()
 if(delay < 60) then 
  delay += 1
  end
 if(delay >= 60) then
  if is_pit_confirmed == true then
   is_pit_confirmed = false 
   pitmessage = ""
  end
   delay = 0
   if (fuel != 0) then
    fuel -= 1
   end
  end
 end
 
 function _draw()
  cls()
  camera_follow()
  drawtrack()
  spr(0, p.x, p.y)
  update_pit_message()
  display_pit_message()
  display_fuel()
  display_information()
  out_of_fuel()
 end
-->8
--camera follow function
c={}
c.x=-60
c.y=-60

function camera_follow()

 c.x=p.x-60
 c.y=p.y-60

 c.x=mid(0,c.x,896)
 c.y=mid(0,c.y,128)

 camera(c.x,c.y)

end
-->8
-- display 

function display_information()
  print("x: " ..p.x, p.x -50 , p.y -50, 14)
  print("y: "..p.y, p.x-50, p.y-44, 14)
  print("delay:"..delay,p.x-50, p.y-38, 14)
  print("map: "..flag, p.x-50, p.y-26, 14)
  print("fuel: "..fuel, p.x-50, p.y-20, 14)
end

function display_pit_message()
 print(pitmessage, p.x-50, p.y-32, 14)
end 

function display_fuel()
 local x = p.x
 local y = p.y-30

  rectfill(x+63, y, x+65, y-fuel, 11)
  rect(x+62, y, x+66, y-21, 5)
end

textlabel="you are out of fuel"

function hcenter(s)
  return p.x-#s*2
end

function vcenter(s)
  return p.y
end

function out_of_fuel()
  if (fuel == 0) then
   rectfill(p.x-60, p.y-21, p.x+70, p.y+21, 8)
   rectfill(p.x-60, p.y-20, p.x+70, p.y+20, 9)
   print(textlabel,hcenter(textlabel),vcenter(textlabel),8)
  end

end
-->8
-- player 
p={}
p.x=80
p.y=62
p.w=5
p.h=5
p.dx=0
p.dy=0
p.sprite=0

function userinput()
  if btn(4) then
   pitstop_initiate()
  end
  if btn(5) then
   pitstop_confirm()
  end
 end
 
function move_player()
 if (btn(⬅️)) p.dx-=2
 if (btn(➡️)) p.dx+=2
 if (btn(⬆️)) p.dy-=2
 if (btn(⬇️)) p.dy+=2

 if (can_move(p.x+p.dx,p.y,p.w,p.h,fuel)) then
  p.x+=p.dx
 end
 
 if (can_move(p.x,p.y+p.dy,p.w,p.h)) then
  p.y+=p.dy
 end
 
 p.dx,p.dy=0,0
 end
 
 function pathfinding()
 local checkpoint
 
 --travel along x+ (right)
 --if cant move check where i can move 
 --  
 
 end
 
 
-->8
-- collision detection

function can_move(x, y, w, h)
 
 if (fuel == 0) return false

 if (is_solid(x,y)) return false
 
 if (is_solid(x+w,y)) return false
 
 if (is_solid(x,y+h)) return false
 
 if (is_solid(x+w,y+h)) return false

 return true
end

function is_solid(x,y)

 --convert pixel coordinates
 --to map coordinates
 local map_x=flr(x/8)
 local map_y=flr(y/8)
 
 local map_sprite=mget(map_x,map_y)
 
  flag=fget(map_sprite)

 return flag==1
end

__gfx__
007777000008800000aaaa0067777776e888888e677777767700770000000000e888888e0000000066d666d60000000000000000000000000000000000000000
07000070008008000a0000a067777776e888888e677777767700770000000000e888888e00000000dddddddd0000000000000000000000000000000000000000
7000000708000080a000000a67777776e888888e677777760077007700000000e888888e00000000d666d6660000000000000000000000000000000000000000
7007700780088008a00aa00a567777652e8888e25677776500770077000000002e8888e200000000d666d6660000000000000000000000000000000000000000
7007700780088008a00aa00a0566665002eeee2077666600770077000000000072eeee0000000000dddddddd0000000000000000000000000000000000000000
7000000708000080a000000a0000000000000000770077007700770000000000770077000000000066d666d60000000000000000000000000000000000000000
07000070008008000a0000a00000000000000000007700770077007700000000007700770000000066d666d60000000000000000000000000000000000000000
007777000008800000aaaa0000000000000000000077007700770077000000000077007700000000dddddddd0000000000000000000000000000000000000000
00bbbb00000000000000000000000000000000007700770000000000000000007700770000000000000000000000000000000000000000000000000000000000
0b0000b0000000000000000000000000000000007700770000000000000000007700770000000000000000000000000000000000000000000000000000000000
b000000b000000000000000000000000000000000077007700000000000000000000007700000000000000000000000000000000000000000000000000000000
b000000b00000000000000000566665002eeee200566665702eeee200566665002eeee2700000000000000000000000000000000000000000000000000000000
b000000b0000000000000000567777652e8888e2567777652e8888e2e67777652e8888e200000000000000000000000000000000000000000000000000000000
b000000b000000000000000067777776e888888e67777776e888888ee7777776e888888e00000000000000000000000000000000000000000000000000000000
0b0000b0000000000000000067777776e888888e67777776e888888ee7777776e888888e00000000000000000000000000000000000000000000000000000000
00bbbb00000000000000000067777776e888888e67777776e888888ee7777776e888888e00000000000000000000000000000000000000000000000000000000
eee2000000002eee000007760000088e000008e2000002e22e8000002e2000000000000000000000000000000000000000000000000000000000000000000000
888e20000002e888000077760000888e0000888e00002e8ee8880000e8e200000000000000000000000000000000000000000000000000000000000000000000
8888e000000e8888000777760008888e0008888e0002e8888888e000888e20000000000000000000000000000000000000000000000000000000000000000000
8888e000000e8888007777760088888e0088888e002e8888e8888e008888e2000000000000000000000000000000000000000000000000000000000000000000
8888e000000e8888077777760888888e088888e202e888882e88888088888e200000000000000000000000000000000000000000000000000000000000000000
8888e000000e888877777766888888ee88888e202e88888002e888880e8888e20000000000000000000000000000000000000000000000000000000000000000
888e20000002e8887777766588888ee2e888e200e8888800002e888e00e8888e0000000000000000000000000000000700000000000000000000000000000000
eee2000000002eee66666650eeeeee202e8e20002e8e20000002eee200088ee20000000000000000000000000000008e00000000000000000000000000000000
66650000000056660000000000000000000007650000056556700000565000000000000000000000000000007665000000000000000000000000000000000000
7776500000056777000000000000000000007776000056766777000067650000000000000000000000000000e000000000000000000000000000000000000000
7777600000067777000000000000000000077776000567767777700077765000000000000000000000000000e000000000000000000000000000000000000000
777760000006777700002eee00005666007777760056777767777700777765000000000000000000000000002000000000000000000000000000000000000000
77776000000677770002e88800056777077777650567777756777770777776500000000000000000000000000000000000000000000000000000000000000000
7777600000067777000e888800067777777776505677777005677777067777650000000000000000000000000000000000000000000000000000000000000000
7776500000056777000e888800067777677765006777770000567776006777760000000000000000000000000000000000000000000000000000000000000000
6665000000005666000e888800067777567650005666600000056665000776650000000000000000000000000000000000000000000000000000000000000000
__gff__
0000020101010200010001000000000002000001010101010100000000000000010101010101010100000000000000000101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000340403040304030403040304030403040304030403043600000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000024000000000000000000000000000000000000000000000036000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000003400000013141314131413141314131413141314131413000000260000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000240000002500000000000000000000000000000000000000270000003600000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000034000000350000000000000000000000000000000000000000003700000026000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000002400000000040304030403040304030403040304030405040304030400000000030403040304030436000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000340000000000000000000000000000000000000000000006000000000000000000000000000000000031000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000300000000000000000000000000000000000020000000006000000000000000000000000000000000021000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000200000333213141314131413141314131413141314131415141314131413141314131413141300000031000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000300000210000000000000000000000000000000000000000000000000000000000000000000020000021000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000200000310000000000000000000000000000000000000000000000000000000000000000000030000031000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000300000210000000000000000000000000000000000000000000000000000000000000000000020000021000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000200000310000000000000000000000000000000000000000000000000000000000000000000030000031000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000300000210000000000000000000000000000000000000000000000000000000000000000000020000021000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000200000310000000000000000000000000000000000000000000000000000000000000000000030000031000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000300000210000000000000000000000000000000000000000000000000000000000000000000020000021000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000200000310000000000000000000000000000000000000000000000000000000000000000000030000031000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000300000210000000000000000000000000000000000000000000000000000000000000000000020000021000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000200000310000000000000000000000000000000000000000000000000000000000000000000030000031000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000300000000403040304030403040304030403040304030403040304030403040304030403040300000021000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000031000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000021000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000271314131413141314131413141314131413141314131413141314131413141314131413141314131435000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
