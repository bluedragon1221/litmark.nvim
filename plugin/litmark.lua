local litmark = require('litmark.nvim')
local vim = vim -- Supress "Undefined global" errors

local function scratch(lines)
    local bufnr = vim.api.nvim_create_buf(false,true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.api.nvim_command("belowright split")
    vim.api.nvim_command("buffer " .. bufnr)
    vim.cmd [[ set ft=lua ]]
end

local function source(lua_code)
    local success, error_message = pcall(load(table.concat(lua_code, '\n')))

    -- Check for errors
    if not success then
        print("Error:", error_message)
    end
end

vim.api.nvim_create_user_command('LMshow',  function() scratch(litmark.remove_non_code_lines()) end, {})
vim.api.nvim_create_user_command('LMsource', function() source(litmark.remove_non_code_lines()) end, {})
