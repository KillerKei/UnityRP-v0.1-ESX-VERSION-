resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Identity'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@urp-core/locale.lua',
	'server/main.lua'
}

client_scripts {
	'@urp-core/locale.lua',
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

dependency 'urp-core'

fx_version 'adamant'
games { 'gta5' }