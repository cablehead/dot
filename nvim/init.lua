require("plugins")

-- require("plugin/lsp")
require("plugin/treesitter")
require("plugin/formatter")

require("config/set")

require("telescope").load_extension("file_browser")

require("telescope").setup({
    pickers = {
        buffers = {
            sort_mru = true,
        },
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
vim.api.nvim_set_keymap("", " cc", [["+y]], {})
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

highlight VertSplit cterm=none

" work around for blown out colors in telescope
" which may be from a regression in nvim
" # Broken color scheme
"   https://github.com/nvim-telescope/telescope.nvim/issues/2145
hi NormalFloat ctermfg=LightGrey

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

-- small steps into LSP

local nvim_lsp = require('lspconfig')

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded"  -- Choose from 'single', 'double', 'rounded', 'solid', or 'shadow'
  }
)

nvim_lsp.rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
    }
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
