local util = require("formatter.util")
require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
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
        html = {
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
			"--print-width",
			120,
                    },
                    stdin = true,
                    try_node_modules = true,
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
