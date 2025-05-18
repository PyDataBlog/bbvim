---@class vim.lsp.Config
return {
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose" },
	root_makers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
	single_file_support = true,
}
