## 🚀 Pull Request Checklist

### 📝 Description
Provide a brief summary of the changes introduced by this PR and which functions were refactored.

### 📊 Performance & Benchmark Verification (Mandatory)
This repository is strictly dedicated to high-frequency load optimizations ($O(1)$ and register-level execution). Any pull request that drops performance or introduces garbage allocation will be automatically closed.

- [ ] I have run the 5,000,000 (Five Million) iteration stress test.
- [ ] This optimization reduces or maintains the current execution time.
- [ ] No generic iterators (`for ... in`) or dynamic string concatenations (`..`) were introduced in high-frequency hot paths.
- [ ] Checked on the target platforms (LuaJIT / Lua 5.4 / Lua 5.5).

### 🪖 Quality Control
- [ ] The code respects the Double-Local Caching architecture.
- [ ] Used at least 1 constant (if Lua 5.4+).
- [ ] Test cases cover edge cases like multi-byte UTF-8 data and emojis (`🗿🍷`).
