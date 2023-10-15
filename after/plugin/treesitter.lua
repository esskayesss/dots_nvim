require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust", "bash", "cmake", "cpp", "git_config", "git_rebase", "go", "gomod", "gosum", "html", "htmldjango", "javascript", "json", "java", "latex", "markdown_inline", "perl", "python", "r", "toml", "tsx", "vue", "xml", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
