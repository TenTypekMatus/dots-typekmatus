{config, pkgs, lib, ...}:

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      neocomplete-vim
      vim-fugitive
      ultisnips
      vim-snippets
      nord-vim
      ale
      vim-lsp-ale
      vim-lsp
      vim-lsp-ultisnips
      vim-startify
      vim-devicons
      ansible-vim
      supertab
      vim-autoformat
      YouCompleteMe
      nerdtree-git-plugin
      nerdtree
      vim-nix
    ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
      set number
      colorscheme nord
      let g:airline#extensions#tabline#enabled = 1
      let g:SuperTabDefaultCompletionType = "<Tab>"
      let g:SuperTabContextDefaultCompletionType = "<Tab>"
      set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
      set shell=sh
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
                     let g:UltiSnipsExpandTrigger="<tab>"
                     let g:UltiSnipsJumpForwardTrigger="<c-b>"
                     let g:UltiSnipsJumpBackwardTrigger="<c-z>"
        set encoding=utf-8
      let g:ycm_language_server =
        \ [
        \   {
        \     'name': 'yaml',
        \     'cmdline': [ 'ansible-lint' ],
        \     'filetypes': [ 'yaml.ansible' ]
        \   },
        \   {
        \     'name': 'rust',
        \     'cmdline': [ 'rust-analyzer' ],
        \     'filetypes': [ 'rust' ],
        \     'project_root_files': [ 'Cargo.toml' ]
        \   }
        \ ]
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
  };
}
