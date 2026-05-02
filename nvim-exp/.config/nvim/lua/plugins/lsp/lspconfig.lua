-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config('*', { capabilities = capabilities })

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local fzf = require("fzf-lua")
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "rename")
        map("gra", fzf.lsp_code_actions, "goto code action", { "n", "x" })
        map("grd", fzf.lsp_definitions, "goto definition")
        map("grr", fzf.lsp_references, "goto references")
        map("gri", fzf.lsp_implementations, "goto implementation")
        map("grt", fzf.lsp_typedefs, "type defs")

        map("gO", fzf.lsp_document_symbols, "open document symbols")
        map("gW", fzf.lsp_live_workspace_symbols, "open workspace symbols")
    end,
})

local signs = {
    [vim.diagnostic.severity.ERROR] = "E",
    [vim.diagnostic.severity.WARN] = "W",
    [vim.diagnostic.severity.HINT] = "H",
    [vim.diagnostic.severity.INFO] = "I",
}

-- update diagnostic config function
vim.diagnostic.config({
    signs = { text = signs },
    virtual_text = true,
    underline = true,  -- Always on
    update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
    },
})

vim.lsp.config("lua_ls", {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                version = "LuaJIT",
                path = { "lua/?.lua", "lua/?/init.lua" },
            },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
            },
        })
    end,
})

vim.lsp.enable({
    "lua_ls",
    "basedpyright",
    "ruff",
})
