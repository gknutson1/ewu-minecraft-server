pathX = 9
pathY = 9
posY = 0
pathX = pathX - 1
pathY = pathY - 1

turtle.select(1)

function unload(slot, prevSlot)
	turtle.select(slot)
	turtle.dropDown(turtle.getItemCount() - 1)
	turtle.select(prevSlot)
end

function forceRefuel(slot, prevSlot)
	turtle.select(slot)
	if not turtle.refuel() then
		print("Waiting for fuel in slot " .. slot .. "!")
		os.pullEvent("turtle_inventory")
		if not turtle.refuel() then
			print("Incorrect fuel, or not in slot " .. slot .. "!")
			forceRefuel()
		end
		while turtle.refuel() do end
	end
	turtle.select(prevSlot)
end

function safeMove()
	if turtle.getFuelLevel() <= 1 then
		forceRefuel(16, 1)
	end
	stat, err = turtle.forward()
	if not stat then
		error(err)
	end
end

function stripMove(length)
	for i = length, 1, -1 do
		safeMove()
		hasBlock, status = turtle.inspectDown()
		if hasBlock and status.state.age and status.state.age == 7 then
			turtle.digDown()
		end
		while turtle.suckDown() do end
		if turtle.getItemCount() > 1 then		
			turtle.placeDown()
		end
		print(status.metadata)
	end
end

stripMove(pathX)
while true do
	turtle.turnRight()
	if posY == pathY then
		turtle.turnLeft()
		turtle.turnLeft()
		stripMove(pathY)
		turtle.turnLeft()
		posY = 0
		stripMove(pathX)
		unload(2, 1)
	else
		stripMove(1)
		turtle.turnRight()
		posY = posY + 1
		stripMove(pathX)
	end

	turtle.turnLeft()
	if posY == pathY then
		turtle.turnRight()
		turtle.turnRight()
		stripMove(pathY)
		turtle.turnRight()
		posY = 0
		unload(2, 1)
	else
		stripMove(1)
		turtle.turnLeft()
		posY = posY + 1
	end

	stripMove(pathX)
end
