local litmark = require('litmark')
local vim = vim -- Supress "Undefined global" errors

vim.api.nvim_create_user_command('LMshow',  function() litmark.scratch() end, {})
vim.api.nvim_create_user_command('LMsource', function() litmark.source() end, {})
