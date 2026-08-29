return function(...)
    local ArgT <const>, Cache <const>, MMode <const> = select(1, ...)
    if type(ArgT) ~= "number" then
        print [[How to setup Hexadec55.lua:
        1 - You should execute this with at least one argument, that's your Hexadec.HEX cache (makes the conversion faster)
        2 - See my Github please :(
        3 - Good luck!]]

        return "Thanks for testing the Hexadec!"
    end
    local Hexadec <const> = {}
    local UCH <const> = (Cache and {}) or nil
    if UCH then
        for i = 1, Cache do
            UCH[i] = false
        end
    end
    local UCHS = (MMode and 0) or nil
    local Al = (MMode and false) or nil
    local Rig = (MMode and Cache) or nil
    if MMode then
        local Y <const> = rawset
        local Z <const> = next
        local m <const> = {__newindex = function(self, k, v)
                local self <const> = self
                local k <const> = k
                if Rig then
                    if UCHS + 1 > Rig then
                        local n = Z
                        local k = n(self)

                        if k then
                            local r <const> = Y
                            r(self, k, nil)
                            UCHS = UCHS - 1 
                        end
                    end
                end
                local v <const> = v
                if Al then
                    Al(k, v)
                end
                local r <const> = rawset
                r(self, k, v)
                UCHS = UCHS + 1
            end}
        local setmetatable <const> = setmetatable
        setmetatable(UCH, m)
    end
    local HEX <const> = {}
    local Sf <const> = string.format
    local Fmt <const> = "%02X"
    for i = 0, ArgT do
        HEX[i] = Sf(Fmt, i)
    end
    local B <const> = table.concat
    local C <const> = string.byte
    local D <const> = tonumber
    local E <const> = string.char
    local F <const> = pairs
    local Code <const> = (Cache and function(str)
        local s <const> = str
        local u <const> = UCH
        local b <const> = u[s]
        if b then
            return b
        end
        local l <const> = #s
        local e <const> = {}
        local h <const> = HEX
        local a = C
        for i = 1, l do
            e[i] = h[a(s, i)]
        end
        local f <const> = B
        local w <const> = f(e)
        u[s] = w
        u[w] = s
        return e
    end) or function(str)
        local s <const> = str
        local l <const> = #s
        local e <const> = {}
        local h <const> = HEX
        local a = C
        for i = 1, l do
            e[i] = h[a(s, i)]
        end
        return e
    end
    local Decode <const> = (Cache and function(tab)
        local t <const> = tab
        local u <const> = UCH
        local b <const> = u[t]
        if b then
            return b
        end
        local l <const> = #t
        local n <const> = D
        local c <const> = E
        local x <const> = {}
        for i = 1, l do
            x[i] = c(n(t[i], 16) or 0)
        end
        local y <const> = B
        local d <const> = y(x)
        u[t] = d
        u[d] = t
        return d
    end) or function(tab)
        local t <const> = tab
        local l <const> = #t
        local n <const> = D
        local c <const> = E
        local b <const> = {}
        for i = 1, l do
            b[i] = c(n(t[i], 16) or 0)
        end
        local y <const> = B
        local d <const> = y(b)
        return d
    end
    local CClean <const> = (Cache and function()
        local p = F
        local u <const> = UCH
        for k in p(u) do
            u[k] = nil
        end
    end) or nil
    local Alert <const> = (MMode and function(func)
        local u <const> = UCH
        local f <const> = func
        local t <const> = type
        if t(f) == "function" then
            Al = f
        else
            Al = false
        end
    end) or nil
    local Rigid <const> = (MMode and function(num)
        local u <const> = UCH
        local n <const> = num
        local t <const> = type
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