return require("packer").startup(function()
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")
    use("famiu/nvim-reload")

    use("nathom/tmux.nvim")

    use({ "bfredl/nvim-luadev" })

    use({ "mhartington/formatter.nvim" })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-file-browser.nvim" })
end)
