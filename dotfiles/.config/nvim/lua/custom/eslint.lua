local namespace = vim.api.nvim_create_namespace("eslint-diagnostics")

local file_patterns = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  ".eslintrc.json",
  "eslint.config.js",
}

local function invoke(buffer)
  buffer = buffer or vim.api.nvim_get_current_buf()

  local config_files = vim.fs.find(file_patterns, { upward = true })

  -- I don't want to run eslint if the current project does not have a configuration for it.
  if #config_files == 0 then
    return
  end

  vim.cmd.compiler("eslint")
  vim.bo[buffer].makeprg = "./node_modules/.bin/eslint_d --format compact"

  -- Run eslint on the current file
  vim.cmd("make! %")

  local qflist = vim.fn.getqflist()
  local diagnostics = vim.diagnostic.fromqflist(qflist)

  vim.diagnostic.reset(namespace, buffer)
  vim.diagnostic.set(namespace, buffer, diagnostics)
end

local function on_save(buffer)
  buffer = buffer or vim.api.nvim_get_current_buf()

  return vim.api.nvim_create_autocmd("BufWritePost", {
    buffer = buffer,
    group = vim.api.nvim_create_augroup("eslint-on-save", { clear = true }),
    callback = function()
      invoke(buffer)
    end,
  })
end


return {
  namespace = namespace,
  invoke = invoke,
  on_save = on_save,
}
