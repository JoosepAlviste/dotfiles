-- https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8

-- This code seems weird, but it hints the LSP server to merge the required
-- packages in the vim global variable
vim = require 'vim.shared'
vim = require 'vim.uri'
vim = require 'vim.inspect'

-- Let Sumneko know where the sources are for the global vim runtime
vim.lsp = require 'vim.lsp'
vim.treesitter = require 'vim.treesitter'
vim.highlight = require 'vim.highlight'
