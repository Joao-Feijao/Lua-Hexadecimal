return function(...)
    local argT = (select(1, ...))
    if type(argT) ~= "number" then
        print [[How to setup Hexadec55.lua:
        1 - You should execute this with at least one argument, that's your Hexadec.HEX cache (makes the conversion faster)
        2 - See my Github please :(
        3 - Good luck!]]

        return "Thanks for testing the Hexadec!"
    end
    
    local Hexadec = {}

    local Hexadec <const> = table.create(0, 4)
    local HEX <const> = table.create(argT, 0)

    for i = 0, (argT or 255) do
        HEX[i] = string.format("%02X", i)
    end

    local Code <const> = function(str)
        local s <const> = str
        local l <const> = #s

        local c <const> = table.create
        local e <const> = c(l, 0)
        local h <const> = Hexadec.HEX
        
        local a = utf8.codes
        for y, z in a(s) do
            e[y] = h[z]
        end

        return e
    end

    local Decode <const> = function(tab)
        local t <const> = tab
        local l <const> = #t

        local n <const> = tonumber
        local c <const> = string.char
        local e = ""
        
        local z <const> = table.create
        local b <const> = z(l, 0)

        for i = 1, l do
            b[i] = c(n(t[i], 16) or 0)
        end

        local a <const> = table.concat

        return a(b)
    end
    
    Hexadec.HEX = HEX
    Hexadec.Code = Code
    Hexadec.Decode = Decode

    return Hexadec
end