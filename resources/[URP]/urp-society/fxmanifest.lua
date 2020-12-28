fx_version 'adamant'
games { 'gta5' }

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@urp-base/locale.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@urp-base/locale.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua',
	"@urp-errorlog/client/cl_errorlog.lua"
}

dependencies {
	'urp-base',
	'cron',
	'urp-addonaccount'
}
