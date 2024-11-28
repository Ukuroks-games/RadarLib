# How to use it

## Create radar

```
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RadarLib = require(ReplicatedStorage.shared.RadarLib)

local RadarPart = worspace.RadarPart

locat radar = RadarLib.CreateRadar(
    RadarPart,
    {X=-1, X=-1},
	{
		X = 40
		Y = 60
    }
)
```

## Delete radar

just delete table

```


radar = nil 
```