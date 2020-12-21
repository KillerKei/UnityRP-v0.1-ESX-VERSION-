resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "urp-core"


client_script "@urp-errorlog/client/cl_errorlog.lua"

server_script "server/sv_log.lua"

server_export "AddLog"