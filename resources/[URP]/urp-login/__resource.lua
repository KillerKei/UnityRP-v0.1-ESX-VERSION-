resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/main.lua",
    "config.lua",
}

client_scripts {
    "client/main.lua",
    "config.lua",
}

ui_page {
    'html/ui.html',
}
files {
    'html/ui.html',

    'html/css/new.css',
    'html/css/ollie.css',

    'html/img/logo.png',
    'html/img/frenzy_bg_2.jpg',
    'html/img/frenzy_bg_3.jpg',
    'html/img/frenzy_bg_4.jpg',
    'html/img/frenzy_bg_5.jpg',
    'html/img/frenzy_bg_6.jpg',
    'html/img/frenzy_bg_8.jpg',

    'html/js/ollie.js',
    'html/js/popper.min.js',
    'html/js/jquery-3.3.1.min.js',
    'html/js/bootstrap.min.js',
}
<<<<<<< HEAD:resources/[URP]/urp-login/__resource.lua
=======

dependencies {
    'urp-core',
    'urp-core'
}
>>>>>>> 98c92594de0bee67b443d6f677dd1682504994d4:resources/[URP]/urp-login/fxmanifest.lua
