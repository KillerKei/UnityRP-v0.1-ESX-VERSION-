fx_version 'bodacious'
games { 'rdr3', 'gta5' }

description 'URPCore'
version '1.0.0'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
<<<<<<< HEAD
	'server.lua',
	's_chopshop.lua'
}

client_script {
	'client.lua',
	'illegal_parts.lua',
	'chopshop.lua',
	'gui.lua'
=======
	'@urp-core/locale.lua',
	'server/server.lua',
	'server/s_chopshop.lua'
}

client_script {
	'@urp-core/locale.lua',
	'client/client.lua',
	'client/illegal_parts.lua',
	'client/chopshop.lua',
	'client/gui.lua'
>>>>>>> b2daf08b272af93893931e0c84dc44b32ee1d8c5
}
