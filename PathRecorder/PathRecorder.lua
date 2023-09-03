_addon.name     = 'PathRecorder'
_addon.author   = 'Bee'
_addon.version  = '0.3'
_addon.commands = {'pathrecorder'}
_addon.commands = {'pr'}

local coroutine = require('coroutine')
local socket = require('socket')
local io = require('io')
local math = require('math')
local config = require('config')
local files = require('files')

local recording_loop = false
local handlers = {}
local path_data = {}
local recording_interval = 0.1 --time, in seconds, between successive position measurements. 

local function prepare_file_path(file_name)

	return 'saved_paths/' .. file_name .. '.txt'
	
end

local function split(s, delimiter)

    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result
	
end

local function print_to_chat(text)

    windower.chat.input('/echo [[' .. _addon.name .. ']] ' .. text)
	
end

local function get_my_position_and_speed()

	local my_mob_data = windower.ffxi.get_mob_by_id(windower.ffxi.get_player().id)
	return {x=my_mob_data['x'], y=my_mob_data['y'], z=my_mob_data['z'], heading=my_mob_data['facing'], speed=my_mob_data['movement_speed']}
	
end

local function handle_print_my_pos()

	local self_mob_data = get_my_position_and_speed()
	print_to_chat('x=' .. tostring(self_mob_data['x']) 
		.. ', y=' .. tostring(self_mob_data['y']) 
		.. ', z=' ..  tostring(self_mob_data['z'])
		.. ', movement_speed=' ..  tostring(self_mob_data['speed'])
	)
	
end 

local function handle_start_recording()

    print_to_chat("Recording BEGIN!")
	if(next(path_data) ~= nil) then
		print_to_chat('WARNING: previous path data is stored. Consider clearing first.')
	end
	
	recording_loop = true
	while recording_loop do
		local my_position = get_my_position_and_speed()
		table.insert(path_data,{ts=socket.gettime(), x=my_position['x'], y=my_position['y'], z=my_position['z'], speed=my_position['speed']})
		coroutine.sleep(recording_interval)
	end
	
end

local function handle_stop_recording()

    print_to_chat("Recording HALT!")
	recording_loop = false
	
end

-- dev testing function
local function handle_print_path_data()

	for i,v in ipairs(path_data) do print(i,v['x']) end
	
end

local function handle_save_path_data(file_name)
	
	if(next(path_data) == nil) then 
		print_to_chat('Current path is empty! Not saving.')
		return
	end
	
	if(file_name == nil) then
		print_to_chat('Please specify a file name.')
		return 
	end
	
	--prepare file
	local file_path = prepare_file_path(file_name)
	if(files.exists(file_path)) then
		print_to_chat('File \"' .. file_path .. '\" exists already!')
		return nil
	end
	local file = files.new(file_path, 'w')
	
	--write a header for file
	local player_index = windower.ffxi.get_player().index
	local zone = windower.ffxi.get_info()['zone']
	local starting_pos = windower.ffxi.get_position(player_index, path_data[1]['x'], path_data[1]['y'], path_data[1]['z'])
	local ending_pos = windower.ffxi.get_position(player_index, path_data[#path_data]['x'], path_data[#path_data]['y'], path_data[#path_data]['z'])
	local header = tostring(zone) 
		.. ',' .. tostring(starting_pos) 
		.. ',' .. tostring(ending_pos) 
		.. '\n'
	file:write(header)

	--write path data
	for key,value in pairs(path_data) do
		local line = tostring(value['ts']) 
			.. ',' .. tostring(value['x']) 
			.. ',' .. tostring(value['y']) 
			.. ',' .. tostring(value['z']) 
			.. ',' .. tostring(value['speed']) 
			.. '\n'
		file:append(line)
	end
	
	print_to_chat('Wrote current path to file \'' .. file_name .. '\'.')
	
end

local function handle_clear_path_data()

	path_data = {}
	print_to_chat('Path data is cleared.')
	
end

--navigate directly to target point.
local function snap_to_point(target_xpos, target_ypos, target_zpos)

	local my_mob_data = get_my_position_and_speed()	

	local tolerance = 0.5 --tolerance between current and target position
	
	--amount of time to walk. 
	--Coefficient < 1 guarantees convergence to target
	local step_time = 0.75*tolerance/my_mob_data['speed'] 
	
	local delta = math.sqrt(math.pow(my_mob_data['x'] - target_xpos, 2) + math.pow(my_mob_data['y'] - target_ypos, 2))
	while(delta > tolerance) do
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

local function load_path(path_name)

	local file_path = prepare_file_path(path_name)
	print_to_chat(file_path)
	index = 1
	local saved_path = {}
	local lines_in_file = files.readlines(file_path)
	for i, line in ipairs(lines_in_file) do
		if(index>1) then 
			ts, xpos, ypos, zpos, speed = unpack(split(line, ','))
			table.insert(saved_path, {ts=ts, x=xpos, y=ypos, z=zpos, speed=speed})
		else
			local header = line
		end
		index = index + 1
	end
	return saved_path
	
end

local function play_path(saved_path)

	--plan movements
	print_to_chat("Snapping to start...")
	snap_to_point(saved_path[2]['x'], saved_path[2]['y'], saved_path[2]['z'])
	print_to_chat("Replaying path from start...")
	for i=3,#saved_path do
		local my_mob_data = get_my_position_and_speed()
		local running_time = math.abs(saved_path[i]['ts'] - saved_path[i-1]['ts'])*(saved_path[i-1]['speed']/my_mob_data['speed'])

		windower.ffxi.run(
			saved_path[i]['x'] - my_mob_data['x'], 
			saved_path[i]['y'] - my_mob_data['y'], 
			saved_path[i]['z'] - my_mob_data['z']
		)
		coroutine.sleep(running_time)
		windower.ffxi.run(false)
	end
	print_to_chat("Replayed.")
	
	local my_mob_data = get_my_position_and_speed()
	print_to_chat("Final error: xerr= " .. tostring(saved_path[#saved_path]['x'] - my_mob_data['x']) 
		.. ", yerr=" .. tostring(saved_path[#saved_path]['y'] - my_mob_data['y'])
	)
	
end

local function handle_play_path_reverse(path_name)

	local saved_path = load_path(path_name)
	for i=1,math.floor(#saved_path/2) do
		saved_path[i], saved_path[#saved_path-(i-1)] = saved_path[#saved_path-(i-1)], saved_path[i]
	end
	play_path(saved_path)
end

local function handle_play_path(path_name)

	local saved_path = load_path(path_name)
	play_path(saved_path)
	
end

handlers['start'] = handle_start_recording
handlers['stop'] = handle_stop_recording
handlers['pos'] = handle_print_my_pos
handlers['clear'] = handle_clear_path_data
handlers['save'] = handle_save_path_data
--handlers['print'] = handle_print_path_data --dev only
handlers['play'] = handle_play_path
handlers['play_reverse'] = handle_play_path_reverse

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