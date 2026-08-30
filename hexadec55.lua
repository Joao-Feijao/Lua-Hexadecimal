return function(...)
    local args <const> = {...}

    local tcount = args[1]
    if type(tcount) ~= "number" then
        print [[How to setup Hexadec for Lua 5.5:
        1 - You should execute this with at least one argument, that's your Hexadec.HEX cache (makes the conversion faster)
        2 - See my Github please :(
        3 - Good luck!]]

        return "Thanks for testing the Hexadec!"
    end

    local tab <const> = table.create(0, 1)

    local Hexadec <const> = table.create(0, 8) -- Metatable = true, NCode = true, SCode = true, NDecode = true, SDecode = true, IsHex = true, Clean = true, Dump = true

    local counter = 0
    
    local bytelen <const> = args[1]

    repeat
        tcount = tcount >> 1
        counter = counter + 1
    until tcount > 1

    local HEX <const> = table.create(2^counter, 0)

    for i = 0, (args[1] or 255) do
        HEX[i] = string.format("%02X", i)
    end

    local BitMetatable <const> = {__type = "nibbles", __index = Hexadec, __tostring = function(self)
        local self <const> = self
        local concat <const> = table.concat

        return "{"..concat(self, ", ").."}"
    end, __concat = function(a, b)
        local a <const> = a
        local b <const> = b
        local tostring <const> = tostring

        return tostring(a)..tostring(b)
    end, __eq = function(a, b)
        local a <const> = a
        local b <const> = b
        local tostring <const> = tostring

        if tostring(a) == tostring(b) then
            return true
        else
            return false
        end
    end, __len = function(self)
        local self <const> = self
        local rawlen <const> = rawlen

        return rawlen(self) * 4
    end}
    local Metatable <const> = {__type = "hexadec", __index = Hexadec, __tostring = function(self)
        local self <const> = self
        local concat <const> = table.concat

        return "{"..concat(self, ", ").."}"
    end, __concat = function(a, b)
        local a <const> = a
        local b <const> = b
        local tostring <const> = tostring

        return tostring(a)..tostring(b)
    end, __eq = function(a, b)
        local a <const> = a
        local b <const> = b
        local tostring <const> = tostring

        if tostring(a) == tostring(b) then
            return true
        else
            return false
        end
    end}
    local NCode <const> = function(base, min, sep, ...) -- base: number, min: number, sep: string, ...: string | The vararg is the numbers (in strings) in the base specified (max: 36) that can have a minimum size of min (filled with 0) and a separator sep
        local vars <const> = {...}
        local base <const> = base or 10

        if base == 16 then
            local create <const> = table.create
            local hex <const> = create(#vars, 0)
            
            if #vars == 1 then
                hex[1] = vars[1]
            else
                for i = 1, #vars do
                    hex[i] = vars[i]
                end
            end

            local Metatable <const> = Metatable

            local setmetatable <const> = setmetatable
            return setmetatable(hex, Metatable)
        elseif base > 36 then
            local error <const> = error

            error("This function can't use bases bigger than 36")
        elseif base < 2 then
            local error <const> = error

            error("This function can't use bases lower than 2")
        end

        local min <const> = min
        local sep <const> = sep
        
        local h <const> = HEX
        local create <const> = table.create
        local hex <const> = create(#vars, 0)
        local format <const> = string.format
        local tonumber <const> = tonumber
        local bytelen <const> = bytelen
        
        local cond <const> = min and (min ~= 0 and sep ~= "")
        if #vars == 1 then
            local vars1 <const> = vars[1]
            local x = tonumber(vars1, base) or 0

            if cond and x > bytelen - 1 then
                local fmt <const> = "%0"..min.."X"..sep
                hex[1] = format(fmt, x)
            else
                hex[1] = h[x]
            end
        else
            local n = 0

            if cond then
                local fmt <const> = "%0"..min.."X"..sep
                for i = 1, #vars do
                    local x = tonumber(vars[i], base) or 0
                    n = n + 1
                    hex[n] = format(fmt, x)
                end
            else
                local fmt <const> = "%X"
                for i = 1, #vars do
                    local x = tonumber(vars[i], base) or 0
                    n = n + 1
                    hex[n] = h[x] or format(fmt, x)
                end
            end
        end

        local Metatable <const> = Metatable

        local setmetatable <const> = setmetatable

        return setmetatable(hex, Metatable)
    end
    local SCode <const> = function(str, min, sep)
        local str <const> = str
        
        local type <const> = type
        local types <const> = type(str)

        if types ~= "string" then
            local error <const> = error

            error("Expected str 'string', received '"..types.."'")
        end

        local min <const> = min
        local sep <const> = sep

        local format <const> = string.format
        local create = table.create
        local hex <const> = create(#str + 1, 0)

        local n = 0
        local len = #str
        local sub = string.sub
        local byte = string.byte
        local cond <const> = min and (min ~= 0 and sep ~= "")
        if cond then
            local fmt <const> = "%0"..min.."X"..sep

            for i = 1, len do
                n = n + 1
                hex[n] = format(fmt, byte(sub(str, i, i)))
            end
        else
            local fmt <const> = "%X"
            local h <const> = HEX
            for i = 1, len do
                n = n + 1
                hex[n] = h[byte(sub(str, i, i))] or format(fmt, byte(sub(str, i, i)))
            end
        end

        local Metatable <const> = Metatable

        local setmetatable <const> = setmetatable

        return setmetatable(hex, Metatable)
    end
    local NDecode <const> = function(self, str, secure)
        local self <const> = self
        
        local type <const> = type
        local tself <const> = type(self)

        if tself == "number" then
            return self
        elseif tself == "string" then
            local tonumber <const> = tonumber

            return tonumber(self, 16)
        end

        local getmetatable <const> = getmetatable
        local tab <const> = tab

        local t <const> = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error <const> = error

            error("Expected 'hexadec' and received '"..(t or type(self)).."'")
        end

        local secure <const> = secure

        if secure then
            if not self:IsHex(true) then 
                return "Not a valid hexadecimal (don't includes spaces)"
            end
        end

        local str <const> = str

        local format <const> = string.format
        local char <const> = string.char

        local create <const> = table.create
        local len <const> = #self
        local nums <const> = create(len, 0)
        local tonumber <const> = tonumber

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
    local SDecode <const> = function(self, caps, secure)
        local self <const> = self

        local type <const> = type
        local tys <const> = type(self)
        if tys == "string" then
            local caps <const> = caps
            local char <const> = string.char
            local tonumber <const> = tonumber
            local cap <const> = (caps and 64) or 96

            return char(tonumber(self, 16) + cap)
        elseif tys == "number" then
            local caps <const> = caps
            local char <const> = string.char
            local cap <const> = (caps and 64) or 96

            return char(self + cap)
        end

        local getmetatable <const> = getmetatable
        local tab <const> = tab

        local t <const> = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            return "Expected 'hexadec' and received '"..t.."'"
        end

        local secure <const> = secure

        if secure then
            if not self:IsHex(true) then 
                return "Not a valid hexadecimal (don't includes spaces)"
            end
        end

        local caps <const> = caps
        
        local char <const> = string.char

        local create <const> = table.create
        local len <const> = #self
        local nums <const> = create(len, 0)

        local cap <const> = (caps and 64) or 96
        local tonumber <const> = tonumber
        for i = 1, len do
            nums[i] = char(tonumber(self[i], 16) + cap)
        end

        return nums
    end
    local IsHex <const> = function(self)
        local self <const> = self

        local type <const> = type
        local tself <const> = type(self)

        if tself == "string" then
            local tonumber <const> = tonumber

            return tonumber(self, 16) ~= nil
        elseif tself == "number" then
            return true
        end

        local getmetatable <const> = getmetatable
        local tab <const> = tab

        local t <const> = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error <const> = error

            error("Expected 'hexadec' and received '"..t.."'")
        end

        local tonumber <const> = tonumber
        for i = 1, #self do
            if not tonumber(self[i], 16) then
                return false
            end
        end

        return true
    end
    local Clean <const> = function(self, spaces, str)
        local self <const> = self

        local type <const> = type
        local tself <const> = type(self)

        if tself == "string" then
            local spaces <const> = spaces
            local fmt <const> = spaces and "[^0-9a-fA-F%s]+" or "[^0-9a-fA-F]+"
            local blank <const> = ""
            local gsub <const> = string.gsub

            return gsub(self, fmt, blank)
        elseif tself == "number" then
            local format <const> = string.format

            return format("%X", self)
        end
        
        local getmetatable <const> = getmetatable
        local tab <const> = tab

        local t <const> = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error <const> = error

            error("Expected 'hexadec' and received '"..t.."'")
        end

        local str <const> = str

        if str then
            local spaces <const> = spaces
            local fmt <const> = spaces and "[^0-9a-fA-F%s]+" or "[^0-9a-fA-F]+"
            local blank <const> = ""
            local gsub <const> = string.gsub
            local concat <const> = table.concat
            local strC <const> = concat(self)

            return gsub(strC, fmt, blank)
        end
        
        local spaces <const> = spaces
        local fmt <const> = spaces and "[^0-9a-fA-F%s]+" or "[^0-9a-fA-F]+"
        local blank <const> = ""
        local gsub <const> = string.gsub
        local create <const> = table.create
        local len <const> = #self
        local hex <const> = create(len, 0)

        for i = 1, #len do
            hex[i] = gsub(self[i], fmt, blank)
        end

        local setmetatable <const> = setmetatable
        local Metatable <const> = Metatable

        return setmetatable(hex, Metatable)
    end
    local Dump <const> = function(self, mode, inter, line)
        local self <const> = self
        local mode <const> = mode
        local line <const> = line or 16

        local getmetatable <const> = getmetatable
        local format <const> = string.format
        local type <const> = type
        local NL <const> = "\n"
        local BACK <const> = " | "

        local tab <const> = tab

        local t <const> = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error <const> = error

            error("Expected 'hexadec' and received '"..t.."'")
        end

        local bline <const> = "%07X"
        local len <const> = #self
        local create <const> = table.create
        local buffer <const> = create(len * 4, 0)
        local n = 0

        if mode == "C" or mode == "-C" then
            local tam = 0
            local j = 1

            for i = 1, len do
                local selfi <const> = self[i]
                local selfil <const> = #selfi

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
            local res <const> = {1, 1}
            local inter <const> = inter
            local inter <const> = (type(inter) == "table" and inter) or res

            local tam = 0
            local j = 1
            for i = (inter[1] or 1), (inter[2] or 1) do
                local selfi <const> = self[i]
                local selfil <const> = #selfi

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
            local inter <const> = inter
            local inter <const> = (type(inter) == "number" and inter) or 1
            local inter1 <const> = inter + 1

            local tam = 0
            local j = 1
            for i = inter1, len do
                local selfi <const> = self[i]
                local selfil <const> = #selfi

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
            local error <const> = error

            error("Invalid mode, options: 'C', 'n' and 's'.")
        end

        buffer[n] = NL
        local write <const> = io.write
        local concat <const> = table.concat

        write(concat(buffer))
    end
    local Color <const> = function(self, alpha, float, bits)
        local self <const> = self
        local bits <const> = bits or 256
        local b = bits
        local i = 0

        repeat
            i = i + 1
            b = b >> 4
        until b < 16

        local type <const> = type
        local tself <const> = type(self)

        if tself == "string" then
            local alpha <const> = alpha
            local float <const> = float

            local sub <const> = string.sub
            
            local tonumber <const> = tonumber

            local i <const> = i
            local ii <const> = i + 1
            local i1 <const> = i << 1
            local ii1 <const> = i1 + 1
            local i25 <const> = i * 3
            local ii25 <const> = i25 + 1
            local i2 <const> = i << 2
            local r <const> = tonumber(sub(self, 1, i), 16) or 0
            local g <const> = tonumber(sub(self, ii, i1), 16) or 0
            local b <const> = tonumber(sub(self, ii1, i25), 16) or 0
            local a <const> = (alpha and tonumber(sub(self, ii25, i2), 16)) or bits

            if float then 
                return r / bits, g / bits, b / bits, a / bits 
            end
            
            return r, g, b, a
        end

        local alpha <const> = alpha
        local float <const> = float

        local getmetatable <const> = getmetatable
        local tab <const> = tab

        local t <const> = (getmetatable(self) or tab).__type
        if t ~= "hexadec" then
            local error <const> = error

            error("Expected 'hexadec' and received '"..(t or type(self)).."'")
        end

        local create <const> = table.create
        local t <const> = create(8, 0)

        t[1] = "#"
        local j = 1

        local error <const> = error
        local max <const> = (alpha and 4) or 3
        local blank <const> = ""

        for k = 1, max do
            if not t[k] then
                t[k] = blank
            end

            repeat
                t[k] = t[k]..(self[j] or error("The table was incomplete"))
                j = j + 1
            until #t[k] >= i
        end

        local concat <const> = table.concat

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