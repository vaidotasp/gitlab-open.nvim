# gitlab-open.nvim

Open files from your code in GitLab. Alternative to
:GBrowse provided by vim-fugitive as that broke for
me constanly due to issues with gx functionality
and netrw.

This has been tested only on MacOS.

### TODOs

- add support for linux/windows
- add support to open MR for existing branch
- support visual block select ranges, so it opens in GL with range selected (e.g. #L1-#L20)
- error handling

### Setup

Include plugin using your plugin manager, for
example Packer:

```lua
  use 'vaidotasp/gitlab-open.nvim'
```

Then init the setup whereever you have your setup
file

```lua
require("gitlab-open").setup({
    repo_url = "https://gitlab.com/name-of-repo/blob/"
})
```

### Usage

Navigate to any file that belong to a repo hosted in GL. Use `:GLopen` command. It should open up GitLab repo in your browse with file and line number that you had in vim.
