os.loadAPI("include.lua")
for z=1,2 do
    for y=1,8 do
        move.forward(16,true,"frontUpDown")
        move.uTurnRight(true)
        move.forward(16,true,"frontUpDown")
        move.uTurnLeft(true)
    end
    move.turnLeft(1)
    move.forward(16)
    move.turnRight(1)
    move.down(3,true,"frontUpDown")
end
