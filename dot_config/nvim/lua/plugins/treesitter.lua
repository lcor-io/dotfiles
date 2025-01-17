-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      -- add more arguments for adding more treesitter parsers
      "html",
      "python",
      "css",
      "scss",
      "javascript",
      "lua",
      "go",
      "typescript",
      "tsx",
      "svelte",
      "dockerfile",
      "astro",
      "prisma",
      "templ",
      "sql",
      "markdown",
      "gleam",
      "dart",
      "haskell",
    },
  },
}
