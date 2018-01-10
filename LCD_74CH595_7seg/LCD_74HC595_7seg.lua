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
[" "]=255,
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

local function set_to_spi(p,d)
 _, _, x = spi.send(1, 0, d)
 gpio.write(p,gpio.HIGH)
 gpio.write(p,gpio.LOW)
end

return function (t,callback)
 local str, st, qty, time  = tostring(t.str), t.st, t.qty, t.time
 if not t.shift then
  str = #str<qty and string.rep(" ", qty-#str)..str or str
  set_to_spi(st,str_to_tab(str))
 else
  if not time_run then
   str=string.rep(" ",qty)..str..string.rep(" ",qty)
   local mytimer = tmr.create()
   mytimer:register(time or 500, tmr.ALARM_AUTO, function (t)
    time_run=true
    set_to_spi(st,str_to_tab(str:sub(1,qty)))
    str = str:sub(2,#str)
    if #str<qty then time_run=nil t:unregister() if callback then callback(true)end end
   end)
   mytimer:start()
  end
 end
 return "OK"
end
