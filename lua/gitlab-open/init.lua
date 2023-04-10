print("plugin loaded");

-- TODO: accept params in the future. For
-- example GitHub or Gitlab
local function setup(params)
end

local url_opener_command = "!open"

-- TODO: Check if we are in a file or a scratch buffer, if buf,
-- exit
local function get_current_file_path()
    local path = vim.fn.expand('%')
    return path
end

local function get_current_buffer_line()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    return line
end

local function get_visual_range()
    local    line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
    local line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
    return { line1, line2 }
end

vim.api.nvim_create_user_command(
    'GLopen',
    function(input)
        -- print "Something should happen here..."
        local url = "https://www.google.com"
        -- vim.cmd('exec "!open https://www.google.com"')

        local cmd = 'silent exec "' .. url_opener_command .. ' \'' .. url .. '\'"'

        local file = get_current_file_path()
        local line = get_current_buffer_line()
        local vis = get_visual_range()
        print(vis.line1)
        --open the URL
        -- vim.cmd(cmd)
    end,
    { bang = true, desc = 'a new command to do the thing' }
)

return {
    setup = setup
}
