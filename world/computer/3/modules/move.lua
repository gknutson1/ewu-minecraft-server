--Turning functions--
function turnLeft(a)
    for i=1,a do
        turtle.turnLeft()
    end
end

function turnRight(a)
    for i=1,a do
        turtle.turnRight()
    end
end

function aboutFace()
    turnLeft(2)
end

--DigFunctions--
function digFront()
    turtle.dig()
	turtle.suck()
end

function digUpDown()
    turtle.digUp()
	turtle.suckUp()
    turtle.digDown()
	turtle.suckDown()
end

function digLeftRight()
	turtle.turnLeft(1)
	digFront()
	turtle.aboutFace()
	digFront()
	turtle.turnRight(1)
end

function frontUpDown()
    digFront()
    digUpDown()
end

--Moving Functions--
function forward(a, doDig)
    for i=1,a do
        if not turtle.forward() then
            if doDig then
                digFront()
                forward(1,false)
            else
                return false
            end
        end
    end
end

function forwardTall(a)
	for i=1,a do
		print("Forward ("..i.."/"..a..")")
		forward(1,true)
		digUpDown()
	end
end

function forwardWide(a)
	for i=1,a do
		forward(1,true)
		digLeftRight()
	end
end

function backward(a, doDig)
    for i=1,a do
        if not turtle.back() then
            if doDig then
                aboutFace()
                digFront()
                aboutFace()
                backward(1,false)
            else
                return false
            end
        end
    end
end

function up(a, doDig)
    for i=1,a do
        if not turtle.up() then
            if doDig then
                digFront()
                up(1, false)
            else
                sleep(0.1)
            end
        end
    end
end         

function down(a, doDig)
    for i=1,a do
        if not turtle.down() then
            if doDig then
                digFront()
                down(1,false)
            else
                return false
            end
        end
    end
end

function moveLeft(a, doDig)
    turnLeft(1)
    forward(a, doDig)
    turnRight(1)
end

function uTurnLeft(doDig)
    turnLeft(1)
    forward(1,doDig)
    turnLeft(1)
end

function moveRight(a, doDig)
    turnRight(1)
    forward(a, doDig)
    turnLeft(1)
end

function uTurnRight(doDig)
    turnRight(1)
    forward(1,doDig)
    turnRight(1)
end
