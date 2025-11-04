return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<Leader>e"] = { "<cmd>Oil<cr>", desc = "Open Oil" },
        },
      },
    },
  },
}
