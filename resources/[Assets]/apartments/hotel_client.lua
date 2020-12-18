local buildingSpawn = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
local ingarage = false
--Max X = 190 Min X = ?
-- Max Z = 30 Min Z = -98
local garageNumber = 0
local curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
local centerPos = { x = 343.01187133789, y = -950.25201416016, z = -99.0 }
local myroomcoords = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211 }
local currentRoom = {}
local CurrentForced = {x = 0.0,y = 0.0,z=0.0}
local insideApartment = false
local showhelp = false
currentselection = 1
curappartmentnumber = 0
forcedID = 0

apartments1 = {
	[1] = { ["x"] = 312.96966552734,["y"] = -218.2705078125, ["z"] = 54.221797943115},
	[2] = { ["x"] = 311.27377319336,["y"] = -217.74626159668, ["z"] = 54.221797943115},
	[3] = { ["x"] = 307.63830566406,["y"] = -216.43359375, ["z"] = 54.221797943115}, 
	[4] = { ["x"] = 307.71112060547,["y"] = -213.40884399414, ["z"] = 54.221797943115}, 
	[5] = { ["x"] = 309.95989990234,["y"] = -208.48258972168, ["z"] = 54.221797943115},
	[6] = { ["x"] = 311.78106689453,["y"] = -203.50025939941, ["z"] = 54.221797943115}, 
	[7] = { ["x"] = 313.72155761719,["y"] = -198.6107635498, ["z"] = 54.221797943115},
	[8] = { ["x"] = 315.5329284668,["y"] = -195.24925231934, ["z"] = 54.226440429688},
	[9] = { ["x"] = 319.23147583008,["y"] = -196.4300994873, ["z"] = 54.226451873779},
	[10] = { ["x"] = 321.08117675781,["y"] = -197.23593139648, ["z"] = 54.226451873779},
	[11] = { ["x"] = 312.98037719727,["y"] = -218.36080932617, ["z"] = 58.019248962402},
	[12] = { ["x"] = 311.10736083984,["y"] = -217.64399719238, ["z"] = 58.019248962402},
	[13] = { ["x"] = 307.37707519531,["y"] = -216.34501647949, ["z"] = 58.019248962402},
	[14] = { ["x"] = 307.76007080078,["y"] = -213.59916687012, ["z"] = 58.019248962402},
	[15] = { ["x"] = 309.76248168945,["y"] = -208.25439453125, ["z"] = 58.019248962402},
	[16] = { ["x"] = 311.48220825195,["y"] = -203.75033569336, ["z"] = 58.019248962402},
	[17] = { ["x"] = 313.65570068359,["y"] = -198.22790527344, ["z"] = 58.019248962402},
	[18] = { ["x"] = 315.47378540039,["y"] = -195.19331359863, ["z"] = 58.019248962402},
	[19] = { ["x"] = 319.39694213867,["y"] = -196.58866882324, ["z"] = 58.019248962402},
	[20] = { ["x"] = 321.19458007813,["y"] = -197.31185913086, ["z"] = 58.019248962402},
	[21] = { ["x"] = 329.49240112305,["y"] = -224.92803955078, ["z"] = 54.221771240234},
	[22] = { ["x"] = 331.33309936523,["y"] = -225.56880187988, ["z"] = 54.221771240234},
	[23] = { ["x"] = 335.18447875977,["y"] = -227.14477539063, ["z"] = 54.221771240234},
	[24] = { ["x"] = 336.71957397461,["y"] = -224.66767883301, ["z"] = 54.221771240234},
	[25] = { ["x"] = 338.79501342773,["y"] = -219.11264038086, ["z"] = 54.221771240234},
	[26] = { ["x"] = 340.43829345703,["y"] = -214.78857421875, ["z"] = 54.221771240234},
	[27] = { ["x"] = 342.28509521484,["y"] = -209.32579040527, ["z"] = 54.221771240234},
	[28] = { ["x"] = 344.39224243164,["y"] = -204.4561920166, ["z"] = 54.221881866455},
	[29] =  { ['x'] = 346.18, ['y'] = -199.51,['z'] = 54.221881866455 },
	[30] = { ["x"] = 329.7096862793,["y"] = -224.65902709961, ["z"] = 58.019248962402}, 
	[31] = { ["x"] = 331.52966308594,["y"] = -225.52110290527, ["z"] = 58.019248962402}, 
	[32] = { ["x"] = 335.16506958008,["y"] = -227.07464599609, ["z"] = 58.019248962402},
	[33] = { ["x"] = 336.35406494141,["y"] = -224.58212280273, ["z"] = 58.019245147705}, 
	[34] = { ["x"] = 338.56127929688,["y"] = -219.3408203125, ["z"] = 58.019245147705},

	[35] = { ["x"] = 342.41970825195,["y"] = -209.25254821777, ["z"] = 58.019245147705},
	[36] = { ["x"] = 344.03280639648,["y"] = -204.98118591309, ["z"] = 58.019245147705},
	[37] = { ["x"] = 346.08560180664,["y"] = -199.59660339355, ["z"] = 58.019245147705}, 

	[38] =  { ['x'] = -1498.02,['y'] = -664.59,['z'] = 33.39,['h'] = 128.87, ['info'] = ' Bay City Ave / App 36' , ['apt'] = 1 },
	[39] =  { ['x'] = -1489.69,['y'] = -671.15,['z'] = 33.39,['h'] = 134.21, ['info'] = ' Bay City Ave / App 69' , ['apt'] = 1 },
	[40] =  { ['x'] = -1493.46,['y'] = -668.06,['z'] = 33.39,['h'] = 141.4, ['info'] = ' Bay City Ave / App 37' , ['apt'] = 1 },
	[41] =  { ['x'] = -1461.53,['y'] = -641.04,['z'] = 33.39,['h'] = 304.53, ['info'] = ' Bay City Ave / App 18' , ['apt'] = 1 },
	[42] =  { ['x'] = -1458.35,['y'] = -645.91,['z'] = 33.39,['h'] = 308.11, ['info'] = ' Bay City Ave / App 19' , ['apt'] = 1 },
	[43] =  { ['x'] = -1456.04,['y'] = -648.95,['z'] = 33.39,['h'] = 306.76, ['info'] = ' Bay City Ave / App 20' , ['apt'] = 1 },
	[44] =  { ['x'] = -1452.73,['y'] = -653.47,['z'] = 33.39,['h'] = 301.36, ['info'] = ' Bay City Ave / App 21' , ['apt'] = 1 },
	[45] =  { ['x'] = -1454.63,['y'] = -655.6,['z'] = 33.39,['h'] = 215.46, ['info'] = ' Bay City Ave / App 22' , ['apt'] = 1 },
	[46] =  { ['x'] = -1459.41,['y'] = -658.81,['z'] = 33.39,['h'] = 213.78, ['info'] = ' Bay City Ave / App 23' , ['apt'] = 1 },
	[47] =  { ['x'] = -1463.32,['y'] = -661.53,['z'] = 33.39,['h'] = 210.0, ['info'] = ' Bay City Ave / App 24' , ['apt'] = 1 },
	[48] =  { ['x'] = -1467.84,['y'] = -665.24,['z'] = 33.39,['h'] = 189.07, ['info'] = ' Bay City Ave / App 25' , ['apt'] = 1 },
	[49] =  { ['x'] = -1471.78,['y'] = -668.02,['z'] = 33.39,['h'] = 214.32, ['info'] = ' Bay City Ave / App 26' , ['apt'] = 1 },
	[40] =  { ['x'] = -1476.37,['y'] = -671.31,['z'] = 33.39,['h'] = 216.08, ['info'] = ' Bay City Ave / App 27' , ['apt'] = 1 },
	[41] =  { ['x'] = -1464.99,['y'] = -639.7,['z'] = 33.39,['h'] = 35.06, ['info'] = ' Bay City Ave / App 28' , ['apt'] = 1 },
	[42] =  { ['x'] = -1469.15,['y'] = -643.43,['z'] = 33.39,['h'] = 35.14, ['info'] = ' Bay City Ave / App 29' , ['apt'] = 1 },
	[43] =  { ['x'] = -1473.23,['y'] = -646.27,['z'] = 33.39,['h'] = 32.85, ['info'] = ' Bay City Ave / App 30' , ['apt'] = 1 },
	[44] =  { ['x'] = -1477.85,['y'] = -649.78,['z'] = 33.39,['h'] = 32.61, ['info'] = ' Bay City Ave / App 31' , ['apt'] = 1 },
	[45] =  { ['x'] = -1481.81,['y'] = -652.67,['z'] = 33.39,['h'] = 33.91, ['info'] = ' Bay City Ave / App 32' , ['apt'] = 1 },
	[46] =  { ['x'] = -1486.47,['y'] = -655.77,['z'] = 33.39,['h'] = 36.38, ['info'] = ' Bay City Ave / App 33' , ['apt'] = 1 },
	[47] =  { ['x'] = -1490.7,['y'] = -658.4,['z'] = 33.39,['h'] = 33.02, ['info'] = ' Bay City Ave / App 34' , ['apt'] = 1 },
	[48] =  { ['x'] = -1495.22,['y'] = -661.82,['z'] = 33.39,['h'] = 38.31, ['info'] = ' Bay City Ave / App 35' , ['apt'] = 1 },

	[49] =  { ['x'] = -1481.97,['y'] = -652.46,['z'] = 29.59,['h'] = 31.19, ['info'] = ' Bay City Ave / App 6' , ['apt'] = 1 },
	[50] =  { ['x'] = -1477.95,['y'] = -649.54,['z'] = 29.59,['h'] = 32.3, ['info'] = ' Bay City Ave / App 7' , ['apt'] = 1 },
	[51] =  { ['x'] = -1473.36,['y'] = -646.2,['z'] = 29.59,['h'] = 26.38, ['info'] = ' Bay City Ave / App 8' , ['apt'] = 1 },
	[52] =  { ['x'] = -1469.31,['y'] = -643.41,['z'] = 29.59,['h'] = 29.38, ['info'] = ' Bay City Ave / App 8' , ['apt'] = 1 },
	[53] =  { ['x'] = -1464.75,['y'] = -640.1,['z'] = 29.59,['h'] = 33.84, ['info'] = ' Bay City Ave / App 10' , ['apt'] = 1 },
	[54] =  { ['x'] = -1461.78,['y'] = -641.4,['z'] = 29.59,['h'] = 303.51, ['info'] = ' Bay City Ave / App 11' , ['apt'] = 1 },
	[55] =  { ['x'] = -1452.58,['y'] = -653.29,['z'] = 29.59,['h'] = 300.87, ['info'] = ' Bay City Ave / App 12' , ['apt'] = 1 },
	[56] =  { ['x'] = -1454.68,['y'] = -655.64,['z'] = 29.59,['h'] = 213.03, ['info'] = ' Bay City Ave / App 13' , ['apt'] = 1 },
	[57] =  { ['x'] = -1459.3,['y'] = -658.86,['z'] = 29.59,['h'] = 228.02, ['info'] = ' Bay City Ave / App 14' , ['apt'] = 1 },
	[58] =  { ['x'] = -1463.37,['y'] = -661.72,['z'] = 29.59,['h'] = 214.95, ['info'] = ' Bay City Ave / App 15' , ['apt'] = 1 },
	[59] =  { ['x'] = -1468.05,['y'] = -664.9,['z'] = 29.59,['h'] = 214.39, ['info'] = ' Bay City Ave / App 16' , ['apt'] = 1 },
	[60] =  { ['x'] = -1471.96,['y'] = -667.82,['z'] = 29.59,['h'] = 213.94, ['info'] = ' Bay City Ave / App 17' , ['apt'] = 1 },
	[61] =  { ['x'] = -1497.83,['y'] = -664.47,['z'] = 29.03,['h'] = 137.35, ['info'] = ' Bay City Ave / App 2' , ['apt'] = 1 },
	[62] =  { ['x'] = -1495.04,['y'] = -661.92,['z'] = 29.03,['h'] = 30.17, ['info'] = ' Bay City Ave / App 3' , ['apt'] = 1 },
	[63] =  { ['x'] = -1490.48,['y'] = -658.73,['z'] = 29.03,['h'] = 29.52, ['info'] = ' Bay City Ave / App 4' , ['apt'] = 1 },
	[64] =  { ['x'] = -1486.45,['y'] = -655.88,['z'] = 29.59,['h'] = 37.15, ['info'] = ' Bay City Ave / App 5' , ['apt'] = 1 },

	[65] =  { ['x'] = 485.3,['y'] = 213.35,['z'] = 108.31},
	[66] =  { ['x'] = 525.38,['y'] = 207.42,['z'] = 104.75},
	[67] =  { ['x'] = 527.99,['y'] = 213.69,['z'] = 104.75},
	[68] =  { ['x'] = 531.07,['y'] = 222.29,['z'] = 104.75},
	[69] =  { ['x'] = 526.89,['y'] = 225.87,['z'] = 104.75},
	[70] =  { ['x'] = 519.51,['y'] = 228.31,['z'] = 104.75},
	[71] =  { ['x'] = 510.99,['y'] = 231.24,['z'] = 104.75},
	[72] =  { ['x'] = 504.31,['y'] = 233.97,['z'] = 104.75},
	[73] =  { ['x'] = 497.27,['y'] = 237.05,['z'] = 104.75},
	[74] =  { ['x'] = 490.52,['y'] = 227.01,['z'] = 104.75},
	[75] =  { ['x'] = 487.98,['y'] = 221.05,['z'] = 104.75},
	[76] =  { ['x'] = 485.06,['y'] = 212.41,['z'] = 104.75},
	[77] =  { ['x'] = 482.71,['y'] = 206.25,['z'] = 104.75},
	[78] =  { ['x'] = 486.53,['y'] = 201.95,['z'] = 104.75},
	[79] =  { ['x'] = 508.32,['y'] = 194.19,['z'] = 104.75},
	[80] =  { ['x'] = 515.06,['y'] = 191.39,['z'] = 104.75},
	[81] =  { ['x'] = 520.08,['y'] = 192.44,['z'] = 104.75},
	[82] =  { ['x'] = 522.32,['y'] = 198.72,['z'] = 104.75},
	[83] =  { ['x'] = 508.17,['y'] = 193.98,['z'] = 108.31},
	[84] =  { ['x'] = 515.18,['y'] = 191.49,['z'] = 108.31},
	[85] =  { ['x'] = 520.42,['y'] = 193.04,['z'] = 108.31},
	[86] =  { ['x'] = 522.46,['y'] = 199.33,['z'] = 108.31},
	[87] =  { ['x'] = 486.13,['y'] = 201.89,['z'] = 108.31},
	[88] =  { ['x'] = 482.3,['y'] = 205.83,['z'] = 108.31},
	[89] =  { ['x'] = -857.24,['y'] = -1282.46,['z'] = 9.71},
	[90] =  { ['x'] = -868.6,['y'] = -1286.5,['z'] = 9.71},
	[91] =  { ['x'] = -880.0,['y'] = -1290.65,['z'] = 9.71},
	[92] =  { ['x'] = -891.13,['y'] = -1294.69,['z'] = 9.71},
	[93] =  { ['x'] = -902.53,['y'] = -1298.85,['z'] = 9.71},
	[94] =  { ['x'] = -913.84,['y'] = -1302.97,['z'] = 9.71},
	[95] =  { ['x'] = -925.03,['y'] = -1307.03,['z'] = 9.71},
	[96] =  { ['x'] = -936.4,['y'] = -1311.18,['z'] = 9.71},
	[97] =  { ['x'] = -947.43,['y'] = -1315.21,['z'] = 9.71},
	[98] =  { ['x'] = -947.66,['y'] = -1315.3,['z'] = 13.21},
	[99] =  { ['x'] = -936.34,['y'] = -1311.16,['z'] = 13.21},
	[100] =  { ['x'] = -924.92,['y'] = -1306.99,['z'] = 13.21},
	[101] =  { ['x'] = -913.58,['y'] = -1302.93,['z'] = 13.21},
	[102] =  { ['x'] = -857.5,['y'] = -1281.78,['z'] = 6.21},
	[103] =  { ['x'] = -869.01,['y'] = -1285.92,['z'] = 6.21},
	[104] =  { ['x'] = -891.23,['y'] = -1293.82,['z'] = 6.21},
	[105] =  { ['x'] = -902.78,['y'] = -1297.95,['z'] = 6.21},
	[106] =  { ['x'] = -925.51,['y'] = -1306.1,['z'] = 6.21},
	[107] =  { ['x'] = -936.63,['y'] = -1310.15,['z'] = 6.21},
	[108] =  { ['x'] = -947.87,['y'] = -1314.25,['z'] = 6.21},
	[109] =  { ['x'] = -857.92,['y'] = -1281.63,['z'] = 13.21},
	[110] =  { ['x'] = -868.98,['y'] = -1285.87,['z'] = 13.21},
	[111] =  { ['x'] = -879.88,['y'] = -1289.98,['z'] = 13.21},
	[112] =  { ['x'] = -891.18,['y'] = -1294.26,['z'] = 13.21},
	[113] =  { ['x'] = -902.39,['y'] = -1298.25,['z'] = 13.21},
	[114] =  { ['x'] = -1542.97,['y'] = -249.04,['z'] = 48.29},
	[115] =  { ['x'] = -1560.96,['y'] = -274.57,['z'] = 48.28},
	[116] =  { ['x'] = -1555.79,['y'] = -279.45,['z'] = 48.28},
	[117] =  { ['x'] = -1550.18,['y'] = -284.23,['z'] = 48.28},
	[118] =  { ['x'] = -1542.65,['y'] = -278.56,['z'] = 48.29},
	[119] =  { ['x'] = -1541.19,['y'] = -276.52,['z'] = 48.28},
	[120] =  { ['x'] = -1538.03,['y'] = -272.43,['z'] = 48.28},
	[121] =  { ['x'] = -1536.46,['y'] = -270.39,['z'] = 48.28},
	[122] =  { ['x'] = -1533.17,['y'] = -260.29,['z'] = 48.28},
	[123] =  { ['x'] = -1538.31,['y'] = -254.67,['z'] = 48.28},
	[124] =  { ['x'] = -1583.62,['y'] = -265.63,['z'] = 48.28},
	[125] =  { ['x'] = -1582.44,['y'] = -278.02,['z'] = 48.28},
	[126] =  { ['x'] = -1574.82,['y'] = -290.13,['z'] = 48.28},
	[127] =  { ['x'] = -1569.57,['y'] = -295.28,['z'] = 48.28},
	[128] =  { ['x'] = -1564.47,['y'] = -300.29,['z'] = 48.24},
	[129] =  { ['x'] = -1555.07,['y'] = -290.08,['z'] = 48.28},
	[130] =  { ['x'] = -1560.71,['y'] = -285.26,['z'] = 48.28},
	[131] =  { ['x'] = -1566.19,['y'] = -280.16,['z'] = 48.28},
	[132] =  { ['x'] = -1309.03,['y'] = -931.24,['z'] = 13.36},
	[133] =  { ['x'] = -1310.95,['y'] = -931.85,['z'] = 13.36},
	[134] =  { ['x'] = -1318.02,['y'] = -934.42,['z'] = 13.36},
	[135] =  { ['x'] = -1319.72,['y'] = -935.08,['z'] = 13.36},
	[136] =  { ['x'] = -1329.32,['y'] = -938.55,['z'] = 12.36},
	[137] =  { ['x'] = -1331.28,['y'] = -939.25,['z'] = 12.36},
	[138] =  { ['x'] = -1338.22,['y'] = -941.85,['z'] = 12.36},
	[139] =  { ['x'] = -1338.24,['y'] = -941.87,['z'] = 15.36},
	[140] =  { ['x'] = -1331.13,['y'] = -939.2,['z'] = 15.36},
	[141] =  { ['x'] = -1329.3,['y'] = -938.55,['z'] = 15.36},
	[142] =  { ['x'] = -1319.91,['y'] = -935.17,['z'] = 16.36},
	[143] =  { ['x'] = -1318.02,['y'] = -934.43,['z'] = 16.36},
	[144] =  { ['x'] = -1311.01,['y'] = -931.9,['z'] = 16.36},
	[145] =  { ['x'] = -1309.15,['y'] = -931.2,['z'] = 16.36},
	[146] =  { ['x'] = -412.02,['y'] = 152.8,['z'] = 65.53},
	[147] =  { ['x'] = -410.7,['y'] = 159.63,['z'] = 65.53},
	[148] =  { ['x'] = -385.0,['y'] = 159.49,['z'] = 65.54},
	[149] =  { ['x'] = -383.78,['y'] = 152.62,['z'] = 65.54},
	[150] =  { ['x'] = -384.91,['y'] = 159.42,['z'] = 69.73},
	[151] =  { ['x'] = -383.78,['y'] = 152.72,['z'] = 69.73},
	[152] =  { ['x'] = -411.99,['y'] = 152.84,['z'] = 69.73},
	[153] =  { ['x'] = -410.7,['y'] = 159.57,['z'] = 69.73},
	[154] =  { ['x'] = -412.02,['y'] = 152.74,['z'] = 73.74},
	[155] =  { ['x'] = -410.72,['y'] = 159.46,['z'] = 73.74},
	[156] =  { ['x'] = -383.8,['y'] = 152.86,['z'] = 73.74},
	[157] =  { ['x'] = -385.02,['y'] = 159.62,['z'] = 73.74},
	[158] =  { ['x'] = -383.79,['y'] = 152.74,['z'] = 77.75},
	[159] =  { ['x'] = -385.0,['y'] = 159.57,['z'] = 77.75},
	[160] =  { ['x'] = -410.67,['y'] = 159.77,['z'] = 77.75},
	[161] =  { ['x'] = -411.98,['y'] = 152.92,['z'] = 77.75},
	[162] =  { ['x'] = -410.7,['y'] = 159.67,['z'] = 81.75},
	[163] =  { ['x'] = -411.98,['y'] = 152.87,['z'] = 81.75},
	[164] =  { ['x'] = -383.81,['y'] = 152.88,['z'] = 81.75},
	[165] =  { ['x'] = -385.03,['y'] = 159.67,['z'] = 81.75},

}


myRoomNumber = 1
myRoomLock = true
curRoomType = 1
myRoomType = 1
hid = 0 
isForced = false

function inRoom()
	if #(vector3(myroomcoords.x,myroomcoords.y,myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 40.0 then
		return true
	else
		return false
	end
end

RegisterNetEvent('hotel:forceOut')
AddEventHandler('hotel:forceOut', function(roomNumber,roomtype)
	isForced = false
	returnCurrentRoom(roomtype,roomNumber)
	if #(vector3(CurrentForced.x, CurrentForced.y, CurrentForced.z) - GetEntityCoords(PlayerPedId())) < 90.0 then
		CleanUpArea()
		if roomNumber == 2 then
			SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
		elseif roomNumber == 3 then
			SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
		end
	end
	if myRoomNumber == roomNumber then
		CleanUpArea()
		if #(vector3(CurrentForced.x, CurrentForced.y, CurrentForced.z) - GetEntityCoords(PlayerPedId())) < 90.0 then
			if roomNumber == 2 then
				SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
			elseif roomNumber == 3 then
				SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
			end
		end
	end
end)

RegisterNetEvent('hotel:AttemptUpgrade')
AddEventHandler('hotel:AttemptUpgrade', function()
	if #(vector3(260.72366333008,-375.27133178711,-44.137680053711) - GetEntityCoords(PlayerPedId())) < 3.0 then
		TriggerServerEvent('hotel:upgradeApartment', myRoomType)
		TriggerEvent("hotel:myroomtype",myRoomType)
	end	
end)

RegisterNetEvent('hotel:AddCashToHotel')
AddEventHandler('hotel:AddCashToHotel', function(amount)
	if inRoom() then
		TriggerServerEvent('hotel:AddCashToHotel', amount)
		Citizen.Wait(555)
		TriggerServerEvent("hotel:getInfo")
	end
end)

RegisterNetEvent('hotel:SetID')
AddEventHandler('hotel:SetID', function(hidX)
	hid = hidX
end)
RegisterNetEvent('hotel:SetID2')
AddEventHandler('hotel:SetID2', function(hidX)
	hid = hidX
	forcedID = hidX
end)
RegisterNetEvent('hotel:RemoveCashFromHotel')
AddEventHandler('hotel:RemoveCashFromHotel', function(amount)
	if inRoom() then
		TriggerServerEvent('hotel:RemoveCashFromHotel', amount)
		Citizen.Wait(555)
		TriggerServerEvent("hotel:getInfo")
	end		
end)

RegisterNetEvent('hotel:AddDMToHotel')
AddEventHandler('hotel:AddDMToHotel', function(amount)
	if inRoom() then
		TriggerServerEvent('hotel:AddDMToHotel', amount)
		Citizen.Wait(555)
		TriggerServerEvent("hotel:getInfo")
	end		
end)

RegisterNetEvent('hotel:RemoveDMFromHotel')
AddEventHandler('hotel:RemoveDMFromHotel', function(amount)
	if inRoom() then
		TriggerServerEvent('hotel:RemoveDMFromHotel', amount)
		Citizen.Wait(555)
		TriggerServerEvent("hotel:getInfo")
	end		
end)

RegisterNetEvent("hotel:forceEnter")
AddEventHandler("hotel:forceEnter", function(roomNumber,roomtype)
	roomNumber = tonumber(roomNumber)
	roomtype = tonumber(roomtype)
	isForced = true
	returnCurrentRoom(roomtype,roomNumber)
end)

function returnCurrentRoom(roomtype,roomNumber)
	if roomtype == 3 then
		local generator = { x = -265.68209838867 , y = -957.06573486328, z = 145.824577331543}
		if roomNumber > 0 and roomNumber < 7 then
			--generator = { x = -143.16976928711 , y = -596.31140136719, z = 61.95349121093}
			--generator.z = (61.9534912) + ((roomNumber * 11.0) * roomType)
			generator = { x = 131.0290527343, y = -644.0509033203, z = 68.025619506836}
			generator.z = (68.0534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 6 and roomNumber < 14 then
			generator = { x = -134.43560791016 , y = -638.13916015625, z = 68.953491210938}
			roomNumber = roomNumber - 6
			generator.z = (61.9534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 13 and roomNumber < 20 then
			generator = { x = -181.440234375 , y = -584.04815673828, z = 68.95349121093}
			roomNumber = roomNumber - 13
			generator.z = (61.9534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 19 and roomNumber < 26 then
			generator = { x = -109.9752227783, y = -570.272351074, z = 61.9534912}
			roomNumber = roomNumber - 19
			generator.z = (61.9534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 25 and roomNumber < 38 then
			generator = { x = -3.9463002681732, y = -693.2456665039, z = 103.0334701538}
			roomNumber = roomNumber - 25
			generator.z = (103.0534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 37 and roomNumber < 49 then
			generator = { x = 140.0758819580, y = -748.12322998, z = 87.0334701538}
			roomNumber = roomNumber - 37
			generator.z = (87.0534912) + ((roomNumber * 11.0))
		end

		if roomNumber > 48 and roomNumber < 60 then
			generator = { x = 131.0290527343, y = -644.0509033203, z = 68.025619506836}
			roomNumber = roomNumber - 48
			generator.z = (68.0534912) + ((roomNumber * 11.0))
		end

		CurrentForced = generator

	elseif roomtype == 2 then 
		local generator = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
		generator.x = (175.09986877441) + ((roomNumber * 25.0))
		generator.y = (-904.7946166992) - ((roomNumber * 25.0))
		CurrentForced = generator
	end
end


RegisterNetEvent('doApartHelp')
AddEventHandler('doApartHelp', function()
	showhelp = true
end)

RegisterNetEvent('hotel:updateLockStatus')
AddEventHandler('hotel:updateLockStatus', function(newStatus)
	myRoomLock = newStatus
end)

RegisterNetEvent('refocusent')
AddEventHandler('refocusent', function()
	TriggerEvent("DoLongHudText","Refocusing entity - abuse of this will result in a ban",2)
	ClearFocus()
end)

RegisterNetEvent('hotel:createRoomFirst')
AddEventHandler('hotel:createRoomFirst', function(numMultiplier,roomType, keys)
	myRoomNumber = numMultiplier
	myRoomType = roomType
	TriggerEvent("hotel:myroomtype",myRoomType)
	TriggerEvent('hotel:createRoom', myRoomType, myRoomNumber)
end)

local disablespawn = false
RegisterNetEvent('disablespawn')
AddEventHandler('disablespawn', function(selke)
	disablespawn = selke
end)


local myspawnpoints = {}
local spawning = false
RegisterNetEvent('hotel:createRoom')
AddEventHandler('hotel:createRoom', function(numMultiplier,roomType)


	
	local isClothesSpawn = false
	local imprisoned = false
	isImprisoned = false
	spawning = false
	TriggerEvent("spawning",true)
	FreezeEntityPosition(PlayerPedId(),true)
	SetEntityCoords(PlayerPedId(), 152.09986877441 , -1004.7946166992, -98.999984741211)
	SetEntityInvincible(PlayerPedId(),true)
	myRoomNumber = myRoomNumber
	myRoomType = myRoomType

	myspawnpoints  = {
		[1] =  { ['x'] = -204.93,['y'] = -1010.13,['z'] = 29.55,['h'] = 180.99, ['info'] = ' Altee Street Train Station', ["typeSpawn"] = 1 },
		[2] =  { ['x'] = 272.16,['y'] = 185.44,['z'] = 104.67,['h'] = 320.57, ['info'] = ' Vinewood Blvd Taxi Stand', ["typeSpawn"] = 1 },
		[3] =  { ['x'] = -1833.96,['y'] = -1223.5,['z'] = 13.02,['h'] = 310.63, ['info'] = ' The Boardwalk', ["typeSpawn"] = 1 },
		[4] =  { ['x'] = 145.62,['y'] = 6563.19,['z'] = 32.0,['h'] = 42.83, ['info'] = ' Paleto Gas Station', ["typeSpawn"] = 1 },
		[5] =  { ['x'] = -214.24,['y'] = 6178.87,['z'] = 31.17,['h'] = 40.11, ['info'] = ' Paleto Bus Stop', ["typeSpawn"] = 1 },
		[6] =  { ['x'] = 1122.11,['y'] = 2667.24,['z'] = 38.04,['h'] = 180.39, ['info'] = ' Harmony Motel', ["typeSpawn"] = 1 },
		[7] =  { ['x'] = 453.29,['y'] = -662.23,['z'] = 28.01,['h'] = 5.73, ['info'] = ' LS Bus Station', ["typeSpawn"] = 1 },
		[8] =  { ['x'] = -1266.53,['y'] = 273.86,['z'] = 64.66,['h'] = 28.52, ['info'] = ' The Richman Hotel', ["typeSpawn"] = 1 },
	}


	if myRoomType == 1 then
		myspawnpoints[#myspawnpoints + 1] = { ['x'] = 326.38,['y'] = -212.11,['z'] = 54.09,['h'] = 166.11, ['info'] = ' Apartments 1', ["typeSpawn"] = 2 }
	elseif myRoomType == 2 then
		myspawnpoints[#myspawnpoints + 1] = { ['x'] = 262.0,['y'] = -639.15,['z'] = 42.88,['h'] = 67.09, ['info'] = ' Apartments 2', ["typeSpawn"] = 2 }
	else
		myspawnpoints[#myspawnpoints + 1] = { ['x'] = 173.96,['y'] = -631.29,['z'] = 47.08,['h'] = 303.12, ['info'] = ' Apartments 3', ["typeSpawn"] = 2 }
	end


	
	if isClothesSpawn then
		local apartmentName = ' Apartments 1'
		if myRoomType == 1 then
			apartmentName = ' Apartments 1'
		elseif myRoomType == 2 then
			apartmentName = ' Apartments 2'
		else
			apartmentName = ' Apartments 3'
		end

		for k,v in pairs(myspawnpoints) do
			if v.info == apartmentName then
				currentselection = k
			end
		end

		confirmSpawning(true)
	else
		if not imprisoned then
			SendNUIMessage({
				openSection = "main",
			})

			SetNuiFocus(true,true)
			doSpawn(myspawnpoints)
			DoScreenFadeIn(2500)
			doCamera()

		end
	end
end)

function prisionSpawn()
	spawning = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)


	local x = 1802.51
	local y = 2607.19
	local z = 46.01
	local h = 93.0

	ClearFocus()
	SetNuiFocus(false,false)
	-- spawn them here.
    
    
	RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
	DestroyCam(cam, false)
	SetEntityCoords(PlayerPedId(),x,y,z)
	SetEntityHeading(PlayerPedId(),h)		

	SetEntityInvincible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),false)

	Citizen.Wait(2000)
	TriggerEvent("attachWeapons")
	TriggerEvent("spawning",false)

	TriggerEvent("tokovoip:onPlayerLoggedIn", true)
	Citizen.Wait(2000)
	TriggerServerEvent("request-dropped-items")
	TriggerServerEvent("HOWMUCHCASHUHGOT")
	TriggerServerEvent("server-request-update",exports["isPed"]:isPed("cid"))
	TriggerServerEvent("jail:charecterFullySpawend")
	if(DoesCamExist(cam)) then
		DestroyCam(cam, false)
	end
	 TriggerServerEvent("stocks:retrieveclientstocks")
end

RegisterNUICallback('selectedspawn', function(data, cb)
	if spawning then
		return
	end
    currentselection = data.tableidentifier
    doCamera()
end)

RegisterNUICallback('confirmspawn', function(data, cb)
	spawning = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)
	SendNUIMessage({
		openSection = "close",
	})	
	startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	RenderScriptCams(false, true, 500, true, true)
	SetCamActiveWithInterp(cam, cam2, 3700, true, true)
	SetEntityVisible(PlayerPedId(), true, 0)
	FreezeEntityPosition(PlayerPedId(), false)
    SetPlayerInvisibleLocally(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)

    DestroyCam(startcam, false)
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
    Citizen.Wait(0)
    FreezeEntityPosition(GetPlayerPed(-1), false)
	confirmSpawning(false)
end)

function confirmSpawning(isClothesSpawn)

	local x = myspawnpoints[currentselection]["x"]
	local y = myspawnpoints[currentselection]["y"]
	local z = myspawnpoints[currentselection]["z"]
	local h = myspawnpoints[currentselection]["h"]

	ClearFocus()

	SetNuiFocus(false,false)
	-- spawn them here.
    
    
	RenderScriptCams(false, false, 0, 1, 0) -- Return to gameplay camera
	DestroyCam(cam, false)

	
	if myspawnpoints[currentselection]["typeSpawn"] == 1 then
		SetEntityCoords(PlayerPedId(),x,y,z)
		SetEntityHeading(PlayerPedId(),h)		
	elseif myspawnpoints[currentselection]["typeSpawn"] == 2 then
		defaultSpawn()
	else
		print("error spawning?")
	end
	
	--TriggerServerEvent("server-request-update")
	SetEntityInvincible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),false)

	TriggerServerEvent("urp-clothing:get_character_current", source)
	TriggerServerEvent("urp-clothing:get_character_face", source)
	TriggerServerEvent("urp-clothing:retrieve_tats", source)

	Citizen.Wait(2000)
	DoScreenFadeIn(4000)
	TriggerEvent("attachWeapons")
	TriggerEvent("spawning",false)

	if isClothesSpawn then
		TriggerEvent("urp-clothing:defaultReset")
	end

	TriggerEvent("tokovoip:onPlayerLoggedIn", true)
	Citizen.Wait(2000)
	TriggerServerEvent("request-dropped-items")
	 TriggerServerEvent("HOWMUCHCASHUHGOT")
	 TriggerServerEvent("server-request-update",exports["isPed"]:isPed("cid"))

	if(DoesCamExist(cam)) then
		DestroyCam(cam, false)
	end
	TriggerServerEvent("stocks:retrieveclientstocks")


end

--	mykeys[i] = { ["house_name"] = results[i].house_name, ["house_poi"] = pois,  ["table_id"] = results[i].id, ["owner"] = true, ["house_id"] = results[i].house_id, ["house_model"] = results[i].house_model, ["house_name"] = results[i].house_name }

-- "typeSpawn" 1 = no building, 2 = default housing, 3 = house/offices with address
function doSpawn(array)

	for i = 1, #array do

		SendNUIMessage({
			openSection = "enterspawn",
			textmessage = array[i]["info"],
			tableid = i,
		})
	end
end

cam = 0
local camactive = false
local killcam = true
function doCamera()
	killcam = true
	if spawning then
		return
	end

	Citizen.Wait(1)
	killcam = false
	local camselection = currentselection
	DoScreenFadeOut(1)
	cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	

	local x,y,z,h

		 x = myspawnpoints[currentselection]["x"]
		 y = myspawnpoints[currentselection]["y"]
		 z = myspawnpoints[currentselection]["z"]
		 h = myspawnpoints[currentselection]["h"]
	
	i = 3200
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	SetCamActive(cam,  true)
	RenderScriptCams(true,  false,  0,  true,  true)
	DoScreenFadeIn(1500)
	local camAngle = -90.0
	while i > 1 and camselection == currentselection and not spawning and not killcam do
		local factor = i / 50
		if i < 1 then i = 1 end
		i = i - factor
		SetCamCoord(cam, x,y,z+i)
		if i < 1200 then
			DoScreenFadeIn(600)
		end
		if i < 90.0 then
			camAngle = i - i - i
		end
		SetCamRot(cam, camAngle, 0.0, 0.0)
		Citizen.Wait(1)
	end

end


function defaultSpawn()
	moveToMyHotel(myRoomType)	
	TriggerEvent("hotel:myroomtype",myRoomType)
end

RegisterNetEvent('hotel:teleportRoom')
AddEventHandler('hotel:teleportRoom', function(numMultiplier,roomType)
	local numMultiplier = tonumber(numMultiplier)
	local roomType = tonumber(roomType)
	if (#(vector3(106.11, -647.76, 45.1) - GetEntityCoords(PlayerPedId())) < 5 and roomType == 3) or (#(vector3(160.26762390137,-641.96905517578,47.073524475098) - GetEntityCoords(PlayerPedId())) < 5 and roomType == 3) or (#(vector3(267.48132324219,-638.818359375,42.020294189453) - GetEntityCoords(PlayerPedId())) < 5 and roomType == 2) then
		moveToMultiplierHotel(numMultiplier,roomType)
	elseif (#(vector3(apartments1[numMultiplier]["x"],apartments1[numMultiplier]["y"],apartments1[numMultiplier]["z"]) - GetEntityCoords(PlayerPedId())) < 5 and roomType == 1) then
		moveToMultiplierHotel(numMultiplier,roomType)
	else
		TriggerEvent("notification","No Entry Point.",2)
	end
	
end)				

RegisterNetEvent('attemptringbell')
AddEventHandler("attemptringbell",function(apnm)
	if 
	(#(vector3(160.29, -642.06, 47.08) - GetEntityCoords(PlayerPedId()) < 5)) or
	(#(vector3(267.52, -638.79, 42.02) - GetEntityCoords(PlayerPedId()) < 5)) or
	(#(vector3(313.09, -225.83, 54.23) - GetEntityCoords(PlayerPedId()) < 5))
	then
		TriggerServerEvent("confirmbellring",apnm)
		TriggerEvent("buzzer")
	else
		TriggerEvent("DoLongHudText","You are not near a buzzer point.")
	end
end)

RegisterNetEvent('buzzbuzz')
AddEventHandler("buzzbuzz",function(apartmentnumber)

	if tonumber(apartmentnumber) == 0 then
		return
	end
	if tonumber(curappartmentnumber) == tonumber(apartmentnumber) then
		TriggerEvent('InteractSound_CL:PlayOnOne','doorbell', 0.5)
	end

end)

RegisterNetEvent('buzzer')
AddEventHandler("buzzer",function()
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1.0, 'doorbell', 0.5)
end)

function moveToMyHotel(roomType)
	TriggerEvent("resetPhone")
	processBuildType(myRoomNumber,roomType)
end

function moveToMultiplierHotel(numMultiplier,roomType)
	processBuildType(tonumber(numMultiplier),tonumber(roomType))
end

function processBuildType(numMultiplier,roomType)
	DoScreenFadeOut(1)
	insideApartment = true
	TriggerEvent("DensityModifierEnable",false)
	TriggerEvent("inhotel",true)
	SetEntityInvincible(PlayerPedId(), true)
	TriggerEvent("enabledamage",false)
	--DoScreenFadeOut(1)

	TriggerEvent("dooranim")	
	if roomType == 1 then
		buildRoom(numMultiplier,roomType)
		if showhelp then
			TriggerEvent("customNotification","Welcome to the Hotel, Press P to open your phone and use the help app for more information!")
			showhelp = false
		end
	elseif roomType == 2 then
		buildRoom2(numMultiplier,roomType)
	elseif roomType == 3 then
		buildRoom3(numMultiplier,roomType)
	end

	curappartmentnumber = numMultiplier

	TriggerEvent('InteractSound_CL:PlayOnOne','DoorClose', 0.7)
	TriggerEvent("dooranim")

	CleanUpPeds()
	--DoScreenFadeIn(100)
	SetEntityInvincible(PlayerPedId(), false)
	FreezeEntityPosition(PlayerPedId(),false)
	TriggerEvent("enabledamage",true)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end
function CleanUpPeds()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstPed()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 50.0 and ObjectFound ~= playerped then
    		if IsPedAPlayer(ObjectFound) or IsEntityAVehicle(ObjectFound) then
    		else
    			DeleteEntity(ObjectFound)
    		end            
        end
        success, ObjectFound = FindNextPed(handle)
    until not success
    EndFindPed(handle)
end

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 50.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    curappartmentnumber = 0
    TriggerEvent("DensityModifierEnable",true)
	TriggerEvent("inhotel",false)
end

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

function buildRoom(numMultiplier,roomType)
	-- this coord is the default object location, we use it to spawn in the interior.


	SetEntityCoords(PlayerPedId(), 152.09986877441 , -1004.7946166992, -98.999984741211)

	Citizen.Wait(5000)

	local generator = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
	generator.x = (175.09986877441) + ((numMultiplier * 12.0))
	
	if numMultiplier == myRoomNumber then
		myroomcoords = generator
	else
		curRoom = generator
	end

	SetEntityCoords(PlayerPedId(), generator.x - 1.6, generator.y - 4, generator.z + 0.6)
	TriggerEvent('sydresisso-op-or-maybe-og', true)
	local building = CreateObject(`furnitured_motel`,generator.x,generator.y,generator.z,false,false,false)

	FreezeEntityPosition(building,true)
	Citizen.Wait(100)
	FloatTilSafe(numMultiplier,roomType,building)
	
	CreateObject(`v_49_motelmp_stuff`,generator.x,generator.y,generator.z,false,false,false)
	CreateObject(`v_49_motelmp_bed`,generator.x+1.4,generator.y-0.55,generator.z,false,false,false)
	CreateObject(`v_49_motelmp_clothes`,generator.x-2.0,generator.y+2.0,generator.z+0.15,false,false,false)
	CreateObject(`v_49_motelmp_winframe`,generator.x+0.74,generator.y-4.26,generator.z+1.11,false,false,false)
	CreateObject(`v_49_motelmp_glass`,generator.x+0.74,generator.y-4.26,generator.z+1.13,false,false,false)
	CreateObject(`v_49_motelmp_curtains`,generator.x+0.74,generator.y-4.15,generator.z+0.9,false,false,false)

	CreateObject(`v_49_motelmp_screen`,generator.x-2.21,generator.y-0.6,generator.z+0.79,false,false,false)
	--props
	CreateObject(`v_res_fa_trainer02r`,generator.x-1.9,generator.y+3.0,generator.z+0.38,false,false,false)
	CreateObject(`v_res_fa_trainer02l`,generator.x-2.1,generator.y+2.95,generator.z+0.38,false,false,false)
	local door = CreateObject(`prop_sc1_12_door`,generator.x-1.0,generator.y-4.25,generator.z,false,false,true)
	local sink = CreateObject(`prop_sink_06`,generator.x+1.1,generator.y+4.0,generator.z,false,false,false)
	local chair1 = CreateObject(`prop_chair_04a`,generator.x+2.1,generator.y-2.4,generator.z,false,false,false)
	local chair2 = CreateObject(`prop_chair_04a`,generator.x+0.7,generator.y-3.5,generator.z,false,false,false)
	local kettle = CreateObject(`prop_kettle`,generator.x-2.3,generator.y+0.6,generator.z+0.9,false,false,false)
	local tvCabinet = CreateObject(`Prop_TV_Cabinet_03`,generator.x-2.3,generator.y-0.6,generator.z,false,false,false)
	local tv = CreateObject(`prop_tv_06`,generator.x-2.3,generator.y-0.6,generator.z+0.7,false,false,false)
	local toilet = CreateObject(`Prop_LD_Toilet_01`,generator.x+2.1,generator.y+2.9,generator.z,false,false,false)
	local clock = CreateObject(`Prop_Game_Clock_02`,generator.x-2.55,generator.y-0.6,generator.z+2.0,false,false,false)
	local phone = CreateObject(`v_res_j_phone`,generator.x+2.4,generator.y-1.9,generator.z+0.64,false,false,false)
	local ironBoard = CreateObject(`v_ret_fh_ironbrd`,generator.x-1.7,generator.y+3.5,generator.z+0.15,false,false,false)
	local iron = CreateObject(`prop_iron_01`,generator.x-1.9,generator.y+2.85,generator.z+0.63,false,false,false)
	local mug1 = CreateObject(`V_Ret_TA_Mug`,generator.x-2.3,generator.y+0.95,generator.z+0.9,false,false,false)
	local mug2 = CreateObject(`V_Ret_TA_Mug`,generator.x-2.2,generator.y+0.9,generator.z+0.9,false,false,false)
	CreateObject(`v_res_binder`,generator.x-2.2,generator.y+1.3,generator.z+0.87,false,false,false)
	
	FreezeEntityPosition(door, true)
	FreezeEntityPosition(sink,true)
	FreezeEntityPosition(chair1,true)	
	FreezeEntityPosition(chair2,true)
	FreezeEntityPosition(tvCabinet,true)	
	FreezeEntityPosition(tv,true)		
	SetEntityHeading(chair1,GetEntityHeading(chair1)+270)
	SetEntityHeading(chair2,GetEntityHeading(chair2)+180)
	SetEntityHeading(door,GetEntityHeading(door)-180)
	SetEntityHeading(kettle,GetEntityHeading(kettle)+90)
	SetEntityHeading(tvCabinet,GetEntityHeading(tvCabinet)+90)
	SetEntityHeading(tv,GetEntityHeading(tv)+90)
	SetEntityHeading(toilet,GetEntityHeading(toilet)+270)
	SetEntityHeading(clock,GetEntityHeading(clock)+90)
	SetEntityHeading(phone,GetEntityHeading(phone)+220)
	SetEntityHeading(ironBoard,GetEntityHeading(ironBoard)+90)
	SetEntityHeading(iron,GetEntityHeading(iron)+230)
	SetEntityHeading(mug1,GetEntityHeading(mug1)+20)
	SetEntityHeading(mug2,GetEntityHeading(mug2)+230)


	if not isForced then
		TriggerServerEvent('hotel:getID')
	end


	curRoomType = 1

end

function buildRoom2(numMultiplier,roomType)
	SetEntityCoords(PlayerPedId(),347.04724121094,-1000.2844848633,-99.194671630859)
	FreezeEntityPosition(PlayerPedId(),true)
	Citizen.Wait(5000)
	local generator = { x = 175.09986877441 , y = -904.7946166992, z = -98.999984741211}
	generator.x = (175.09986877441) + ((numMultiplier * 25.0))
	generator.y = (-774.7946166992) -- ((numMultiplier * 25.0))
	currentRoom = generator

	if numMultiplier == myRoomNumber then
		myroomcoords = generator
	else
		curRoom = generator
	end

	SetEntityCoords(PlayerPedId(), 	generator.x + 3.9, generator.y - 11.2, generator.z, generator.h)
	TriggerEvent('sydresisso-op-or-maybe-og', true)
	local building = CreateObject(`furnitured_midapart`,generator.x+2.29760700,generator.y-1.33191200,generator.z+1.26253700,false,false,false)
	FreezeEntityPosition(building,true)
	Citizen.Wait(100)
	FloatTilSafe(numMultiplier,roomType,building)
	if not isForced then
		TriggerServerEvent('hotel:getID')
	end
	curRoomType = 2
end

function getRotation(input)
	return 360/(10*input)
end

function FloatTilSafe(numMultiplier,roomType,buildingsent)
	SetEntityInvincible(PlayerPedId(),true)
	FreezeEntityPosition(PlayerPedId(),true)
	local plyCoord = GetEntityCoords(PlayerPedId())
	local processing = 3
	local counter = 100
	local building = buildingsent
	while processing == 3 do
		Citizen.Wait(100)
		if DoesEntityExist(building) then

			processing = 2
		end
		if counter == 0 then
			processing = 1
		end
		counter = counter - 1
	end

	if counter > 0 then
		SetEntityCoords(PlayerPedId(),plyCoord)
		CleanUpPeds()
	elseif processing == 1 then
		if roomType == 2 then
			SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
		elseif roomType == 3 then
			SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
		elseif roomType == 1 then
			SetEntityCoords(PlayerPedId(),312.96966552734,-218.2705078125,54.221797943115)
		end
		TriggerEvent("DoLongHudText","Failed to load, please retry.",2)	
	end
	TriggerEvent("reviveFunction")	

end

RegisterNetEvent("hotel:loadWarehouse")
AddEventHandler("hotel:loadWarehouse", function()
    renderPropsWhereHouse()
end)

RegisterNetEvent("hotel:clearWarehouse")
AddEventHandler("hotel:clearWarehouse", function()
    CleanUpArea()
end)



isJudge = true
RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
    isJudge = true
end)
RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
    isJudge = false
end)



function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)

end

function logout()
    TransitionToBlurred(500)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    CleanUpArea()
    Citizen.Wait(1000)   
		TriggerEvent("np-base:clearStates")
    exports["np-base"]:getModule("SpawnManager"):Initialize()

	Citizen.Wait(1000)
end

local canInteract = true

RegisterNetEvent('hotel:interactState')
AddEventHandler('hotel:interactState', function(state)
	canInteract = state
end)


RegisterNetEvent('newRoomType')
AddEventHandler('newRoomType', function(newRoomType)
	myRoomType = newRoomType
	TriggerEvent("hotel:myroomtype",myRoomType)
end)

local comparedst = 1000
function smallestDist(typeCheck)
	if typeCheck < comparedst then
		comparedst = typeCheck
	end
end

Controlkey = {
	["generalUse"] = {38,"E"},
	["housingMain"] = {74,"H"},
	["housingSecondary"] = {47,"G"}
} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["generalUse"] = table["generalUse"]
	Controlkey["housingMain"] = table["housingMain"]
	Controlkey["housingSecondary"] = table["housingSecondary"]

	if Controlkey["housingSecondary"] == nil or Controlkey["housingMain"] == nil or Controlkey["generalUse"] == nil then
		Controlkey = {["generalUse"] = {38,"E"},["housingMain"] = {74,"H"},["housingSecondary"] = {47,"G"}} 
	end
end)

Citizen.CreateThread(function()

 	while true do
		Citizen.Wait(0)

		comparedst = 1000

		local plyId = PlayerPedId()
		local plyCoords = GetEntityCoords(plyId)


		local entryUpgradesDst = #(vector3(260.72366333008,-375.27133178711,-44.137680053711) - plyCoords)
		local entry10th = #(vector3(apartments1[146]["x"],apartments1[146]["y"],apartments1[146]["z"]) - plyCoords)
		local entry9th = #(vector3(apartments1[132]["x"],apartments1[132]["y"],apartments1[132]["z"]) - plyCoords)
		local entry8th = #(vector3(apartments1[114]["x"],apartments1[114]["y"],apartments1[114]["z"]) - plyCoords)
		local entry7th = #(vector3(apartments1[89]["x"],apartments1[89]["y"],apartments1[89]["z"]) - plyCoords)
		local entry6th = #(vector3(apartments1[65]["x"],apartments1[65]["y"],apartments1[65]["z"]) - plyCoords)
		local entry5rd = #(vector3(apartments1[50]["x"],apartments1[50]["y"],apartments1[50]["z"]) - plyCoords)
		local entry4rd = #(vector3(4.67, -724.85, 32.18) -  plyCoords)
		local entry3rd = #(vector3(160.26762390137,-641.96905517578,47.073524475098) - plyCoords)
		local entry2nd = #(vector3(267.48132324219,-638.818359375,42.020294189453) - plyCoords)
		local entry1st = #(vector3(apartments1[1]["x"],apartments1[1]["y"],apartments1[1]["z"]) - plyCoords)
		local payTicketsDst = #(vector3(235.91, -416.43, -118.16) - plyCoords)
		
		smallestDist(payTicketsDst)
		smallestDist(entryUpgradesDst)
		smallestDist(entry10th)
		smallestDist(entry9th)
		smallestDist(entry8th)
		smallestDist(entry7th)
		smallestDist(entry6th)
		smallestDist(entry5rd)
		smallestDist(entry4rd)
		smallestDist(entry3rd)
		smallestDist(entry2nd)
		smallestDist(entry1st)

		if insideApartment or comparedst < 100 then

			if payTicketsDst < 5.0 then
				if payTicketsDst < 1.0 then
					DrawText3Ds(235.91, -416.43, -118.16, "Public Records")
					if IsControlJustReleased(1,Controlkey["generalUse"][1]) then
						TriggerEvent("phone:publicrecords")
						Citizen.Wait(2500)
					end	
				end

				if #(vector3(236.51, -414.43, -118.16) - plyCoords) < 1.0 then
					DrawText3Ds(236.51, -414.43, -118.16, "Property Records")
					if IsControlJustReleased(1, Controlkey["generalUse"][1]) then
						TriggerServerEvent("houses:PropertyListing")
						Citizen.Wait(2500)
					end	
				end

			end


			if entryUpgradesDst < 1.0 then
				DrawText3Ds(260.72366333008,-375.27133178711,-44.137680053711, "~g~"..Controlkey["generalUse"][2].."~s~ Upgrade Housing (25k for tier 2.")
				if IsControlJustReleased(1,Controlkey["generalUse"][1]) then
					TriggerEvent("hotel:AttemptUpgrade")
					Citizen.Wait(2500)
				end
			end

			if (entry4rd < 5 and myRoomType == 3) or (entry3rd < 5 and myRoomType == 3) or (entry1st < 45.0 and myRoomType == 1) or (entry5rd < 65.0 and myRoomType == 1) or (entry2nd < 5 and myRoomType == 2) or (entry6th < 81.0 and myRoomType == 1) or (entry7th < 81.0 and myRoomType == 1) or (entry8th < 81.0 and myRoomType == 1) or (entry8th < 81.0 and myRoomType == 1) or (entry10th < 81.0 and myRoomType == 1) then
        if myRoomType == 1 then
					local myappdist = #(vector3(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"]) - plyCoords)
          if myappdist < 15.0 then
						DrawMarker(20,apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"], 0, 0, 0, 0, 0, 0, 0.701,1.0001,0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
						if myappdist < 3.0 then
							if myRoomLock then
								DrawText3Ds(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"], "~g~"..Controlkey["housingMain"][2].."~s~ to enter ~g~"..Controlkey["housingSecondary"][2].."~s~ to unlock (" .. myRoomNumber .. ")")
							else
								DrawText3Ds(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"], "~g~H~s~ to enter ~g~G~s~ to lock (" .. myRoomNumber .. ")")
							end
						end
					end
				end

				if myRoomType == 2 then
					DrawMarker(27,267.48132324219,-638.818359375,41.020294189453, 0, 0, 0, 0, 0, 0, 7.001, 7.0001, 0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
					if myRoomLock then
						DrawText3Ds(267.48132324219,-638.818359375,42.020294189453, "~g~"..Controlkey["housingMain"][2].."~s~ to enter ~g~"..Controlkey["housingSecondary"][2].."~s~ to unlock (" .. myRoomNumber .. ")")
					else
						DrawText3Ds(267.48132324219,-638.818359375,42.020294189453, "~g~"..Controlkey["housingMain"][2].."~s~ to enter ~g~"..Controlkey["housingSecondary"][2].."~s~ to lock (" .. myRoomNumber .. ")")
					end
				end

				if myRoomType == 3 then
					if entry4rd < 5 then
						DrawMarker(27,4.67, -724.85, 32.18, 0, 0, 0, 0, 0, 0, 7.001, 7.0001, 0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
						if myRoomLock then
							DrawText3Ds(4.67, -724.85, 32.18, "~g~"..Controlkey["housingMain"][2].."~s~ to enter ~g~"..Controlkey["housingSecondary"][2].."~s~ to unlock (" .. myRoomNumber .. ")")
						else
							DrawText3Ds(4.67, -724.85, 32.18, "~g~"..Controlkey["housingMain"][2].."~s~ to enter ~g~"..Controlkey["housingSecondary"][2].."~s~ to lock (" .. myRoomNumber .. ")")
						end
					else
						DrawMarker(27,160.26762390137,-641.96905517578,47.073524475098, 0, 0, 0, 0, 0, 0, 7.001, 7.0001, 0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
						if myRoomLock then
							DrawText3Ds(160.26762390137,-641.96905517578,47.073524475098, "~g~"..Controlkey["housingMain"][2].."~s~ to enter ~g~"..Controlkey["housingSecondary"][2].."~s~ to unlock (" .. myRoomNumber .. ")")
						else
							DrawText3Ds(160.26762390137,-641.96905517578,47.073524475098, "~g~"..Controlkey["housingMain"][2].."~s~ to enter ~g~"..Controlkey["housingSecondary"][2].."~s~ to lock (" .. myRoomNumber .. ")")
						end
					end

				end

				if IsControlJustReleased(1,Controlkey["housingSecondary"][1]) then
					if #(vector3(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"]) - plyCoords) < 5 and myRoomType == 1 then	
						TriggerEvent("dooranim")
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'keydoors', 0.4)
						if myRoomLock == false then
						TriggerServerEvent("hotel:updateLockStatus",true)
				
						Citizen.Wait(500)
						else
							TriggerServerEvent("hotel:updateLockStatus",false)
						end
					elseif myRoomType ~= 1 then
						TriggerEvent("dooranim")
						TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'keydoors', 0.4)
						if myRoomLock == false then
							TriggerServerEvent("hotel:updateLockStatus",true)
					
							Citizen.Wait(500)
							else
								TriggerServerEvent("hotel:updateLockStatus",false)
							end
						Citizen.Wait(500)
					end
				end


				if IsControlJustReleased(1,Controlkey["housingMain"][1]) then
					TriggerEvent("DoLongHudText","Please wait!",1)

					Citizen.Wait(300)
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)

					if #(vector3(apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"]) - plyCoords) < 5 and myRoomType == 1 then	
						processBuildType(myRoomNumber,myRoomType)
						TriggerServerEvent("hotel:getInfo")
						Citizen.Wait(500)
					elseif (#(vector3(160.26762390137,-641.96905517578,47.073524475098) - plyCoords) < 5 and myRoomType == 3) or entry4rd < 5 then
						processBuildType(myRoomNumber,myRoomType)
						TriggerServerEvent("hotel:getInfo")
						Citizen.Wait(500)					
					elseif #(vector3(267.48132324219,-638.818359375,42.020294189453) - plyCoords) < 5 and myRoomType == 2 then
						processBuildType(myRoomNumber,myRoomType)
						TriggerServerEvent("hotel:getInfo")
						Citizen.Wait(500)
					else
						TriggerEvent("DoLongHudText","Moved too far away!",2)
					end			
				end
			end

			if #(vector3(myroomcoords.x-2, myroomcoords.y + 2.5, myroomcoords.z) - plyCoords) < 5.5 and curRoomType == 1 then
				DrawText3Ds(myroomcoords.x-2, myroomcoords.y + 2.5, myroomcoords.z+1.5, '/outfits')
			elseif #(vector3(myroomcoords.x+8, myroomcoords.y + 4, myroomcoords.z+0.4) - plyCoords) < 5.5 and curRoomType == 2 then
				DrawText3Ds(myroomcoords.x+8, myroomcoords.y + 4, myroomcoords.z+2.4, ' /outfits')
			elseif #(vector3(myroomcoords.x + 6, myroomcoords.y + 6, myroomcoords.z) - plyCoords) < 2.5 and curRoomType == 3 then
				DrawText3Ds(myroomcoords.x + 6, myroomcoords.y + 6, myroomcoords.z+1.5, '/outfits')
			end	
			if 	(#(vector3(myroomcoords.x - 14.3, myroomcoords.y - 02.00, myroomcoords.z + 7.02) - plyCoords) < 3.0 and curRoomType == 3) or 
				(#(vector3(myroomcoords.x + 4.30, myroomcoords.y - 15.95, myroomcoords.z + 0.42) - plyCoords) < 3.0 and curRoomType == 2) or 
				(#(vector3(myroomcoords.x - 2.00, myroomcoords.y - 04.00, myroomcoords.z) - plyCoords) < 3.0 and curRoomType == 1) 
			then
				
				if curRoomType == 2 then
					DrawText3Ds(myroomcoords.x + 4.3,myroomcoords.y - 15.95,myroomcoords.z+2.42, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave')
				elseif curRoomType == 3 then
					DrawText3Ds(myroomcoords.x - 14.45,myroomcoords.y - 2.5,myroomcoords.z+7.3, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave or ~g~'..Controlkey["housingSecondary"][2]..'~s~ to enter garage.')				
				elseif curRoomType == 1 then
					DrawText3Ds(myroomcoords.x - 1.15,myroomcoords.y - 4.2,myroomcoords.z+1.20, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave')
				end

				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)
					Wait(330)
					CleanUpArea()
					isForced = false
					TriggerEvent("enabledamage",false)
					if curRoomType == 2 then
						SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
					elseif curRoomType == 3 then
						SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
					elseif curRoomType == 1 then
						SetEntityCoords(PlayerPedId(),apartments1[myRoomNumber]["x"],apartments1[myRoomNumber]["y"],apartments1[myRoomNumber]["z"])
					end
					TriggerEvent("enabledamage",true)
					insideApartment = false
					Citizen.Wait(100)
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorClose', 0.7)
					curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
					TriggerEvent("attachWeapons")
				end

				if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) and curRoomType == 3 then
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)
					Wait(330)
					isForced = false
					insideApartment = false
					CleanUpArea()
					DoScreenFadeOut(1)
					buildGarage()
					Citizen.Wait(4500)
					DoScreenFadeIn(1)
				end
 
			end

			if 	(#(vector3(myroomcoords.x - 1.6, myroomcoords.y + 1.20, myroomcoords.z + 1.00) - plyCoords) < 5.0 and curRoomType == 1) or 
				(#(vector3(myroomcoords.x + 9.8, myroomcoords.y - 1.35, myroomcoords.z + 0.15) - plyCoords) < 5.0 and curRoomType == 2) or 
				(#(vector3(myroomcoords.x + 1.5, myroomcoords.y + 8.00, myroomcoords.z + 1.00) - plyCoords) < 5.0 and curRoomType == 3) 
				and canInteract 
			then
				if curRoomType == 2 then
					DrawText3Ds(myroomcoords.x+9.8, myroomcoords.y - 1.35, myroomcoords.z+2.15, '~g~'..Controlkey["housingMain"][2]..'~s~ to interact')
				elseif curRoomType == 3 then
					DrawText3Ds(myroomcoords.x + 1.5, myroomcoords.y + 8, myroomcoords.z+1, '~g~'..Controlkey["housingMain"][2]..'~s~ to interact')
				elseif curRoomType == 1 then
					DrawText3Ds(myroomcoords.x - 1.6,myroomcoords.y + 1.2, myroomcoords.z+1, '~g~'..Controlkey["housingMain"][2]..'~s~ to interact')
				end

				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
					if inRoom() then
						canInteract = false
						TriggerEvent('InteractSound_CL:PlayOnOne','StashOpen', 0.6)
						maxRoomWeight = 100.0 * (curRoomType * 2)
						local cid = exports["isPed"]:isPed("cid")
						if not isForced then
							TriggerServerEvent('hotel:getID')
						end
						TriggerEvent("server-inventory-open", "1", "motel"..curRoomType.."-"..cid)

						TriggerEvent("actionbar:setEmptyHanded")
					else
						TriggerEvent("DoLongHudText","This is not your stash!",2)
					end
					Citizen.Wait(1900)
				end
			end

		if 	(#(vector3(curRoom.x - 1.6, curRoom.y + 1.20, curRoom.z + 1.00) - plyCoords) < 2.0 and curRoomType == 1) or 
			(#(vector3(curRoom.x + 9.8, curRoom.y - 1.35, curRoom.z + 0.15) - plyCoords) < 2.0 and curRoomType == 2) or 
			(#(vector3(curRoom.x + 1.5, curRoom.y + 8.00, curRoom.z + 1.00) - plyCoords) < 2.0 and curRoomType == 3) and 
			canInteract 
		then

			if curRoomType == 2 then
				DrawText3Ds(curRoom.x+9.8, curRoom.y - 1.35, curRoom.z+2.15, '~g~'..Controlkey["housingMain"][2]..'~s~ to interact')
			elseif curRoomType == 3 then
				DrawText3Ds(curRoom.x + 1.5, curRoom.y + 8, curRoom.z+1, '~g~'..Controlkey["housingMain"][2]..'~s~ to interact')
			elseif curRoomType == 1 then
				DrawText3Ds(curRoom.x - 1.6,curRoom.y + 1.2, curRoom.z+1, '~g~'..Controlkey["housingMain"][2]..'~s~ to interact')
			end

			if IsControlJustReleased(1, Controlkey["housingMain"][1]) then

				local myJob = exports["isPed"]:isPed("myJob")
				local LEO = false
				if myJob == "police" or myJob == "judge" then
					LEO = true
				end

				if LEO then
					canInteract = false
					TriggerEvent('InteractSound_CL:PlayOnOne','StashOpen', 0.6)
					maxRoomWeight = 500.0 * curRoomType
					TriggerServerEvent('hotel:getID')
					--TriggerServerEvent('hotel:GetInteract',maxRoomWeight,forcedID)

					TriggerEvent("server-inventory-open", "1", "motel"..curRoomType.."-"..forcedID)

				else
					TriggerEvent("DoLongHudText","This is not your stash!",2)
				end
				Citizen.Wait(1900)
			end

		end



	
		if 	(#(vector3(curRoom.x - 14.3,curRoom.y - 2,curRoom.z+7.02) - plyCoords) < 3.0 and curRoomType == 3) or 
			(#(vector3(curRoom.x + 4.3,curRoom.y - 15.95,curRoom.z+0.42) - plyCoords) < 3.0 and curRoomType == 2) or 
			(#(vector3(curRoom.x - 2,curRoom.y - 4,curRoom.z) - plyCoords) < 3.0 and curRoomType == 1) 
		then
				if curRoomType == 2 then
					DrawText3Ds(curRoom.x + 4.3,curRoom.y - 15.95,curRoom.z+2.42, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave')
				elseif curRoomType == 3 then
					DrawText3Ds(curRoom.x - 14.45,curRoom.y - 2.5,curRoom.z+7.3, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave or ~g~'..Controlkey["housingSecondary"][2]..'~s~ to enter garage.')	
				elseif curRoomType == 1 then
					DrawText3Ds(curRoom.x - 1.15,curRoom.y - 4.2,curRoom.z+1.20, '~g~'..Controlkey["housingMain"][2]..'~s~ to leave')
				end

				if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) and curRoomType == 3 then
					TriggerEvent("dooranim")
					TriggerEvent('InteractSound_CL:PlayOnOne','DoorOpen', 0.7)
					Wait(330)
					isForced = false
					insideApartment = false
					CleanUpArea()
					DoScreenFadeOut(1)
					buildGarage()
					Citizen.Wait(4500)
					DoScreenFadeIn(1)
				end


				if IsControlJustReleased(1, Controlkey["housingMain"][1]) then

					Wait(200)
					CleanUpArea()

					if curRoomType == 2 then
						SetEntityCoords(PlayerPedId(),267.48132324219,-638.818359375,42.020294189453)
					elseif curRoomType == 3 then
						SetEntityCoords(PlayerPedId(),160.26762390137,-641.96905517578,47.073524475098)
					elseif curRoomType == 1 then
						SetEntityCoords(PlayerPedId(),313.2561340332,-227.30776977539,54.221176147461)
					end

					Citizen.Wait(2000)
					curRoom = { x = 1420.0, y = 1420.0, z = -900.0 }
					TriggerEvent("attachWeapons")
				end

			end
		else
			if ingarage then
				if #(vector3(currentGarage.x+9.5 , currentGarage.y-12.7, currentGarage.z+1.0) - plyCoords) < 3.0 then
					DrawText3Ds(currentGarage.x+9.5, currentGarage.y-12.7, currentGarage.z+1.0, '~g~'..Controlkey["housingMain"][2]..'~s~ to Room ~g~'..Controlkey["housingSecondary"][2]..'~s~ to Garage Door')
					if IsControlJustReleased(1, Controlkey["housingMain"][1]) then
						TriggerEvent("Garages:ToggleHouse",false)
						Wait(200)
						CleanUpArea()
						processBuildType(garageNumber,3)
						ingarage = false
						TriggerEvent("attachWeapons")
					end
					if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) then
						TriggerEvent("Garages:ToggleHouse",false)
						Wait(200)
						CleanUpArea()
						SetEntityCoords(PlayerPedId(),4.67, -724.85, 32.18)
						ingarage = false
						TriggerEvent("attachWeapons")
					end
				else
					DisplayHelpText('Press ~g~'..Controlkey["housingSecondary"][2]..'~s~ while in a vehicle to spawn it.')
					if IsControlJustReleased(1, Controlkey["housingSecondary"][1]) then
						if IsPedInAnyVehicle(PlayerPedId(), false) then
							local carcarbroombrooms = GetClosestVehicle(-41.43, -716.53, 32.54, 3.000, 0, 70)

							if not DoesEntityExist(carcarbroombrooms) then
								local vehmove = GetVehiclePedIsIn(PlayerPedId(), true)
								
								SetEntityCoords(vehmove,-41.43, -716.53, 32.54)
								SetEntityHeading(vehmove,170.0)
								Wait(200)
								CleanUpArea()
								SetPedIntoVehicle(PlayerPedId(), vehmove, - 1)
								TriggerEvent("Garages:HouseRemoveVehicle",vehmove)
								ingarage = false
								
							else
								TriggerEvent("DoShortHudText","Vehicle on spawn.",2)
							end

							--leaveappartment
						else
							TriggerEvent("DoShortHudText","Enter Vehicle First", 2)
						end
					end
				end
				local lights = plyCoords
				DrawLightWithRange(lights["x"],lights["y"],lights["z"]+3, 255, 197, 143, 100.0, 0.45)
				DrawLightWithRange(lights["x"],lights["y"],lights["z"]-3, 255, 197, 143, 100.0, 0.45)
			else
				Citizen.Wait(math.ceil(comparedst * 10))
			end
			
		end
	end
end)

function nearClothingMotel()
	if #(vector3(myroomcoords.x, myroomcoords.y + 3, myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 5.5 and curRoomType == 1 then
		return true
	end
	if #(vector3(myroomcoords.x + 10, myroomcoords.y + 6, myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 5.5 and curRoomType == 2 then
		return true
	end	
	if #(vector3(myroomcoords.x - 3, myroomcoords.y - 7, myroomcoords.z) - GetEntityCoords(PlayerPedId())) < 55.5 and curRoomType == 3 then
		return true
	end		

	if #(vector3(1782.86, 2494.95, 50.43) - GetEntityCoords(PlayerPedId())) < 8.5 then
		return true
	end	

	local myjob = exports["isPed"]:isPed("myjob")
	--missionrow locker room
	if myjob == "police" then
		return true
	end

	if myjob == "ems" then
		return true
	end

	if myjob == "doctor" then
		return true
	end
	return false
end






RegisterNetEvent('hotel:listSKINSFORCYRTHESICKFUCK')
AddEventHandler('hotel:listSKINSFORCYRTHESICKFUCK', function(skincheck)
	for i = 1, #skincheck do
		TriggerEvent("DoLongHudText", skincheck[i].slot .. " | " .. skincheck[i].name,i)
	end
end)

RegisterNetEvent('hotel:outfit')
AddEventHandler('hotel:outfit', function(args,sentType)

	if nearClothingMotel() then
		if sentType == 1 then
			local id = args[2]
			table.remove(args, 1)
			table.remove(args, 1)
			strng = ""
			for i = 1, #args do
				strng = strng .. " " .. args[i]
			end
			TriggerEvent("urp-clothing:outfits", sentType, id, strng)
		elseif sentType == 2 then
			local id = args[2]
			TriggerEvent("urp-clothing:outfits", sentType, id)
		elseif sentType == 3 then
			local id = args[2]
			TriggerEvent('item:deleteClothesDna')
			TriggerEvent('InteractSound_CL:PlayOnOne','Clothes1', 0.6)
			TriggerEvent("urp-clothing:outfits", sentType, id)
		else
			TriggerServerEvent("urp-clothing:list_outfits")
		end
	end
end)