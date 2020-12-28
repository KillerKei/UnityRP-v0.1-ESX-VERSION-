resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'urp-base'

version '1.1.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'locale.lua',
	'locales/en.lua',
	
	'config.lua',

	'events/sv_common.lua',
	'events/classes/sv_players.lua',
	'events/sv_functions.lua',
	'events/sv_check.lua',
	'events/sv_main.lua',
	'events/sv_commands.lua',

	'playermanager/modules/serverevents.lua',
	'playermanager/modules/event_tables.lua',
	'playermanager/server.lua',
	'events/server-functions/sqlite/SQLite.net.dll',
	'events/server-functions/sqlite/sqlite.js',
	'config.lua',
	'events/server-functions/sv_util.lua',
	'events/server-functions/sv_playerevents.lua',
	'events/server-functions/sv_db.lua',
	'events/server-functions/classes/sv_players.lua',
	'events/server-functions/classes/sv_groups.lua',
	'events/server-functions/player/sv_login.lua',
	'events/server-functions/player/sv_wrappers.lua',
	'events/server-functions/sv_metric.lua'
}

client_scripts {
	'locale.lua',
	'locales/en.lua',

	'config.lua',
	'shared/sh_init.lua',
	'shared/sh_entityiter.lua',
	'shared/sh_functions.lua',
	'shared/sh_wrapper.lua',
	'shared/sh_main.lua',

	'shared/modules/mod_death.lua',
	'shared/modules/mod_scaleform.lua',
	'shared/modules/mod_streaming.lua',

	'playermanager/modules/event_tables.lua',
	'playermanager/modules/serverevents.lua',
	'playermanager/functions.lua',
	'shared/client-functions/func_main.lua',
	"@urp-errorlog/client/cl_errorlog.lua"
}

ui_page {
	'nui/ui.html'
}

files {
	'locale.js',
	'nui/ui.html',

	'nui/css/app.css',

	'nui/js/mustache.min.js',
	'nui/js/wrapper.js',
	'nui/js/app.js',

	'nui/fonts/pdown.ttf',
	'nui/fonts/bankgothic.ttf',

	'nui/img/accounts/bank.png',
	'nui/img/accounts/black_money.png'
}

exports {
	'getSharedObject',
	'getUser'
}

server_exports {
	'getSharedObject',
	'getCurrentCharacter',
	'getPlayerFromId',
	'addAdminCommand',
	'addCommand',
	'addGroupCommand',
	'addACECommand',
	'canGroupTarget',
	'log',
	'debugMsg'
}

dependencies {
	'mysql-async',
	'async'
}
