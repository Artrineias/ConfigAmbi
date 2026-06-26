return {
  -- GERENCIADOR DE ARQUIVOS (NvimTree na lateral)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { group_empty = true },
      })
      -- Teclas de atalho: Aperte Ctrl + n para Abrir/Fechar a barra lateral
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  },

  -- ABAS DE ARQUIVOS ABERTOS (Bufferline)
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = "slant",
          diagnostics = "nvim_lsp", -- Mostra erros diretamente na aba
          show_buffer_close_icons = true,
        }
      })
    end,
  },

   -- 3. DESTAQUE DE SINTAXE AVANÇADO (Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "php", "java", "python", "javascript", "html", "css", "lua" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

-- FECHAMENTO AUTOMÁTICO DE DELIMITADORES
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- INDICADORES VISUAIS DE ESCOPO (Linhas verticais de indentação)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        scope = { enabled = true }, -- Ilumina a linha vertical do bloco atual
      })
    end,
  },

-- 6. AMBIENTE INTELLISENSE & AUTOCOMPLETE (Mason e LSPConfig - Atualizado)
  {
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "intelephense", "jdtls", "pyright", "ts_ls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      -- O motor de autocomplete continua igual

    local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args) require('luasnip').lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        })
      })

      -- NOVA API DE INICIALIZAÇÃO DE SERVIDORES (Substitui o código obsoleto)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local servers = { "intelephense", "jdtls", "pyright", "ts_ls" }
      
      for _, lsp in ipairs(servers) do
        -- Adiciona as capacidades de autocomplete diretamente no motor nativo
        vim.lsp.config[lsp] = { capabilities = capabilities }
        -- Habilita a inteligência de código do servidor
        vim.lsp.enable(lsp)
      end
    end,
  },
}

