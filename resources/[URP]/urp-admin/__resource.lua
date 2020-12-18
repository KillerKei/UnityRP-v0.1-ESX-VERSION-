resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

--dependency "urp-base"
dependency "ghmattimysql"


client_script "@urp-errorlog/client/cl_errorlog.lua"

client_script "@urp-infinity/client/cl_lib.lua"
server_script "@urp-infinity/server/sv_lib.lua"

ui_page "html/index.html"

files({
    "html/index.html",
    "html/script.js",
    "html/styles.css"
})

server_script "shared/sh_admin.lua"
server_script "shared/sh_commands.lua"
server_script "shared/sh_ranks.lua"
server_script '@mysql-async/lib/MySQL.lua'

client_script "shared/sh_admin.lua"
client_script "client/WarMenu.lua"
client_script "client/cl_menu.lua"

client_script "shared/sh_commands.lua"
client_script "shared/sh_ranks.lua"

server_script "server.lua"

client_script "client/cl_admin.lua"