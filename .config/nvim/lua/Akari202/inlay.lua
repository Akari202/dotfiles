local ih = require 'inlay-hints'
local lspconfig = require 'lspconfig'

-- lspconfig.sumneko_lua.setup {
--     on_attach = function(c, b)
--         ih.on_attach(c, b)
--     end,
--     settings = {
--         Lua = {
--             hint = {
--                 enable = true
--             },
--             diagnostics = {
--                 globals = {
--                     'vim',
--                     'packer_plugins'
--                 }
--             }
--         }
--     }
-- }

require 'rust-tools'.setup {
    tools = {
        on_initialized = function()
            ih.set_all()
        end,
        inlay_hints = {
            auto = false
        }
    },
    server = {
        on_attach = function(c, b)
            ih.on_attach(c, b)
        end
    }
}

-- lspconfig.tsserver.setup {
--     on_attach = function(c, b)
--         ih.on_attach(c, b)
--     end,
--     settings = {
--         javascript = {
--             inlayHints = {
--                 includeInlayEnumMemberValueHints = true,
--                 includeInlayFunctionLikeReturnTypeHints = true,
--                 includeInlayFunctionParameterTypeHints = true,
--                 includeInlayParameterNameHints = 'all',
--                 includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--                 includeInlayPropertyDeclarationTypeHints = true,
--                 includeInlayVariableTypeHints = true
--             }
--         },
--         typescript = {
--             inlayHints = {
--                 includeInlayEnumMemberValueHints = true,
--                 includeInlayFunctionLikeReturnTypeHints = true,
--                 includeInlayFunctionParameterTypeHints = true,
--                 includeInlayParameterNameHints = 'all',
--                 includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--                 includeInlayPropertyDeclarationTypeHints = true,
--                 includeInlayVariableTypeHints = true
--             }
--         }
--     }
-- }
--
-- lspconfig.gopls.setup {
--     on_attach = function(c, b)
--         ih.on_attach(c, b)
--     end,
--     settings = {
--         gopls = {
--             hints = {
--                 assignVariableTypes = true,
--                 compositeLiteralFields = true,
--                 compositeLiteralTypes = true,
--                 constantValues = true,
--                 functionTypeParameters = true,
--                 parameterNames = true,
--                 rangeVariableTypes = true
--             }
--         }
--     }
-- }
