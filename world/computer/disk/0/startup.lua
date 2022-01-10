fs.delete("/.settings")
fs.delete("/programs")
fs.delete("/modules")
fs.delete("/include.lua")
fs.copy("disk/.settings", ".settings")
fs.copy("disk/programs/", "programs")
fs.copy("disk/modules/", "modules")
fs.copy("disk/include.lua", "include.lua")

if not fs.exists("startup.lua") then
    fs.copy("disk/turtleStartup.lua", "startup.lua")
end
shell.execute("startup.lua")
