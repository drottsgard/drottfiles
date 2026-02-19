return {
  "dmmulroy/tsc.nvim",
  config = function()
    require("tsc").setup({
      run_as_monorepo = true,
    })
  end,
}
