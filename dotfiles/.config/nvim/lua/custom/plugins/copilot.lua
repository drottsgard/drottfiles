-- return {
--   "zbirenbaum/copilot.lua",
--   cmd = "Copilot",
--   event = "InsertEnter",
--   config = function()
--     require("copilot").setup({
--       suggestion = {
--         auto_trigger = false,
--       }
--     })
--   end,
-- }

return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true -- disable default <Tab>
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    vim.g.copilot_filetypes = {
      markdown = true,
      gitcommit = true,
    }

    -- vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true, noremap = true })
    -- vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Next()', { silent = true, expr = true, noremap = true })
    -- vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Previous()', { silent = true, expr = true, noremap = true })
    -- vim.api.nvim_set_keymap("i", "<C-]>", 'copilot#Dismiss()', { silent = true, expr = true, noremap = true })

    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true, noremap = true })
    -- add key binds with meta for next and previous suggestion
    vim.api.nvim_set_keymap("i", "<M-j>", 'copilot#Next()', { silent = true, expr = true, noremap = true })
    vim.api.nvim_set_keymap("i", "<M-k>", 'copilot#Previous()', { silent = true, expr = true, noremap = true })

    -- accept next word of suggestion
    vim.api.nvim_set_keymap("i", "<C-Right>", "<Plug>(copilot-accept-word)", { silent = true })

    vim.api.nvim_set_keymap("i", "<C-]>", 'copilot#Dismiss()', { silent = true, expr = true, noremap = true })
  end,
}
