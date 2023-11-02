return require("packer").startup(function()
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")
    use("famiu/nvim-reload")

    use("nathom/tmux.nvim")

    -- use({ "bfredl/nvim-luadev" })
    -- use({ "rhaiscript/vim-rhai" })

    use({ "mhartington/formatter.nvim" })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({ "nvim-telescope/telescope-file-browser.nvim" })

		use('neovim/nvim-lspconfig')

    -- use("github/copilot.vim")
end)
