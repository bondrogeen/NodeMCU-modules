
local id=0
local dev_addr=0x68
local t={"sec","min","hour","day","date","month","year"}

local function bcdToDec(val)
  return((((val/16) - ((val/16)%1)) *10) + (val%16))
end

local function decToBcd(val)
  if val == nil then return 0 end
  return((((val/10) - ((val/10)%1)) *16) + (val%10))
end

local function read(byte,len)
  i2c.start(id)
  i2c.address(id, dev_addr, i2c.TRANSMITTER)
  i2c.write(id, byte)
  i2c.stop(id)
  i2c.start(id)
  i2c.address(id, dev_addr, i2c.RECEIVER)
  local c=i2c.read(0, len)
  i2c.stop(id)
  return c
end

local function set_time(data)
  i2c.start(id)
  local r=i2c.address(id, dev_addr, i2c.TRANSMITTER)
  i2c.write(id, 0x00)
  for i = 1, 7 do
   i2c.write(id, decToBcd(data[t[i]]))
  end
  i2c.stop(id)
  return r
end

local function get_time()
  local c = read(0x00,7)
  local date = {}
  for i = 1, 7 do
   date[t[i]] = bcdToDec(tonumber(string.byte(c, i)))
  end
  return date
end

local function get_temp()
  local c = read(0x11,2)
  return string.byte(c,1)
end

return function (res)
local r
if res.init=="get" then
r=get_time()
elseif res.init=="temp"then
r=get_temp()
elseif res.init=="set" then
r=set_time(res)
end
return r
end
