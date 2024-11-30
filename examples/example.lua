--[[
    # RadarLib example
]]

--
local RadarLib = require(game:GetService("ReplicatedStorage").Packages.RadarLib)

local RadarPart = Instance.new("Part")

local radar = RadarLib.CreateRadar(
    RadarPart,
    10,
    {
        X = 60,
        Y = 60,
    },
    {
        X = 40,
        Y = 40
    }
)

while task.wait(0.1) do
    print(RadarLib.GetData(radar))
end
