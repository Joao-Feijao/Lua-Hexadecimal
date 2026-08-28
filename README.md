# Introduction for Lua Hexadecimal
Hi, I made a module in Lua that can manipulate hexadecimal!
It can convert numbers of a n-base (up to 36) and strings to hexadec (special type representing hexadecimal in a table) that can be converted
back or become RGB (RGBA) colors, hexdumped and be cleaned, with a secure mode for the decode function.
Also, I recommend using 'Color' and 'Hex' with it!

<details>
<summary>🔍 <b>Starting</b></summary>
You can download via LuaRocks through the [repository website](https://luarocks.org/modules/joao-feijao/hexadec) or you can use the following prompt if you have LuaRocks installed:
````bash
  $ luarocks install hexadec
````

Now, the next step is loading the package:
````lua
  local hexset = require("hexadec") -- Normal version
  local hexsetlite = require("hexadec_lite") -- Lite version, available on v1.1.0+

  print(type(hexset), type(hexsetlite)) -- function  function -- They both return a setup function
  hexset() -- Will print a tutorial and return a secret message because it doesn't have an argument or the argument isn't a number
  local hexadec = hexset(10) -- Will return the Hexadec module
  
  print(hexadec.NCode(10, nil, nil, "255")) -- {FF}
````
</details>

<details>
  <summary>⚡<b>Benchmarks</b></summary>
  Here you can see Hexadec compared to other LuaRocks modules!
  Specs:<br>
  - R7 5700G;<br>
  - 16GB DDR4;<br>
  - Made on VSCode.

  Benckmark function:<br>
  ````lua
    local function Set(name, func, reps, ...)
    local ini= os.clock()
    for _ = 1, reps do
        func(...)
    end
    local en = os.clock()
    print(string.format("%-25s: %.3f secs", name, en - ini), ..., func(...))
  end
  ````
  <details>
    <summary><b>Version: 1.0.0</b></summary><br>
    
    ````lua
    require("hex")
    require("hexadec")
    
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
    NCODE                    : 0.058 secs   6       017 | 001 | 
    SCODE                    : 0.096 secs   121 abc 31 32 31 20 61 62 63 
    NDECODE                  : 0.004 secs   161     161
    SDECODE                  : 0.007 secs   A1      161
    ISHEX                    : 0.021 secs   123     true
    CLEAN                    : 0.014 secs   123     7B
    -- Hexdump
    DUMP                     : 0.001 secs   C8
    COLOR                    : 0.032 secs   #FFFFFFFF       1.0     1.0     1.0     1.0
    Hex: Encode              : 0.003 secs   121 abc 31323120616263
    Hex: Decode              : 0.003 secs   31323120616263  121 abc
    ````
  </details>
  <details>
    <summary><b>Version: 1.1.0</b></summary><br>
    
    ````lua
    require("hex")
    require("hexadec")
    
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
    NCODE                    : 0.058 secs   6       017 | 001 | 
    SCODE                    : 0.096 secs   121 abc 31 32 31 20 61 62 63 
    NDECODE                  : 0.004 secs   161     161
    SDECODE                  : 0.007 secs   A1      161
    ISHEX                    : 0.021 secs   123     true
    CLEAN                    : 0.014 secs   123     7B
    -- Hexdump
    DUMP                     : 0.001 secs   C8
    COLOR                    : 0.032 secs   #FFFFFFFF       1.0     1.0     1.0     1.0
    Hex: Encode              : 0.003 secs   121 abc 31323120616263
    Hex: Decode              : 0.003 secs   31323120616263  121 abc
    ````
  </details>
</details>

<details>
<summary>🔤 <b>Documentation</b></summary>
**FUNCTION: Setup(...):**
  Description: The setup function mentioned in the Starting section.

  Return:<br>
  *- Hexadec Module or SECRET MESSAGE*.

  Args:<br>
  *- 1st argument (or cache size)*: Number that defines your Hexadec.HEX size.

  Example:<br>
   ````lua
   local Hexadec = require("hexadec")
   print (Hexadec) -- function: 0x... -- Setup function
   print (Hexadec()) -- SECRET MESSAGE -- No arguments
   print (Hexadec(255)) -- table: 0x... (Hexadec Module) - With cache size
  ````
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
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.NCode(16, nil, nil, "255") -- Will be extremely optimized
   print(hexa) -- {255, 255}
   ````

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
  *- Every UTF8 character on str will be considered, even blank spaces*;<br>
  *- If the min is nil or min == 0 and sep == "", then it will activate a more efficient string pattern*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.SCode("255", nil, nil) -- Will be optimized
   print(hexa) -- {32, 35, 35}
  ````

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
  *- Str*: Defines if the return is a table or a string (ONLY AVAILABLE ON v1.1.0+);<br>
  *- Secure*: Uses Hexadec.IsHex before trying the conversion.

  Tips:<br>
  *- Numbers and strings are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
  *- Secure makes the code slightly slower, but may worth it*;<br>
  *- Str makes the code slightly slower, but may worth it*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.NDecode("FF", false, false) -- Will be optimized
   print(hexa) -- 255
   ````
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
  *- Caps == true uses lowercase and not Caps uses uppercase*;<br>
  *- Secure makes the code slightly slower, but may worth it*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.SDecode({1, 1, 1}, false, false)
   print(hexa[1]) -- A
  ````
**FUNCTION (METHOD): Hexadec.IsHex(self: hexadec type | string | number, spaces: boolean):**<br>
  Description: A function that checks if self is a valid hexadecimal or not (can ignore spaces).
  
  Return:<br>
  *Self -> number - True*;<br>
  *Self -> string - Boolean*;<br>
  *Self -> hexadec type - Boolean*.

  Args:<br>
  *- Self*: Can be a hexadec type, a string or a number;<br>
  *- Spaces*: Activates a mode that permits spaces in the self argument (ONLY AVAILABLE ON v1.0.0).

  Tips:<br>
  *- Every number is a hexadecimal, including integers and floats*;<br>
  *- Spaces makes every %s character be included as valid*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.IsHex("FF", false) -- Will be optimized
   print(hexa) -- true
  ````
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
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.Clean("F F", false)
   print(hexa) -- FF
  ````
**FUNCTION (METHOD): Hexadec.Dump(self: hexadec type, mode: string, inter: table | number, line: number):**<br>
  Description: A function that generates a hexdump in the terminal.
  
  Return: *nil*

  Args:<br>
  *- Self*: Must be a hexadec type;<br>
  *- Mode*: Defines the hexdump mode:<br>
    *> "C" or "-C" don't require inter because hexdumps everything*;<br>
    *> "n" or "-n" require inter -> table ({start, end})*;<br>
    *> "s" or "-s" require inter -> number (ignore from start)*;<br>
  *- Inter*: Defines the interval of the hexdump;<br>
  *- Line:* Defines the max characteres output for every line in the hexdump (default is 16).

  Tips:<br>
  *- Start and end in inter should be numbers*;<br>
  *- If line is way too small, you can have some problems (Ctrl + C!!!)*;<br>
  *- If mode is invalid, a error call will occur*;<br>
  *- The line doesn't include the line notation size*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.Dump(hexadec.NCode(10, nil, nil, "255"), "C", nil, 16)
   00000001: FF |  -- Output
   print(hexa) -- nil
  ````
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
  *- If self -> number, the return will be a hexadecimal string with its value*;<br>
  *- Spaces == true keeps spaces and not spaces removes them*;<br>
  *- Str can make the code slightly slower, but may worth it*;<br>
  *- Str is only used when self -> hexadec type, so you generally can avoid it*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexaint = Hexadec.Color("FFFFFFFF", true, false, 255) -- Will be optimized
   print(hexaint) -- 255

   local hexafloat = Hexadec.Color("FFFFFFFF", true, true, 255) -- Will be optimized
   print(hexafloat) -- 1.0
  ````
</details>
More coming soon...
