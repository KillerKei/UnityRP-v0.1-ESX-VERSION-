fx_version 'bodacious'
games { 'rdr3', 'gta5' }

author 'whitewingz'
description 'One City Garage'
version '1.0.0'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@urp-base/locale.lua',
	'server/server.lua',
	'server/s_chopshop.lua'
}

client_script {
	'@urp-base/locale.lua',
	'client/client.lua',
	'client/illegal_parts.lua',
	'client/chopshop.lua',
	'client/gui.lua'
}

