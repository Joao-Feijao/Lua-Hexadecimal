return function(...)
    local table_new = require("table.new")
    local table_clear = require("table.clear")

    local ArgT, Cache, MMode = select(1, ...)
    if type(ArgT) ~= "number" then
        print [[How to setup Hexadec55.lua:
        1 - You should execute this with at least one argument, that's your Hexadec.HEX cache (makes the conversion faster)
        2 - See my Github please :(
        3 - Good luck!]]

        return "Thanks for testing the Hexadec!"
    end
    local A = table_new
    local Hexadec = A(0, 5)
    local UCH = (Cache and A(0, Cache)) or nil
    local UCHS = (MMode and 0) or nil
    local Al = (MMode and false) or nil
    local Rig = (MMode and Cache) or nil
    if MMode then
        local Y = rawset
        local Z = next
        local m = {__newindex = function(self, k, v)
                local self = self
                local k = k
                if Rig then
                    if UCHS + 1 > Rig then
                        local n = Z
                        local k = n(self)

                        if k then
                            local r = Y
                            r(self, k, nil)
                            UCHS = UCHS - 1 
                        end
                    end
                end
                local v = v
                if Al then
                    Al(k, v)
                end
                local r = rawset
                r(self, k, v)
                UCHS = UCHS + 1
            end}
        local setmetatable = setmetatable
        setmetatable(UCH, m)
    end
    local HEX = A(ArgT, 0)
    local Sf = string.format
    local Fmt = "%02X"
    for i = 0, ArgT do
        HEX[i] = Sf(Fmt, i)
    end
    local B = table.concat
    local C = string.byte
    local D = tonumber
    local E = string.char
    local F = pairs
    local Code = (Cache and function(str)
        local s = str
        local u = UCH
        local b = u[s]
        if b then
            return b
        end
        local l = #s
        local t = A
        local e = t(l, 0)
        local h = HEX
        local a = C
        for i = 1, l do
            e[i] = h[a(s, i)]
        end
        local f = B
        local w = f(e)
        u[s] = w
        u[w] = s
        return e
    end) or function(str)
        local s = str
        local l = #s
        local t = A
        local e = t(l, 0)
        local h = HEX
        local a = C
        for i = 1, l do
            e[i] = h[a(s, i)]
        end
        return e
    end
    local Decode = (Cache and function(tab)
        local t = tab
        local u = UCH
        local b = u[t]
        if b then
            return b
        end
        local l = #t
        local n = D
        local c = E
        local a = A
        local x = a(l, 0)
        for i = 1, l do
            x[i] = c(n(t[i], 16) or 0)
        end
        local y = B
        local d = y(x)
        u[t] = d
        u[d] = t
        return d
    end) or function(tab)
        local t = tab
        local l = #t
        local n = D
        local c = E
        local a = A
        local b = a(l, 0)
        for i = 1, l do
            b[i] = c(n(t[i], 16) or 0)
        end
        local y = B
        local d = y(b)
        return d
    end
    local CClean = (Cache and function(memory)
        local u = UCH
        if memory then
            table_clear(u)
        else
            local p = F
            for k in p(u) do
                u[k] = nil
            end
        end
    end) or nil
    local Alert = (MMode and function(func)
        local u = UCH
        local f = func
        local t = type
        if t(f) == "function" then
            Al = f
        else
            Al = false
        end
    end) or nil
    local Rigid = (MMode and function(num)
        local u = UCH
        local n = num
        local t = type
        if n == "nil" then
            Rig = false
        elseif t(n) == "number" then
            Rig = n
        else
            Rig = Cache
        end
    end) or nil
    Hexadec.UCH = UCH
    Hexadec.HEX = HEX
    Hexadec.Code = Code
    Hexadec.Decode = Decode
    Hexadec.CClean = CClean
    Hexadec.Alert = Alert
    Hexadec.Rigid = Rigid
    return Hexadec
end