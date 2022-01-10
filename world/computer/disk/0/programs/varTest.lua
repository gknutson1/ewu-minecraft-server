function foo(v1, v2)
    if v1 == nil then
        v1 = 0
    end
    if v2 == nil then
        v2  =  0
    end
    print(v1 .. " _ " .. v2)
end

foo(1,1)
foo(1)
foo()
