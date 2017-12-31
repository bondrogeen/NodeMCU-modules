id  = 0
sda = 4
scl = 3
i2c.setup(id, sda, scl, i2c.SLOW)
-- single value
t = {mode="Volume",value = 20}

-- or multiple values
t = {
{mode="Volume",value = 20}, -- value 0 - 63
{mode="LF",value = 15}, -- value 0 - 31
{mode="RF",value = 15}, -- value 0 - 31
{mode="LR",value = 15}, -- value 0 - 31
{mode="RR",value = 15}, -- value 0 - 31
{mode="input",value = 2}, -- value 1 - 3
{mode="bass",value = 8}, -- value 0 - 15
{mode="treble",value = 8}, -- value 0 - 15
}

print(dofile("TDA7313.lua")(t))



