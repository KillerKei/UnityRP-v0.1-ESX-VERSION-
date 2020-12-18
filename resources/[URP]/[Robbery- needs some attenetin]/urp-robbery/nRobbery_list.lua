local markersofsydres = {
[1]  = { pos = vector3(256.5196, 219.7890, 106.28), difficulity = 1},
[2]  = { pos = vector3(261.3627, 223.0399, 106.28), difficulity = 1},
[3]  = { pos = vector3(253.5149, 228.3643, 101.68), difficulity = 1},
[4]  = { pos = vector3(254.1452, 225.7106, 101.87), difficulity = 1},
[5]  = { pos = vector3(252.9976, 221.5834, 101.68), difficulity = 1},
[6]  = { pos = vector3(257.8968, 214.5024, 101.68), difficulity = 1},
[7]  = { pos = vector3(259.3956, 218.0461, 101.68), difficulity = 1},
[8]  = { pos = vector3(260.9788, 215.2981, 101.68), difficulity = 1},
[9]  = { pos = vector3(264.5987, 215.9601, 101.68), difficulity = 1},
[10] = { pos = vector3(265.9152, 213.6485, 101.68), difficulity = 1},
[11] = { pos = vector3(263.5963, 212.2665, 101.68), difficulity = 1},
-- bank x

[12]  = { pos = vector3(2752.080, 1465.003, 49.050), difficulity = 1},
[13]  = { pos = vector3(2792.160, 1482.197, 24.530), difficulity = 1},
[14]  = { pos = vector3(2800.542, 1513.992, 24.530), difficulity = 1},
[15]  = { pos = vector3(2809.443, 1547.166, 24.533), difficulity = 1},
[16]  = { pos = vector3(2862.568, 1510.230, 24.567), difficulity = 1},
[17]  = { pos = vector3(2744.313, 1505.682, 45.295), difficulity = 1},
}

Citizen.CreateThread(function()
    local src = source
    for k, v in pairs (markersofsydres) do
        print('sending markers', json.encode(v))
        TriggerClientEvent('robbery:sendMarkers', -1, v[pos], v[pos], v.difficulity)
    end
end)