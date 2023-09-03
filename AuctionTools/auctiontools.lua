_addon.name     = 'AuctionTools'
_addon.author   = 'Bee'
_addon.description = 'Automatically buy sets of items from AH.'
_addon.version  = '0.1'
_addon.commands = {'at'}
_addon.commands = {'atools'}

--TODO: remove this dependency
windower.send_command('lua load auctionhelper')

PACKET_IDS = {
	INCOMING = {
		BID_RESULT = 0,
	},
	OUTGOING = {
		BID_REQUEST = 0,
	}
}

local function new_state()
	return {
			bid_state = {
			target_item = '',
			is_stack = false,
			next_bid = 0,
			max_bid = 0,
			bid_increment = 0,
			remaining_to_buy = nil,
			should_bid = false,
		}
		sell_state = {
			sales_price = 0,
			remaining_to_sell = 0,
			should_sell = false,
		},
	}
end
state = new_state()

CHAT_COLOR = 208
INTER_BID_DELAY = 9 --seconds

local function message(message_text)
	windower.add_to_chat(CHAT_COLOR,'[' .. _addon.name .. '] ' .. message_text)
end

local function update_bid_state(bid_succeeded)
	if(bid_succeeded and state.bid_state.remaining_to_buy ~= nil) then
		state.bid_state.remaining_to_buy = state.bid_state.remaining_to_buy - 1
		if(state.bid_state.remaining_to_buy <= 0) then
			state.bid_state.should_bid = false
		end
	else
		local next_bid = math.min(state.bid_state.next_bid + state.bid_state.bid_increment, state.bid_state.max_bid)
		if(state.bid_state.next_bid < next_bid and state.bid_state.remaining_to_buy > 0) then
			state.bid_state.next_bid = next_bid
		else
			state.bid_state.should_bid = false
		end
	end
end

local function send_bid()
	--TODO: impelement this
	-- local bid_packet = packets.new('outgoing', PACKET_IDS.OUTGOING.BID_REQUEST,{
	-- })
	-- packets.inject(bid_packet)
	windower.send_command('buy \"' .. tostring(state.bid_state.target_item) .. '\" ' .. tostring(state.bid_state.is_stack) .. ' ' .. tostring(state.bid_state.next_bid))
end

local function process_auction_result(results_packet)
	local bid_succeeded = false
	update_bid_state(bid_succeeded)
	coroutine.sleep(INTER_BID_DELAY)
	if(state.bid_state.should_bid) then
		send_bid()
	end
end

--COMMANDS
local function set_buy_order(target_item, is_stack, floor_price, max_price, increment, max_items)
	local bid_state = {
			target_item = item,
			is_stack = is_stack,
			next_bid = floor_price,
			max_bid = max_price,
			bid_increment = increment,
			remaining_to_buy = max_items,
			should_bid = true,
		}
	state.bid_state = bid_state
	send_bid()
end

local function cancel_streams()
	state = new_state()
	message('Canceling buy and sell orders.')
end

handlers = {}
handlers['buy_order'] = set_buy_order
handlers['cancel'] = cancel_streams

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

--REACTIONS
windower.register_event('incoming chunk', function(id, data)
	if(id == PACKET_IDS.INCOMING.BID_RESULT) then
		local bid_result_packet = packets.parse('incoming', data)
		process_auction_result(auction_result_packet)
	end
end