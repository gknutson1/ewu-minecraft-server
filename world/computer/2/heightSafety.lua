while true do
    height = vector.new(gps.locate()).y
    if height > 58 then
        turtle.down()
        print("Going down - "..height)
    end
end
