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
