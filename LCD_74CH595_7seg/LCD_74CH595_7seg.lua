
local num={
["0"]=192,
["1"]=249,
["2"]=164,
["3"]=176,
["4"]=153,
["5"]=146,
["6"]=130,
["7"]=248,
["8"]=128,
["9"]=144,
["-"]=191,
["_"]=255,
["t"]=135,
["d"]=151
}

local function str_to_tab(str)
local r={}
for S in str:gmatch("(.)") do
r[#r+1]=num[S] and num[S] or 255
end
return r
end

local function set_to_spi(d)
_, _, x = spi.send(1, 0, d)
gpio.write(6,gpio.HIGH)
gpio.write(6,gpio.LOW)
end

return function (str,dir,callback)
str=tostring(str)
if not dir then
str = #str<6 and string.rep("_", 6-#str)..str or str
set_to_spi(str_to_tab(str))
else
if not time_run then
str="______"..str.."______"
local mytimer = tmr.create()
mytimer:register(500, tmr.ALARM_AUTO, function (t)
time_run=true
set_to_spi(str_to_tab(str:sub( 1, 6)))
str = str:sub( 2, #str)
if #str<6 then time_run=nil t:unregister() if callback then callback(true)end end
end)
mytimer:start()
end

end
return "OK"
end
