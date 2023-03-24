-- Provides a lazy autoload mechanism similar to Vimscript's autoload mechanism.
--
-- Examples:
--
--    " Vimscript - looks for function named `user#foo#bar#baz()` in
--    " autoload/user/foo/bar.vim):
--
--    call user#foo#bar#baz()
--
--    -- Lua - lazy-loads these files in sequence before calling
--    -- `user.foo.bar.baz()`:
--    --
--    --    1. lua/user/foo.lua (or lua/user/foo/init.lua)
--    --    2. lua/user/foo/bar.lua (or lua/user/foo/bar/init.lua)
--    --    3. lua/user/foo/bar/baz.lua (or lua/user/foo/bar/baz/init.lua)
--
--    local user = require'user'
--    user.foo.bar.baz()
--
--    -- Note that because `require'user'` appears at the top of the top-level
--    -- init.lua, the previous example can be written as:
--
--    user.foo.bar.baz()
--
local autoload = function(base)
  local storage = {}
  local mt = {
    __index = function(_, key)
      if storage[key] == nil then
        storage[key] = require(base .. '.' .. key)
      end
      return storage[key]
    end,
  }

  return setmetatable({}, mt)
end

return autoload
