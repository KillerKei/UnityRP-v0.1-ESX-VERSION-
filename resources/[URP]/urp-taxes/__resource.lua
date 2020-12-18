resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'URPCore Taxes'

version '87.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua',
}