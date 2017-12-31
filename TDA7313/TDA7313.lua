local id=0
local dev_addr=0x44

local function set(val)
 i2c.start(id)
 local r=i2c.address(id,dev_addr,i2c.TRANSMITTER)
 i2c.write(id,val)
 i2c.stop(id)
 return r
end

local function sort(m,v)
 local r=false
 if not tonumber(v) then return false end
 v=tonumber(v)
 m=string.lower(m)
 if m=="volume"then
  r=(v<=63 and v>=0)and set(63-v)
 elseif m=="lf"then
  r=(v<=31 and v>=0)and set(128+31-v)
 elseif m=="rf"then
  r=(v<=31 and v>=0)and set(160+31-v)
 elseif m=="lr"then
  r=(v<=31 and v>=0)and set(192+31-v)
 elseif m=="rr" then
  r=(v<=31 and v>=0)and set(224+31-v)
 elseif m=="input" then
  r = (v<=3 and v>=1)and set(79+v)
 elseif m=="bass" then
  if v<=7 and v>=0 then
   r = set(96+v)
  elseif v<=15 and v>=8 then
   r = set(111+8-v)
  end
 elseif m=="treble" then
  if v<=7 and v>=0 then
   r = set(112+v)
  elseif v<=15 and v>=8 then
   r = set(127+8-v)
  end
 end
 return r
end

return function (t)
 local x = ""
 if #t==0 then
  x=t.mode.."="..tostring(sort(t.mode,t.value))
 else
  for i=1,#t do
   x=x..t[i].mode.."="..tostring(sort(t[i].mode,t[i].value))..","
  end
   x=x:sub(0,#x-1)
 end
 return x
end
