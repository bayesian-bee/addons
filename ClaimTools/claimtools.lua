_addon.name     = 'ClaimTools'
_addon.author   = 'Bee'
_addon.description = 'Helps you claim the monsters you want, and track ToDs.'
_addon.version  = '0.7'
_addon.commands = {'claimtools'}
_addon.commands = {'ct'}

--TODO: build ToDs
--TODO: build claim mode

nms = require('notorious_monsters')
require('vectors')
math = require('math')
packets = require('packets')

PACKET_IDS = {
	INCOMING = {
		MOB_SPAWN = 0x05B,
		ENV_ANIMATION = 0x038,
		STATUS_FLAGS = 0x00E,
		WIDESCAN = 0x0F4,
		TARGET = 0x058,
	},
	OUTGOING = {
		WIDESCAN = 0x0F4,
	}
}
CLAIM_MODE = {CLAIM = 1, ORIENT = 2, INFORM = 3, PURSUE = 4}
CLAIM_MODE_NAMES = {[1] = "Claim", [2] = "Orient", [3] = "Inform"}
CHAT_COLOR = 55
REPORTING_DELAY = 1
local function new_state()
	state = {
		claim_mode = CLAIM_MODE.INFORM,
		widescan_tracking_list = {},
		last_reported_time = 0,
		attempting_claim = false,
	}
end
new_state()

local function message(message_text)
	windower.add_to_chat(CHAT_COLOR,'[' .. _addon.name .. '] ' .. message_text)
end

local function reset_state()
	message('Resetting tracking list and claim state...')
	new_state()
end

local function get_current_timestamp()
	return os.time(os.date("!*t"))
end

local function get_player_info()
	return windower.ffxi.get_mob_by_id(windower.ffxi.get_player().id)
end

local function nms_in_this_zone()
	return nms[windower.ffxi.get_info()['zone']]
end

local function is_nm(mob_id)
	local nms_in_this_zone = nms_in_this_zone()
	if nms_in_this_zone[mob_id] then
		return nms_in_this_zone[mob_id].is_nm
	else
		return false 
	end
end

--https://stackoverflow.com/questions/33510736/check-if-array-contains-specific-value
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local function quadrant_correction(v)
	if(v[1] >= 0 and v[2] >= 0) then
		return 0
	elseif(v[1] < 0 and v[2] >= 0) then
		return 180
	elseif(v[1] < 0 and v[2] < 0) then
		return 180
	else
		return 360
	end
end

local function get_2d_vector_angle(v)
	return quadrant_correction(v) + math.deg(math.atan(v[2] / v[1]))
end

local function angle_of_vector_between_two_points(point1, point2)
	return get_2d_vector_angle(vector.subtract(point2, point1))
end


local function get_mob_name(mob_id)

	for i,v in pairs(windower.ffxi.get_mob_array()) do
		if v['id'] == mob_id then
			return v['name']
		end
	end
	return nil
end

local function get_mob_compass_direction(mob_x, mob_y)
	local me = windower.ffxi.get_mob_by_id(windower.ffxi.get_player().id)
	local angle = angle_of_vector_between_two_points(V({me.x, me.y}), V({mob_x, mob_y}))
	
	local compass_direction = ''
	if(angle >= 337.5 or angle < 22.5) then
		compass_direction = 'East'
	elseif(angle >= 22.5 and angle  < 67.5) then
		compass_direction = 'NorthEast'
	elseif(angle >= 67.5 and angle < 112.5) then
		compass_direction = 'North'
	elseif(angle >= 112.5 and angle < 157.5) then
		compass_direction = 'NorthWest'
	elseif(angle >= 157.5 and angle < 202.5) then
		compass_direction = 'West'
	elseif(angle >= 202.5 and angle < 247.5) then
		compass_direction = 'SouthWest'
	elseif(angle >= 247.5 and angle < 292.5) then
		compass_direction = 'South'
	elseif(angle >= 292.5 and angle < 337.5) then
		compass_direction = 'SouthEast'
	else
		compass_direction = tostring(angle)
	end
	return compass_direction
end

local function distance_between_two_points(x1, y1, x2, y2)
	return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

local function report_mob_spawn(mob_name, mob_x, mob_y, status)
	local player_info = get_player_info()
	local distance = distance_between_two_points(player_info.x, player_info.y, mob_x, mob_y)
	local compass_direction = get_mob_compass_direction(mob_x, mob_y)
	
	local status_string = ''
	if(status) then status_string = ' (' .. tostring(status) .. ')' end
	local report_string = mob_name .. status_string 
		.. ' @ (' .. math.floor(mob_x*1000)/1000 .. ', ' .. math.floor(mob_y*1000)/1000 
		.. ') [' .. math.floor(distance*1000)/1000 .. ' yalms ' .. compass_direction .. ']'
	message(report_string)
end

-- local function handle_spawn_packet(packet)
	-- local mob_id = packet['ID']
	-- local nms_in_this_zone = nms_in_this_zone()
	-- message('handling spawn packet')
	-- if(is_nm(mob_id)) then
		-- message(nms_in_this_zone[mob_id].name .. ' spawned!')
		-- report_mob_spawn(nms_in_this_zone[mob_id].name, mob_packet['X'], mob_packet['Y'])
		-- if(state.claim_mode==CLAIM_MODE.ORIENT) then
			-- orient_towards_mob(mob_id)
		-- elseif(state.claim_mode==CLAIM_MODE.CLAIM) then
			-- claim_mob()
		-- end
	-- end
-- end

--this seems to not work. maybe i should just do this based on the status in the periodic scans, using a table to store previous state and current state.
--i also need to track time of deaths in a table, and then check that table constantly. i can send alerts when a ToD nears.
local function handle_time_of_death(packet)
	local mob_id = packet['ID']
	local nms_in_this_zone = nms_in_this_zone()
	if(nms_in_this_zone[mob_id]) then
		message(nms_in_this_zone[mob_id].name .. ' ToD: ' .. tostring(get_current_timestamp()))
	end
end

local function orient_towards_mob(mob_info)
	local player = get_player_info()
	local distance = distance_between_two_points(player.x, player.y, mob_info.x, mob_info.y)
	if(not player.target_locked and distance < 50) then
		message('Injecting targeting packet...')
		local targeting_packet = packets.new('incoming', 0x058,{
			['Target'] = mob_info.id,
			['Player'] = player.id,
			['Player Index'] = player.index,
		})
		packets.inject(targeting_packet)
	end
end

local function pursue_mob(mob_info)
	orient_towards_mob(mob_info)
	windower.ffxi.run(true)
end

local function claim_mob(mob_info)
	orient_towards_mob(mob_info.id)
	windower.ffxi.run(true)
	local mob_info = windower.ffxi.get_mob_by_id(mob_info.id)
	while(mob_info.status == 0) do
		mob_info = windower.ffxi.get_mob_by_id(mob_info.id)
		--TODO: do something smarter w/ jobs here
		--TODO: add packet injection here for the action
		if(mob_info.distance < 17.8) then windower.send_command('input /ja \"Charm\" <t>') end
	end
	windower.ffxi.run(false)
end

local function set_claim_mode(mode)
	if(not mode) then
		message("Claim mode is " .. CLAIM_MODE_NAMES[state.claim_mode])
	elseif(mode:lower() == 'claim') then 
		state.claim_mode = CLAIM_MODE.CLAIM
		message("Claim mode is now Claim!")
	elseif(mode:lower() == 'orient') then
		state.claim_mode = CLAIM_MODE.ORIENT
		message("Claim mode is now Orient!")
	elseif(mode:lower() == 'pursue') then
		state.claim_mode = CLAIM_MODE.PURSUE
		message("Claim mode is now Pursue!")
	elseif(mode:lower() == 'inform') then
		state.claim_mode = CLAIM_MODE.INFORM
		message("Claim mode is now Inform!")
	else
		message("Unrecognized claim mode \"" .. mode .. "\"")
	end
end

local function display_nm_info(nearby_nms)
	for i,v in ipairs(nearby_nms) do
		report_mob_spawn(v.name, v.x, v.y, v.status)
	end
end

local function scan_for_nms()
	local nms_in_this_zone = nms_in_this_zone()
	local nearby_nms = {}
	local nm_is_up = false
	for i,v in pairs(windower.ffxi.get_mob_array()) do
		if nms_in_this_zone[v['id']] and not has_value({2, 3}, v['status']) then
			v.is_nm = nms_in_this_zone[v['id']].is_nm
			table.insert(nearby_nms, v)
			if(not nm_is_up) then nm_is_up = v.is_nm end
		end
	end
	return nearby_nms, nm_is_up
end

local function scan_for_mob(mob_name)
	for i,v in pairs(windower.ffxi.get_mob_array()) do
		if v.name == mob_name then
			report_mob_spawn(v.name, v.x, v.y)
		end
	end
end

local function inject_widescan_packet()
	local widescan_packet = packets.new('outgoing', PACKET_IDS.OUTGOING.WIDESCAN, {
		["Flags"] = 1,
		["_unknown1"] = 0,
		["_unknown2"] = 0,
	})
	message('Injecting widescan packet...')
	packets.inject(widescan_packet)
end

local function print_tracking_list()
	local tracking_list_string = ''
	local comma = ''
	for i,v in ipairs(state.widescan_tracking_list) do
		if(i>1) then comma = ', ' end
		tracking_list_string = tracking_list_string .. comma .. state.widescan_tracking_list[i]
	end
	message('Tracking list: ' .. tracking_list_string)
end

local function handle_widescan_command(cmd, mob_name)
	if(cmd == nil) then
		inject_widescan_packet()
	elseif(cmd:lower() == "track") then
		table.insert(state.widescan_tracking_list, mob_name)
		message('Added ' .. mob_name .. ' to tracking list.')
	elseif(cmd:lower() == "clear") then 
		state.widescan_tracking_list = {}
		message('Cleared widescan tracking list.')
	elseif(cmd:lower() == "print") then
		print_tracking_list()
	end
end

local function handle_widescan_packet(packet)
	local mob_info = windower.ffxi.get_mob_by_index(packet['Index'])
	if(mob_info and (has_value(state.widescan_tracking_list, mob_info.name)
		or nms_in_this_zone()[mob_info.id])) then
		report_mob_spawn(mob_info.name, mob_info.x, mob_info.y)
	end
end

local function test_target()
	windower.ffxi.follow(17395793)
	local player = windower.ffxi.get_player()
	local targeting_packet = packets.new('incoming', 0x058,{
		['Target'] = 17395793,
		['Player'] = player.id,
		['Player Index'] = player.index,
	})
	packets.inject(targeting_packet)
end

handlers = {}
handlers['mode'] = set_claim_mode
handlers['scan'] = scan_for_mob
handlers['widescan'] = handle_widescan_command
handlers['test'] = test_target
handlers['reset'] = reset_state

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

local function handle_nm_spawn(nearby_nms)
	for i,v in ipairs(nearby_nms) do
		if(v.is_nm and v.status == 0 and state.claim_mode==CLAIM_MODE.ORIENT and not state.attempting_claim) then
			orient_towards_mob(v)
			break;
		elseif(v.is_nm and v.status == 0 and state.claim_mode==CLAIM_MODE.CLAIM and not state.attempting_claim) then
			claim_mob(v)
			break;
		elseif(v.is_nm and v.status == 0 and state.claim_mode==CLAIM_MODE.PURSUE and not state.attempting_claim) then
			pursue_mob(v)
			break;
		end
	end
	if(state.claim_mode~=CLAIM_MODE.INFORM) then
		state.attempting_claim = true
	end
end

windower.register_event('addon command', handle_command)

windower.register_event('incoming chunk', function(id, data)

	-- -- these two packet triggers don't actually work
	-- -- they're also not necessary cuz i can do everything with scans
	-- if(id == PACKET_IDS.INCOMING.MOB_SPAWN) then
		-- local packet = packets.parse('incoming', data)
		-- message('Spawn debug: ' .. get_mob_name(packet['ID']) .. '(' .. packet['ID'] .. ')')
		-- handle_spawn_packet(packet)
	-- end
	
	-- if(id == PACKET_IDS.INCOMING.ENV_ANIMATION) then
		-- local packet = packets.parse('incoming', data)
		-- handle_time_of_death(packet)
	-- end
	
	--packet not necessary, this just calls it frequently. 
	if(id == PACKET_IDS.INCOMING.STATUS_FLAGS) then
		local nearby_nms, nm_is_up = scan_for_nms()
		if((get_current_timestamp() - state.last_reported_time) > REPORTING_DELAY) then
			state.last_reported_time = get_current_timestamp()
			if(nearby_nms) then
				display_nm_info(nearby_nms)
			end
		end
		if(nm_is_up) then handle_nm_spawn(nearby_nms) end
		
	end
	
	if(id == PACKET_IDS.INCOMING.WIDESCAN) then
		local packet = packets.parse('incoming', data)
		handle_widescan_packet(packet)
	end
end)
