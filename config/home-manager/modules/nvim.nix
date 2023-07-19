{config, pkgs, lib, ...}:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      ultisnips
      vim-snippets
      nord-nvim
      ale
      vim-devicons
      ansible-vim
      vim-autoformat
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      nerdtree-git-plugin
      nerdtree
      nvim-web-devicons
      vim-nix
      deoplete-nvim
      supertab
      dashboard-nvim
      noice-nvim
      nvim-whichkey-setup-lua
      nvim-lspconfig
      vim-airline-themes
      telescope-nvim
      tabby-nvim
      lspkind-nvim
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-nvim-lsp
      cmp-nvim-ultisnips
      lualine-nvim
    ];
    extraConfig = ''
      set encoding=utf-8
      set nobackup
      set nowritebackup
      set nowildmenu
      set updatetime=300
      let g:barbar_auto_setup = v:true
      set signcolumn=yes
      lua <<EOF
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
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      })
      EOF
      lua <<EOF
      vim.o.showtabline = 2
      local theme = {
      fill = 'TabLineFill',
      -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
      head = 'TabLine',
      current_tab = 'TabLineSel',
      tab = 'TabLine',
      win = 'TabLine',
      tail = 'TabLine',
      }
      require('tabby.tabline').set(function(line)
      return {
      {
      { '  ', hl = theme.head },
      line.sep('', theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep('', hl, theme.fill),
        tab.is_current() and '' or '󰆣',
        tab.number(),
        tab.name(),
        tab.close_btn(''),
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
      return {
        line.sep('', theme.win, theme.fill),
        win.is_current() and '' or '',
        win.buf_name(),
        line.sep('', theme.win, theme.fill),
        hl = theme.win,
        margin = ' ',
      }
      end),
      {
      line.sep('', theme.tail, theme.fill),
      { '  ', hl = theme.tail },
      },
      hl = theme.fill,
      }
      end)
      EOF
      lua <<EOF
      require("dashboard").setup({
      theme = 'hyper',
      config = {
      week_header = {
       enable = true,
      },
      shortcut = {
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' Projects',
          group = 'DiagnosticHint',
          action = 'Telescope ~/proj',
          key = 'a',
        },
        {
          desc = ' dotfiles',
          group = 'Number',
          action = 'Telescope dotfiles',
          key = 'd',
        },
      },
      },
      })
      EOF
      lua <<EOF
      local cmp = require'cmp'
      local lspkind = require'lspkind'

      cmp.setup({
      snippet = {
      expand = function(args)
      -- For `ultisnips` user.
      vim.fn["UltiSnips#Anon"](args.body)
      end,
      },
      mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Esc>'] = cmp.mapping.close(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
        }),
      sources = {
      { name = 'nvim_lsp' }, -- For nvim-lsp
      { name = 'ultisnips' }, -- For ultisnips user.
      { name = 'nvim_lua' }, -- for nvim lua function
      { name = 'path' }, -- for path completion
      { name = 'buffer', keyword_length = 4 }, -- for buffer word completion
      { name = 'omni' },
      { name = 'emoji', insert = true, } -- emoji completion
      },
      completion = {
      keyword_length = 1,
      completeopt = "menu,noselect"
      },
      view = {
      entries = 'custom',
      },
      formatting = {
      format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        nvim_lsp = "[LSP]",
        ultisnips = "[US]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        buffer = "[Buffer]",
        emoji = "[Emoji]",
          omni = "[Omni]",
      }),
      }),
      },
      })
      EOF
      lua require'lspconfig'.vls.setup{}
      lua require("lualine").setup()
      set noshowmode
      set mouse=a
      set number
      colorscheme nord
      set shell=sh
      set encoding=utf-8
      nnoremap <leader>nt :tabnew<CR>
      nnoremap <leader>tn :tabnext<CR>
      nnoremap <leader>tc :tabclose<CR>
      nnoremap <leader>ff :NERDTreeToggle<CR>
      let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ 'Modified'  :'✹',
      \ 'Staged'    :'✚',
      \ 'Untracked' :'✭',
      \ 'Renamed'   :'➜',
      \ 'Unmerged'  :'═',
      \ 'Deleted'   :'✖',
      \ 'Dirty'     :'✗',
      \ 'Ignored'   :'☒',
      \ 'Clean'     :'✔︎',
      \ 'Unknown'   :'?',
      \ }
    '';
    viAlias = true;
    vimAlias = true;
  };
}
