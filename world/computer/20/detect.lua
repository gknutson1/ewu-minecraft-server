beep = redstone.getAnalogInput("top")
speaker = peripheral.wrap("bottom")
while true do
    beep = redstone.getAnalogInput("top")
    os.queueEvent("randomEvent")
    os.pullEvent()
    if beep > 1 then
        speaker.playNote("bass", 15, 8)
    end
end
