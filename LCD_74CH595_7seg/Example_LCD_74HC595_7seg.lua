t={
st=6,        -- pin ESP for 74HC595 (latch)
qty=6,       -- quantity 7seg
str="1 2 3 " -- string to send
}

dofile("LCD_74HC595_7seg.lua")(t)   -- simple output of information

t={
st=6,                    -- pin ESP for 74HC595 (latch)
qty=6,                   -- quantity 7seg
str="12-01-2018 12 48",  -- string to send
shift=true,              -- line shift
time= 500                -- speed shift mS *(if time == nil then time=500 end)
}

dofile("LCD_74HC595_7seg.lua")(t)   -- display information with a shift

-- or callback

dofile("LCD_74HC595_7seg.lua")(t,function(x)
 print("end")
end)
