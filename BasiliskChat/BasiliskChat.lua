-- Bee 2023
-- Dedicated to the dumbest people in silicon valley
_addon.name     = 'BasiliskChat'
_addon.author   = 'Bee'
_addon.version  = '0.2'
_addon.commands = {'basiliskchat', 'bchat'}

local https = require('ssl.https')
local config = require('config')
local json = require('json')
local table = require('table')

local user_config = config.load('data/settings.xml')
local api_key = config.load('data/api_key.xml')['openai_key']
local endpoint = "https://api.openai.com/v1/chat/completions"
local chat_color = user_config['chat_color']
handlers = {}

local bot_instructions = [[You are called Basilisk. You are an AI helper to Final Fantasy XI players whose primary role is to answer their questions about content within the game. Your answers are short, but informative.]]

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local function prepare_query(query)
	clean_query = table.concat(query, ' ')
	return clean_query
end

--TODO: find some kind of less hacky json parsing that works
--json.parse eliminates the `choices` list that contains the response. orz.
local function parse_response(response)
	response_tail_index = string.find(response, "\"content\": \"")
	response_end_index = string.find(string.sub(response, response_tail_index), "\"finish_reason\":")
	return string.sub(response, response_tail_index+12, response_tail_index+response_end_index-19)
end

local function send_query_to_chatgpt(query)
	
	local request_body = "{\"messages\":[{\"role\":\"user\", \"content\":\"" .. bot_instructions ..  "\"},"
		.. "{\"role\":\"user\", \"content\": \"" .. query .. "\"}],"
		.. "\"n\": " .. 1 .. ","
		.. "\"model\": \"" .. user_config['model'] .. "\"}"
	local response_body = {}
	
	local response, code, headers, status = https.request{
	  url = endpoint,
	  method = "POST",
	  --max_tokens = user_config['max_tokens'],
	  headers = {
		["Content-Type"] = "application/json",
		["Authorization"] = "Bearer " .. api_key,
		["Content-Length"] = request_body:len()
	  },
	  source = ltn12.source.string(request_body),
	  sink = ltn12.sink.table(response_body)
	}
	answer = parse_response(response_body[1])
	return answer
end

local function send_response_to_user(response)
	windower.add_to_chat(chat_color,'<BasiliskChat> Response: ' .. response)
end

local function send_query_to_user(query)
	windower.add_to_chat(chat_color,'<BasiliskChat> Query:     ' .. query)
end

local function handle_user_query(user_query)
	local prepared_query = prepare_query(user_query)
	send_query_to_user(prepared_query)
	response = send_query_to_chatgpt(prepared_query)
	send_response_to_user(response,prepared_query)
end

--TODO: implement this
local function print_history()
	windower.add_to_chat(chat_color,'<BasiliskChat> No history implemented yet!')
end

local function test_prompt()
	for i=1,255 do 
		windower.add_to_chat(i,'<BasiliskChat> Color' .. tostring(i) .. '!') 
	end
end


handlers['query'] = handle_user_query
handlers['test_prompt'] = test_prompt
--handlers['history'] = print_history

local function handle_command(cmd, ...)
    local cmd = cmd or 'help'
    if handlers[cmd] then
        local msg = handlers[cmd]({...})
        if msg then
            error(msg)
        end
    else
        error("Unknown command %s":format(cmd))
    end
end

windower.register_event('addon command', handle_command)