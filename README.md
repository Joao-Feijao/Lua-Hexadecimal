# Introduction for Hexadec-LuaRocks-Module
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
  *- Hexadec Module or SECRETE MESSAGE*.

  Args:<br>
  *- 1st argument (or cache)*: Number that defines your Hexadec.HEX cache.

  Example:<br>
   ````lua
   local Hexadec = require("hexadec")
   print (Hexadec) -- function: 0x... -- Setup function
   print (Hexadec()) -- SECRETE MESSAGE -- No arguments
   print (Hexadec(255)) -- table: 0x... (Hexadec Module) - With cache
  ````
**FUNCTION: Hexadec.NCode(base: number, min: number, sep: string, ...):**<br>
  Description: A function that uses numeric strings (in base) passed in vararg that can have a minimum size of min (filled with 0) and a separator sep.
  
  Return:<br>
  *- Hexadec type (table)*.

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

### More coming soon...
