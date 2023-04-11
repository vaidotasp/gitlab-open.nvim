print("plugin loaded");
local repoURL = "https://gitlab.com/remote-com/employ-starbase/dragon/blob/"

-- TODO: accept params in the future. For
-- example GitHub or Gitlab
local function setup(params)
end

local url_opener_command = "!open"

-- TODO: Check if we are in a file or a scratch buffer, if buf -> exit
local function get_current_file_path()
    local path = vim.fn.expand('%')
    return path
end

local function get_current_buffer_line()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    return line
end

-- TODO implement ranges
local function get_visual_range()
    local    line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
    local line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
    return { line1, line2 }
end

local function get_git_branch()
  local branch = vim.fn.systemlist('git symbolic-ref --short HEAD')[1]
  return branch
end

local function getURL(file, line)
    return repoURL .. get_git_branch() .. "/" .. file .. "#L" .. line
end

-- local function get_project_path()
--     local current_path = vim.api.nvim_buf_get_name(0)
--     local git_root = vim.fn.systemlist({'git', '-C', current_path, 'rev-parse', '--show-toplevel'})[1]

--     if git_root == nil or git_root == '' then
--         return vim.fn.fnamemodify(current_path, ':p:h')
--     end
--     return git_root
-- end

-- local function get_current_buffer_project_path()
--   -- Get the current buffer file path
--   local current_path = vim.api.nvim_buf_get_name(0)

--   -- Get the project root path
--   local project_path = get_project_path()

--   -- Get the relative path from the project root

--     print(project_path)
--   -- local rel_path = current_path:gsub('^' .. project_path .. '/', '')

--   return project_path .. '/' 
-- end



vim.api.nvim_create_user_command(
    'GLopen',
    function(input)
        -- print "Something should happen here..."
        -- local url = "https://www.google.com"
        -- vim.cmd('exec "!open https://www.google.com"')


        local file = get_current_file_path()
        local line = get_current_buffer_line()
        -- local vis = get_visual_range()
        local url = getURL(file, line)
        -- print(url)
        --open the URL
        local cmd = 'silent exec "' .. url_opener_command .. ' \'' .. url .. '\'"'
        print(cmd)
        vim.cmd(cmd)
    end,
    { bang = true, desc = 'a new command to do the thing' }
)

return {
    setup = setup
}
