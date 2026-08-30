package.path = "Your path here"
local hexadec = require("hexadec")(255) -- Start: The arg is the cache size for bits
local hl = require("hexadec_lite")(255, 255, true) -- Cache size, ULTRA CACHE, Manutention Mode

local a = function()
    -- Literally nothing
end
local b = function(x) -- Benchmark with the default function for decoding
    local tn = tonumber

    return tn("F", 16)
end
local function Set(name, func, reps, ...) -- Benchmark function
    local ini = os.clock()
    for _ = 1, reps do
        func(...)
    end
    local en = os.clock()
    print(string.format("%-25s: %.3f secs", name, en - ini), ..., func(...))
end

local table_for_tests = hexadec.NCode(10, nil, nil, "1", "2", "3", "4")

Set("\nHexadec.NCode", hexadec.NCode, 50000, 10, nil, nil, "255")
Set("\nEstressed - Hexadec.NCode", hexadec.NCode, 50000, 10, 3, " ", "255", "4095")
Set("\nSCODE", hexadec.SCode, 50000, "123")
Set("\nEstressed - Hexadec.SCode", hexadec.SCode, 50000, "WXYZ", 3, " ")
Set("\nExtra - Hexadec.SCode", hexadec.SCode, 50000, [[ !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~]])
Set("\nHexadec.NDecode", hexadec.NDecode, 50000, 0xA1)
Set("\nEstressed - Hexadec.NDecode", hexadec.NDecode, 50000, 0xA1, true, true)
Set("\nHexadec.SDecode", hexadec.SDecode, 50000, 1)
Set("\nEstressed - Hexadec.SDecode", hexadec.SDecode, 50000, table_for_tests, true, true)
Set("\nISHEX", hexadec.IsHex, 50000, 123)
Set("\nEstressed - ISHEX", hexadec.IsHex, 50000, table_for_tests)
Set("\nCLEAN", hexadec.Clean, 50000, 123)
Set("\nEstressed - CLEAN", hexadec.Clean, 50000, table_for_tests, true, true)
Set("\nDUMP", hexadec.Dump, 5, table_for_tests, "C")
Set("\nCOLOR", hexadec.Color, 50000, "#FFFFFFFF", true, true)
Set("\nEstressed - COLOR", hexadec.Color, 50000, table_for_tests, true, true, 16)

print ("--- Lite ---")

Set("\nLite.Code", hl.Code, 50000, "121 abc")
Set("\nEstressed - Lite.Code", hl.Code, 50000, [[ !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~]])
Set("\nLite.Decode", hl.Decode, 50000, {"1A"})
Set("\nEstressed - Lite.Decode", hl.Decode, 50000, table_for_tests)
Set("\nNothing", a, 50000)
Set("\nTonumber", b, 50000)