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
end

function digUpDown()
    turtle.digUp()
    turtle.digDown()
end

function frontUpDown()
    digFront()
    digUpDown()
end

function checkAndDig(digType)
    if not digType == nil then
        print("Type: " .. digType)
    end
    if (digType == "") or (digType == nil) then
        if digType == "digFront" then
            digFront()
            print("Null or Nil")
        elseif digType == "digUpDown" then
            digUpDown()
            print(digType)
        elseif digType == "frontUpDown" then
            frontUpDown()
            print(digType)
        else
            digFront()
            print("Unknown")
        end
    end
end

--Moving Functions--
function forward(a, doDig, digType)
    for i=1,a do
        if not turtle.forward() then
            if doDig then
                turtle.dig()
                checkAndDig(digType)
                forward(1,false)
            else
                return false
            end
        else
            if doDig then
                checkAndDig(digType)
            end
        end
    end
end

function backward(a, doDig,digType)
    for i=1,a do
        if not turtle.back() then
            if doDig then
                aboutFace()
                turtle.dig()
                checkAndDig(digType)
                aboutFace()
                backward(1,false)
            else
                return false
            end
        else
            if doDig then
                checkAndDig(digType)
            end
        end
    end
end

function up(a, doDig, digType)
    for i=1,a do
        if not turtle.up() then
            if doDig then
                turtle.digUp()
                checkAndDig(digType)
                up(1, false)
            else
                return false
            end
        else
            if doDig then
                checkAndDig(digType)
            end
        end
    end
end         

function down(a, doDig, digType)
    for i=1,a do
        if not turtle.down() then
            if doDig then
                turtle.digDown()
                checkAndDig(digType)
                down(1,false)
            else
                return false
            end
        else
            if doDig then
                checkAndDig(digType)
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
