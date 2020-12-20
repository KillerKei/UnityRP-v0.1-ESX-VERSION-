fx_version 'adamant'
games { 'gta5' }

server_scripts {
	'server/server-functions/sqlite/SQLite.net.dll',
	'server/server-functions/sqlite/sqlite.js',
	'config.lua',
	'server/server-functions/util.lua',
	'server/server-functions/main.lua',
	'server/server-functions/db.lua',
	'server/server-functions/classes/player.lua',
	'server/server-functions/classes/groups.lua',
	'server/server-functions/player/login.lua',
	'server/server-functions/metrics.lua'
}

client_scripts {
	'client/client-functions/main.lua',
	"@urp-errorlog/client/cl_errorlog.lua"
}

exports {
	'getUser'
}

server_exports {
	'getPlayerFromId',
	'addAdminCommand',
	'addCommand',
	'addGroupCommand',
	'addACECommand',
	'canGroupTarget',
	'log',
	'debugMsg',
}