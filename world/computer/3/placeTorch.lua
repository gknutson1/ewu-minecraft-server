for i = 0,3 do
move.forward(64,true)
move.down(2,true)
turtle.select(1)
move.up(1)
turtle.placeDown()
move.up(1)
turtle.select(2)
turtle.placeDown()
turtle.turnLeft()
end