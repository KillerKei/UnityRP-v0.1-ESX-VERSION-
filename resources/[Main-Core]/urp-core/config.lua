Config                      = {}
Config.Locale               = 'en'

Config.Accounts             = { 'bank', 'black_money' }
Config.AccountLabels        = { bank = _U('bank'), black_money = _U('black_money') }

Config.EnableSocietyPayouts = false -- pay from the society account that the player is employed at? Requirement: drp_society
Config.DisableWantedLevel   = true
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)

Config.PaycheckInterval     = 15 * 60000

Config.EnableDebug          = false

ip = GetConvar('es_couchdb_url', '127.0.0.1') 	        -- Change to wherever your DB is hosted, use convar
port = GetConvar('es_couchdb_port', '5984') 	        -- Change to whatever port you have CouchDB running on, use convar
auth = GetConvar('es_couchdb_password', 'root:1202') 	-- "user:password", if you have auth setup, use convar
metrics = GetConvar('es_enable_metrics', '1')           -- Change to '0' to disable metrics, no identifiable data is stored