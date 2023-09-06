-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.relativenumber = true
lvim.format_on_save = true
lvim.transparent_window = true

vim.keymap.set("n", "ç", ":")
vim.keymap.set("n", "Ç", ":")

vim.keymap.set("n", "<tab>", ":bn<CR>")
vim.keymap.set("n", "<S-tab>", ":bp<CR>")


lvim.plugins = {
  {
    "tpope/vim-surround",
  },
  {
    "lexrupy/doom-one.nvim",
  }

}

-- lvim.colorscheme = "tokyonight"
lvim.colorscheme = "doom-one"
-- Kill trailings whitespaces
lvim.autocommands = {
  {
    "BufWritePre",
    {
      pattern = { "*.py", "*.lua" },
      command = ":%s/\\s\\+$//e",
    }
  },
  {
    "InsertLeave",
    {
      callback = function()
        local _, _, caps_state = vim.fn.system("xset -q"):find("00: Caps Lock:%s+(%a+)")
        if caps_state == "on" then
          vim.fn.system("xdotool key Caps_Lock")
        end
      end,
    }
  },
}


local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" },
  {
    name = "shellcheck",
    args = { "--severity", "warning" },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "proselint",
  },
}
