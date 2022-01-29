function slotsFront(a, b)
    for i = a, b do
        turtle.select(i)
		turtle.refuel(64)
        turtle.drop()
    end
end

function slotsDown(a, b)
    for i = a, b do
        turtle.select(i)
		turtle.refuel(64)
        turtle.dropDown()
    end
    turtle.select(1)
end

function currentFront()
    turlte.drop()
end

function currentDown()
    turlte.dropDown()
end