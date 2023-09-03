_addon.name     = 'TellAlert'
_addon.author   = 'Bee'
_addon.description = 'High visibility message appears when you get a DM.'
_addon.version  = '0.4'
_addon.commands = {'tellalert'}
_addon.commands = {'ta'}

config = require('config')
texts = require('texts')

state = {
	alerts_enabled = false,
	alert_on_screen = true,
	total_undismissed = 0,
	replied_to_gm = false,
}
settings = config.load('data/settings.xml')
box = texts.new(settings)

local function auto_reply(name, message, delay)
	windower.send_command('wait ' .. delay .. ';input /tell ' .. name .. ' ' .. message)
end

local function panic_button()
	windower.send_command('lua unload shuckmaster')
	windower.send_command('lua unload claimtools')
	windower.ffxi.run(false)
end

local function message(message_text)
	windower.add_to_chat(settings.chat_color,'[' .. _addon.name .. '] ' .. message_text)
end

local function display_alert(message_text, player, isGM)
	state.alert_on_screen = true
	state.total_undismissed = state.total_undismissed + 1
	if(isGM) then
		gm_text = " (GM!)"
	else
		gm_text = ''
	end
	box:text('/tell from: ' .. player .. gm_text .. '\nUnread: ' .. tostring(state.total_undismissed))
	box:visible(true)
end

local function enable_tell_alerts()
	state.alerts_enabled = true
	message('Alerts enabled!')
end

local function disable_tell_alerts()
	state.alerts_enabled = false
	message('Alerts disabled!')
end

local function dismiss_alert()
	state.alert_on_screen = false
	message('Alerts dismissed (' .. tostring(state.total_undismissed) .. ')')
	state.total_undismissed = 0
	box:visible(false)
end

handlers = {} 
handlers['enable'] = enable_tell_alerts
handlers['disable'] = disable_tell_alerts
handlers['dismiss'] = dismiss_alert
local function handle_command(cmd, ...)
    local cmd = cmd or 'help'
    if handlers[cmd] then
        local msg = handlers[cmd](unpack({...}))
        if msg then
            error(msg)
        end
    else
        error("Unknown command %s":format(cmd))
    end
end
windower.register_event('addon command', handle_command)

windower.register_event('chat message',function(message_text,player,mode,isGM)
    if mode==3 and state.alerts_enabled then
        display_alert(message_text, player, isGM)
		if(isGM and not state.replied_to_gm) then 
			state.replied_to_gm = true
			auto_reply(player, 'Hello, officer. i was doing the speed limit', 6)
		end
    end
	if(isGM) then
		panic_button()
	end
end)
