return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'famiu/nvim-reload'

  use 'nathom/tmux.nvim'

  use {'ibhagwan/fzf-lua', requires = {'vijaymarupudi/nvim-fzf'}}

  use {'bfredl/nvim-luadev'}

  use {'mhartington/formatter.nvim'}
end)
