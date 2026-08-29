return function(...)
    local args = {...}

    local tcount = args[1]
    if type(tcount) ~= "number" then
        print [[How to setup Hexadec for LuaJIT:
        1 - You should execute this with at least one argument, that's your Hexadec.HEX cache (makes the conversion faster)
        2 - See my Github please :(
        3 - Good luck!]]

        return "Thanks for testing the Hexadec!"
    end

    local table_create = require("table.new")
    local tab = table_create(0, 0)

    local Hexadec = table_create(0, 8) -- Metatable = true, NCode = true, SCode = true, NDecode = true, SDecode = true, IsHex = true, Clean = true, Dump = true

    local counter = 0
    local bytelen = args[1]

    repeat
        tcount = math.floor(tcount / 2)
        counter = counter + 1
    until tcount > 1

    local HEX = table_create(2^counter, 0)
    local format = string.format

    for i = 0, args[1] do
        HEX[i] = format("%02X", i)
    end

    local BitMetatable = {__type = "nibbles", __index = Hexadec, __tostring = function(self)
        local concat = table.concat

        return "{"..concat(self, ", ").."}"
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
    end, __len = function(self)
        local rawlen = rawlen

        return rawlen(self) * 4
    end}
    local Metatable = {__type = "hexadec", __index = Hexadec, __tostring = function(self)
        local concat = table.concat

        return "{"..concat(self, ", ").."}"
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
    local NCode = function(base, min, sep, ...) -- base: number, min: number, sep: string, ...: string | The vararg is the numbers (in strings) in the base specified (max: 36) that can have a minimum size of min (filled with 0) and a separator sep
        local vars = {...}
        local base = base or 10

        if base == 16 then
            local create = table_create
            local hex = create(#vars, 0)
            
            if #vars == 1 then
                hex[1] = vars[1]
            else
                for i = 1, #vars do
                    hex[i] = vars[i]
                end
            end

            local Metatable = Metatable

            local setmetatable = setmetatable
            return setmetatable(hex, Metatable)
        elseif base > 36 then
            local error = error

            error("This function can't use bases bigger than 36")
        elseif base < 2 then
            local error = error

            error("This function can't use bases lower than 2")
        end

        local min = min
        local sep = sep
        
        local h = HEX
        local create = table_create
        local hex = create(#vars, 0)
        local format = string.format
        local tonumber = tonumber
        local bytelen = bytelen
        
        local cond = min and (min ~= 0 and sep ~= "")
        if #vars == 1 then
            local vars1 = vars[1]
            local x = tonumber(vars1, base) or 0

            if cond or x > bytelen - 1 then
                local fmt = "%0"..min.."X"..sep
                hex[1] = format(fmt, x)
            else
                hex[1] = h[x]
            end
        else
            local n = 0

            if cond then
                local fmt = "%0"..min.."X"..sep
                for i = 1, #vars do
                    local x = tonumber(vars[i], base) or 0
                    n = n + 1
                    hex[n] = format(fmt, x)
                end
            else
                local fmt = "%X"
                for i = 1, #vars do
                    local x = tonumber(vars[i], base) or 0
                    n = n + 1
                    hex[n] = h[x] or format(fmt, x)
                end
            end
        end

        local Metatable = Metatable

        local setmetatable = setmetatable

        return setmetatable(hex, Metatable)
    end
    local SCode = function(str, min, sep)
        local str = str
        
        local type = type
        local types = type(str)

        if types ~= "string" then
            local error = error

            error("Expected str 'string', received '"..types.."'")
        end

        local min = min
        local sep = sep

        local format = string.format
        local create = table_create
        local hex = create(#str + 1, 0)

        local n = 0
        local len = #str
        local sub = string.sub
        local byte = string.byte
        local cond = min and (min ~= 0 and sep ~= "")
        if cond then
            local fmt = "%0"..min.."X"..sep

            for i = 1, len do
                n = n + 1
                hex[n] = format(fmt, byte(sub(str, i, i)))
            end
        else
            local fmt = "%X"
            local h = HEX
            for i = 1, len do
                n = n + 1
                hex[n] = format(fmt, byte(sub(str, i, i)))
            end
        end

        local Metatable = Metatable

        local setmetatable = setmetatable

        return setmetatable(hex, Metatable)
    end
    local NDecode = function(self, str, secure)
        local self = self
        
        local type = type
        local tself = type(self)

        if tself == "number" then
            return self
        elseif tself == "string" then
            local tonumber = tonumber

            return tonumber(self, 16)
        end

        local getmetatable = getmetatable
        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error = error

            error("Expected 'hexadec' and received '"..(t or type(self)).."'")
        end

        local secure = secure

        if secure then
            if not self:IsHex(true) then 
                return "Not a valid hexadecimal (don't includes spaces)"
            end
        end

        local str = str

        local format = string.format
        local char = string.char

        local create = table_create
        local len = #self
        local nums = create(len, 0)
        local tonumber = tonumber

        if str then
            for i = 1, len do
                nums[i] = char(tonumber(self[i], 16))
            end
        else
            for i = 1, len do
                nums[i] = tonumber(self[i], 16)
            end
        end

        return nums
    end
    local SDecode = function(self, caps, secure)
        local self = self

        local type = type

        if type(self) == "string" then
            local caps = caps
            local char = string.char
            local tonumber = tonumber
            local cap = (caps and 64) or 96

            return char(tonumber(self, 16) + cap)
        end

        local getmetatable = getmetatable
        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            return "Expected 'hexadec' and received '"..t.."'"
        end

        local secure = secure

        if secure then
            if not self:IsHex(true) then 
                return "Not a valid hexadecimal (don't includes spaces)"
            end
        end

        local caps = caps
        
        local char = string.char

        local create = table_create
        local len = #self
        local nums = create(len, 0)

        local cap = (caps and 64) or 96
        local tonumber = tonumber
        for i = 1, len do
            nums[i] = char(tonumber(self[i], 16) + cap)
        end

        return nums
    end
    local IsHex = function(self)
        local self = self

        local type = type
        local tself = type(self)

        if tself == "string" then
            local tonumber = tonumber

            return tonumber(self, 16) ~= nil
        elseif tself == "number" then
            return true
        end

        local getmetatable = getmetatable
        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error = error

            error("Expected 'hexadec' and received '"..t.."'")
        end

        local tonumber = tonumber
        for i = 1, #self do
            if not tonumber(self[i], 16) then
                return false
            end
        end

        return true
    end
    local Clean = function(self, spaces, str)
        local self = self

        local type = type
        local tself = type(self)

        if tself == "string" then
            local spaces = spaces
            local fmt = spaces and "[^0-9a-fA-F%s]+" or "[^0-9a-fA-F]+"
            local blank = ""
            local gsub = string.gsub

            return gsub(self, fmt, blank)
        elseif tself == "number" then
            local format = string.format

            return format("%X", self)
        end
        
        local getmetatable = getmetatable
        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error = error

            error("Expected 'hexadec' and received '"..t.."'")
        end

        local str = str

        if str then
            local spaces = spaces
            local fmt = spaces and "[^0-9a-fA-F%s]+" or "[^0-9a-fA-F]+"
            local blank = ""
            local gsub = string.gsub
            local concat = table.concat
            local strC = concat(self)

            return gsub(strC, fmt, blank)
        end
        
        local spaces = spaces
        local fmt = spaces and "[^0-9a-fA-F%s]+" or "[^0-9a-fA-F]+"
        local blank = ""
        local gsub = string.gsub
        local create = table_create
        local len = #self
        local hex = create(len, 0)

        for i = 1, #len do
            hex[i] = gsub(self[i], fmt, blank)
        end

        local setmetatable = setmetatable
        local Metatable = Metatable

        return setmetatable(hex, Metatable)
    end
    local Dump = function(self, mode, inter, line)
        local self = self
        local mode = mode
        local line = line or 16

        local getmetatable = getmetatable
        local format = string.format
        local type = type
        local NL = "\n"
        local BACK = " | "

        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error = error

            error("Expected 'hexadec' and received '"..t.."'")
        end

        local bline = "%07X"
        local len = #self
        local create = table_create
        local buffer = create(len * 4, 0)
        local n = 0

        if mode == "C" or mode == "-C" then
            local tam = 0
            local j = 1

            for i = 1, len do
                local selfi = self[i]
                local selfil = #selfi

                if tam == 0 then
                    n = n + 1
                    buffer[n] = format(bline, j)
                    j = j + 1
                end

                n = n + 1 buffer[n] = BACK
                n = n + 1 buffer[n] = selfi
                tam = tam + selfil + 3

                if tam + selfil + 3 > line then
                    n = n + 1
                    buffer[n] = NL
                    tam = 0
                end
            end
        elseif mode == "n" or mode == "-n" then
            local res = {1, 1}
            local inter = inter
            local inter = (type(inter) == "table" and inter) or res

            local tam = 0
            local j = 1
            for i = (inter[1] or 1), (inter[2] or 1) do
                local selfi = self[i]
                local selfil = #selfi

                if tam + selfil + 3 > line then
                    n = n + 1
                    buffer[n] = NL
                    tam = 0
                end

                if tam == 0 then
                    n = n + 1 buffer[n] = format(bline, j)
                    j = j + 1
                end

                n = n + 1 buffer[n] = BACK
                n = n + 1 buffer[n] = selfi
                tam = tam + selfil + 3
            end
        elseif mode == "s" or mode == "-s" then
            local inter = inter
            local inter = (type(inter) == "number" and inter) or 1
            local inter1 = inter + 1

            local tam = 0
            local j = 1
            for i = inter1, len do
                local selfi = self[i]
                local selfil = #selfi

                if tam + selfil + 3 > line then
                    n = n + 1
                    buffer[n] = NL
                    tam = 0
                end

                if tam == 0 then
                    n = n + 1
                    buffer[n] = format(bline, j)
                    j = j + 1
                end

                n = n + 1 buffer[n] = BACK
                n = n + 1 buffer[n] = selfi
                tam = tam + selfil + 3
            end
        else
            local error = error

            error("Invalid mode, options: 'C', 'n' and 's'.")
        end

        buffer[n] = NL
        local write = io.write
        local concat = table.concat

        write(concat(buffer))
    end
    local Color = function(self, alpha, float, bits)
        local self = self
        local bits = bits or 256
        local b = bits
        local i = 0

        repeat
            i = i + 1
            b = math.floor(b / 16)
        until b < 16

        local type = type
        local tself = type(self)

        if tself == "string" then
            local alpha = alpha
            local float = float

            local sub = string.sub
            
            local tonumber = tonumber

            local i = i
            local ii = i + 1
            local i1 = i * 2
            local ii1 = i1 + 1
            local i25 = i * 3
            local ii25 = i25 + 1
            local i2 = i * 4
            local r = tonumber(sub(self, 1, i), 16) or 0
            local g = tonumber(sub(self, ii, i1), 16) or 0
            local b = tonumber(sub(self, ii1, i25), 16) or 0
            local a = (alpha and tonumber(sub(self, ii25, i2), 16)) or bits

            if float then 
                return r / bits, g / bits, b / bits, a / bits 
            end
            
            return r, g, b, a
        end

        local alpha = alpha
        local float = float

        local getmetatable = getmetatable
        local tab = tab

        local t = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error = error

            error("Expected 'hexadec' and received '"..(t or type(self)).."'")
        end

        local create = table_create
        local t = create(8, 0)

        t[1] = "#"
        local j = 1

        local error = error
        local max = (alpha and 4) or 3
        local blank = ""

        for k = 1, max do
            if not t[k] then
                t[k] = blank
            end

            repeat
                t[k] = t[k]..(self[j] or error("The table was incomplete"))
                j = j + 1
            until #t[k] >= i
        end

        local concat = table.concat

        return concat(t)
    end

    Hexadec.HEX = HEX
    Hexadec.BitMetatable = BitMetatable
    Hexadec.Metatable = Metatable
    Hexadec.NCode = NCode
    Hexadec.SCode = SCode
    Hexadec.NDecode = NDecode
    Hexadec.SDecode = SDecode
    Hexadec.IsHex = IsHex
    Hexadec.Clean = Clean
    Hexadec.Dump = Dump
    Hexadec.Color = Color

    return Hexadec
end