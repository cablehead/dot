require("plugins")

require("plugin/treesitter")
require("plugin/formatter")

require("config/set")

vim.cmd("colorscheme nordfox")

require("telescope").load_extension("file_browser")

require("telescope").setup({
    pickers = {
        buffers = {
            sort_mru = true,
            mappings = {
                i = {
                    ["<c-d>"] = "delete_buffer",
                },
            },
        },
    },
})

vim.filetype.add({
    extension = {
        nu = "nu",
    },
})

-- vim.api.nvim_set_keymap("", "<M-p>", [[<cmd>PackerSync<CR>]], {})

vim.api.nvim_set_keymap("n", "  ", [[<cmd>bprevious<CR>]], {})

vim.api.nvim_set_keymap("n", "\\b", [[<cmd>Telescope buffers<CR>]], {})
vim.api.nvim_set_keymap("n", " fb", [[<cmd>Telescope buffers<CR>]], {})
vim.api.nvim_set_keymap("n", " ff", [[<cmd>Telescope file_browser<CR>]], {})
vim.api.nvim_set_keymap("n", " fa", [[<cmd>Telescope git_files<CR>]], {})
vim.api.nvim_set_keymap("n", " fo", [[<cmd>Telescope oldfiles<CR>]], {})

-- copy to system clipboard
-- vim.api.nvim_set_keymap("", " cc", [["+y]], {})
vim.api.nvim_set_keymap("v", " cc", [["+ygv]], { noremap = true })

vim.api.nvim_set_keymap("", " co", [[<cmd>new | execute 'r !pbpaste' | setlocal buftype=nofile<CR>]], {})
vim.api.nvim_set_keymap("", " cv", [[<cmd>vnew | execute 'r !pbpaste' | setlocal buftype=nofile<CR>]], {})

vim.api.nvim_set_keymap("n", " qr", [[<cmd>Reload<CR><cmd>echom "reloaded"<CR>]], {})
vim.api.nvim_set_keymap("n", " .f", [[<cmd>w<CR><cmd>Format<CR>]], {})
vim.api.nvim_set_keymap("n", " .F", [[<cmd>w<CR><cmd>FormatWrite<CR>]], {})

vim.cmd([[
set mouse=

" always show status bar
set laststatus=2
set modeline
set modelines=5

" https://stackoverflow.com/a/2288438
set smartcase

" highlight VertSplit cterm=none

" work around for blown out colors in telescope
" which may be from a regression in nvim
" # Broken color scheme
"   https://github.com/nvim-telescope/telescope.nvim/issues/2145
" hi NormalFloat ctermfg=LightGrey

vnoremap < <gv
vnoremap > >gv

autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType sh set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType go set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType nginx set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType ghmarkdown set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType markdown set tabstop=4|set shiftwidth=4|set expandtab
autocmd FileType html set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType lua set tabstop=2|set shiftwidth=2|set noexpandtab
autocmd FileType nu set tabstop=2|set shiftwidth=2|set expandtab

set statusline=%<%f                            " path to file
set statusline+=\ [%{&ff}]                     " space + fileformat
set statusline+=%y                             " filetype
set statusline+=%{&expandtab?'[spc]':'[TAB]'}  " is expandtab set?
set statusline+=%m                             " modified status
set statusline+=%r                             " read only flag
set statusline+=%=                             " switch to the right side
set statusline+=%-14.(%l,%c%)                  " current line,col
set statusline+=\ %L                           " total number of lines

"
" tmux related config, TODO: replace with zellij
"
nnoremap <silent> <C-h> :lua require('tmux').move_left()<CR>
nnoremap <silent> <C-l> :lua require('tmux').move_right()<CR>
nnoremap <silent> <C-j> :lua require('tmux').move_down()<CR>
nnoremap <silent> <C-k> :lua require('tmux').move_up()<CR>

" http://ricostacruz.com/til/repeat-tmux-from-vim.html
" run up enter in the last tmux pane used
" function! s:TmuxRepeat()
    " let x = system("tmux select-pane -l && tmux send up enter && tmux select-pane -l")
" endfunction
" noremap  <C-i> :w<CR>:call <SID>TmuxRepeat()<CR>
]])

local reload = require("nvim-reload")

-- If you use Neovim's built-in plugin system
-- Or a plugin manager that uses it (eg: packer.nvim)
local plugin_dirs = vim.fn.stdpath("data") .. "/site/pack/*/start/*"

reload.vim_reload_dirs = { vim.fn.stdpath("config"), plugin_dirs }
reload.lua_reload_dirs = {
    vim.fn.stdpath("config"),
    -- Note: the line below may cause issues reloading your config
    plugin_dirs,
}

-- XS store integration
function _G.open_xs_file(filename)
    local ft = vim.fn.fnamemodify(filename, ":e")

    local handle = io.popen("xs head ./store/ " .. vim.fn.shellescape(filename))
    local exists = handle:read("*a")
    handle:close()

    if vim.fn.winnr("$") == 1 and vim.fn.expand("%") == "" and vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
        if exists ~= "" then
            vim.cmd(
                "read !xs head ./store/ "
                    .. vim.fn.shellescape(filename)
                    .. " | jq -r .hash | xargs -I {} xs cas ./store/ {}"
            )
            vim.cmd("normal ggdd")
        end
    else
        vim.cmd("enew")
        if exists ~= "" then
            vim.cmd(
                "read !xs head ./store/ "
                    .. vim.fn.shellescape(filename)
                    .. " | jq -r .hash | xargs -I {} xs cas ./store/ {}"
            )
            vim.cmd("normal ggdd")
        end
    end

    vim.cmd("file xs://" .. filename)
    vim.cmd("set filetype=" .. ft)
    vim.cmd("set nomodified")

    local save_cmd = "silent w !xs append ./store " .. vim.fn.shellescape(filename) .. " >/dev/null"
    vim.keymap.set("n", ":w<CR>", function()
        vim.cmd(save_cmd)
        vim.cmd("set nomodified")
    end, { buffer = true })

    vim.keymap.set("n", ":wq<CR>", function()
        vim.cmd(save_cmd)
        vim.cmd("set nomodified")
        vim.cmd("q")
    end, { buffer = true })
end

vim.api.nvim_create_user_command("XS", function(args)
    _G.open_xs_file(args.args)
end, { nargs = 1 })
