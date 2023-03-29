local util = require("formatter.util")
require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        css = {
            require("formatter.filetypes.css").prettier,
        },

        json = {
            require("formatter.filetypes.json").prettier,
        },

        sh = {
            require("formatter.filetypes.sh").shfmt,
        },

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

        html = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--print-width",
                        99,
                    },
                    stdin = true,
                    try_node_modules = true,
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

        typescriptreact = {
            require("formatter.filetypes.typescriptreact").denofmt,
        },

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
