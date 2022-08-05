require("plugins")

local actions = require("fzf-lua.actions")

require("fzf-lua").setup({
    winopts = {
        -- split         = "belowright new",-- open in a split instead?
        -- "belowright new"  : split below
        -- "aboveleft new"   : split above
        -- "belowright vnew" : split right
        -- "aboveleft vnew   : split left
        -- Only valid when using a float window
        -- (i.e. when 'split' is not defined)
        height = 0.85, -- window height
        width = 0.80, -- window width
        row = 0.35, -- window row position (0=top, 1=bottom)
        col = 0.50, -- window col position (0=left, 1=right)

        -- border argument passthrough to nvim_open_win(), also used
        -- to manually draw the border characters around the preview
        -- window, can be set to 'false' to remove all borders or to
        -- 'none', 'single', 'double' or 'rounded' (default)
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        -- border           =    { '',  '',  '',  '│', '',  '',  '',  '│' },
        -- border           = 'none',

        fullscreen = false, -- start fullscreen?

        hl = {
            normal = "Normal", -- window normal color (fg+bg)
            border = "Normal", -- border color (try 'FloatBorder')
            -- Only valid with the builtin previewer:
            cursor = "Cursor", -- cursor highlight (grep/LSP matches)
            cursorline = "CursorLine", -- cursor line
            -- title       = 'Normal',        -- preview border title (file/buffer)
            -- scrollbar_f = 'PmenuThumb',    -- scrollbar "full" section highlight
            -- scrollbar_e = 'PmenuSbar',     -- scrollbar "empty" section highlight
        },
        preview = {
            -- default     = 'bat',           -- override the default previewer?
            default = "builtin", -- override the default previewer?
            -- default uses the 'builtin' previewer

            border = "noborder", -- border|noborder, applies only to
            -- native fzf previewers (bat/cat/git/etc)

            wrap = "nowrap", -- wrap|nowrap
            hidden = "nohidden", -- hidden|nohidden
            vertical = "down:30%", -- up|down:size
            horizontal = "right:60%", -- right|left:size
            layout = "flex", -- horizontal|vertical|flex
            flip_columns = 120, -- #cols to switch to horizontal on flex

            -- Only valid with the builtin previewer:
            title = false, -- preview border title (file/buf)?
            scrollbar = "float", -- `false` or string:'float|border'
            -- float:  in-window floating border
            -- border: in-border chars (see below)
            scrolloff = "-1", -- float scrollbar offset from right
            -- applies only when scrollbar = 'float'
            scrollchars = { "█", "" }, -- scrollbar chars ({ <full>, <empty> }
            -- applies only when scrollbar = 'border'
            delay = 20, -- delay(ms) displaying the preview
            -- prevents lag on fast scrolling
            winopts = { -- builtin previewer window options
                number = false,
                relativenumber = false,
                cursorline = false,
                cursorlineopt = "both",
                cursorcolumn = false,
                signcolumn = "no",
                list = false,
                foldenable = false,
                foldmethod = "manual",
            },
        },
        on_create = function()
            -- called once upon creation of the fzf main window
            -- can be used to add custom fzf-lua mappings, e.g:
            --   vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>",
            --     { silent = true, noremap = true })
        end,
    },
    keymap = {
        -- These override the default tables completely
        -- no need to set to `false` to disable a bind
        -- delete or modify is sufficient
        builtin = {
            -- neovim `:tmap` mappings for the fzf win
            ["<F2>"] = "toggle-fullscreen",
            -- Only valid with the 'builtin' previewer
            ["<F3>"] = "toggle-preview-wrap",
            ["<F4>"] = "toggle-preview",
            -- Rotate preview clockwise/counter-clockwise
            ["<F5>"] = "toggle-preview-ccw",
            ["<F6>"] = "toggle-preview-cw",
            ["<S-down>"] = "preview-page-down",
            ["<S-up>"] = "preview-page-up",
            ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
            -- fzf '--bind=' options
            ["ctrl-z"] = "abort",
            ["ctrl-u"] = "unix-line-discard",
            ["ctrl-f"] = "half-page-down",
            ["ctrl-b"] = "half-page-up",
            ["ctrl-a"] = "beginning-of-line",
            ["ctrl-e"] = "end-of-line",
            ["alt-a"] = "toggle-all",
            -- Only valid with fzf previewers (bat/cat/git/etc)
            ["f3"] = "toggle-preview-wrap",
            ["f4"] = "toggle-preview",
            ["shift-down"] = "preview-page-down",
            ["shift-up"] = "preview-page-up",
        },
    },
    -- use skim instead of fzf?
    -- https://github.com/lotabout/skim
    -- fzf_bin          = 'sk',
    fzf_opts = {
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        -- set to '' for a non-value flag
        -- for raw args use `fzf_args` instead
        ["--ansi"] = "",
        ["--keep-right"] = "",
        ["--prompt"] = "> ",
        ["--info"] = "inline",
        ["--height"] = "100%",
        ["--layout"] = "reverse-list",
        ["--border"] = "none",
    },
    -- fzf '--color=' options (optional)
    fzf_colors = {
        ["fg"] = { "fg", "CursorLine" },
        ["bg"] = { "bg", "Normal" },
        ["hl"] = { "fg", "Comment" },
        ["fg+"] = { "fg", "Visual" },
        ["bg+"] = { "bg", "Visual" },
        ["hl+"] = { "fg", "Statement" },
        ["info"] = { "fg", "PreProc" },
        ["prompt"] = { "fg", "Conditional" },
        ["pointer"] = { "fg", "Exception" },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" },
        ["gutter"] = { "bf", "Normal" },
    },
    previewers = {
        cat = { cmd = "cat", args = "--number" },
        bat = {
            cmd = "bat",
            args = "--style=numbers,changes -f",
            theme = "Coldark-Dark", -- bat preview theme (bat --list-themes)
            config = nil, -- nil uses $BAT_CONFIG_PATH
        },
        head = { cmd = "head", args = nil },
        git_diff = {
            cmd = "git diff",
            args = "--color",
            -- pager        = "delta",      -- if you have `delta` installed
        },
        man = { cmd = "man -c %s | col -bx" },
        builtin = {
            syntax = true, -- preview syntax highlight?
            syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
            syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
        },
    },
    -- provider setup
    files = {
        -- previewer      = "cat",          -- uncomment to override previewer
        prompt = "Files❯ ",
        git_icons = false, -- show git icons?
        file_icons = false, -- show file icons?
        color_icons = true, -- colorize file|git icons
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd` over `find`
        -- default options are controlled by 'fd|find_opts'
        -- NOTE: 'find -printf' requires GNU find
        -- cmd            = "find . -type f -printf '%P\n'",
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        fd_opts = [[--color always --type f --hidden --follow ]]
            .. [[--exclude .git --exclude node_modules --exclude '*.pyc']],
        actions = {
            -- set bind to 'false' to disable an action
            -- default action opens a single selection
            -- or sends multiple selection to quickfix
            -- replace the default aciton with the below
            -- to open all files whether single or multiple
            -- ["default"]     = actions.file_edit,
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["alt-q"] = actions.file_sel_to_qf,
            -- custom actions are available too
            ["ctrl-y"] = function(selected)
                print(selected[1])
            end,
        },
    },
    git = {
        files = {
            prompt = "GitFiles❯ ",
            cmd = "git ls-files --exclude-standard",
            git_icons = true, -- show git icons?
            file_icons = true, -- show file icons?
            color_icons = true, -- colorize file|git icons
        },
        status = {
            prompt = "GitStatus❯ ",
            cmd = "git status -s",
            previewer = "git_diff",
            file_icons = true,
            git_icons = true,
            color_icons = true,
        },
        commits = {
            prompt = "Commits❯ ",
            cmd = "git log --pretty=oneline --abbrev-commit --color",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions = { ["default"] = actions.git_checkout },
        },
        bcommits = {
            prompt = "BCommits❯ ",
            cmd = "git log --pretty=oneline --abbrev-commit --color",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions = {
                ["default"] = actions.git_buf_edit,
                ["ctrl-s"] = actions.git_buf_split,
                ["ctrl-v"] = actions.git_buf_vsplit,
                ["ctrl-t"] = actions.git_buf_tabedit,
            },
        },
        branches = {
            prompt = "Branches❯ ",
            cmd = "git branch --all --color",
            preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
            actions = { ["default"] = actions.git_switch },
        },
        icons = {
            ["M"] = { icon = "M", color = "yellow" },
            ["D"] = { icon = "D", color = "red" },
            ["A"] = { icon = "A", color = "green" },
            ["?"] = { icon = "?", color = "magenta" },
            -- ["M"]          = { icon = "★", color = "red" },
            -- ["D"]          = { icon = "✗", color = "red" },
            -- ["A"]          = { icon = "+", color = "green" },
        },
    },
    grep = {
        prompt = "Rg❯ ",
        input_prompt = "Grep For❯ ",
        git_icons = false, -- show git icons?
        file_icons = false, -- show file icons?
        color_icons = true, -- colorize file|git icons
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `rg` over `grep`
        -- default options are controlled by 'rg|grep_opts'
        -- cmd            = "rg --vimgrep",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
        grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
        -- 'true' enables file and git icons in 'live_grep'
        -- degrades performance in large datasets, YMMV
        experimental = false,
        -- live_grep_glob options
        glob_flag = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
    },
    args = {
        prompt = "Args❯ ",
        files_only = true,
        actions = {
            -- added on top of regular file actions
            ["ctrl-x"] = actions.arg_del,
        },
    },
    oldfiles = { prompt = "History❯ ", cwd_only = false },
    buffers = {
        -- previewer      = false,        -- disable the builtin previewer?
        prompt = "Buffers❯ ",
        file_icons = false, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
        actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
            ["ctrl-x"] = actions.buf_del,
        },
    },
    lines = {
        previewer = "builtin", -- set to 'false' to disable
        prompt = "Lines❯ ",
        show_unlisted = false, -- exclude 'help' buffers
        no_term_buffers = true, -- exclude 'term' buffers
        fzf_opts = {
            -- do not include bufnr in fuzzy matching
            -- tiebreak by line no.
            ["--delimiter"] = vim.fn.shellescape("]"),
            ["--nth"] = "2..",
            ["--tiebreak"] = "index",
        },
        actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
        },
    },
    blines = {
        previewer = "builtin", -- set to 'false' to disable
        prompt = "BLines❯ ",
        show_unlisted = true, -- include 'help' buffers
        no_term_buffers = false, -- include 'term' buffers
        fzf_opts = {
            -- hide filename, tiebreak by line no.
            ["--delimiter"] = vim.fn.shellescape("[:]"),
            ["--with-nth"] = "2..",
            ["--tiebreak"] = "index",
        },
        actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
        },
    },
    colorschemes = {
        prompt = "Colorschemes❯ ",
        live_preview = true, -- apply the colorscheme on preview?
        actions = {
            ["default"] = actions.colorscheme,
            ["ctrl-y"] = function(selected)
                print(selected[1])
            end,
        },
        winopts = { height = 0.55, width = 0.30 },
        post_reset_cb = function()
            -- reset statusline highlights after
            -- a live_preview of the colorscheme
            -- require('feline').reset_highlights()
        end,
    },
    quickfix = {
        -- cwd               = vim.loop.cwd(),
        file_icons = false,
        git_icons = false,
    },
    lsp = {
        prompt = "❯ ",
        -- cwd               = vim.loop.cwd(),
        cwd_only = false, -- LSP/diagnostics for cwd only?
        async_or_timeout = 5000, -- timeout(ms) or 'true' for async calls
        file_icons = false,
        git_icons = false,
        lsp_icons = true,
        severity = "hint",
        icons = {
            ["Error"] = { icon = "", color = "red" }, -- error
            ["Warning"] = { icon = "", color = "yellow" }, -- warning
            ["Information"] = { icon = "", color = "blue" }, -- info
            ["Hint"] = { icon = "", color = "magenta" }, -- hint
        },
    },
    -- uncomment to disable the previewer
    -- nvim = { marks    = { previewer = { _ctor = false } } },
    -- helptags = { previewer = { _ctor = false } },
    -- manpages = { previewer = { _ctor = false } },
    -- uncomment to set dummy win location (help|man bar)
    -- "topleft"  : up
    -- "botright" : down
    -- helptags = { previewer = { split = "topleft" } },
    -- uncomment to use `man` command as native fzf previewer
    -- manpages = { previewer = { _ctor = require'fzf-lua.previewer'.fzf.man_pages } },
    -- optional override of file extension icon colors
    -- available colors (terminal):
    --    clear, bold, black, red, green, yellow
    --    blue, magenta, cyan, grey, dark_grey, white
    -- padding can help kitty term users with
    -- double-width icon rendering
    file_icon_padding = "",
    file_icon_colors = { ["lua"] = "blue" },
})

local util = require("formatter.util")
require("formatter").setup({
    filetype = {
        lua = {
            function()
                return {
                    exe = "stylua",
                    args = {
                        "--search-parent-directories",
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--indent-type=Spaces",
                        "--",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        rust = {
            function()
                return {
                    exe = "rustfmt",
                    args = {
                        "--edition",
                        "2021",
                    },
                    stdin = true,
                }
            end,
        },
        -- go = {{cmd = {"gofmt -w", "goimports -w"}, tempfile_postfix = ".tmp"}},
        -- javascript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
        -- html = {{cmd = {"tidy -quiet --tidy-mark no -modify -indent"}}},
        ["*"] = {
            function()
                -- remove trailing whitespace
                return {
                    exe = "sed",
                    args = {
                        "'s/[ \t]*$//'",
                    },
                    stdin = true,
                }
            end,
        },
    },
})

-- (Optional) easy way to get Neovim current size.
local ui = vim.api.nvim_list_uis()[1]

vim.api.nvim_set_keymap("", "<M-p>", [[<cmd>PackerSync<CR>]], {})

vim.api.nvim_set_keymap("n", " ff", [[<cmd>lua require('fzf-lua').files()<CR>]], {})
vim.api.nvim_set_keymap("n", " fb", [[<cmd>lua require('fzf-lua').buffers()<CR>]], {})
vim.api.nvim_set_keymap("n", "\\b", [[<cmd>lua require('fzf-lua').buffers()<CR>]], {})
vim.api.nvim_set_keymap("n", " fc", [[<cmd>lua require('fzf-lua').command_history()<CR>]], {})
vim.api.nvim_set_keymap("n", " fo", [[<cmd>lua require('fzf-lua').oldfiles()<CR>]], {})

vim.api.nvim_set_keymap("n", "  ", [[<cmd>bprevious<CR>]], {})

vim.api.nvim_set_keymap("n", " qr", [[<cmd>Reload<CR><cmd>echom "reloaded"<CR>]], {})

vim.api.nvim_set_keymap("n", " .f", [[<cmd>w<CR><cmd>Format<CR>]], {})
vim.api.nvim_set_keymap("n", " .F", [[<cmd>w<CR><cmd>FormatWrite<CR>]], {})

vim.cmd([[
set mouse=
set laststatus=0

highlight VertSplit cterm=none
set nohlsearch

vnoremap < <gv
vnoremap > >gv

nnoremap <silent> <C-h> :lua require('tmux').move_left()<CR>
nnoremap <silent> <C-l> :lua require('tmux').move_right()<CR>
nnoremap <silent> <C-j> :lua require('tmux').move_down()<CR>
nnoremap <silent> <C-k> :lua require('tmux').move_up()<CR>

set statusline=%<%f                            " path to file
set statusline+=\ [%{&ff}]                     " space + fileformat
set statusline+=%y                             " filetype
set statusline+=%{&expandtab?'[spc]':'[TAB]'}  " is expandtab set?
set statusline+=%m                             " modified status
set statusline+=%r                             " read only flag
set statusline+=%=                             " switch to the right side
set statusline+=%-14.(%l,%c%)                  " current line,col
set statusline+=\ %L                           " total number of lines

" http://ricostacruz.com/til/repeat-tmux-from-vim.html
" run up enter in the last tmux pane used
function! s:TmuxRepeat()
    let x = system("tmux select-pane -l && tmux send up enter && tmux select-pane -l")
endfunction
noremap  <C-i> :w<CR>:call <SID>TmuxRepeat()<CR>
]])

local reload = require("nvim-reload")

-- If you use Neovim's built-in plugin system
-- Or a plugin manager that uses it (eg: packer.nvim)
local plugin_dirs = vim.fn.stdpath("data") .. "/site/pack/*/start/*"

-- If you use vim-plug
-- local plugin_dirs = vim.fn.stdpath('data') .. '/plugged/*'

reload.vim_reload_dirs = { vim.fn.stdpath("config"), plugin_dirs }

reload.lua_reload_dirs = {
    vim.fn.stdpath("config"),
    -- Note: the line below may cause issues reloading your config
    plugin_dirs,
}
