"" vim-lsp

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Highlight references to the symbol under the cursor
let g:lsp_highlight_references_enabled = 1

" enable signals and echo under cursor when in normal mode
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('/tmp/vim-lsp.log')
" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('/tmp/vim-asyncomplete.log')

" specify alternative root markers
let g:lsp_settings_root_markers = ['.projections.json', '.git', '.git/', '.svn', '.hg', '.bzr']

" use ccls as default c/c++ server
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
   autocmd FileType c nmap <buffer> gd <plug>(lsp-definition)
   autocmd FileType c nmap <buffer> gr <plug>(lsp-references)
endif

if executable('gopls')
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-lang',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ 'workspace_config': {'gopls': {
        \     'staticcheck': v:true,
        \     'completeUnimported': v:true,
        \     'caseSensitiveCompletion': v:true,
        \     'usePlaceholders': v:true,
        \     'completionDocumentation': v:true,
        \     'watchFileChanges': v:true,
        \     'hoverKind': 'SingleLine',
        \   }},
        \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
    autocmd FileType go nmap <buffer> gr <plug>(lsp-references)
    " autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
    " autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
  augroup END
endif
