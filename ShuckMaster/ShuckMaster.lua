_addon.name     = 'ShuckMaster'
_addon.author   = 'Bee (Staxxy)'
_addon.description = 'HorizonXI Summer clamming event bot.'
_addon.version  = '0.5'
_addon.commands = {'shuckmaster'}
_addon.commands = {'shuck'}

packets = require('packets')

windower.send_command('lua load sellnpc')

-- !!! WARNING !!!
-- this sucks and is kinda broken lmfao GL

--TODO:
--cleanup dependency on sellnpc
--use state machine to guide actions and events to trigger state changes w safeguards
--stopping and restarting straight doesn't work

n_injects = 4

--back to start
BOT_ACTION = {IDLE = 1, GATHERING = 2, SELLING = 3, TALK_TO_TOH = 4}
CLAMMING_NPC_OUTCOMES = {REWARDED = 1, REWARD_CONT = 2, BROKE = 3, BUCKET50 = 4, BUCKET100 = 5, BUCKET150 = 6, BUCKET200 = 7}
CLAMMING_OUTCOMES = {FULL = 1, BROKEN = 2}
ITEM_ACTION = {SELL_TO_MERCHANT = 1, SELL_ON_AH = 2, TOSS = 3}

MIN_INJECTION_DELAY_SECONDS = 0
CLAMMING_DELAY_SECONDS = 11
REWARD_LOCK_DELAY = 5

CLAMMING_POINT_LOCATION = {x = -306.9, y = -414.6, z = -0.14}
CLAMMING_POINT_RADIUS = 2
CLAMMING_NPC_LOCATION = {x =-370.656, y = -422.3, z = -1.4}
CLAMMING_NPC_RADIUS = 1
MERCHANT_NPC_LOCATION = {x = -408.2, y = -447.4, z = -3.3}
MERCHANT_NPC_RADIUS = 1

CHAT_COLOR = 208

--TODO: add approximate AH value for non-merchant-sales
CLAMMING_ITEM_DATA = {
	[5122] = {name = "bibiki_slug", weight = 3, value = 5, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[4318] = {name = "bibiki_urchin", weight = 6, value = 750, action = ITEM_ACTION.SELL_ON_AH},
	[485] = {name = "bkn_willow_rod", weight = 6, value = 0, action = ITEM_ACTION.TOSS},
	[887] = {name = "coral_fragment", weight = 6, value = 1735, action = ITEM_ACTION.SELL_ON_AH},
	[881] = {name = "crab_shell", weight = 6, value = 392, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[1193] = {name = "high_quality_crab_shell", weight = 6, value = 3132, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[5187] = {name = "elshimo_coconut", weight = 6, value = 44, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[690] = {name = "elm_log", weight = 6, value = 390, action = ITEM_ACTION.SELL_ON_AH},
	[864] = {name = "fish_scales", weight = 3, value = 23, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[510] = {name = "goblin_armor", weight = 6, value = 0, action = ITEM_ACTION.SELL_ON_AH},
	[507] = {name = "goblin_mail", weight = 6, value = 0, action = ITEM_ACTION.SELL_ON_AH},
	[511] = {name = "goblin_mask", weight = 6, value = 0, action = ITEM_ACTION.SELL_ON_AH},
	[4328] = {name = "hobgoblin_bread", weight = 6, value = 91, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[4325] = {name = "hobgoblin_pie", weight = 6, value = 153, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[5123] = {name = "jacknife", weight = 11, value = 20, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[1446] = {name = "lacquer_tree_log", weight = 6, value = 3578, action = ITEM_ACTION.SELL_ON_AH},
	[691] = {name = "maple_log", weight = 6, value = 100, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[4361] = {name = "nebimonite", weight = 6, value = 53, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[1311] = {name = "oxblood", weight = 6, value = 13250, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[4468] = {name = "pamamas", weight = 6, value = 20, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[624] = {name = "pamtam_kelp", weight = 6, value = 7, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[17296] = {name = "pebble", weight = 7, value = 1, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[703] = {name = "petrified_log", weight = 6, value = 2193, action = ITEM_ACTION.SELL_ON_AH},
	[868] = {name = "pugil_scales", weight = 3, value = 23, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[1587] = {name = "high_quality_pugil_scales", weight = 6, value = 253, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[936] = {name = "rock_salt", weight = 6, value = 3, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[888] = {name = "seashell", weight = 6, value = 30, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[4484] = {name = "shall_shell", weight = 6, value = 307, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[1586] = {name = "titanictus_shell", weight = 6, value = 357, action = ITEM_ACTION.SELL_ON_AH},
	[5124] = {name = "tropical_clam", weight = 20, value = 5100, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[885] = {name = "turtle_shell", weight = 6, value = 1190, action = ITEM_ACTION.SELL_ON_AH},
	[1618] = {name = "uragnite_shell", weight = 6, value = 1455, action = ITEM_ACTION.SELL_ON_AH},
	[5131] = {name = "vongola_clam", weight = 6, value = 192, action = ITEM_ACTION.SELL_TO_MERCHANT},
	[1889] = {name = "white_sand", weight = 7, value = 250, action = ITEM_ACTION.SELL_TO_MERCHANT},
}

BIBIKI_BAY = 4

INCOMING_PACKETS = {
	DIALOGUE=0x034,
	MESSAGE=0x02A,
}

OUTGOING_PACKETS = {
	NPC_INTERACT = 0x01A,
	DIALOGUE_OPTION = 0x05B,
	UPDATE_REQUEST = 0x016,
}
--are these fixed?
ENTITIES = {
	TOH_ZONIKKI = 16793989,
	CLAMMING_POINT = 16793990,
	MARCELLA = 16795413,
}

DIALOGUE = {
	TOH_START_CLAMMING_MENU = 28,
	TOH_MID_CLAMMING_MENU = 29,
	CLAMMING_POINT_MENU = 20,
}

MESSAGES = {
	GOT_CLAM = 40028,
	BUCKET_BROKE = 40029,
	WAIT_TO_CLAM = 40031,
	GRANDPAPPY = 40025,
	REWARDED = 39167,
	REWARDED_AND_HELD_SOME = 40017,
	
}

state = {
	keep_clamming = false,
	bucket_weight = 0,
	bucket_value = 0,
	bucket_size = 0,
	current_max_size = 0,
	last_clam_gather_timestamp = 0,
	action = BOT_ACTION.IDLE,
	last_injection_time = 0,
	last_reward_trigger_time = 0,
}

local function press_key(key)
	windower.send_command('setkey '..key..' down')
	coroutine.sleep(.1)
	windower.send_command('setkey '..key..' up')
end

local function message(message_text)
	windower.add_to_chat(CHAT_COLOR,'[ShuckMaster] ' .. message_text)
end

local function get_current_timestamp()
	return os.time(os.date("!*t"))
end

local function buy_bucket()
	press_key('up')
	coroutine.sleep(0.25)
	press_key('enter')
end

local function safe_inject(packet)
	local current_timestamp = get_current_timestamp()
	if(current_timestamp - state.last_injection_time) < MIN_INJECTION_DELAY_SECONDS then
		coroutine.sleep(current_timestamp - state.last_injection_time)
	end
	if(n_injects > 0) then
		message('injecting packet')
		packets.inject(packet)
		n_injects = n_injects - 1
		state.last_injection_time = get_current_timestamp()
	else
		message('Would have injected but n_injects=' .. tostring(n_injects))
	end
end

local function get_random_point_on_circle(x, y, z, radius)
	--https://stackoverflow.com/questions/20154991/generating-uniform-random-numbers-in-lua
	math.randomseed(os.time())
	math.random();math.random();math.random();
	
	
	local radians = math.random()*2
	
	local chosen_x = x + radius*math.cos(radians)
	local chosen_y = y + radius*math.sin(radians)
	local chosen_z = z
	return {x = chosen_x, y = chosen_y, z = chosen_z}
end

local function get_my_position_and_speed()

	local my_mob_data = windower.ffxi.get_mob_by_id(windower.ffxi.get_player().id)
	return {x=my_mob_data['x'], y=my_mob_data['y'], z=my_mob_data['z'], heading=my_mob_data['facing'], speed=my_mob_data['movement_speed']}
	
end

--navigate directly to target point.
--borrowed from PathRecorder, modified to be disableable w/ clamming flag
local function snap_to_point(target_xpos, target_ypos, target_zpos)
	local my_mob_data = get_my_position_and_speed()	

	local tolerance = 0.5 --tolerance between current and target position
	
	--amount of time to walk. 
	--Coefficient < 1 guarantees convergence to target
	local step_time = 0.75*tolerance/my_mob_data['speed'] 
	
	local delta = math.sqrt(math.pow(my_mob_data['x'] - target_xpos, 2) + math.pow(my_mob_data['y'] - target_ypos, 2))
	while(state.keep_clamming and delta > tolerance) do
		my_mob_data = get_my_position_and_speed()
		delta = math.sqrt(math.pow(my_mob_data['x'] - target_xpos, 2) + math.pow(my_mob_data['y'] - target_ypos, 2))
		windower.ffxi.run(target_xpos - my_mob_data['x'], 
			target_ypos - my_mob_data['y'], 
			target_zpos - my_mob_data['z']
		)
		coroutine.sleep(step_time)
		windower.ffxi.run(false)
	end
	
end

--stolen from Sparks addon
local function poke_npc(npc_id,npc_index)
	if npc_id and target_index then
		local packet = packets.new('outgoing', OUTGOING_PACKETS.NPC_INTERACT, {
			["Target"]=npc_id,
			["Target Index"]=npc_index,
			["Category"]=0,
			["Param"]=0,
			["_unknown1"]=0})
		packets.inject(packet)	
	end
end

--TODO: figure out why this isn't doing anything
local function inject_dialogue_option(option_index, npc_id, npc_index, menu_id, automated_message)
	if(option_index and npc_id and npc_index and menu_id) then
		message('sending dialogue choice!')
		local packet = packets.new('outgoing', OUTGOING_PACKETS.DIALOGUE_OPTION, {
			["Target"]=npc_id,
			["Option Index"]=option_index,
			["_unknown1"]=0,
			["Target Index"]=npc_index,
			["Automated Message"]=automated_message,
			["_unknown2"]=0,
			["Zone"]=BIBIKI_BAY,
			["Menu ID"] = menu_id
			})
		packets.inject(packet)
	end
end

local function inject_update_request()
	local id = windower.ffxi.get_player().id
	if(id) then 
		local packet = packets.new('outgoing', OUTGOING_PACKETS.UPDATE_REQUEST, {
			["Target Index"]=windower.ffxi.get_player().id
		})
		packets.inject(packet)
	end
end

local function gather_clams()
	coroutine.sleep(6)
	-- --TODO: fix this logic, doesn't seem to work. 
	-- local current_timestamp = get_current_timestamp()
	-- if((current_timestamp - state.last_clam_gather_timestamp) < CLAMMING_DELAY_SECONDS) then
		-- message('Waiting to gather...')
		-- coroutine.sleep(current_timestamp - state.last_clam_gather_timestamp + 1)
	-- end
	--validate distance from clamming point
	if(state.keep_clamming) then 
		mob_array = windower.ffxi.get_mob_array()
		for i,v in pairs(mob_array) do
			if v['name'] == "Clamming Point" then
				target_index = i
				target_id = v['id']
				break
			end
		end
		message('Gathering clams~')
		poke_npc(target_id, target_index)
	end
end


local function talk_to_clamming_npc()
	if(state.keep_clamming and ((get_current_timestamp() - state.last_reward_trigger_time) > REWARD_LOCK_DELAY)) then 
		mob_array = windower.ffxi.get_mob_array()
		for i,v in pairs(mob_array) do
			if v['name'] == "Toh Zonikki" then
				target_index = i
				target_id = v['id']
				break
			end
		end
		poke_npc(target_id, target_index)
	end
end

local function toss_willow_rods()
	--TODO: make this more efficient
	local items = windower.ffxi.get_items()
	for k,v in pairs(items.inventory) do
		if(type(v) == "table" and v.id and v.id == 485) then
			message('Tossing willow rod')
			local drop_packet = packets.new('outgoing', 0x028, {
                    ["Count"] = v.count,
                    ["Bag"] = 0,
                    ["Inventory Index"] = k,
                })
                packets.inject(drop_packet)
                coroutine.sleep(.5)
		end
	end
	message('All willow rods tossed!')
end

--TODO: Finish this
local function sell_items_to_npc()
	windower.send_command('sellnpc clamming');
	coroutine.sleep(2)
	for i,v in pairs(mob_array) do
		if v['name'] == "Marcella" then
			target_index = i
			target_id = v['id']
			message('Found Marcella!')
			break
		end
	end
	poke_npc(target_id, target_index)
	coroutine.sleep(2)
	press_key('escape')
	Message('Current Gil: ' .. tostring(windower.ffxi.get_items().gil))
end

--hacky
local function calculate_clamming_ev()
	if(state.bucket_value < 2000 and state.bucket_weight <= (state.bucket_size - 7)) then 
		return 1
	elseif(state.bucket_value >= 10000 and state.bucket_weight > (state.bucket_size - 20)) then
		return -1
	elseif(state.bucket_value >= 2000 and state.bucket_weight < (state.bucket_size - 11)) then
		return 1
	else
		return -1
	end
end

local function add_to_bucket(item)
	local weight = CLAMMING_ITEM_DATA[item].weight
	local value = CLAMMING_ITEM_DATA[item].value
	if(weight ~= nil) then 
		state.bucket_weight = state.bucket_weight + weight
		state.bucket_value = state.bucket_value + value
		message('weight: ' .. tostring(state.bucket_weight) .. '/' .. tostring(state.bucket_size) .. ' value: ' .. tostring(state.bucket_value))
	else
		message('Encountered unrecognized item ID ' .. item .. '. Stopping.')
		stop_clamming_loop()
	end
end

local function reset_bucket()
	state.bucket_weight = 0
	state.bucket_value = 0
	state.bucket_size = 0
end

local function start_clamming_loop()
	state.keep_clamming = true
	if(state.action == BOT_ACTION.IDLE) then
		message('Going to Toh Zonikki~')
		local clamming_npc_location = get_random_point_on_circle(CLAMMING_NPC_LOCATION.x, 
			CLAMMING_NPC_LOCATION.y, CLAMMING_NPC_LOCATION.z, CLAMMING_NPC_RADIUS)
		snap_to_point(clamming_npc_location.x, clamming_npc_location.y, clamming_npc_location.z)
		talk_to_clamming_npc()
	elseif(state.action == BOT_ACTION.GATHERING) then
			message('Going clamming (size:' .. tostring(state.bucket_size) .. ' weight:' .. tostring(state.bucket_weight) .. ")")
		local clamming_point_location = get_random_point_on_circle(CLAMMING_POINT_LOCATION.x, 
			CLAMMING_POINT_LOCATION.y, CLAMMING_POINT_LOCATION.z, CLAMMING_POINT_RADIUS)
		snap_to_point(clamming_point_location.x, clamming_point_location.y, clamming_point_location.z)
		gather_clams()
	elseif(state.action == BOT_ACTION.SELLING) then
		message('Going to merchant~')
		local merchant_location = get_random_point_on_circle(MERCHANT_NPC_LOCATION.x, 
			MERCHANT_NPC_LOCATION.y, MERCHANT_NPC_LOCATION.z, MERCHANT_NPC_RADIUS)
		snap_to_point(merchant_location.x, merchant_location.y, merchant_location.z)
		message('Selling to merchant~')
		toss_willow_rods()
		sell_items_to_npc()
	elseif(state.action == BOT_ACTION.TALK_TO_TOH) then
		message('Going to Toh Zonikki~')
		local clamming_npc_location = get_random_point_on_circle(CLAMMING_NPC_LOCATION.x, 
			CLAMMING_NPC_LOCATION.y, CLAMMING_NPC_LOCATION.z, CLAMMING_NPC_RADIUS)
		snap_to_point(clamming_npc_location.x, clamming_npc_location.y, clamming_npc_location.z)
		talk_to_clamming_npc()
	else
		stop_clamming_loop()
		message('Unrecognized state. Stopping')
	end
end

local function stop_clamming_loop()
	message('Stopping clamming loop!')
	state.keep_clamming = false
end

local function generate_mid_clamming_toh_action(npc_id, npc_index, menu_id)
	if(state.keep_clamming) then
		--inject_dialogue_option(0, npc_id, npc_index, menu_id,false) -- select first option
		buy_bucket()
		if(state.bucket_size < 150 and (state.bucket_size - state.bucket_weight) <= 5) then
			coroutine.sleep(2)
			--inject_dialogue_option(3, npc_id, npc_index, menu_id,false) -- continue clamming
			press_key('enter')
			coroutine.sleep(2)
			state.bucket_size = state.bucket_size + 50
			message('Going clamming (size:' .. tostring(state.bucket_size) .. ' weight:' .. tostring(state.bucket_weight) .. ")")
			local clamming_point_location = get_random_point_on_circle(CLAMMING_POINT_LOCATION.x, 
			CLAMMING_POINT_LOCATION.y, CLAMMING_POINT_LOCATION.z, CLAMMING_POINT_RADIUS)
			snap_to_point(clamming_point_location.x, clamming_point_location.y, clamming_point_location.z)
			gather_clams()
		elseif(state.bucket_size >= 150 and (state.bucket_size - state.bucket_weight) <= 5) then
			coroutine.sleep(2)
			--inject_dialogue_option(2, npc_id, npc_index, menu_id,false) -- stop clamming
			press_key('down')
			coroutine.sleep(1)
			press_key('enter')
		end
	end
end

handlers = {}
handlers['start'] = start_clamming_loop
handlers['stop'] = stop_clamming_loop

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

windower.register_event('incoming chunk', function(id, data)
	if(id == INCOMING_PACKETS.MESSAGE and state.keep_clamming) then 
		local packet = packets.parse('incoming', data)
		if(packet['Message ID'] == MESSAGES.GOT_CLAM) then
			state.last_clam_gather_timestamp = get_current_timestamp()
			add_to_bucket(packet['Param 1'])
			local clamming_ev = calculate_clamming_ev()
			if(clamming_ev > 0) then
				state.action = BOT_ACTION.GATHERING
				gather_clams()
			else
				state.action = BOT_ACTION.TALK_TO_TOH
				message('Going to Toh Zonikki~')
				local clamming_npc_location = get_random_point_on_circle(CLAMMING_NPC_LOCATION.x, 
			CLAMMING_NPC_LOCATION.y, CLAMMING_NPC_LOCATION.z, CLAMMING_NPC_RADIUS)
				snap_to_point(clamming_npc_location.x, clamming_npc_location.y, clamming_npc_location.z)
				talk_to_clamming_npc()
			end
			
		elseif(packet['Message ID'] == MESSAGES.WAIT_TO_CLAM) then
			state.action = BOT_ACTION.GATHERING
			gather_clams()
			
		elseif(packet['Message ID'] == MESSAGES.BUCKET_BROKE) then
			state.action = BOT_ACTION.TALK_TO_TOH
			message('Going to Toh Zonikki~')
			local clamming_npc_location = get_random_point_on_circle(CLAMMING_NPC_LOCATION.x, 
			CLAMMING_NPC_LOCATION.y, CLAMMING_NPC_LOCATION.z, CLAMMING_NPC_RADIUS)
			snap_to_point(clamming_npc_location.x, clamming_npc_location.y, clamming_npc_location.z)
			talk_to_clamming_npc()
				
		elseif(packet['Message ID'] == MESSAGES.GRANDPAPPY) then
			state.action = BOT_ACTION.TALK_TO_TOH
			reset_bucket()
			coroutine.sleep(1)
			talk_to_clamming_npc()
			
		elseif(packet['Message ID'] == MESSAGES.REWARDED) then
			local current_timestamp = get_current_timestamp()
			if(current_timestamp - state.last_reward_trigger_time) > REWARD_LOCK_DELAY then
				state.last_reward_trigger_time = current_timestamp
				state.action = BOT_ACTION.SELL_TO_MERCHANT
				reset_bucket()
				message('Going to merchant~')
				local merchant_location = get_random_point_on_circle(MERCHANT_NPC_LOCATION.x, 
				MERCHANT_NPC_LOCATION.y, MERCHANT_NPC_LOCATION.z, MERCHANT_NPC_RADIUS)
				snap_to_point(merchant_location.x, merchant_location.y, merchant_location.z)
				message('Selling to merchant~')
				sell_items_to_npc()
				state.action = BOT_ACTION.IDLE
				start_clamming_loop()
			end
		elseif(packet['Message ID'] == MESSAGES.REWARDED_AND_HELD_SOME) then
			-- state.action = BOT_ACTION.SELL_TO_MERCHANT
			-- reset_bucket()
			-- message('Going to merchant~')
			-- local merchant_location = get_random_point_on_circle(MERCHANT_NPC_LOCATION.x, 
			-- MERCHANT_NPC_LOCATION.y, MERCHANT_NPC_LOCATION.z, MERCHANT_NPC_RADIUS)
			-- snap_to_point(merchant_location.x, merchant_location.y, merchant_location.z)
			-- message('Selling to merchant~')
			-- sell_items_to_npc()
			-- state.action = BOT_ACTION.TALK_TO_TOH
			-- reset_bucket()
			-- coroutine.sleep(1)
			-- talk_to_clamming_npc()
			message('Rewarded and held some packet, doing nothing')
		end
			
	elseif(id == INCOMING_PACKETS.DIALOGUE) then 
		local packet = packets.parse('incoming', data)
		if(packet['Menu ID'] == DIALOGUE.CLAMMING_POINT_MENU and packet['NPC'] == ENTITIES.CLAMMING_POINT) then
			coroutine.sleep(1)
			press_key('enter')
			
		elseif(packet['Menu ID'] == DIALOGUE.TOH_START_CLAMMING_MENU and packet['NPC'] == ENTITIES.TOH_ZONIKKI) then
			message('Toh Dialogue time')
			coroutine.sleep(2)
			--inject_dialogue_option(1, ENTITIES.TOH_ZONIKKI, packet['NPC Index'], packet['Menu ID'],false) -- select first option
			buy_bucket()
			coroutine.sleep(1)
			state.bucket_size = 50
			state.action = BOT_ACTION.GATHERING
			message('Going clamming (size:' .. tostring(state.bucket_size) .. ' weight:' .. tostring(state.bucket_weight) .. ")")
			local clamming_point_location = get_random_point_on_circle(CLAMMING_POINT_LOCATION.x, 
			CLAMMING_POINT_LOCATION.y, CLAMMING_POINT_LOCATION.z, CLAMMING_POINT_RADIUS)
			snap_to_point(clamming_point_location.x, clamming_point_location.y, clamming_point_location.z)
			gather_clams()

		elseif(packet['Menu ID'] == DIALOGUE.TOH_MID_CLAMMING_MENU and packet['NPC'] == ENTITIES.TOH_ZONIKKI) then
			coroutine.sleep(1)
			generate_mid_clamming_toh_action(packet['NPC'], packet['NPC index'], packet['Menu ID'])
		end
	end
end)
