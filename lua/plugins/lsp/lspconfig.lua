return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },

    config = function()
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
        vim.lsp.enable('lua_ls')

        vim.lsp.config("pyright", {})
        vim.lsp.enable("pyright")

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local c = vim.lsp.get_client_by_id(args.data.client_id)
                if not c then return end

                if vim.bo[args.buf].filetype == "lua" then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = args.buf,
                                id = c.id
                            })
                        end,
                    })
                end
            end,
        })
    end,
}
