if fs.exists("disk/") then
    os.loadAPI("disk/modules/echo.lua")
else
    os.loadAPI("modules/echo.lua")
end
echo.echo("hi")
