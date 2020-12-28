
fx_version 'adamant'
games { 'gta5' }

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@urp-base/locale.lua',
	'server/main.lua'
}

client_scripts {
	'@urp-base/locale.lua',
	'client/main.lua',
	"@urp-errorlog/client/cl_errorlog.lua"
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/img/esx_identity.png'
}

dependency 'urp-base'