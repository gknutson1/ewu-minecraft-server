os.loadAPI("include.lua")

--Turn Tests--
move.aboutFace()
move.aboutFace()
move.turnLeft(2)
move.turnRight(2)

if turtle.getFuelLevel()>=6 then
--Move Tests--
move.forward(1,false)
move.backward(1,false)
move.up(1,false)
move.down(1,false)
move.moveLeft(1,false)
move.moveRight(1,false)
else
    echo.echo("Unable to test movement")
end
