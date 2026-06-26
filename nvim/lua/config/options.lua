local opt = vim.opt

opt.termguicolors = true

opt.number = true          -- Ativa número na linha atual
opt.relativenumber = true  -- Numeração relativa para ajudar na navegação rápida
opt.cursorline = true      -- Linha do cursor destacada

opt.expandtab = true       -- Transforma Tab em espaços reais
opt.shiftwidth = 4         -- Tamanho da indentação (4 espaços)
opt.tabstop = 4            -- Espaço do Tab visual
opt.smartindent = true     -- Autoindentação inteligente para novas chaves/blocos

opt.showmatch = true       -- Pisca o delimitador correspondente ((), {}, [])
