return function(...)
    local table_create
    local v = _VERSION

    if v == "Lua 5.5" or v == "LuaJIT" then
        table_create = table.create 
    else
        table_create = function() return {} end
    end

    local args = {...}
    local tab = table_create(0, 0)

    local Hexadec = table_create(0, 8) -- Metatable = true, NCode = true, SCode = true, NDecode = true, SDecode = true, IsHex = true, Clean = true, Dump = true
    local Ax = table_create(0, 2)

    local counter = 0
    local tcount = args[1]
    local bitwis
    if v == "LuaJIT" then
        -- No LuaJIT, dividimos por 2^b usando matemática pura
        bitwis = function(a, b) return math.floor(a / (2^b)) end
    elseif bit32 then
        bitwis = bit32.rshift
    else
        bitwis = function(a, b) return math.floor(a / (2^b)) end
    end

    repeat
        bitwis(tcount, 1)
        counter = counter + 1
    until tcount > 1
    -- Se 'utf8' não existir (caso do LuaJIT/5.1), criamos um substituto compatível
    local utf8_codes = (utf8 and utf8.codes) or function(str)
        local i = 1
        local len = #str
        return function()
            if i > len then return nil end
            local strbyte = string.byte
            local byte = strbyte(str, i)
            
            -- Lógica de decodificação UTF-8 manual rápida (Pula os bytes extras dos caracteres acentuados)
            local code = byte
            local step = 1
            if byte >= 0xC0 and byte <= 0xDF then
                local b2 = strbyte(str, i + 1)
                code = ((byte - 0xC0) * 64) + (b2 - 0x80)
                step = 2
            elseif byte >= 0xE0 and byte <= 0xEF then
                local b2, b3 = strbyte(str, i + 1, i + 2)
                code = ((byte - 0xE0) * 4096) + ((b2 - 0x80) * 64) + (b3 - 0x80)
                step = 3
            elseif byte >= 0xF0 and byte <= 0xF7 then
                local b2, b3, b4 = strbyte(str, i + 1, i + 3)
                code = ((byte - 0xF0) * 262144) + ((b2 - 0x80) * 4096) + ((b3 - 0x80) * 64) + (b4 - 0x80)
                step = 4
            end
            
            local pos = i
            i = i + step 
            return pos, code
        end
    end


    Hexadec.HEX = table_create(2^counter, 0)
    local format = string.format

    for i = 0, (args[1] or 255) do
        Hexadec.HEX[i] = format("%02X", i)
    end

    Hexadec.Metatable = {__type = "hexadec", __index = Hexadec, __tostring = function(self)
        local concat = table.concat

        return concat(self)
    end, __concat = function(a, b)
        local tostring = tostring

        return tostring(a)..tostring(b)
    end, __eq = function(a, b)
        local tostring = tostring

        if tostring(a) == tostring(b) then
            return true
        else
            return false
        end
    end}
    Hexadec.NCode = function(base, min, sep, ...) -- base: number, min: number, sep: string, ...: string | The vararg is the numbers (in strings) in the base specified (max: 36) that can have a minimum size of min (filled with 0) and a separator sep
        local vars = {...}
        local h = Hexadec.HEX
        base = base or 10
        min = min or 0
        sep = sep or ""

        local create = table_create
        local insert = table.insert
        local format = string.format
        local codes = utf8_codes
        local setmetatable = setmetatable
        local tonumber = tonumber
        local args = args

        local hex = create(#vars, 0)
        local fmt
        if min and (min ~= 0 and sep ~= "") then
            fmt = "%0"..min.."X"..sep
        else
            fmt = "%X"
        end

        if base > 36 then
            local error = error

            error("This function can't use bases bigger than 36")
        elseif base == 16 then
            if #args == 1 then
                hex[1] = vars[1]
            else
                for i = 1, #vars do
                    hex[i] = vars[i]
                end
            end

            return setmetatable(hex, Hexadec.Metatable)
        end

        local tostring = tostring
        local sub = string.sub
        local byte = string.byte
        local lower = string.lower

        if #vars == 1 then
            local x = tonumber(vars[1], base)

            if (min and (min ~= 0 and sep ~= "")) or x > args[1] - 1 then
                hex[1] = format(fmt, x)
            else
                hex[1] = h[x]
            end
        else
            local n = 0

            for i = 1, #vars do
                local x = tonumber(vars[i], base)

                if (min and (min ~= 0 and sep ~= "")) or x > args[1] - 1 then
                    n = n + 1
                    hex[n] = format(fmt, x)
                else
                    n = n + 1
                    hex[n] = h[x]
                end
            end
        end

        return setmetatable(hex, Hexadec.Metatable)
    end
    Hexadec.SCode = function(str, min, sep)
        local create = table_create
        local format = string.format
        local codes = utf8_codes
        local setmetatable = setmetatable
        local type = type
        local types = type(str)

        if types ~= "string" then
            local error = error

            error("Expected str 'string', received '"..types.."'")
        end

        local hex = create(#str + 1, 0)

        local n = 0
        if min and (min ~= 0 and sep ~= "") then
            local fmt = "%0"..min.."X"..sep

            for _, code in codes(str) do
                n = n + 1
                hex[n] = format(fmt, code)
            end
        else
            local h = Hexadec.HEX
            for _, code in codes(str) do
                n = n + 1
                hex[n] = h[code]
            end
        end

        return setmetatable(hex, Hexadec.Metatable)
    end
    function Hexadec:NDecode(secure)
        local error = error
        local getmetatable = getmetatable
        local type = type
        local format = string.format
        local tonumber = tonumber
        local tself = type(self) 

        if tself == "number" then
            return self
        elseif tself == "string" then
            return tonumber(self, 16)
        end

        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            error("Expected 'hexadec' and received '"..(t or type(self)).."'")
        end

        if secure then
            if not self:IsHex(true) then 
                return "Not a valid hexadecimal (don't includes spaces)"
            end
        end

        local nums = {}
        for i = 1, #self do
            nums[i] = tonumber(self[i], 16)
        end

        return nums
    end
    function Hexadec:SDecode(caps, secure)
        local error = error
        local type = type
        local getmetatable = getmetatable
        local char = string.char
        local tonumber = tonumber
        local format = string.format
        local create = table_create

        if type(self) == "string" then
            return tonumber(self, 16)
        end

        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            return "Expected 'hexadec' and received '"..t.."'"
        end

        if secure then
            if not self:IsHex(true) then 
                error("Not a valid hexadecimal (don't includes spaces)") 
            end
        end

        local nums = create(#self + 1, 0)
        local cap = (caps and 64) or 96
        for i = 1, #self do
            nums[i] = char(tonumber(self[i], 16) + cap)
        end

        return nums
    end
    function Hexadec:IsHex(spaces)
        local type = type
        local gsub = string.gsub
        local tself = type(self)
        local format = string.format
        local getmetatable = getmetatable
        
        local is = true
        local fmt
        if spaces then
            fmt = "[^0-9a-fA-F%s]"
        else
            fmt = "[^0-9a-fA-F]"
        end
        if tself == "string" then
            local func = function()
                is = false
            end
            gsub(self, fmt, func)

            return is
        elseif tself == "number" then
            self = format("%00X", self)

            local func = function()
                is = false
            end
            gsub(self, fmt, func)

            return is
        end

        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error = error
            error("Expected 'hexadec' and received '"..t.."'")
        end

        for i = 1, #self do
            gsub(self[i], fmt, function()
                is = false
            end)
        end

        return is
    end
    function Hexadec:Clean(spaces, str)
        local type = type
        local tself = type(self)
        local concat = table.concat
        local gsub = string.gsub
        local format = string.format
        local getmetatable = getmetatable

        local fmt
        if spaces then
            fmt = "[^0-9a-fA-F%s]"
        else
            fmt = "[^0-9a-fA-F]"
        end
        if tself == "string" then
            self = gsub(self, fmt, "")

            return self
        elseif tself == "number" then
            self = format("%00X", self)

            self = gsub(self, fmt, "")

            return self
        end

        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error = error
            error("Expected 'hexadec' and received '"..t.."'")
        end
        
        if str then
            self = concat(self)
            self = gsub(self, fmt, "")
        else
            for i = 1, #self do
                self[i] = gsub(self[i], fmt, "")
            end
        end

        return self
    end
    function Hexadec:Dump(mode, inter, line)
        local getmetatable = getmetatable
        local error = error
        local write = io.write
        local format = string.format
        local type = type

        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            error("Expected 'hexadec' and received '"..t.."'")
        end
        
        line = line or 16

        local bline = "%07X"
        if mode == "C" or mode == "-C" then
            inter = nil

            local tam = 0
            local j = 1
            for i = 1, #self do
                ::Q::
                if tam == 0 then
                    write(format(bline, j)..": ")
                    j = j + 1
                end
                if #self[i] + tam > line then
                    write("\n")
                    tam = 0
                    goto Q
                else
                    tam = tam + #self[i] + 3
                    write(self[i].." | ")
                end
            end

            --[=[local tam = 0
            local i = 1
            local j = 1
            repeat
                io.write(string.format("%07X", i)..": ")
                repeat
                    if #x[j] + tam > line then
                        break
                    else
                        tam = tam + #x[j] + 3
                        io.write(x[j].." | ")
                    end

                    j = j + 1
                until not x[j]

                io.write("\n")
                i = i + 1
            until not x[j]]=]
        elseif mode == "n" or mode == "-n" then
            inter = (type(inter) == "table" and inter) or {1, 1}

            local tam = 0
            local j = 1
            for i = (inter[1] or 1), (inter[2] or 1) do
                ::Q::
                if tam == 0 then
                    write(format(bline, j)..": ")
                    j = j + 1
                end
                if #self[i] + tam > line then
                    write("\n")
                    tam = 0
                    goto Q
                else
                    tam = tam + #self[i] + 3
                    write(self[i].." | ")
                end
            end
        elseif mode == "s" or mode == "-s" then
            inter = (type(inter) == "number" and inter) or 1

            local tam = 0
            local j = 1
            for i = inter + 1, #self do
                ::Q::
                if tam == 0 then
                    write(format(bline, j)..": ")
                    j = j + 1
                end
                if #self[i] + tam > line then
                    write("\n")
                    tam = 0
                    goto Q
                else
                    tam = tam + #self[i] + 3
                    write(self[i].." | ")
                end
            end
        else
            error("Invalid mode, options: 'C', 'n' and 's'.")
        end

        io.write("\n")
    end
    function Hexadec:Color(alpha, float, bits)
        bits = bits or 255

        local type = type
        local tself = type(self)
        local create = table_create
        local error = error

        if tself == "string" then
            local sub = string.sub
            local tonumber = tonumber
            if sub(self, 1, 1) == "#" then
                self = sub(self, 2)
            end

            local r = sub(self, 1, 2)
            local g = sub(self, 3, 4)
            local b = sub(self, 5, 6)
            local a
            if alpha then
                a = tonumber(sub(self, 7, 8), 16) or bits
            end

            r = tonumber(r, 16) or 0
            g = tonumber(g, 16) or 0
            b = tonumber(b, 16) or 0

            if float then
                return r / bits, g / bits, b / bits, a and (a / bits)
            else
                return r, g, b, a
            end
        end

        local t = create(8, 0)
        local i = 0
        local bitwis = bitwis

        repeat
            i = i + 1
            bits = bitwis(bits, 4)
        until bits < 16

        local n = 1
        t[1] = "#"
        local j = 1
        local max
        if alpha then
            max = 4
        else
            max = 3
        end

        repeat
            if not t[n] then
                t[n] = ""
            end

            t[n] = t[n]..self[j]
            j = j + 1

            if #t[n] >= i then
                n = n + 1
            end

            if n > max then
                break
            elseif not self[j] then
                error("The table was incomplete")
            end
        until false

        return table.concat(t)
    end
    Ax.Sum = function(t, i, j)
        local getmetatable = getmetatable

        local mt = getmetatable(t)
        if (mt or {}).__AxSum then
            return mt.__AxSum()
        end

        local r = 0
        for ij = i, j do
            r = r + t[ij]
        end

        return r
    end
    return Hexadec, Ax
end