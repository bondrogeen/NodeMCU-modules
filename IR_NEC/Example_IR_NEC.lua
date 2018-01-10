t = {
   adr=255,    -- address, 0-255  *optional parameter def=0
   com=12,     -- command, 0-255 or (0x00-0XFF)
   pin=7,      -- out pin ESP
   mode="NEC"
  }
print(dofile("IR_NEC.lua")(t))

t = {
   com=12,  -- 0-4294967295 or 0x00 - 0xFFFFFFFF
   pin=7    -- out pin ESP
  }
print(dofile("IR_NEC.lua")(t))
