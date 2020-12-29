resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_script "@urp-errorlog/client/cl_errorlog.lua"

client_scripts {
    'client.lua',
    'wound.lua',
    'config.lua'
}
server_scripts {
    'config.lua',
    'server.lua'
}

