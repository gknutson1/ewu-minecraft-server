os.loadAPI("include.lua")

--Vars to put in digVars config file
--local dumpPos = vector.new(0,0,0)
--local refuelPos = vector.new(0,0,0)
--local flyHeight = 0
local prevPos = vector.new(0,0,0)
local prevFacing = ""
local depth = 2
local tArgs = { ... }
if #tArgs > 1 then
	depth = tArgs[1]
end

local function isFull()
	turtle.select(16)
	if turtle.getItemCount() > 0 then
		turtle.select(1)
		return true
	else
		turtle.select(1)
		return false
	end
	
end

local function doDump()
	prevPosSave = prevPos
	prevPos = vector.new(gps.locate())
	move.moveTo(digVars.dumpPos,digVars.flyHeight)
	dump.slotsDown(1,16)
	move.moveTo(prevPos,digVars.flyHeight)
	prevPos = prevPosSave
end

local function doRefuel()
	prevPosSave = prevPos
	prevPos = vector.new(gps.locate())
	doDump()
	move.moveTo(digVars.refuelPos,digVars.flyHeight)
	turtle.select(1)
	while turtle.getItemCount() < 32 do
		turtle.dropDown()
		turtle.suckDown()
	end
	turtle.refuel(64)
	move.moveTo(prevPos,digVars.flyHeight)
	prevPos = prevPosSave
end

local function main()
	move.forward(1, true)
	dig.digDown()
	--Height layers 1-depth
	for i=1,depth do
		--For each down and back
		for j=1,8 do
			if isFull() then
				print("Inventory Full")
				doDump()
			end
			if turtle.getFuelLevel() < 64 then
				print("Refueling")
				doRefuel()
			end
			--Start across
			print("Going across")
			move.forwardTall(15)
			
			--Right uturn tall
			move.turnRight()
			dig.digUpDown()
			move.forwardTall()
			move.turnRight()
			
			if isFull() then
				print("Inventory Full")
				doDump()
			end
			--Start back
			print("Coming back")
			move.forwardTall(15)
			
			--left uturn tall
			move.turnLeft()
			dig.digUpDown()
			move.forwardTall()
			move.turnLeft()
		end
		print("Starting new Layer")
		move.turnLeft()
		move.forward(16,true)
		move.turnRight()
		move.down(3,true)
		move.backward(1,true)
	end
end

main()