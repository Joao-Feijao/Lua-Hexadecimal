# Contributing to Lua-Hexadecimal

First off, thank you for taking the time to contribute! This project is built with an absolute obsession for low-level performance, micro-optimizations, and zero-overhead memory design. 

If you found a way to squeeze even more nanoseconds out of this engine, we want your code!

## How Can I Contribute?

### 🐛 Reporting Bugs & Performance Regressions
* Check the current Issues tab before opening a new report.
* If a specific function is running slower than traditional C-extensions on high-frequency loads, please open a performance issue with your hardware specs and benchmark script.

### 💡 Submitting a Pull Request (PR)
1. **Fork the Repository:** Create your own branch from the latest tag/main branch.
2. **Write Clean, Purist Lua:** Your code must be compatible with our multi-platform matrix (LuaJIT, Lua 5.4, and Lua 5.5).
3. **Run the Stress Test:** Any code modification **MUST** pass our 5,000,000 (Five Million) iteration benchmark test without dropping performance.
4. **Keep it Light:** Keep file weight strictly optimized. Do not add bloated dependencies.

## Coding Style Rules (NÍVEL C Standard)

To maintain our chart-breaking speed, all pull requests must respect the following molecular guidelines:

* 🚫 **No Dynamic Concatenations:** Do not use the `..` operator inside high-frequency loops. Use our pre-allocated array pathways and `table.concat`.
* 🚫 **No High-Level Iterators:** Avoid generic `for ... in` loops with heavy iterator functions (like `utf8.codes`) in the performance modules. Stick to linear numerical loops (`for i = 1, len do`) combined with fast primitives like `string.byte`.
* 🔒 **Double-Local Caching:** Always cache external functions, standard libraries, and dynamic upvalues into internal static local constants (`<const>`) before entering loops to eliminate `GETUPVAL` overhead.
* 📦 **Pointer-Based Hashes:** Keep the decoding cache matching memory addresses directly. Do not introduce slow table-flattening mechanisms unless absolutely necessary.

## Community & Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md). Please report any unacceptable behavior responsibly via the official contact channel.
