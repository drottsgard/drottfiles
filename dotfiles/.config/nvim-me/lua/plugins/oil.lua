-- File explorer: edit your filesystem like a buffer
return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {
    columns = { "icon" },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
}
