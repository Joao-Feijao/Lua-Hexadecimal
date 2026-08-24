# Hexadec-LuaRocks-Module
Hi, I made a module in Lua that can manipulate hexadecimal!
# Documentation:
**Hexadec.NCode:**
  Return:
  *- Hexadec type (table)*.

  Args:
  *- Base*: Numeric base of the numeric strings (default is 10; minimum is 2 and maximum is 36);
  *- Min*: Minimum size of each hexadecimal, filled with 0;
  *- Sep*: Separates the hexadecimal digits if table.concat is used on the return;
  *- Variadic (...)*: Numeric strings that will be converted.
  
  Example:
    ```lua
    local meu_hex = Hexadec.NCode(10, nil, nil, "255", "255") 
    print(meu_hex) -- "FFFF"
    ```
    
  Tips:
  *- If base is 16, then it will do a direct conversion*;
  *- If there's only one variadic argument, then it will activate a slightly faster version*;
  *- If the min is nil or min == 0 and sep == "", then it will activate a more efficient string pattern*.

### More coming soon...
