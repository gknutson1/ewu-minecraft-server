
-- Find modems
local tModems = {}
for _, sModem in ipairs( peripheral.getNames() ) do
    if peripheral.getType( sModem ) == "modem" then
        table.insert( tModems, sModem )
    end
end
if #tModems == 0 then
    print( "No modems found." )
    return
elseif #tModems == 1 then
    print( "1 modem found." )
else
    print( #tModems .. " modems found." )
end

local function open( nChannel )
    for n = 1, #tModems do
        local sModem = tModems[n]
        peripheral.call( sModem, "open", nChannel )
    end
end

local function close( nChannel )
    for n = 1, #tModems do
        local sModem = tModems[n]
        peripheral.call( sModem, "close", nChannel )
    end
end

-- Open channels
print( "0 messages repeated." )
open( gps.CHANNEL_GPS )

-- Main loop (terminate to break)
local ok, error = pcall( function()
    local tReceivedMessages = {}
    local tReceivedMessageTimeouts = {}
    local nTransmittedMessages = 0

    while true do
        local sEvent, sModem, nChannel, nReplyChannel, tMessage = os.pullEvent("modem_message")
        if sEvent == "modem_message" then
            -- Got a modem message, rebroadcast it if it's a rednet thing
            if nChannel == gps.CHANNEL_GPS then

                -- Send on all other open modems, to the target and to other repeaters
                for n = 1, #tModems do
                    local sOtherModem = tModems[n]
                    peripheral.call( sOtherModem, "transmit", 65534, nReplyChannel, tMessage )
                end

                -- Log the event
                nTransmittedMessages = nTransmittedMessages + 1
                local _, y = term.getCursorPos()
                term.setCursorPos( 1, y - 1 )
                term.clearLine()
                if nTransmittedMessages == 1 then
                    print( nTransmittedMessages .. " message repeated." )
                else
                    print( nTransmittedMessages .. " messages repeated." )
                end
                
            end

        elseif sEvent == "timer" then
            -- Got a timer event, use it to clear the message history
            local nTimer = sModem
            local nMessageID = tReceivedMessageTimeouts[ nTimer ]
            if nMessageID then
                tReceivedMessageTimeouts[ nTimer ] = nil
                tReceivedMessages[ nMessageID ] = nil
            end

        end
    end
end )
if not ok then
    printError( error )
end

-- Close channels
close( rednet.CHANNEL_REPEAT )