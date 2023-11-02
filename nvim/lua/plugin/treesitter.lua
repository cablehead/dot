require("nvim-treesitter.configs").setup({
    ensure_installed = { "rust", "lua", "svelte", "css", "html", "kdl", "javascript", "typescript" },
    sync_install = true,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})
