os.loadAPI("include.lua")
for i=1,2 do
	for i=1,8 do
		print("Set ("..i.."/8)")
		print("Starting new row")
		move.forwardTall(16,true)
		move.uTurnRight(true)
		move.digUpDown()
		print("Starting new row")
		move.forwardTall(16,true)
		move.uTurnLeft(true)
	end
	print("Starting new Layer")
	move.turnLeft(1)
	move.forward(16,true)
	move.turnRight(1)
	move.down(3,true)
	move.backward(1,true)
end
