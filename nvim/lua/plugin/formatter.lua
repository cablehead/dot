local util = require("formatter.util")
require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        css = {
            require("formatter.filetypes.css").prettier,
        },

        scss = {
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

        json = {
            require("formatter.filetypes.json").prettier,
        },

        svelte = {
            require("formatter.filetypes.svelte").prettier,
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

        javascriptreact = {
            require("formatter.filetypes.javascriptreact").denofmt,
        },

        javascript = {
            require("formatter.filetypes.javascript").denofmt,
        },

        typescriptreact = {
            require("formatter.filetypes.typescriptreact").denofmt,
        },

        typescript = {
            require("formatter.filetypes.typescript").denofmt,
        },

        markdown = {
            require("formatter.filetypes.markdown").denofmt,
        },

        nu = {
            function()
                return {
                    exe = "topiary",
                    args = {
                        "format",
                        "-l",
                        "nu",
                    },
                    stdin = true,
                }
            end,
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
