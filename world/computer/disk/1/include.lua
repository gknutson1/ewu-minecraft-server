function includeAll()
    if fs.exists("disk/modules/") then
        for _, file in ipairs(fs.list("disk/modules/")) do
            os.loadAPI("disk/modules/"..file)
        end
    end
    
    if fs.exists("modules/") then
        for _, file in ipairs(fs.list("modules/")) do
            os.loadAPI("modules/"..file)
        end
    end

    if fs.exists("config/") then
        for _, file in ipairs(fs.list("config/")) do
            os.loadAPI("config/"..file)
        end
    end

end
includeAll()
echo.echo("Include Success")