-- Harpoon 2: pin files and jump between them instantly
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>a", desc = "Harpoon add file" },
    { "<C-e>", desc = "Harpoon menu" },
    { "<leader>1", desc = "Harpoon file 1" },
    { "<leader>2", desc = "Harpoon file 2" },
    { "<leader>3", desc = "Harpoon file 3" },
    { "<leader>4", desc = "Harpoon file 4" },
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
      { desc = "Harpoon add file" })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon menu" })

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end,
      { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end,
      { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end,
      { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end,
      { desc = "Harpoon file 4" })
  end,
}
