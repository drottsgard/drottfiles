print('loaded eslint tool')
local namespace = vim.api.nvim_create_namespace("typescript-is-silly")
local buffer = vim.api.nvim_get_current_buf()

-- nnoremap <leader>f mF:%!eslint_d --cache --stdin --fix-to-stdout --stdin-filename %<CR>`F
local function run_eslint()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local old_makeprg = vim.bo.makeprg
  local old_errorformat = vim.bo.errorformat

  vim.bo.makeprg = "eslint_d --format compact --fix --cache"
  vim.bo.errorformat = "%f: line %l\\, col %c\\, %m,%-G%.%#"

  vim.cmd("silent! make %")

  local qflist = vim.fn.getqflist()
  local diagnostics = vim.diagnostic.fromqflist(qflist)

  vim.api.nvim_buf_clear_namespace(buffer, namespace, 0, -1)
  vim.diagnostic.set(namespace, buffer, diagnostics)

  vim.bo.makeprg = old_makeprg
  vim.bo.errorformat = old_errorformat
  vim.api.nvim_win_set_cursor(0, cursor)
end

return {
  run_eslint = run_eslint
}
