resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"


client_script "@irp-errorlog/client/cl_errorlog.lua"

client_script 'apart_client.lua'
server_script 'apart_server.lua'

client_script 'GUI.lua'

client_script 'hotel_client.lua'
server_script 'hotel_server.lua'
client_script 'houserobberies_client.lua'
server_script 'houserobberies_server.lua'
client_script 'safecracking.lua'
server_script '@mysql-async/lib/MySQL.lua'


ui_page 'index.html'

files {
  "index.html",
  "scripts.js",
  "css/style.css"
}