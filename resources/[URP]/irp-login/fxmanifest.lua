fx_version 'adamant'
game 'gta5'

client_script 'client.lua'
server_script 'server.lua'
shared_script 'shared.lua'
server_script('@mysql-async/lib/MySQL.lua')

files {
    'html/index.html',
    'html/css/main.css',
    'html/js/script.js',
    'html/logo.png',
}

ui_page 'html/index.html'

