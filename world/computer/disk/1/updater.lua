shell.execute("wget","run","https://raw.githubusercontent.com/TylerRose/TurtleProject/main/update.lua")
if fs.exists("/disk/") then
	fs.makeDir("/disk/.noUpdate")
end
shell.execute("reboot") 