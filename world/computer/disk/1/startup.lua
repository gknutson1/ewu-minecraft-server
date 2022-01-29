if not fs.exists("/disk/.noUpdate") then
	shell.execute("/disk/updater")
else
	fs.delete("/disk/.noUpdate")
end
fs.delete("/.settings")
fs.delete("/programs")
fs.delete("/modules")
fs.delete("/include.lua")
fs.delete("/updater.lua")
if fs.exists("/disk/") then
    fs.copy("disk/.settings", ".settings")
    fs.copy("disk/programs/", "programs")
    fs.copy("disk/modules/", "modules")
    fs.copy("disk/include.lua", "include.lua")
    fs.copy("disk/updater.lua", "updater.lua")
end

if not fs.exists("startup.lua") then
    fs.copy("disk/turtleStartup.lua", "startup.lua")
end

if fs.exists("/disk/startup.lua") then
    shell.execute("startup.lua")
end
