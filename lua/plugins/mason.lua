return {
  "mason-org/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- Then, setup mason-tool-installer.nvim
    require("mason-tool-installer").setup({
      ensure_installed = {
        "lua-language-server",
      },
      auto_update = false,
      run_mason_update_on_startup = true,
    })
  end,
}
