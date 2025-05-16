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

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- language servers----
        "lua-language-server",
        "basedpyright",
        "ruff",

      },
      auto_update = false,
      run_mason_update_on_startup = true,
    })
  end,
}
