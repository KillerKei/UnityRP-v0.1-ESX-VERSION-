local Charset = {}

for i = 48,  57 do table.insert(Charset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

URPCore.GetRandomString = function(length)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return URPCore.GetRandomString(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

URPCore.GetConfig = function()
	return Config
end

URPCore.GetWeapon = function(weaponName)
	weaponName = string.upper(weaponName)
	local weapons = URPCore.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			return i, weapons[i]
		end
	end
end

URPCore.GetWeaponList = function()
	return Config.Weapons
end

URPCore.GetWeaponLabel = function(weaponName)
	weaponName = string.upper(weaponName)
	local weapons = URPCore.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			return weapons[i].label
		end
	end
end

URPCore.GetWeaponComponent = function(weaponName, weaponComponent)
	weaponName = string.upper(weaponName)
	local weapons = URPCore.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			for j=1, #weapons[i].components, 1 do
				if weapons[i].components[j].name == weaponComponent then
					return weapons[i].components[j]
				end
			end
		end
	end
end

URPCore.DumpTable = function(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. URPCore.DumpTable(v, nb + 1) .. ',\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

URPCore.Round = function(value, numDecimalPlaces)
	return URPCore.Math.Round(value, numDecimalPlaces)
end
