function placeSide()
move.down(2,true)
move.up(1)
turtle.select(1)
turtle.placeDown()
move.up(1)
turtle.select(2)
turtle.placeDown()
move.forward(64,true)
for i=1,3 do

    move.down(2,true)
    move.up(1)
    turtle.select(1)
    turtle.placeDown()
    move.up(1)
    turtle.select(2)
    turtle.placeDown()
    move.forward(1,true)
    move.down(2,true)
    move.up(1)
    turtle.select(1)
    turtle.placeDown()
    move.up(1)
    turtle.select(2)
    turtle.placeDown()
    if i < 3 then
    move.forward(64,true)
    end
end
end
placeSide()
--pick up last double torch and re-align
turtle.digDown()
move.turnLeft()
move.forward(64,true)
move.turnLeft()
placeSide()
