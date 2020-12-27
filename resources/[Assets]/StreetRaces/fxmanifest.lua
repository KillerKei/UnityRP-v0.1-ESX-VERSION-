fx_version 'adamant'
games { 'gta5' }

server_scripts {
    "config.lua",
    "port_sv.lua",
    "races_sv.lua",
}

client_scripts {
    "config.lua",
    "races_cl.lua",
    "@urp-errorlog/client/cl_errorlog.lua"
}

exports {
    'cleanupRecording',
    'isRecordingRace',
    'cpCount'
}