-- LitMark - Create a literate neovim config in markdown

local vim = vim -- supress "Undefined global" errors

local M = {}

function M.remove_non_code_lines()
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

return M
