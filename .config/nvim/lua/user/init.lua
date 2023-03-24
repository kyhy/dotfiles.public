require("user.options")
require("user.packer")
require("user.keymap")
require("user.statusline")
-- equire("user.autocmds")
-- equire("user.autoload")

local autoload = require('user.autoload')

local user = autoload('user')

-- Using a real global here to make sure anything stashed in here (and
-- in `wincent.g`) survives even after the last reference to it goes away.
_G.user = user

return user
