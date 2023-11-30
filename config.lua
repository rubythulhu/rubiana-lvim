-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  -- enough pkgs need this anyway
  { 'nvim-tree/nvim-web-devicons' },

  -- nim lsp / etc 
  { "alaviss/nim.nvim" },

  ---- qol stuff 
  -- line number previews with :1234 while typing
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end
  },

  -- dim unused variables
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
      require("neodim").setup({ alpha = 0.5 })
    end
  },

  -- little minimap with dots :)
  -- this requires https://github.com/wfxr/code-minimap to be installed locally
  -- { 'wfxr/minimap.vim' },

  -- buffer selector window
  {
    'matbme/JABS.nvim',
    config = function()
      require('jabs').setup()
      vim.keymap.set('n', '<leader>bv', '<cmd>JABSOpen<cr>', { desc = 'Buffer Picker' })
    end
  },

  -- magic folding using left/right arrow keys at beginning of line.
  {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost", -- later or on keypress would prevent saving folds
    opts = {
      setupFoldKeymaps = false
    },
    config = function()
      local ori = require("origami")
      vim.keymap.set('n', '<Left>', function() ori.h() end)
      vim.keymap.set('n', '<Right>', function() ori.l() end)
    end
  },

  -- symbol tree explorer. needs a slightly better config, its too noisy as-is imo
  {
    'hedyhli/outline.nvim',
    config = function()
      require("outline").setup({ })
      vim.keymap.set('n', '<leader>o', '<cmd>Outline<cr>', { desc = 'Outline' })
    end
  },

  -- nicer ui:
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
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
      })
    end
  },

  ---- extra git stuffs
  -- inline git blame 
  { 'f-person/git-blame.nvim' },
  -- PR stuff
  {
    -- see docs page at the below github. all commands start with :Octo 
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  },
  -- <leader>gy to copy github share link
  {
    'ruifm/gitlinker.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() 
      require("gitlinker").setup()
    end
  },
  -- git log + git show w/ side-by-side diffs
  { 'sindrets/diffview.nvim' },

  -- just some themes 💖
  { "jaredgorski/spacecamp" },
  { "romgrk/doom-one.vim" },
  { "miikanissi/modus-themes.nvim" },
  {
    "maxmx03/fluoromachine.nvim",
    config = function ()
      local fm = require 'fluoromachine'
      fm.setup { glow = false, brightness = 0.25, theme = 'retrowave' }
    end
  },
  { "rebelot/kanagawa.nvim" },
  { "nvimdev/paradox.vim" },
  { "NTBBloodbath/sweetie.nvim" },
}

local function initial_setup()
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = initial_setup })

-- not using this plugin rn, commenting out these lines
-- vim.g.minimap_auto_start = 1
-- vim.g.minimap_auto_start_win_enter = 1
-- vim.g.minimap_width = 10
-- vim.g.minimap_git_colors = 1

lvim.colorscheme = "sweetie"
-- lvim.colorscheme = "fluoromachine"

vim.keymap.set('n', '<leader>]', '<cmd>bnext<cr>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>[', '<cmd>bprev<cr>', { desc = "Previous buffer" })
vim.keymap.set('n', '<S-Right>', '<cmd>bnext<cr>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-Left>', '<cmd>bprev<cr>', { desc = "Previous buffer" })

-- this is also available as `gl` in lunarvim, but i like <Leader>E better
vim.keymap.set('n', '<leader>E', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = "Show Error Details" })
