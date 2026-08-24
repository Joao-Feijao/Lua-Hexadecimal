package.path = "E:\\Lua Int\\Meus Arquivos Lua\\Projetos Reais\\Hexadec\\?.lua" -- your path here
local hexadec = require("hexadec")(255) -- Start: The arg is the cache size for bits

print (hexadec.NCode())
local function Set(name, func, reps, ...)
    local inicio = os.clock()
    for _ = 1, reps do
        func(...)
    end
    local fim = os.clock()
    print(string.format("%-25s: %.3f secs", name, fim - inicio), ..., func(...))
end

Set("NCODE", hexadec.NCode, 50000, 6, 3, " | ", "35", "1")
Set("SCODE", hexadec.SCode, 50000, "121 abc", 2, " ")
Set("NDECODE", hexadec.NDecode, 50000, 0xA1)
Set("SDECODE", hexadec.SDecode, 50000, "A1", "A1")
Set("ISHEX", hexadec.IsHex, 50000, 123, false)
Set("CLEAN", hexadec.Clean, 50000, 123, false, true)
Set("DUMP", hexadec.Dump, 5, hexadec.NCode(10, nil, nil, "200"), "C")
Set("COLOR", hexadec.Color, 50000, "#FFFFFFFF", true, true)

local a = hexadec.NCode(10, nil, nil, "255", "255", "255", "255")
print (a)
print (hexadec.Color(a, true, true))
print (a:Color(true, true)) -- Hexadec Method