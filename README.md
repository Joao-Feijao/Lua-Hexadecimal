# Introduction for Lua Hexadecimal
Hi, I made a module in Lua that can manipulate hexadecimal!
It can convert numbers of a n-base (up to 36) and strings to hexadec (special type representing hexadecimal in a table) that can be converted
back or become RGB (RGBA) colors, hexdumped and be cleaned, with a secure mode for the decode function.
Also, I recommend using 'Color' and 'Hex' with it!

# Starting
You can download via LuaRocks through the [repository website](https://luarocks.org/modules/joao-feijao/hexadec) or you can use the following prompt if you have LuaRocks installed:
````bash
  $ luarocks install hexadec
````

Now, the next step is loading the package:
````lua
  local hexset = require("hexadec") -- Normal version
  local hexsetlite = require("hexadec_lite") -- Lite version, available on v1.1.0-1+

  print(type(hexset), type(hexsetlite)) -- function  function -- They both return a setup function
  hexset() -- Will print a tutorial and return a secret message because it doesn't have an argument or the argument isn't a number
  local hexadec = hexset(10)
  
  print(hexadec.NCode(10, nil, nil, "255")) -- {FF}
````



# Functions documentation
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

**FUNCTION: Hexadec.NDecode(self: hexadec type | number | string, str: boolean, secure: boolean):**<br>
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
**FUNCTION: Hexadec.SDecode(self: hexadec type | string, caps: boolean, secure: boolean):**<br>
  Description: A function that decodes a hexadec type or a string in hexadecimal to a table or number, with a optional secure mode.
  
  Return:<br>
  *Self -> string - Number*;<br>
  *Self -> hexadec type - String*.

  Args:<br>
  *- Self*: Can be a hexadec type, a string or a number;<br>
  *- Caps*: Defines if the self uses uppercase or lowercase letters for the conversion;<br>
  *- Secure*: Uses Hexadec.IsHex before trying the conversion.

  Tips:<br>
  *- Strings are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
  *- Caps == true uses lowercase and not Caps uses uppercase*;<br>
  *- Secure makes the code slightly slower, but may worth it*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.SDecode("FF", false, false) -- Will be optimized
   print(hexa) -- 255
  ````
###UNDER CONSTRUCTION!!!
**FUNCTION: Hexadec.IsHex(self: hexadec type | string | number, spaces: boolean):**<br>
  Description: A function that decodes a hexadec type or a string in hexadecimal to a table or number, with a optional secure mode.
  
  Return:<br>
  *Self -> string - Number*;<br>
  *Self -> hexadec type - String*<br>;
  *Self -> hexadec type - Boolean*.

  Args:<br>
  *- Self*: Can be a hexadec type, a string or a number;<br>
  *- Spaces*: Defines if the self uses uppercase or lowercase letters for the conversion.

  Tips:<br>
  *- Strings are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
  *- Caps == true uses lowercase and not Caps uses uppercase*;<br>
  *- Secure makes the code slightly slower, but may worth it*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.SDecode("FF", false, false) -- Will be optimized
   print(hexa) -- 255
  ````
**FUNCTION: Hexadec.SDecode(self: hexadec type | string, caps: boolean, secure: boolean):**<br>
  Description: A function that decodes a hexadec type or a string in hexadecimal to a table or number, with a optional secure mode.
  
  Return:<br>
  *Self -> string - Number*;<br>
  *Self -> hexadec type - String*.

  Args:<br>
  *- Self*: Can be a hexadec type, a string or a number;<br>
  *- Caps*: Defines if the self uses uppercase or lowercase letters for the conversion;<br>
  *- Secure*: Uses Hexadec.IsHex before trying the conversion.

  Tips:<br>
  *- Strings are converted with better performance (prefer using strings than hexadec types with only 1 index)*;<br>
  *- Caps == true uses lowercase and not Caps uses uppercase*;<br>
  *- Secure makes the code slightly slower, but may worth it*.
  
  Example:<br>
   ````lua
   local Hexadec = require("hexadec")(255)
   local hexa = Hexadec.SDecode("FF", false, false) -- Will be optimized
   print(hexa) -- 255
  ````
### More coming soon...
