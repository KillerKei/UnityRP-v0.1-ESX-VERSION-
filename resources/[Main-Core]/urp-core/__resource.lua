resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'urp-core'

version '1.1.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'locale.lua',
	'locales/en.lua',
	
	'config.lua',

	'server/common.lua',
	'server/classes/player.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	'server/commands.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua',
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
	'locale.lua',
	'locales/en.lua',

	'config.lua',
	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/main.lua',

	'client/modules/death.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua',
	'client/client-functions/main.lua',
	"@urp-errorlog/client/cl_errorlog.lua"
}

ui_page {
	'html/ui.html'
}

files {
	'locale.js',
	'html/ui.html',

	'html/css/app.css',

	'html/js/mustache.min.js',
	'html/js/wrapper.js',
	'html/js/app.js',

	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf',

	'html/img/accounts/bank.png',
	'html/img/accounts/black_money.png'
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
