--[[
	# RadarLib

	RadarLib - это библиотека для радаров.

]]
local Radarlib = {}

--[[
	Структура данных получаемых с радара
	представляет собой двумерный массив из длин от радара до объекта
]]
export type RadarData = {
	[number]: {
		[number]: number,
	},
}

--[[
	Структура данных радара
]]
export type Radar = {
	--[[
		Деталь отностиельно которой будет радар получать данные
	]]
	RadarPart: Part,

	--[[
		Дистанция работы радара
	]]
	Distace: number,

	--[[
		Углы работы радара по X и Y
	]]
	Angles: {
		X: number,
		Y: number,
	},

	--[[
		Разрешение радара по X и Y
		Влияет на размер получаемых данных
	]]
	Resolution: {
		X: number,
		Y: number,
	},
}

--[[
	Создать радар

	#### Params:

	`radarPart` - Парт, который используется как
	`resolution` - Разрешение радара, если значение X или Y равно -1, то использется то же, что и для углов
	`angles` - Углы работы радара

	#### Returns:

	Созданная структура радара

	#### Usage

	Example:

	```
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RadarLib = require(ReplicatedStorage.shared.RadarLib)

	local RadarPart = worspace.RadarPart

	local radar = RadarLib.CreateRadar (
		RararPart,
		{X=-1, X=-1},
		{
			X = 40
			Y = 60
		}
	)
	```

]]
function Radarlib.CreateRadar(
	radarPart: Part,
	distance: number,
	resolution: { X: number, Y: number },
	angles: { X: number, Y: number }
): Radar
	if not (angles.X > 0 and angles.X > 0) then
		error("Wrong angles:", angles)
	end

	if resolution.X == -1 then
		resolution.X = angles.X
	end

	if resolution.Y == -1 then
		resolution.Y = angles.Y
	end

	local obj: Radar = {
		["RadarPart"] = radarPart,
		["Distace"] = distance,
		["Resolution"] = resolution,
		["Angles"] = angles,
	}

	return obj
end

--[[
	Получить данные с радара

	#### Params:

	`radar` - Радар, с котромо получаем данные

	#### Returns:

	Данные с радара.
]]
function Radarlib.GetData(radar: Radar): RadarData
	local ret: RadarData = {}

	for i = 1, radar.Resolution.Y do
		ret[i] = {}
		for j = 1, radar.Resolution.X do
			local pos = radar.RadarPart.Position

			local direction = radar.RadarPart.CFrame.LookVector * radar.Distace

			local ray = workspace:Raycast(pos, direction)

			if ray then
				ret[i][j] = ray.Distance
			end
		end
	end

	return ret
end

return Radarlib
