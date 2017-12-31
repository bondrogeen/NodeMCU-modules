id  = 0
sda = 4
scl = 3
i2c.setup(id, sda, scl, i2c.SLOW)

-- get time
t={
	init="get"
}

date=dofile("ds3231.lua")(t)
print(string.format("%02d-%02d-20%02dT%02d:%02d", date["date"], date["month"], date["year"],date["hour"], date["min"]))

-- get a temperature
print(dofile("ds3231.lua")({init="temp"}))

-- set time
t={
	init="set",
	sec=00,
	min=15,
	hour=9,
	day=1,
	date=31,
	month=12,
	year=17
}

print(dofile("ds3231.lua")(t))
