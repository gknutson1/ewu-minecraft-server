function main()
    while true do
        checkSaps()
        checkBonemeal()
        growTree()
        fellTree()
        checkDump()
    end
end

function checkSaps()
    turtle.select(16)
    while turtle.getItemCount() < 32 do
        turtle.dropUp()
        turtle.suckUp()
    end
end

function checkBonemeal()
    turtle.select(15)
    if turtle.getItemCount() < 16 then
        turtle.turnLeft()
        while turtle.getItemCount() < 64 do
            turtle.drop()
            turtle.suck()
        end
        turtle.turnRight()
    end
end        

function growTree()
    turtle.select(16)
    turtle.place()
    turtle.select(15)
    _, data = turtle.inspect()
    while data.name == "minecraft:sapling" do
        turtle.place()
        _, data = turtle.inspect()
        if turtle.getItemCount() < 8 then
            checkSaps()
        end
    end
end

function fellTree()
    turtle.dig()
end

function checkDump()
    turtle.select(2)
    if turtle.getItemCount() > 1 then
        dump.slotsFront(1,14)
    end
end

main()
