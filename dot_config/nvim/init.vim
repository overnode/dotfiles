if &compatible
	set nocompatible
endif

" {{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Themes
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'sonph/onehalf', {'rtp': 'vim/'}
"Plug 'morhetz/gruvbox'
"Plug 'haishanh/night-owl.vim'
Plug 'itchyny/lightline.vim'
Plug 'kaicataldo/material.vim'

Plug 'taohexxx/lightline-buffer'
Plug 'ryanoasis/vim-devicons'

" Tag autoclose
Plug 'AndrewRadev/tagalong.vim'

" Rainbow parantheses
Plug 'luochen1990/rainbow'

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" NERDTree file icon
Plug 'ryanoasis/vim-devicons'

Plug 'luochen1990/rainbow'

Plug 'Shougo/deol.nvim'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
Plug 'sbdchd/neoformat'
Plug 'vimwiki/vimwiki'

Plug 'elzr/vim-json'
Plug 'Shougo/echodoc.vim'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'mattn/emmet-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'roxma/nvim-yarp'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'bkad/CamelCaseMotion'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }


call plug#end()
" }}}

" {{{ Settings
set list listchars=tab:»·,trail:·,nbsp:·
set clipboard+=unnamed
set foldmethod=marker
set cursorline
set rnu
set showtabline=2
set splitbelow
set shortmess+=c
set splitright
set confirm
set undofile
set ignorecase
set smartcase
set inccommand = "split"
set termguicolors
set laststatus=2
set nu
set noshowmode
"set cmdheight=2
set hidden
set completeopt=noinsert,menuone,noselect
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set updatetime=300
set signcolumn=yes

filetype plugin indent on
syntax on

let mapleader="\<Space>"
let g:python3_host_prog = '/usr/bin/python3'

set background=dark
colorscheme material

let g:rainbow_active = 1

let g:vim_json_syntax_conceal = 0
" }}}

" {{{ Mappings
map <leader>re :execute "edit " . $MYVIMRC<CR>
map <leader>rs :so ~/.config/nvim/init.vim<CR>

nmap <Esc> <Esc>:nohlsearch<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>l :BLines<CR>
nmap <c-p> :Files<CR>

nmap <F8> :NERDTreeToggle<cr>
nmap <c-n> :NERDTreeToggle<cr>

nnoremap <leader>pr :PrettierAsync<CR>
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

nnoremap <leader>bc :bdelete<CR>

nnoremap <Tab> <C-W><Left>

let g:user_emmet_leader_key = '<C-y>'

" FZF :Find
if executable('rg')
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!node_modules/" --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
end
"}}}

" {{{ NERDTree
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = '﵂'
" }}}

" {{{ Filetypes 
autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
autocmd FileType typescript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
autocmd FileType vue set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
" }}}

" {{{ Deol
nnoremap <leader>@ :Deol<CR>
tnoremap <ESC> <C-\><C-n>
" }}}

" {{{ CoC
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"}}}

" {{{ Lightline 

nnoremap <C-Left> :bprev<CR>
nnoremap <C-Right> :bnext<CR>

let g:lightline = {
        \ 'enable': {
            \ 'statusline': 1,
            \ 'tabline': 1
        \ },
        \ 'colorscheme': 'dracula',
    \ }

let g:lightline.active = {
   \ 'left': [ [ 'mode', 'paste' ],
   \           [ 'gitbranch', 'readonly', 'relativepath', 'modified'] ],
   \ 'right': [ [ 'neomake' ],
   \            [ 'lineinfo' ],
   \            [ 'percent' ],
   \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
let g:lightline.inactive = {
   \ 'left': [ [ 'filename' ] ],
   \ 'right': [ [ 'lineinfo' ],
   \            [ 'percent' ] ] }
let g:lightline.tabline = {
   \ 'left': [ [ 'bufferinfo' ], ['seperator'],
   \           ['bufferbefore', 'buffercurrent', 'bufferafter' ],],
   \ 'right': [ [ 'close' ] ] }

let g:lightline.tab = {
    \ 'active': [ 'tabnum', 'filename', 'modified' ],
    \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

let g:lightline.component_expand = {
    \   'buffercurrent': 'lightline#buffer#buffercurrent',
    \   'bufferbefore': 'lightline#buffer#bufferbefore',
    \   'bufferafter': 'lightline#buffer#bufferafter',
    \   'neomake': 'LightlineNeomake',
    \ }
let g:lightline.component_type = {
    \   'buffercurrent': 'tabsel',
    \   'bufferbefore': 'raw',
    \   'bufferafter': 'raw',
    \   'neomake': 'error',
    \ }
let g:lightline.component_function = {
    \   'bufferinfo': 'lightline#buffer#bufferinfo',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \   'gitbranch': 'fugitive#head'
    \ }
let g:lightline.component = {
    \   'separator': '',
    \ }

let g:lightline.colorscheme='onehalfdark'

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" enable devicons, only support utf-8
" require <https://github.com/ryanoasis/vim-devicons>
let g:lightline_buffer_enable_devicons = 1

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1

" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'

" hide buffer list
let g:lightline_buffer_excludes = ['vimfiler']

" max file name length
let g:lightline_buffer_maxflen = 30

" max file extension length
let g:lightline_buffer_maxfextlen = 3

" min file name length
let g:lightline_buffer_minflen = 16

" min file extension length
let g:lightline_buffer_minfextlen = 3

" reserve length for other component (e.g. info, close)
let g:lightline_buffer_reservelen = 20
" }}}

" {{{ Echdoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" }}}
