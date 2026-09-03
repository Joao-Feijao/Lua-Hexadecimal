# Introduction for Lua Hexadecimal
**Hi, I made a module in Lua that can manipulate hexadecimal!**

LuaRocks description:<br>
Can convert numbers of n-base (up to 36) and strings to hexadec (special type representing hexadecimal in a table) that can be converted
back or become RGB (RGBA) colors, hex dumped and be cleaned, with a secure mode for the decode function.<br>
Functions:<br>
NCode - Codes numeric strings to a hexadec type;<br>
SCode - Codes strings to a hexadec type;<br>
NDecode - Decodes a hexadec type to numbers;<br>
SDecode - Decodes a hexadec type to strings;<br>
IsHex - Validates a hexadec type or a string;<br>
Clean - Cleans a hexadec type or a string or a number excluding non-hexadecimal caracteres;<br>
Dump - Hex dump from a hexadec type;<br>
Color - Uses a table or a string to create RGB or RGBA (with Alpha).

Also, I recommend using [Color](https://github.com/andOrlando/color) and [Hex](https://github.com/mah0x211/lua-hex) with it!

<details open>
<summary>🔍 <b>Starting</b></summary>

## How can I download the module?
You can download the module via:
- *tags and releases*;
- *LuaRocks, with the [repository website](https://luarocks.org/modules/joao-feijao/hexadec)*;
- *If you have LuaRocks installed, you can use the following prompt:*
```bash
$ luarocks install hexadec
```

## Downloaded it via LuaRocks? Let's proceed!
Now, the next step is loading the package (currently, every version supports this):

- Normal version:
```lua
local hexset = require("hexadec")

print (type(hexset)) -- function
hexset() -- Will print a tutorial and return a secret message because it doesn't have an argument or the argument isn't a number
hexset = hexset(your_cache_size_here)
print (type(hexset)) -- table (Hexadec module)
```

- Lite version (available on v1.1.0=+):
```lua
local hexsetlite = require("hexadec_lite")

print(type(hexsetlite)) -- function
hexsetlite() -- Will print a tutorial and return a secret message because it doesn't have an argument or the argument isn't a number
hexsetlite = hexsetlite(your_cache_size_here)
hexsetlite(your_cache_size_here) -- table (Hexadec lite module)
```

## Downloaded it via tags or releases? Let's proceed!
Instead of requiring a universal file, you will have the manual method:
```lua
-- For LuaJIT, available on v1.2.0=+
local hexset = require("hexadecJIT")
local hexsetlite = require("hexadec_liteJIT")

-- For Lua 5.3, available on v1.2.0=+
local hexset = require("hexadec53")
local hexsetlite = require("hexadec_lite53")

-- For Lua 5.4, available on v1.2.0=+
local hexset = require("hexadec54")
local hexsetlite = require("hexadec_lite54")

-- For Lua 5.5, available on v1.1.0=+
local hexset = require("hexadec55")
local hexsetlite = require("hexadec_lite55")

-- General, available on v1.2.0<
local hexset = require("hexadec") -- DOESN'T HAVE SETUP FUNCTION!!!
local hexsetlite = require("hexadec_lite") -- DOESN'T HAVE SETUP FUNCTION!!!

-- Normal version
print(type(hexset)) -- function
hexset() -- Will print a tutorial and return a secret message because it doesn't have an argument or the argument isn't a number
hexset = hexset(your_cache_size_here)
hexset(your_cache_size_here) -- table (Hexadec module)

-- Lite version
print(type(hexsetlite)) -- function
hexsetlite() -- Will print a tutorial and return a secret message because it doesn't have an argument or the argument isn't a number
hexsetlite = hexsetlite(your_cache_size_here)
hexsetlite(your_cache_size_here) -- table (Hexadec lite module)
```

## Last thing to do...
Now you can use the module! Also, thank you for downloading.

You can see more of how to use the functions, setup and others in the [Documentation](#here-you-can-see-how-to-use-the-functions-inside-of-hexadec) and [Extras](#here-you-can-see-other-features-and-extras) sections below!

-------------------------------------------------------------------------------------------------------- STARTING END
</details>

<details>
<summary>⚡ <b>Benchmarks</b></summary>

## Here you can see Hexadec compared to other LuaRocks modules!
Specs:<br>
- R7 5700G;<br>
- 16GB DDR4;<br>
- Made on VSCode.

## Benckmark function:<br>
```lua
local function Set(name, func, reps, ...)
  local ini = os.clock()
  for _ = 1, reps do
    func(...)
  end
  local en = os.clock()
  print(string.format("%-25s: %.3f secs", name, en - ini), ..., func(...))
end
```
<details>
<summary>🌙 <b>Lua Version: JIT</b></summary><br>
<details>
<summary>---> <b>Version: 1.2.0</b></summary>

```lua
local hexadec = require("hexadec")(255) -- Start: The arg is the cache size for bits
local hl = require("hexadec_lite")(255, 255, true) -- Cache size, ULTRA CACHE, Manutention Mode

local a = function()
    -- Literally nothing
end
local b = function(x) -- Benchmark with the default function for decoding
    local tn = tonumber

    return tn("F", 16)
end

local table_for_tests = hexadec.NCode(10, nil, nil, "1", "2", "3", "4")

print ("Benchmark!!!")
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
Set("\nLite.CClean", hl.CClean, 50000)
Set("\nEstressed - Lite.CClean", hl.CClean, 50000, true)
Set("\nLite.Alert", hl.Alert, 50000, a)
Set("\nLite.Rigid", hl.Rigid, 50000, 4)
Set("\nNothing", a, 50000)
Set("\nTonumber", b, 50000)

-- OUTPUT (50.000 repeats, except for Hexadec.Dump, which is 5)
Benchmark!!!

Hexadec.NCode           : 0.008 secs    10      {FF}

Estressed - Hexadec.NCode: 0.017 secs   10      {0FF , FFF }

SCODE                   : 0.007 secs    123     {31, 32, 33}

Estressed - Hexadec.SCode: 0.015 secs   WXYZ    {057 , 058 , 059 , 05A }

Extra - Hexadec.SCode   : 0.110 secs     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ {20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 2A, 2B, 2C, 2D, 2E, 2F, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 3A, 3B, 3C, 3D, 3E, 3F, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 4A, 4B, 4C, 4D, 4E, 4F, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 5A, 5B, 5C, 5D, 5E, 5F, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 6A, 6B, 6C, 6D, 6E, 6F, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 7A, 7B, 7C, 7D, 7E}

Hexadec.NDecode         : 0.001 secs    161     161

Estressed - Hexadec.NDecode: 0.001 secs 161     161

Hexadec.SDecode         : 0.002 secs    1       a

Estressed - Hexadec.SDecode: 0.026 secs {01, 02, 03, 04}        table: 0x0215a9dfe700

ISHEX                   : 0.002 secs    123     true

Estressed - ISHEX       : 0.009 secs    {01, 02, 03, 04}        true

CLEAN                   : 0.003 secs    123     7B

Estressed - CLEAN       : 0.013 secs    {01, 02, 03, 04}        01020304        0
-- Hex dump

DUMP                    : 0.000 secs    {01, 02, 03, 04}

COLOR                   : 0.011 secs    #FFFFFFFF       0       0.99609375      0.99609375      0.99609375

Estressed - COLOR       : 0.014 secs    {01, 02, 03, 04}        #01020304
--- Lite ---

Lite.Code               : 0.001 secs    121 abc 31323120616263

Estressed - Lite.Code   : 0.001 secs     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ 202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E

Lite.Decode             : 0.001 secs    table: 0x0215a9df18e8

Estressed - Lite.Decode : 0.001 secs    {01, 02, 03, 04}

Lite.CClean             : 0.008 secs    nil

Estressed - Lite.CClean : 0.008 secs    true

Lite.Alert              : 0.000 secs    function: 0x0215a9df2108

Lite.Rigid              : 0.000 secs    4

Nothing                 : 0.001 secs    nil

Tonumber                : 0.002 secs    nil     15
```
</details>
</details>
<details>
<summary>🌙 <b>Lua Version: 5.3</b></summary><br>
<details>
<summary>---> <b>Version: 1.2.0</b></summary>

```lua
local hexadec = require("hexadec")(255) -- Start: The arg is the cache size for bits
local hl = require("hexadec_lite")(255, 255, true) -- Cache size, ULTRA CACHE, Manutention Mode

local a = function()
    -- Literally nothing
end
local b = function(x) -- Benchmark with the default function for decoding
    local tn = tonumber

    return tn("F", 16)
end

local table_for_tests = hexadec.NCode(10, nil, nil, "1", "2", "3", "4")

print ("Benchmark!!!")
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
Set("\nLite.Alert", hl.Alert, 50000, a)
Set("\nLite.Rigid", hl.Rigid, 50000, 4)
Set("\nNothing", a, 50000)
Set("\nTonumber", b, 50000)

-- OUTPUT (50.000 repeats, except for Hexadec.Dump, which is 5)
Benchmark!!!

Hexadec.NCode           : 0.029 secs    10      {FF}

Estressed - Hexadec.NCode: 0.065 secs   10      {0FF , FFF }

SCODE                   : 0.068 secs    123     {31, 32, 33}

Estressed - Hexadec.SCode: 0.088 secs   WXYZ    {057 , 058 , 059 , 05A }

Extra - Hexadec.SCode   : 1.117 secs     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ {20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 2A, 2B, 2C, 2D, 2E, 2F, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 3A, 3B, 3C, 3D, 3E, 3F, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 4A, 4B, 4C, 4D, 4E, 4F, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 5A, 5B, 5C, 5D, 5E, 5F, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 6A, 6B, 6C, 6D, 6E, 6F, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 7A, 7B, 7C, 7D, 7E}

Hexadec.NDecode         : 0.003 secs    161     161

Estressed - Hexadec.NDecode: 0.004 secs 161     161

Hexadec.SDecode         : 0.006 secs    1       a

Estressed - Hexadec.SDecode: 0.081 secs {01, 02, 03, 04}        table: 0000000000f4ab30

ISHEX                   : 0.003 secs    123     true

Estressed - ISHEX       : 0.023 secs    {01, 02, 03, 04}        true

CLEAN                   : 0.009 secs    123     7B

Estressed - CLEAN       : 0.028 secs    {01, 02, 03, 04}        01020304        0
-- Hex dump

DUMP                    : 0.001 secs    {01, 02, 03, 04}

COLOR                   : 0.034 secs    #FFFFFFFF       0.0     0.99609375      0.99609375      0.99609375

Estressed - COLOR       : 0.058 secs    {01, 02, 03, 04}        #01020304
--- Lite ---

Lite.Code               : 0.002 secs    121 abc 31323120616263

Estressed - Lite.Code   : 0.003 secs     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ 202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E

Lite.Decode             : 0.003 secs    table: 0000000000f1a930

Estressed - Lite.Decode : 0.002 secs    {01, 02, 03, 04}

Lite.CClean : nan (not measured)

Estressed - Lite.CClean : nan (not measured)

Lite.Alert              : 0.004 secs    function: 0000000000720b80

Lite.Rigid              : 0.004 secs    4

Nothing                 : 0.000 secs    nil

Tonumber                : 0.004 secs    nil     15
```
</details>
</details>
<details>
<summary>🌙 <b>Lua Version: 5.4</b></summary><br>
<details>
<summary>---> <b>Version: 1.0.0</b></summary>

```lua
local hexadec = require("hexadec")
local hex = require("hex")

Set("NCODE", hexadec.NCode, 50000, 6, 3, " | ", "35", "1")
Set("SCODE", hexadec.SCode, 50000, "121 abc", 2, " ")
Set("NDECODE", hexadec.NDecode, 50000, 0xA1)
Set("SDECODE", hexadec.SDecode, 50000, "A1", "A1")
Set("ISHEX", hexadec.IsHex, 50000, 123, false)
Set("CLEAN", hexadec.Clean, 50000, 123, false, true)
Set("DUMP", hexadec.Dump, 5, hexadec.NCode(10, nil, nil, "200"), "C")
Set("COLOR", hexadec.Color, 50000, "#FFFFFFFF", true, true)
Set("Hex: Encode", hex.encode, 50000, "121 abc", true, true)
Set("Hex: Decode", hex.decode, 50000, "31323120616263", true, true)

-- OUTPUT (50.000 repeats, except for Hexadec.Dump, which is 5)
NCODE : 0.058 secs 6 017 | 001 | 
SCODE : 0.096 secs 121 abc 31 32 31 20 61 62 63 
NDECODE : 0.004 secs 161 161
SDECODE : 0.007 secs A1 161
ISHEX : 0.021 secs 123 true
CLEAN : 0.014 secs 123 7B
-- Hex dump
DUMP : 0.001 secs C8
COLOR : 0.032 secs #FFFFFFFF 1.0 1.0 1.0 1.0
Hex: Encode : 0.003 secs 121 abc 31323120616263
Hex: Decode : 0.003 secs 31323120616263 121 abc
```
</details>
<details>
<summary>---> <b>Version: 1.1.0</b></summary>

```lua
local hexadec = require("hexadec")(255)
local hl = require("hexadec_lite")(255)
local hex = require("hex")

Set("NCODE", hexadec.NCode, 50000, 6, 3, " | ", "35", "1")
Set("SCODE", hexadec.SCode, 50000, "121 abc", 2, " ")
Set("NDECODE", hexadec.NDecode, 50000, 0xA1)
Set("SDECODE", hexadec.SDecode, 50000, "A1")
Set("ISHEX", hexadec.IsHex, 50000, 123, false)
Set("CLEAN", hexadec.Clean, 50000, 123, false, true)
Set("DUMP", hexadec.Dump, 5, hexadec.NCode(10, nil, nil, "200"), "C")
Set("COLOR", hexadec.Color, 50000, "#FFFFFFFF", true, true)
Set("Lite: CODE", hl.Code, 50000, "121 abc")
Set("Lite: DECODE", hl.Decode, 50000, "A1")
Set("Hex: Encode", hex.encode, 50000, "121 abc", true, true)
Set("Hex: Decode", hex.decode, 50000, "31323120616263", true, true)

-- OUTPUT (50.000 repeats, except for Hexadec.Dump, which is 5)
NCODE                    : 0.057 secs   6       {017 | , 001 | }
SCODE                    : 0.097 secs   121 abc {31 , 32 , 31 , 20 , 61 , 62 , 63 }
NDECODE                  : 0.005 secs   161     161
SDECODE                  : 0.006 secs   A1      161
ISHEX                    : 0.020 secs   123     true
CLEAN                    : 0.015 secs   123     7B
-- Hex dump
DUMP                     : 0.001 secs   {C8}
COLOR                    : 0.033 secs   #FFFFFFFF       1.0     1.0     1.0     1.0
Lite: CODE               : 0.043 secs   121 abc table: 000000000072e150
Lite: DECODE             : 0.021 secs   table: 000000000072e1d0 A
Hex: Encode              : 0.003 secs   121 abc 31323120616263
Hex: Decode              : 0.003 secs   31323120616263  121 abc
```
</details>
<details>
<summary>---> <b>Version: 1.2.0</b></summary>

```lua
local hexadec = require("hexadec")(255) -- Start: The arg is the cache size for bits
local hl = require("hexadec_lite")(255, 255, true) -- Cache size, ULTRA CACHE, Manutention Mode

local a = function()
    -- Literally nothing
end
local b = function(x) -- Benchmark with the default function for decoding
    local tn = tonumber

    return tn("F", 16)
end

local table_for_tests = hexadec.NCode(10, nil, nil, "1", "2", "3", "4")

print ("Benchmark!!!")
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
Set("\nLite.CClean", hl.CClean, 50000)
Set("\nEstressed - Lite.CClean", hl.CClean, 50000, true)
Set("\nLite.Alert", hl.Alert, 50000, a)
Set("\nLite.Rigid", hl.Rigid, 50000, 4)
Set("\nNothing", a, 50000)
Set("\nTonumber", b, 50000)

-- OUTPUT (50.000 repeats, except for Hexadec.Dump, which is 5)
Benchmark!!!

Hexadec.NCode           : 0.023 secs    10      {FF}

Estressed - Hexadec.NCode: 0.053 secs   10      {0FF , FFF }

SCODE                   : 0.040 secs    123     {31, 32, 33}

Estressed - Hexadec.SCode: 0.073 secs   WXYZ    {057 , 058 , 059 , 05A }

Extra - Hexadec.SCode   : 0.522 secs     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ {20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 2A, 2B, 2C, 2D, 2E, 2F, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 3A, 3B, 3C, 3D, 3E, 3F, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 4A, 4B, 4C, 4D, 4E, 4F, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 5A, 5B, 5C, 5D, 5E, 5F, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 6A, 6B, 6C, 6D, 6E, 6F, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 7A, 7B, 7C, 7D, 7E}

Hexadec.NDecode         : 0.003 secs    161     161

Estressed - Hexadec.NDecode: 0.003 secs 161     161

Hexadec.SDecode         : 0.005 secs    1       a

Estressed - Hexadec.SDecode: 0.071 secs {01, 02, 03, 04}        table: 0000000000eedf30

ISHEX                   : 0.003 secs    123     true

Estressed - ISHEX       : 0.020 secs    {01, 02, 03, 04}        true

CLEAN                   : 0.008 secs    123     7B

Estressed - CLEAN       : 0.026 secs    {01, 02, 03, 04}        01020304        0
-- Hex dump

DUMP                    : 0.001 secs    {01, 02, 03, 04}

COLOR                   : 0.030 secs    #FFFFFFFF       0.0     0.99609375      0.99609375      0.99609375

Estressed - COLOR       : 0.044 secs    {01, 02, 03, 04}        #01020304
--- Lite ---

Lite.Code               : 0.001 secs    121 abc 31323120616263

Estressed - Lite.Code   : 0.002 secs     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ 202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E

Lite.Decode             : 0.002 secs    table: 0000000000eed930

Estressed - Lite.Decode : 0.002 secs    {01, 02, 03, 04}

Lite.CClean             : 0.013 secs    nil

Estressed - Lite.CClean : 0.013 secs    true

Lite.Alert              : 0.003 secs    function: 0000000000ec91d0

Lite.Rigid              : 0.003 secs    4

Nothing                 : 0.001 secs    nil

Tonumber                : 0.005 secs    nil     15
```
</details>
</details>
<details>
<summary>🌙 <b>Lua Version: 5.5</b></summary><br>
<details>
<summary>---> <b>Version: 1.1.0</b></summary>

```lua
local hexadec = require("hexadec")
local hl = require("hexadec_lite")

Set("NCODE", hexadec.NCode, 50000, 6, 3, " | ", "35", "1")
Set("SCODE", hexadec.SCode, 50000, "121 abc", 2, " ")
Set("NDECODE", hexadec.NDecode, 50000, 0xA1)
Set("SDECODE", hexadec.SDecode, 50000, "A1")
Set("ISHEX", hexadec.IsHex, 50000, 123, false)
Set("CLEAN", hexadec.Clean, 50000, 123, false, true)
Set("DUMP", hexadec.Dump, 5, hexadec.NCode(10, nil, nil, "200"), "C")
Set("COLOR", hexadec.Color, 50000, "#FFFFFFFF", true, true)
Set("Lite: CODE", hl.Code, 50000, "121 abc")
Set("Lite: DECODE", hl.Decode, 50000, {"41"})

-- OUTPUT (50.000 repeats, except for Hexadec.Dump, which is 5)
NCODE                    : 0.051 secs   6       {017 | , 001 | }
SCODE                    : 0.085 secs   121 abc {31 , 32 , 31 , 20 , 61 , 62 , 63 }
NDECODE                  : 0.004 secs   161     161
SDECODE                  : 0.006 secs   A1      161
ISHEX                    : 0.004 secs   123     true
CLEAN                    : 0.011 secs   123     7B
-- Hex dump
DUMP                     : 0.001 secs   {C8}
COLOR                    : 0.025 secs   #FFFFFFFF       0.0     0.99609375      0.99609375      0.99609375
Lite: CODE               : 0.025 secs   121 abc table: 0000000000eb65c0
Lite: DECODE             : 0.020 secs   table: 0000000000eb5e40 A
```
</details>
<details>
<summary>---> <b>Version: 1.2.0</b></summary>

```lua
local hexadec = require("hexadec")(255) -- Start: The arg is the cache size for bits
local hl = require("hexadec_lite")(255, 255, true) -- Cache size, ULTRA CACHE, Manutention Mode

local a = function()
    -- Literally nothing
end
local b = function(x) -- Benchmark with the default function for decoding
    local tn = tonumber

    return tn("F", 16)
end

local table_for_tests = hexadec.NCode(10, nil, nil, "1", "2", "3", "4")

print ("Benchmark!!!")
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
Set("\nLite.CClean", hl.CClean, 50000)
Set("\nEstressed - Lite.CClean", hl.CClean, 50000, true)
Set("\nLite.Alert", hl.Alert, 50000, a)
Set("\nLite.Rigid", hl.Rigid, 50000, 4)
Set("\nNothing", a, 50000)
Set("\nTonumber", b, 50000)

-- OUTPUT (50.000 repeats, except for Hexadec.Dump, which is 5)
Benchmark!!!

Hexadec.NCode           : 0.024 secs    10      {FF}

Estressed - Hexadec.NCode: 0.052 secs   10      {0FF , FFF }

SCODE                   : 0.028 secs    123     {31, 32, 33}

Estressed - Hexadec.SCode: 0.068 secs   WXYZ    {057 , 058 , 059 , 05A }

Extra - Hexadec.SCode   : 0.448 secs     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ {20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 2A, 2B, 2C, 2D, 2E, 2F, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 3A, 3B, 3C, 3D, 3E, 3F, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 4A, 4B, 4C, 4D, 4E, 4F, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 5A, 5B, 5C, 5D, 5E, 5F, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 6A, 6B, 6C, 6D, 6E, 6F, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 7A, 7B, 7C, 7D, 7E}

Hexadec.NDecode         : 0.002 secs    161     161

Estressed - Hexadec.NDecode: 0.003 secs 161     161

Hexadec.SDecode         : 0.006 secs    1       a

Estressed - Hexadec.SDecode: 0.060 secs {01, 02, 03, 04}        table: 0000000000edb300

ISHEX                   : 0.003 secs    123     true

Estressed - ISHEX       : 0.021 secs    {01, 02, 03, 04}        true

CLEAN                   : 0.010 secs    123     7B

Estressed - CLEAN       : 0.026 secs    {01, 02, 03, 04}        01020304        0
-- Hex dump

DUMP                    : 0.001 secs    {01, 02, 03, 04}

COLOR                   : 0.026 secs    #FFFFFFFF       0.0     0.99609375      0.99609375      0.99609375

Estressed - COLOR       : 0.038 secs    {01, 02, 03, 04}        #01020304
--- Lite ---

Lite.Code               : 0.001 secs    121 abc 31323120616263

Estressed - Lite.Code   : 0.002 secs     !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ 202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E

Lite.Decode             : 0.002 secs    table: 0000000000edc7a0

Estressed - Lite.Decode : 0.002 secs    {01, 02, 03, 04}

Lite.CClean             : 0.010 secs    nil

Estressed - Lite.CClean : 0.010 secs    true

Lite.Alert              : 0.003 secs    function: 0000000000ed5360

Lite.Rigid              : 0.003 secs    4

Nothing                 : 0.000 secs    nil

Tonumber                : 0.004 secs    nil     15
```
</details>
</details>

## Ranking of the functions speed in each Lua version (otimized mode):
**Function Hexadec.NCode**:<br>
1st - JIT (8 ms);<br>
2nd - Lua 5.4 (23 ms);<br>
3rd - Lua 5.5 (24 ms).

**Function Hexadec.SCode**:<br>
1st - JIT (7 ms);<br>
2nd - Lua 5.5 (28 ms);<br>
3rd - Lua 5.4 (40 ms).

**Function Hexadec.NDecode**:<br>
1st - JIT (1 ms);<br>
2nd - Lua 5.5 (2 ms);<br>
3rd - Lua 5.4 and Lua 5.3 (3 ms).

**Function Hexadec.SDecode**:<br>
1st - JIT (2 ms);<br>
2nd - Lua 5.4 (5 ms);<br>
3rd - Lua 5.5 and Lua 5.3 (6 ms).

**Function Hexadec.IsHex**:<br>
1st - JIT (2 ms);<br>
2nd - Lua 5.5, Lua 5.4 and Lua 5.3 (3 ms).

**Function Hexadec.Clean**:<br>
1st - JIT (3 ms);<br>
2nd - Lua 5.4 (8 ms);<br>
3rd - Lua 5.3 (9 ms).

**Function Hexadec.Dump**:<br>
1st - JIT (0 ms);<br>
2nd - Lua 5.5, Lua 5.4 and Lua 5.3 (1 ms).

**Function Hexadec.Color**:<br>
1st - JIT (11 ms);<br>
2nd - Lua 5.5 (26 ms);<br>
3rd - Lua 5.4 (30 ms).

**Function Lite.Code**:<br>
1st - JIT (1 ms);<br>
2nd - Lua 5.5 and Lua 5.4 (2 ms);<br>
3rd - Lua 5.3 (3 ms).

**Function Lite.Decode**:<br>
1st - JIT (1 ms);<br>
2nd - Lua 5.5 and Lua 5.4 (2 ms);<br>
3rd - Lua 5.3 (3 ms).

**Function Lite.CClean**:<br>
1st - JIT (8 ms);<br>
2nd - Lua 5.5 (10 ms);<br>
3rd - Lua 5.4 (13 ms).

**Function Lite.Alert**:<br>
1st - JIT (0 ms);<br>
2nd - Lua 5.5 and Lua 5.4 (3 ms);<br>
3rd - Lua 5.3 (4 ms).

**Function Lite.Rigid**:<br>
1st - JIT (0 ms);<br>
2nd - Lua 5.5 and Lua 5.4 (3 ms);<br>
3rd - Lua 5.3 (4 ms).

## Better Lua versions:
1st - JIT (unbeatable);<br>
2nd - Lua 5.5;<br>
3rd - Lua 5.4;<br>
4th - Lua 5.3.

-------------------------------------------------------------------------------------------------------- BENCHMARK END
</details>

<details>
<summary>🔤 <b>Documentation</b></summary>

## Here you can see how to use the functions inside of Hexadec!<br>
Select the version you want to browse:

<details>
<summary><b>Normal version</b></summary>

Normal version can be represented with:
```lua
require("hexadec")
```
<details>

<summary><b>v1.0.0-1</b></summary>

**FUNCTION: Setup(...):**<br>
Description: The setup function mentioned in the Starting section.

Return:<br>
*No arguments - SECRET MESSAGE*;<br>
*At least one argument - Hexadec module*.

Args:<br>
*- 1st argument (or cache size)*: Number that defines your Hexadec.HEX size.

Example:<br>
```lua
local Hexadec = require("hexadec")
print (Hexadec) -- function: 0x... -- Setup function
print (Hexadec()) -- SECRET MESSAGE -- No arguments
print (Hexadec(255)) -- table: 0x... (Hexadec Module) - With cache size
```
**FUNCTION: Hexadec.NCode(base: number, min: number, sep: string, ...):**<br>
Description: A function that uses numeric strings (in base) passed in vararg that can have a minimum size of min (filled with 0) and a separator sep to create a hexadec type.
Disclaimer: It can't convert negative numbers, yet.

Return:<br>
*- Hexadec type (table) with string values*.

Args:<br>
*- Base*: Numeric base of the numeric strings (default is 10; minimum is 2 and maximum is 36);<br>
*- Min*: Minimum size of each hexadecimal, filled with 0;<br>
*- Sep*: Separates the hexadecimal digits for table.concat on the hexadec type return;<br>
*- Variadic (...)*: Numeric strings that will be converted.

Tips:<br>
*- If base is 16, then it will do a direct conversion*;<br>
*- If there's only one variadic argument, then it will activate a slightly faster version*;<br>
*- If the min is nil or min == 0 and sep == "", then it will activate a more efficient string pattern*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.NCode(16, nil, nil, "255") -- Will be extremely optimized
print(hexa) -- {255, 255}
```

**FUNCTION: Hexadec.SCode(str: string, min: number, sep: string):**<br>
Description: A function that uses a single string and converts every UTF8 and ASCII character in a hexadec type that can have a minimum size of min (each filled with 0) and a separator sep to create a hexadec type.
Disclaimer: Shouldn't be confused with Hexadec.NCode, even though they almost make the same thing.

Return:<br>
*- Hexadec type (table) with string values*.

Args:<br>
*- Str*: Can only be a string;<br>
*- Min*: Minimum size of each hexadecimal, filled with 0;<br>
*- Sep*: Separates the hexadecimal digits for table.concat on the hexadec type return.

Tips:<br>
*- Every UTF-8 character on str will be considered, even blank spaces and null (ASCII 0)*;<br>
*- If the min is nil or min == 0 and sep == "", then it will activate a more efficient string pattern*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.SCode("255", nil, nil) -- Will be optimized
print(hexa) -- {32, 35, 35}
```

**FUNCTION (METHOD): Hexadec.NDecode(self: hexadec type | number | string, secure: boolean):**<br>
Description: A function that decodes a hexadec type, number or a string in hexadecimal to a table, with a optional secure mode.<br>

Return:<br>
*Self -> number - Number*;<br>
*Self -> string - Number*;<br>
*Self -> hexadec type - Table with number values*.

Args:<br>
*- Self*: Can be a hexadec type, a string or a number;<br>
*- Secure*: Uses Hexadec.IsHex before trying the conversion.

Tips:<br>
*- Numbers and strings are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
*- Secure makes the code slightly slower, but may worth it*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.NDecode("FF", false) -- Will be optimized
print(hexa) -- 255
```
**FUNCTION (METHOD): Hexadec.SDecode(self: hexadec type | string, caps: boolean, secure: boolean):**<br>
Description: A function that decodes a hexadec type or a string in hexadecimal to a table or number, with a optional secure mode.

Return:<br>
*Self -> string - Number*;<br>
*Self -> hexadec type - Table*.

Args:<br>
*- Self*: Can be a hexadec type or a string;<br>
*- Caps*: Defines if the self uses uppercase or lowercase letters for the conversion;<br>
*- Secure*: Uses Hexadec.IsHex before trying the conversion.

Tips:<br>
*- Strings are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
*- Caps == true uses uppercase and not Caps uses lowercase (only works with self -> hexadec type)*;<br>
*- Secure makes the code slightly slower, but may worth it*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.SDecode("F")
print(hexa) -- 15
```
**FUNCTION (METHOD): Hexadec.IsHex(self: hexadec type | string | number, spaces: boolean):**<br>
Description: A function that checks if self is a valid hexadecimal or not (can ignore spaces).

Return:<br>
*Self -> number - True*;<br>
*Self -> string - Boolean*;<br>
*Self -> hexadec type - Boolean*.

Args:<br>
*- Self*: Can be a hexadec type, a string or a number;<br>
*- Spaces*: Activates a mode that permits spaces in the self argument.

Tips:<br>
*- Every number is a hexadecimal, including integers and floats*;<br>
*- Spaces makes every %s character be included as valid*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.IsHex("FF", false) -- Will be optimized
print(hexa) -- true
```
**FUNCTION (METHOD): Hexadec.Clean(self: hexadec type | string | number, spaces: boolean, str: boolean):**<br>
Description: A function that cleans self, removing every non-hexadecimal character, with a option to keep spaces or not.

Return:<br>
*Self -> string - String*;<br>
*Self -> number - String*;<br>
*<Self -> hexadec type:>*<br>
*Str == true - String*;<br>
*Str ~= true - Hexadec type*.

Args:<br>
*- Self*: Can be a hexadec type, a string or a number;<br>
*- Spaces*: Defines if the self will keep spaces or not;<br>
*- Str*: Concatenates the hexadec type before cleaning.

Tips:<br>
*- Strings and numbers are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
*- If self -> number, the return will be a hexadecimal string with its value*;<br>
*- Spaces == true keeps spaces and not spaces removes them*;<br>
*- Str can make the code slightly slower, but may worth it*;<br>
*- Str is only used when self -> hexadec type, so you generally can avoid it*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.Clean("F F", false)
print(hexa) -- FF
```
**FUNCTION (METHOD): Hexadec.Dump(self: hexadec type, mode: string, inter: table | number, line: number):**<br>
Description: A function that generates a hex dump in the terminal.

Return: *nil*.

Args:<br>
*- Self*: Must be a hexadec type;<br>
*- Mode*: Defines the hex dump mode:<br>
*> "C" or "-C" don't require inter because hex dumps everything*;<br>
*> "n" or "-n" require inter -> table ({start, end})*;<br>
*> "s" or "-s" require inter -> number (ignore from start)*;<br>
*- Inter*: Defines the interval of the hex dump;<br>
*- Line:* Defines the max characteres output for every line in the hex dump (default is 16).

Tips:<br>
*- Start and end in inter should be numbers*;<br>
*- If line is way too small, you can have some problems (Ctrl + C!!!)*;<br>
*- If mode is invalid, a error call will occur*;<br>
*- The line doesn't include the line notation size*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.Dump(hexadec.NCode(10, nil, nil, "255"), "C", nil, 16)
00000001: FF | -- Output
print(hexa) -- nil
```
**FUNCTION (METHOD): Hexadec.Color(self: hexadec type | string, alpha: boolean, float: boolean, bits: number):**<br>
Description: A function that creates a RGB or RGBA using a hexadec type or a string.

Return:<br>
*Self -> hexadec type - String*;<br>
*<Self -> string:>*<br>
*Float == true - float, float, float, floatr*;<br>
*Float ~= true - number, number, number, number*.

Args:<br>
*- Self*: Can be a hexadec type or a string;<br>
*- Alpha*: Defines if the self have a alpha channel;<br>
*- Float*: Defines if the return should be in 0-1 or brute RGB(A);<br>
*- Bits:* Defines each color channel (default is 255, RRGGBBAA).

Tips:<br>
*- Strings are converted with better performance and doesn't require "#" in its start*;<br>
*- Alpha will always be maxed out if deactivated*;<br>
*- Less bits equals to more speed (always use powers of 16!)*;<br>
*- Alpha and float can make the code slightly slower, but may worth it*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexaint = Hexadec.Color("FFFFFFFF", true, false, 255) -- Better than hexadec type
print(hexaint) -- 255

local hexafloat = Hexadec.Color("#FFFFFFFF", true, true, 255) -- Also works
print(hexafloat) -- 1.0
```
</details>
<details>
<summary><b>v1.1.0-1</b></summary>

**FUNCTION (METHOD): Hexadec.NDecode(self: hexadec type | number | string, str: boolean, secure: boolean):**<br>
Description: A function that decodes a hexadec type, number or a string in hexadecimal to a table or string, with a optional secure mode.<br>

Return:<br>
*Self -> number - Number*;<br>
*Self -> string - Number*;<br>
*<Self -> hexadec type>*<br>
*Str ~= true - Table with number values*;<br>
*Str == true - String*.

Args:<br>
*- Self*: Can be a hexadec type, a string or a number;<br>
*- Str*: Defines if the return is a table or a string;<br>
*- Secure*: Uses Hexadec.IsHex before trying the conversion.

Tips:<br>
*- Numbers and strings are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
*- Secure makes the code slightly slower, but may worth it*;<br>
*- Str makes the code slightly slower, but may worth it*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.NDecode("FF", false, false) -- Will be optimized
print(hexa) -- 255
```
**FUNCTION (METHOD): Hexadec.IsHex(self: hexadec type | string | number):**<br>
Description: A function that checks if self is a valid hexadecimal or not (can ignore spaces).

Return:<br>
*Self -> number - True*;<br>
*Self -> string - Boolean*;<br>
*Self -> hexadec type - Boolean*.

Args:<br>
*- Self*: Can be a hexadec type, a string or a number.

Tips:<br>
*- Every number is a hexadecimal, including integers and floats*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.IsHex("FF") -- Will be optimized
print(hexa) -- true
```
**FUNCTION (METHOD): Hexadec.Color(self: hexadec type | string, alpha: boolean, float: boolean, bits: number):**<br>
Description: A function that creates a RGB or RGBA using a hexadec type or a string.

Return:<br>
*Self -> hexadec type - String*;<br>
*<Self -> string:>*<br>
*Float == true - float, float, float, float*;<br>
*Float ~= true - number, number, number, number*.

Args:<br>
*- Self*: Can be a hexadec type or a string;<br>
*- Alpha*: Defines if the self have a alpha channel;<br>
*- Float*: Defines if the return should be in 0-1 or brute RGB(A);<br>
*- Bits:* Defines each color channel (default is 256, RRGGBBAA).

Tips:<br>
*- Strings and hexadec types can't start with '#'*;<br>
*- Strings are generally way less expensive than hexadec type*;<br>
*- Alpha will always be maxed out if deactivated*;<br>
*- Less bits equals to more speed (always use powers of 16!)*;<br>
*- Alpha and float can make the code slightly slower, but may worth it*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexaint = Hexadec.Color("FFFFFFFF", true, false, 255) -- Better than hexadec type
print(hexaint) -- 255

local hexafloat = Hexadec.Color("#FFFFFFFF", true, true, 255) -- Doesn't work anymore for extra otimization
print(hexafloat) -- 1.0
```
</details>

<details>
<summary><b>v1.2.0-1</b></summary>

**FUNCTION (METHOD): Hexadec.SDecode(self: hexadec type | string, caps: boolean, secure: boolean):**<br>
Description: A function that decodes a hexadec type or a string in hexadecimal to a table or string with alphabet letters (1-26) and others, with a optional secure mode.

Return:<br>
*Self -> string - String*;<br>
*Self -> hexadec type - Table*.

Args:<br>
*- Self*: Can be a hexadec type or a string;<br>
*- Caps*: Defines if the self uses uppercase or lowercase letters for the conversion;<br>
*- Secure*: Uses Hexadec.IsHex before trying the conversion.

Tips:<br>
*- Strings are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
*- Caps == true uses uppercase and not Caps uses lowercase (only works with self -> hexadec type)*;<br>
*- Secure makes the code slightly slower, but may worth it*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.SDecode("1", true)
print(hexa) -- A
```
</details>
<details>
<summary><b>v1.2.1-1</b></summary>

**FUNCTION (METHOD): Hexadec.SDecode(self: hexadec type | string | number, caps: boolean, secure: boolean):**<br>
Description: A function that decodes a hexadec type, a string or a number in hexadecimal to a table or string with the corresponding alphabet letters, with a optional secure mode.

Return:<br>
*Self -> string - String*;<br>
*Self -> number - String*;<br>
*Self -> hexadec type - Table*.

Args:<br>
*- Self*: Can be a hexadec type, a string or a number;<br>
*- Caps*: Defines if the self will return uppercase or lowercase letters for the conversion;<br>
*- Secure*: Uses Hexadec.IsHex before trying the conversion.

Tips:<br>
*- Strings and numbers (even better) are converted with better performance (prefer using strings or numbers than hexadec types with only 1 index)*;<br>
*- Caps == true uses uppercase and not Caps uses lowercase (only works with self -> hexadec type)*;<br>
*- Secure makes the code slightly slower, but may worth it*.

Example:<br>
```lua
local Hexadec = require("hexadec")(255)
local hexa = Hexadec.SDecode(1, true) -- Will be otimized
print(hexa) -- A
```
</details>
</details>
<details>
<summary><b>Lite version</b></summary>

Lite version can be represented with:
```lua
require("hexadec_lite")
```
<details>
<summary><b>v1.1.0-1</b></summary>

**FUNCTION: Setup(...):**<br>
Description: The setup function mentioned in the Starting section.<br>
OBS: Only available on Lua 5.5!

Return:<br>
*No arguments - SECRET MESSAGE*;<br>
*At least one argument - Lite Hexadec module*.

Args:<br>
*- 1st argument (or cache size)*: Number that defines your Hexadec.HEX size.

Example:<br>
```lua
local Lite = require("hexadec_lite")
print (Lite) -- function: 0x... -- Setup function
print (Lite()) -- SECRET MESSAGE -- No arguments
print (Lite(255)) -- table: 0x... (Lite Hexadec Module) -- With cache size
```
**FUNCTION: Lite.Code(str: string):**<br>
Description: Lite counterpart to Hexadec.SCode, inspired by encode, from "hex" (by <b>mah0x211</b>).

Return:<br>
*- Table with string values*.

Args:<br>
*- Str*: Can only be a string.

Tips:<br>
*- This function is way faster than Hexadec.SCode, but return a normal table instead of a hexadec type*;<br>
*- Every UTF-8 character on str will be considered, even blank spaces and null (ASCII 0)*.

Example:<br>
```lua
local Lite = require("hexadec_lite")(255)
local hexa = Lite.Code("123")
print(hexa) -- table: 0x...
print (hexa[1]) -- 31
```
**FUNCTION: Lite.Decode(tab: table):**<br>
Description: Lite counterpart to Hexadec.NDecode, inspired by decode, from "hex" (by <b>mah0x211</b>).<br>
OBS: Only works on Lua 5.5 because of a bug (patched in v1.1.1-1).

Return:<br>
*- String*.

Args:<br>
*- Tab*: Table with string values.

Tips:<br>
*- The string values are interpreted as ASCII, so the max is 255*.

Example:<br>
```lua
local Lite = require("hexadec_lite")(255)
local hexa = Lite.Decode({"31", "32", "33"})
print(hexa) -- 123
```
</details>
<details>
<summary><b>v1.2.0-1 (UNDER CONSTRUCTION...)</b></summary>

**FUNCTION: Setup(...):**<br>
Description: The setup function mentioned in the Starting section.<br>
OBS: Only available on Lua 5.5!

Return:<br>
*No arguments - SECRET MESSAGE*;<br>
*At least one argument - Lite Hexadec module*.

Args:<br>
*- 1st argument (or cache size)*: Number that defines your Hexadec.HEX size;<br>
*- 2nd argument (or Ultra Cache size)*: Number that defines your Ultra Cache size (and also enables it);<br>
*- 3rd argument (or Manutention Mode)*: Boolean that activates MM.

Example:<br>
```lua
local Lite = require("hexadec_lite")
print (Lite) -- function: 0x... -- Setup function
print (Lite()) -- SECRET MESSAGE -- No arguments
print (Lite(255)) -- table: 0x... (Lite Hexadec Module) -- With cache size
print (Lite(255, 255, true)) -- table: 0x... (Hexadec Module) -- With cache size | Ultra Cache size | Manutention Mode
```
**FUNCTION: Lite.CClean(memory: boolean):**<br>
Description: Cleans the Ultra Cache.<br>
OBS: Only activated if Ultra Cache is enabled.

Return: *nil*.

Args:<br>
*- Memory*: Activates a mode that doesn't need internal realloc (ONLY IN LuaJIT VERSION).

Tips:<br>
*- You may think this is not useful at all... you are right, but it has a better performance than a normal pairs*;<br>
*- Memory uses table.clear from LuaJIT to prevent new realloc calls*.

Example:<br>
```lua
local Lite = require("hexadec_lite")(255)
local hexa = Lite.CClean()
print(hexa) -- nil

local func = function(x)
    for k in pairs(x) do
        x[k] = nil
    end
end
Set("PAIRS", func, 50000, hl.UCH)
Set("CClean", hl.CClean, 50000, hl.UCH)

-- Output:

nil
PAIRS                    : 0.013 secs   table: 0000000000e749a0
CClean                   : 0.012 secs   table: 0000000000e749a0

-- Using LuaJIT with memory:

PAIRS                    : 0.009 secs   table: 0x015c7bf9d720
CClean                   : 0.007 secs   table: 0x015c7bf9d720
```
**FUNCTION: Lite.Alert(func: function):**<br>
Description: Calls a function every time Ultra Cache gets a new index (__newindex).<br>
OBS: Only activated if Manutention Mode is enabled.

Return: *nil*.

Args:<br>
*- Func*: Function that will be called as func(index, value).

Tips:<br>
*- __newindex metamethod is very expensive, so you might prefer this as a debug feature*.

Example:<br>
```lua
local Lite = require("hexadec_lite")(255)
local hexa = Lite.Alert(function(k, v)
    print (k, v)
end)
print(hexa) -- nil

local tab = Lite.Code("123")
123     313233 -- Alert
313233  123 -- Alert
print(tab) -- table: 0x...
```
**FUNCTION: Lite.Rigid(num: number | string):**<br>
Description: Defines a limit to the Ultra Cache, preventing memory overflow.<br>
OBS: Only activated if Manutention Mode is enabled.

Return: *nil*.

Args:<br>
*- Num*: Can be a number or a string.

Tips:<br>
*- If num is a number, the new limit will be num. But, if num == "nil" (string) or none of these, then the limit will be deactivated or the limit will be the Ultra Cache initial size, respectively*.

Example:<br>
```lua
local Lite = require("hexadec_lite")(255)
local hexa = Lite.Rigid(1)
print(hexa) -- nil

local tab = Lite.Code("123")
print(tab) -- table: 0x...

for k, v in pairs(Lite.UCH) do
  print (k, v) -- Will print only one value, randomized by LRU
end
```
</details>
</details>

-------------------------------------------------------------------------------------------------------- DOCUMENTATION END
</details>

<details>
<summary>📜 <b>Change log</b></summary>

## Here you can see the changes that every update made!
The functions documentation is linked to the Change Log, so you only see the functions that were changed in this section on the newer versions.
Changes:

<details>
<summary>⌚ <b>v1.2.1-1</b> - Patch <b>(NEWER RELEASE)</b></summary>

1 - Fixed hexadec54.lua (it's a somewhat specific bug);<br>
2 - Upgraded the Benchmark.lua (it was necessary!);<br>
3 - Fixed minor bugs, like the "attempt to concatenate a nil value (local 'sep')";<br>
4 - Added a new feature for Hexadec.SDecode for the self arg, now with number support.
</details>
<details>
<summary><b>v1.2.0-1 - Ultra compatibility</b></summary>

1 - Ultra Cache otimization for Lite version, featuring Randomized LRU and velocity compared to "Hex" Lua module;<br>
2 - Added a Manutention Mode for Lite version with new functions:<br>
*- Alert -> Can call a function every time the Ultra Cache is used;*<br>
*- Rigid -> Can define a limit for Ultra Cache, preventing RAM overflow;*<br>
*- They are **deactivated by default**.*<br>
3 - Added new otimizations and centralized modules for the main Lua versions:<br>
*- Lua 5.5 (already in last update, now with extra performance);*<br>
*- Lua 5.4;*<br>
*- Lua 5.3;*<br>
*- LuaJIT;*<br>
*- This excludes Lua 5.2 and pure Lua 5.1.*<br>
4 - Added a new use for Hexadec.SDecode, now able to decode numeric strings directly to ASCII + 64 or 96 (1-26 will show the alphabet).
</details>
<details>
<summary><b>v1.1.1-1</b> - Patch</summary>

1 - Corrected Hexadec_lite.Decode;<br>
2 - Brings a better general GitHub folder, with a corrected "Benchmark.lua"
</details>
<details>
<summary>⚡ <b>v1.1.0-2</b> - Revision</summary>

*- Corrected 1.1.0 LuaRocks error when trying to download the module.*
</details>
<details>
<summary><b>v1.1.0-1 - Lite introduction</b></summary>

1 - New Hexadec lite mode (for those who wants something like "hex" without using a C compiler);<br>
2 - Color now have dynamic width color channels (you don't need only 256 bits anymore);<br>
3 - New otimization and file for Lua 5.5 (automatic detection on LuaRocks), featuring table.create and constants (massive increase);<br>
4 - Hexadec.NCode str argument was added;<br>
5 - Hexadec.IsHex spaces argument was removed;<br>
6 - Changed Hexadec.Color bits default from 255 to 256;<br>
7 - The Ax is being discontinued because it's useless...;<br>
8 - New Setup tutorial for basic help.
</details>
<details>
<summary>⚡ <b>v1.0.0-2</b> - Revision</summary>

*- Corrected 1.1.0 LuaRocks error when trying to download the module.*
</details>
<details>
<summary><b>v1.0.0-1 - Release</b></summary>

1 - Features:<br>
*-> Setup;<br>*
*-> Hexadec.Metatable;<br>*
*-> Hexadec.HEX;<br>*
*-> Hexadec.NCode;<br>*
*-> Hexadec.SCode;<br>*
*-> Hexadec.NDecode;<br>*
*-> Hexadec.SDecode;<br>*
*-> Hexadec.IsHex;<br>*
*-> Hexadec.Clean;<br>*
*-> Hexadec.Dump;<br>*
*-> Hexadec.Color.*
</details>

-------------------------------------------------------------------------------------------------------- CHANGE LOG END
</details>

<details>
<summary>📄 <b>Extras</b></summary>

## Here you can see other features and extras!

<details>
<summary><b>Hexadec.HEX</b></summary>

Description: **Hexadec.HEX is a cache** made with hexadecimal numbers for faster conversion.

Size: Table (string indexes) with Setup 1st argument size.

Tips:<br>
*- This cache can have external uses, so feel free!*.

Example:<br>
```lua
local size = 255
local Hexadec = require("hexadec")(size)
print (#Hexadec.HEX == size) -- true
```
</details>

-------------------------------------------------------------------------------------------------------- EXTRAS END
</details>
More coming soon... (FAQ for discussion questions or Mechanics (like cache)? Also, a better documentation organization, because y'all deserve it :D)
