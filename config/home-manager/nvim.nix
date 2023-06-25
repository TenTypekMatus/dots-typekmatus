{config, pkgs, lib, ...}:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      tabby-nvim
      ultisnips
    vim-snippets
      nord-nvim
      ale
      lightline-vim
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
      noice-nvim
      nvim-whichkey-setup-lua
      nvim-lspconfig
      vim-startify
      coc-snippets
      vim-airline-themes
#      barbar-nvim
      wilder-nvim
      supertab
    ];
    extraConfig = ''
      set encoding=utf-8
      set nobackup
      set nowritebackup
      set nowildmenu
      set updatetime=300
      call wilder#setup({'modes': [':', '/', '?']})
      call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))
      let g:deoplete#enable_at_startup = 1
      set signcolumn=yes
      let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }
      set noshowmode
      " returns all modified files of the current git repo
      " `2>/dev/null` makes the command fail quietly, so that when we are not
      " in a git repo, the list will be empty
      function! s:gitModified()
      let files = systemlist('git ls-files -m 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
      endfunction

      " same as above, but show untracked files, honouring .gitignore
      function! s:gitUntracked()
      let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
      return map(files, "{'line': v:val, 'path': v:val}")
      endfunction

      let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
      set mouse=a
      set number
      colorscheme nord
      set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
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
