-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  -- enough pkgs need this anyway
  { "nvim-tree/nvim-web-devicons" },

  -- nim lsp / etc
  { "alaviss/nim.nvim" },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      local nt = require "neo-tree"
      nt.setup {
        window = {
          mappings = {
            ["`"] = function()
              vim.cmd [[Neotree close]]
            end,
          },
        },
      }
    end,
  },

  {
    "pappasam/nvim-repl",
    init = function()
      vim.g["repl_filetype_commands"] = {
        javascript = "node",
        python = "ipython --no-autoindent",
        nim = "inim --noAutoIndent",
      }
    end,
    keys = {
      { "<leader>rt", "<cmd>ReplToggle<cr>", desc = "Toggle nvim-repl" },
      { "<leader>rc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl run cell" },
    },
  },
  ---- qol stuff
  -- line number previews with :1234 while typing

  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },

  -- dim unused variables
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
      require("neodim").setup { alpha = 0.5 }
    end,
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  },

  -- little minimap with dots :)
  -- this requires https://github.com/wfxr/code-minimap to be installed locally
  -- { 'wfxr/minimap.vim' },

  -- magic folding using left/right arrow keys at beginning of line.
  {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost", -- later or on keypress would prevent saving folds
    opts = {
      setupFoldKeymaps = false,
    },
    config = function()
      local ori = require "origami"
      vim.keymap.set("n", "<Left>", function()
        ori.h()
      end)
      vim.keymap.set("n", "<Right>", function()
        ori.l()
      end)
    end,
  },

  -- nicer ui:
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  ---- extra git stuffs
  -- inline git blame
  { "f-person/git-blame.nvim" },
  -- PR stuff
  {
    -- see docs page at the below github. all commands start with :Octo
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
  },
  -- <leader>gy to copy github share link
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  },
  -- git log + git show w/ side-by-side diffs
  { "sindrets/diffview.nvim" },

  -- just some themes 💖
  { "jaredgorski/spacecamp" },
  { "romgrk/doom-one.vim" },
  { "miikanissi/modus-themes.nvim" },
  {
    "maxmx03/fluoromachine.nvim",
    config = function()
      local fm = require "fluoromachine"
      fm.setup { glow = false, brightness = 0.25, theme = "retrowave" }
    end,
  },
  { "rebelot/kanagawa.nvim" },
  { "nvimdev/paradox.vim" },
  { "NTBBloodbath/sweetie.nvim" },

  -- sigh
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
}

-- local function initial_setup()
--   require("nvim-tree.api").tree.open()
-- end
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = initial_setup })

-- not using this plugin rn, commenting out these lines
-- vim.g.minimap_auto_start = 1
-- vim.g.minimap_auto_start_win_enter = 1
-- vim.g.minimap_width = 10
-- vim.g.minimap_git_colors = 1

lvim.colorscheme = "sweetie"
-- lvim.colorscheme = "fluoromachine"

vim.keymap.set("n", "<leader>]", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>[", "<cmd>bprev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Left>", "<cmd>bprev<cr>", { desc = "Previous buffer" })

-- this is also available as `gl` in lunarvim, but i like <Leader>E better
vim.keymap.set("n", "<leader>E", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Show Error Details" })

-- vim.opt.foldmethod = "foldexpr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

local components = require "lvim.core.lualine.components"
local llsect = lvim.builtin.lualine.sections
llsect.lualine_a = {
  components.mode, -- this is just a colored icon
  "mode", -- this is the actual name, INSERT/COMMAND/VISUAL/NORMAL etc
  "hostname",
}

llsect.lualine_c = {
  components.filename,
  components.encoding,
  components.diff,
}
llsect.lualine_x = {
  components.diagnostics,
  components.treesitter,
  components.lsp,
  components.spaces,
  components.filetype,
}

local blopts = lvim.builtin.bufferline.options
blopts.separator_style = "slope"

lvim.builtin.telescope.pickers.layout_strategy = "horizontal"
lvim.builtin.telescope.pickers.layout_config = {
  horizontal = {
    height = 0.8,
    width = 0.8,
    prompt_position = "top",
    preview_width = 0.5,
  },
}

-- vim.keymap.del('n', '<leader>e');
-- lvim.keys.normal_mode["`"] = ':Neotree left source filesystem<cr>';
local findopts = {
  -- preview = true,
  -- hidden = false,
  -- layout_strategy = "horizontal",
  -- layout_config = { width = 0.9, height = 0.9, prompt_position = "top"  }
}

lvim.builtin.telescope.defaults.preview = true
lvim.builtin.telescope.defaults.hidden = false
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config = { width = 0.9, height = 0.9, prompt_position = "top" }
-- this becomes <leader><leader>. all of these are run by double-tapping space
-- this is ruby's personal quick shortcuts
local tbs = require "telescope.builtin"
lvim.builtin.which_key.mappings["<leader>"] = {
  name = "make go quick pls",
  ["`"] = { "<cmd>Neotree float filesystem<cr>", "files" },
  ["]"] = { "<cmd>bnext<cr>", "next buf" },
  ["["] = { "<cmd>bprev<cr>", "prev buf" },
  F = { "<cmd>Telescope find_files<cr>", "find" },
  g = { "<cmd>Telescope live_grep<cr>", "grep" },
  b = { "<cmd>Telescope buffers<cr>", "buffers" },
  a = { "<cmd>Telescope git_branches<cr>", "git branches" },
  T = { "<cmd>Telescope git_status<cr>", "git status" },
  h = { "<cmd>Telescope git_stash<cr>", "git stash" },
  e = { "<cmd>Telescope diagnostics<cr>", "diagnostics" },
  i = { "<cmd>Telescope lsp_implementations<cr>", "implementations" },
  d = { "<cmd>Telescope lsp_definitions<cr>", "defs" },
  t = { "<cmd>Telescope lsp_type_definitions<cr>", "typedefs" },
  c = { "<cmd>Telescope git_commits<cr>", "git commits" },
  s = { "<cmd>Telescope lsp_document_symbols<cr>", "doc symbols" },
  w = { "<cmd>Telescope lsp_workspace_symbols<cr>", "workspace symbols" },
}
lvim.builtin.which_key.mappings["]"] = { "<cmd>bnext<cr>", "next buf" }
lvim.builtin.which_key.mappings["["] = { "<cmd>bprev<cr>", "prev buf" }
lvim.builtin.which_key.mappings["`"] = { "<cmd>Neotree float filesystem<cr>", "files" }
lvim.builtin.which_key.mappings.f = { "<cmd>Telescope find_files<cr>", "find" }
lvim.builtin.which_key.mappings.e = {}

lvim.keys.normal_mode["`"] = "<cmd>Neotree float filesystem<cr>"
lvim.keys.normal_mode["<tab>"] = "<cmd>Telescope buffers<cr>"

-- not working right now. kinda dont care. kinda might reconfig the welcome/greeter thing instead
-- local function initial_setup()
--   -- tbs.find_files(findopts);
--   vim.cmd "Telescope find_files"
-- end
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = initial_setup })

lvim.builtin.alpha.active = false

lvim.format_on_save.enabled = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "nimpretty" },
  { name = "prettier" },
  { name = "stylua" },
  { name = "clang_format" },
  { name = "codespell" },
  { name = "crystal_format" },
  { name = "djlint" },
  { name = "fish_indent" },
  { name = "mdformat" },
  { name = "rustfmt" },
  { name = "zigfmt" },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { name = "shellcheck" },
  { name = "refactoring" },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "actionlint" },
  { name = "alex" },
  { name = "cfn_lint" },
  { name = "checkmake" },
  { name = "codespell" },
  { name = "djlint" },
  { name = "dotenv_linter" },
  { name = "shellcheck" },
  { name = "tsc" },
  { name = "write_good" },
}

-- local completion = require "lvim.lsp.null-ls.completions"
-- completion.setup {
--   { name = "luasnip" },
-- }
