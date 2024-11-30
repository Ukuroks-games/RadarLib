# How to use it

This is guide to how to use this library.

## Create radar

For creating radar you can use function `RadarLib.CreateRadar`

example:

```
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RadarLib = require(ReplicatedStorage.Packages.RadarLib)

local radarPart = workspace.RadarPart

local radar = RadarLib.CreateRadar(
    radarPart,
    10,
    {X=-1, X=-1},
	{
		X = 40
		Y = 60
    }
)
```

or not use function

```
local radar = {
    ["RadarPart"] = radarPart,
    ["Distance"] = 10,
    ["Resolution"] = {
        X = 40,
        Y = 60
    },
    ["Angles"] = {
        X = 40,
        Y = 60
    }
}
```

but better use `CreateRadar()` because it check args to valid

## Get info from radar

use function GetData

```
local Data = RadarLib.GetData(radar)
```

Data is array of arrays that contain numbers - distance beetwen radar and object. if object not exist number is -1.

## Delete radar

just delete table

```
radar = nil 
```
