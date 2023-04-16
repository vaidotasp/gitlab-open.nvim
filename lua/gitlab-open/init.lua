-- this should be based on config
RepoURL = ""

-- TODO: accept other params in the future. For
-- example GitHub or Gitlab
local function setup(params)
    if params.repo_url == '' then
        print('setup missing: "repo_url"')
    end
    RepoURL = params.repo_url
end

-- TODO: Check if we are in a file or a scratch buffer, if buf -> exit
local function get_current_file_path()
    local path = vim.fn.expand('%')
    if path == '' or vim.fn.filereadable(path) ~= 1 then
        print('empty buffer')
        -- maybe less intrusive feedback than error needed
        error('empty buffer')
    end
    return path
end

local function get_current_buffer_line()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    return line
end

-- TODO implement ranges, so we can open and select L1->L23 in GL UI
local function get_visual_range()
    local line1 = vim.api.nvim_buf_get_mark(0, "<")[1]
    local line2 = vim.api.nvim_buf_get_mark(0, ">")[1]
    return { line1, line2 }
end

local function get_git_branch()
    local branch = vim.fn.systemlist('git symbolic-ref --short HEAD')[1]
    return branch
end

local function getURL(file, line)
    return RepoURL .. get_git_branch() .. "/" .. file .. "#L" .. line
end

vim.api.nvim_create_user_command(
    'GLopen',
    function()
        local file = get_current_file_path()
        local line = get_current_buffer_line()
        local url = getURL(file, line)
        --open the URL
        local cmd = 'open ' .. url
        os.execute(cmd) -- using os.execute instead of exec !open to prevent weird URL manipulation when it comes to symbols like "#"
    end,
    { bang = true, desc = 'open file and line number in GitLab UI' }
)

return {
    setup = setup
}
