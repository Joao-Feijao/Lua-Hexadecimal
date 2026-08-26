return function(...)
    local argT = (select(1, ...))
    local Hexadec = {}

    local table_create
    local v = _VERSION

    if v == "Lua 5.5" or v == "LuaJIT" then
        table_create = table.create 
    else
        table_create = function() return {} end
    end

    local Hexadec = table_create(0, 4)
    Hexadec.HEX = table_create(argT, 0)

    for i = 0, (argT or 255) do
        Hexadec.HEX[i] = string.format("%02X", i)
    end
    local utf8_codes = (utf8 and utf8.codes) or function(str)
        local i = 1
        local len = #str
        return function()
            if i > len then return nil end

            local strbyte = string.byte
            local byte = strbyte(str, i)
            
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

    if v == "LuaJIT" then
        Hexadec.Code = function(str)
            local l = #str
            local c = table.concat
            local cr = table_create
            local b = string.byte
            local he = cr(l, 0)
            local h = Hexadec.HEX

            for i = 1, l do
                he[i] = h[b(str, i)]
            end

            return c(he)
        end

        function Hexadec.Decode(str)
        
        end
    else
        Hexadec.Code = function(str)
            local c = table_create
            local d = utf8_codes

            local hex = c(#str + 1, 0)

            local h = Hexadec.HEX
            local n = 1
            for _, code in d(str) do
                hex[n] = h[code]
                n = n + 1
            end

            return hex
        end

        function Hexadec.Decode(str)
        
        end
    end

    return Hexadec
end