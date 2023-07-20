local Util = require("k1ng.util")

-- global variables
Autocmd = function (event, opts)
    return vim.api.nvim_create_autocmd(event, opts or {})
end

Usercmd = function (name, cb, opts)
    return vim.api.nvim_create_user_command(name, cb, opts or {})
end

Augroup = function (name, opts)
    return vim.api.nvim_create_augroup(name, opts or {clear = true})
end

Nmap = function (lhs, rhs, opts)
    Util.keymap("n", lhs, rhs, opts)
end

Vmap = function (lhs, rhs, opts)
    Util.keymap("v", lhs, rhs, opts)
end

Tmap = function (lhs, rhs, opts)
    Util.keymap("t", lhs, rhs, opts)
end

Imap = function (lhs, rhs, opts)
    Util.keymap("i", lhs, rhs, opts)
end

Keymap = Util.keymap

-- logging
vim.trace = function(msg, ...)
    return vim.notify(msg:format(...), vim.log.levels.TRACE)
end

vim.debug = function(msg, ...)
    return vim.notify(msg:format(...), vim.log.levels.DEBUG)
end

vim.info = function(msg, ...)
    return vim.notify(msg:format(...), vim.log.levels.INFO)
end

vim.warn = function(msg, ...)
    return vim.notify(msg:format(...), vim.log.levels.WARN)
end

vim.error = function(msg, ...)
    return vim.notify(msg:format(...), vim.log.levels.ERROR)
end

