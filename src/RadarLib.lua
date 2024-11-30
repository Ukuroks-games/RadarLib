--[[
	# RadarLib

	RadarLib - это библиотека для радаров.
]]
local Radarlib = {}

--[[
	# Структура данных получаемых с радара
	
	представляет собой двумерный массив из длин от радара до объекта
]]
export type RadarData = {
	[number]: {
		[number]: number,
	},
}

--[[
	# Структура данных радара

]]
export type Radar = {
	--[[
		# Парт отностиельно которой будет радар получать данные

		Размер не важен, имеет значение только координаты и вращение
	]]
	RadarPart: Part,

	--[[
		# Дальность работы радара
	]]
	Distace: number,

	--[[
		# Углы работы радара по X и Y
	]]
	Angles: {
		X: number,
		Y: number,
	},

	--[[
		# Разрешение радара по X и Y
		Влияет на размер получаемых данных
	]]
	Resolution: {
		X: number,
		Y: number,
	},
}

--[[
	# Создать радар

	Создаёт радар. Использовать именно эту фнукцию не обязятельно, но лучше использовать т.к. есть проверки на правильность аргументов

	## Params:

	`radarPart` - Парт, который используется как

	`resolution` - Разрешение радара, если значение X или Y равно -1, то использется то же, что и для углов

	`angles` - Углы работы радара

	## Returns:

	Созданная структура радара

	## Usage

	Example:

	```
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RadarLib = require(ReplicatedStorage.Packages.RadarLib)

	local RadarPart = worspace.RadarPart

	local radar = RadarLib.CreateRadar (
		RararPart,
		10,
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
	if not (angles.X > 0 and angles.Y > 0) then
		error("Wrong angles")
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
	# Получить данные с радара

	Осторожно! Эта функция может быть медленной.

	## Params:

	`radar` - Радар, с котромо получаем данные

	## Returns:

	Данные с радара.
]]
function Radarlib.GetData(radar: Radar): RadarData
	local ret: RadarData = {}

	local props = RaycastParams.new()

	props.FilterDescendantsInstances = {
		radar.RadarPart,
	}

	local startDirection = Vector3.new(
		radar.RadarPart.CFrame.LookVector.X - (radar.Angles.X / 2),
		radar.RadarPart.CFrame.LookVector.Y - (radar.Angles.Y / 2),
		radar.RadarPart.CFrame.LookVector.Z
	)

	for i = 0, radar.Resolution.Y do
		ret[i] = {}
		for j = 0, radar.Resolution.X do

			local ray = workspace:Raycast(
				radar.RadarPart.CFrame.Position,
				Vector3.new(
					startDirection.X + ((i / radar.Resolution.X) * radar.Angles.X),
					startDirection.Y + ((i / radar.Resolution.Y) * radar.Angles.Y),
					startDirection.Z
				) * radar.Distace,
				props
			)

			if ray then
				ret[i][j] = ray.Distance
			else
				ret[i][j] = -1
			end
		end
	end

	return ret
end

return Radarlib
