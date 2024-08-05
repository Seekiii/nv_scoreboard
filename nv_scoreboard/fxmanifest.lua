fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Nevera Development'
description 'Free Scoreboard'
version '1.0.0'

server_scripts {
	'config.lua',
	'server/server.lua'
}

client_scripts {
	'config.lua',
	'client/client.lua'
}
files {
    'html/index.html',
    'html/assets/js/**',
    'html/assets/css/**',
    'html/assets/img/**'
}
ui_page 'html/index.html'