# Hexadec-LuaRocks-Module
Hi, I made a module in Lua that can manipulate hexadecimal!
It can convert numbers of n-base (up to 36) and strings to hexadec (special type representing hexadecimal in a table) that can be converted
back or become RGB (RGBA) colors, dump and be cleaned, with a secure mode for the decode function.
Also, I recommend using 'Color' and 'Hex' with it!
# Documentation:
**FUNCTION: Hexadec.NCode:**
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
   ````markdown
   ```lua
   local Hexadec = require("hexadec")
   local hexa = Hexadec.NCode(16, nil, nil, "255", "255") -- Will be extremely optimized
   print(hexa) -- {255, 255}
   ```
  ````

### More coming soon...
