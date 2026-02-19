---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt", lsp_format = "fallback" },
      -- Run eslint_d to fix lint errors, then prettier for formatting
      javascript = function(bufnr)
        return { "eslint_d", first(bufnr, "prettierd", "prettier") }
      end,
      typescript = function(bufnr)
        return { "eslint_d", first(bufnr, "prettierd", "prettier") }
      end,
      javascriptreact = function(bufnr)
        return { "eslint_d", first(bufnr, "prettierd", "prettier") }
      end,
      typescriptreact = function(bufnr)
        return { "eslint_d", first(bufnr, "prettierd", "prettier") }
      end,

      markdown = { "prettierd", "prettier", stop_after_first = true },
    },
    format_after_save = {
      lsp_format = "fallback",
    },
  },
}
