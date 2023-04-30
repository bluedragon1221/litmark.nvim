-- LitMark - Create a literate neovim config in markdown

local vim = vim -- supress "Undefined global" errors

local M = {}

local function remove_non_code_lines()
    local in_code_block = false
    local new_lines = {}
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0,0,-1,false)) do
        if string.match(line, "^```") or string.match(line, "^```lua") then
            in_code_block = not in_code_block
            if in_code_block then
                table.insert(new_lines, line)
            end
        elseif in_code_block then
            table.insert(new_lines, line)
        end
    end
    local final_lines = {}
    for _, line in ipairs(new_lines) do
        if not string.match(line, "^```$") and not string.match(line, "^```lua$") then
            table.insert(final_lines, line)
        end
    end

    return final_lines
end


function M.scratch()
    local bufnr = vim.api.nvim_create_buf(false,true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, remove_non_code_lines())
    vim.api.nvim_command("belowright split")
    vim.api.nvim_command("buffer " .. bufnr)
    vim.cmd [[ set ft=lua ]]
end

function M.source()
    local success, error_message = pcall(load(table.concat(remove_non_code_lines(), '\n')))

    -- Check for errors
    if not success then
        print("Error:", error_message)
    end
end

return M
