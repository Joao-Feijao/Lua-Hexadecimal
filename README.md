< Thanks for using my Hexadec Module >

< You can see the documentation at my GitHub: Joao-Feijao >

< This update brings:
1 - Ultra Cache otimization for Lite version, featuring Randomized LRU and velocity compared to "Hex" Lua module;
2 - Added new functions to the Lite version:
    - Alert -> Can call a function every time the Ultra Cache is used;
    - Rigid -> Can define a limit for Ultra Cache, preventing RAM overflow;
    - They are deactivated by default.
3 - Added new otimizations and centralized modules for the main Lua versions:
    - Lua 5.5 (already in last update, now with extra performance);
    - Lua 5.4;
    - Lua 5.3;
    - LuaJIT;
    - This excludes Lua 5.2 and pure Lua 5.1.
4 - Added a new use for Hexadec.SDecode, now able to decode numeric strings directly to ASCII + 64 or 96 (1-26 will show the alphabet).