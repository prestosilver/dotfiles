local lsp_status = require('lsp-status')

lsp_status.config({
    indicator_errors = 'E',
    indicator_warnings = 'W',
    indicator_info = 'i',
    indicator_hint = '?',
    indicator_ok = 'Ok',
})

vim.lsp.config('zls', {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
})
vim.lsp.enable('zls')

vim.lsp.config('rust_analyzer', {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('nim_langserver', {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities
})
vim.lsp.enable('nim_langserver')

-- lspconfig.nimls = {
--     on_attach = lsp_status.on_attach,
--     capabilities = lsp_status.capabilities
-- }

vim.lsp.config('lua_ls', {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
vim.lsp.enable('lua_ls')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            -- 3
            buffer = ev.buf,
            callback = function()
                -- 4 + 5
                if vim.lsp.buf.filetype == "zig" then
                    vim.lsp.buf.format { async = false, id = ev.data.client_id }
                end
            end,
        })

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gr', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.references, opts)
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
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

vim.diagnostic.config({ virtual_text = true })

-- Auto wordwrap on markdown and text files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.md", "*.txt" },                 -- Apply to markdown and text files
    callback = function()
        vim.opt_local.wrap = true                  -- Enable visual wrap for the buffer
        vim.opt_local.linebreak = true             -- Wrap at word boundaries
        vim.opt_local.textwidth = 80               -- Set hard wrap width to 80 characters
        vim.opt_local.fo = vim.opt_local.fo + "tc" -- Add 't' (textwidth) and 'c' (comments) to formatoptions
    end,
})
