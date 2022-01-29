for _=0,8 do
move.forward(32)
turtle.placeDown()
end
move.forward(2)
move.down(50)
for _=0,2 do
for _=0,5 do
    turtle.placeDown()
    turtle.forward()
end
move.uTurnLeft()
for _=0,5 do
    turtle.placeDown()
    turtle.forward()
end
move.uTurnRight()
end
