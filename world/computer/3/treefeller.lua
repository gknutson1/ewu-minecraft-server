
function checkSaps()
    turtle.select(16)
    if turtle.getItemCount() < 8 then
        print("Out of saps")
    end
    while turtle.getItemCount() < 8 do
        turtle.dropUp()
        turtle.suckUp()
    end
    turtle.select(1)
end

function checkBonemeal()
    turtle.select(15)
    if turtle.getItemCount() < 16 then
        print("Need more bonemeal")
        turtle.turnLeft()
        while turtle.getItemCount() < 64 do
            turtle.drop()
            turtle.suck()
        end
        turtle.turnRight()
    end
    turtle.select(1)
end

function growTree()
    turtle.select(16)
    turtle.place()
    _, data = turtle.inspect()
    while data.name == "minecraft:sapling" do
       turtle.select(15)
       turtle.place()
       turtle.select(16)
       _, data = turtle.inspect()
    end
    print("Timber!")
    turtle.dig()
end

while true do
    checkSaps()
    checkBonemeal()
    growTree()
    turtle.select(14)
    if turtle.getItemCount() > 1 then
        for i=1,14 do
            turtle.select(i)
            turtle.drop()
        end
    end
    turtle.select(1)
end

