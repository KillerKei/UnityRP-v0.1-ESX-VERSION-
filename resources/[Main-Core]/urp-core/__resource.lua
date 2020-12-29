resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'URP Core'

version '1.1.0'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'locale.lua',
	'locales/en.lua',
	
	'sh_init.lua',

	'playermanager/server.lua',
	'player/sv_settings.lua',
	'spawnmanager/cl_spawnmanager.lua',
	'player/sv_player.lua',
	'player/sv_controls.lua',
	'gameplay/cl_gameplay.lua',

	'database/sv_db.lua',
	'events/sv_events.lua',
	'core/cl_core.lua'
}

client_scripts {
	'locale.lua',
	'locales/en.lua',

	'sh_init.lua',
	'blipmanager/cl_blipmanager.lua',
	'blipmanager/cl_blips.lua',
	'commands/cl_commands.lua',
	'core/sv_characters.lua',
	'core/sh_core.lua',

	'core/sv_core.lua',
	'events/cl_events.lua',
	'events/sh_events.lua',

	'database/sv_db.lua',
	'events/sv_events.lua',
	'core/cl_core.lua',
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
	'getSharedObject'
}

server_exports {
	'getSharedObject',
	'getCurrentCharacter'
}

dependencies {
	'mysql-async',
	'urp-base',
	'async'
}
