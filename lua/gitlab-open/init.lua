print("plugin loaded");

-- TODO: accept params (GL/GH)
local function setup(params)
end

-- Create a command, ':DoTheThing'
vim.api.nvim_create_user_command(
    'GLOpen',
    function(input)
        print "Something should happen here..."
    end,
    {bang = true, desc = 'a new command to do the thing'}
)

return {
	setup = setup
}
