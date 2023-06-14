""""""""""""""""""""""""""""""""
""" Nakrule nvim config file """
""""""""""""""""""""""""""""""""

" Depedency:
" - Install exuberant-ctags (sudo apt install exuberant-ctags) for vim-tagbar plugin
" - fd and fzf for telescope (search)

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Nice start page when starting VIM without a file
Plug 'mhinz/vim-startify'

" Fuzzy finder with live preview.
" Other plugins are depedencies.
" Need to install 2 things:
" brew install fd
" brew install ripgrep
" Then do :checkhealth telescope to verify the installation.
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'  " required for telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " recommanded

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Jump to any word in the screen
Plug 'ggandor/leap.nvim'

" Auto complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plugin to ease the process to comment/uncomment lines
" Just use gcc to comment a line, or gc in visual mode.
Plug 'tpope/vim-commentary'

" Easily add comment with proper syntax in many languages.
" Just use :Neogen on a function, type, class...
Plug 'danymat/neogen'

" NERDtree and the tab extension to keep nerdtree sync between all tabs.
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Nice status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Show github add/delete in the margin
Plug 'airblade/vim-gitgutter'

" Automatic closing of quotes, parenthesis, brackets, etc.
Plug 'jiangmiao/auto-pairs'

" Use :Git + any git command, like :Git git add *, :Git commit, :Git mergetool...
Plug 'tpope/vim-fugitive'

" Theme
Plug 'morhetz/gruvbox'

" To use tagbar, exuberant-ctags should be installed
" sudo apt install exuberant-ctags
" brew install universal-ctags
Plug 'majutsushi/tagbar' " For tag bar list in the windows

Plug 'psliwka/vim-smoothie' " Super smooth scrooling in VIM with CTRL-U/D

" Go programming language, build, run, error detection, auto complete...
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" File icons in NERD tree
" Need a nerd font installed and used in the terminal
" Download one here: https://github.com/ryanoasis/nerd-fonts/releases/tag/v2.1.0
" I use SourceCodePro usually.
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Use fd as escape
:imap fd <Esc>

" set the backspace to delete normally
set backspace=indent,eol,start

autocmd BufWritePre * %s/\s\+$//e " Remove all white space at the end of each line when saving a file
autocmd BufWritePre * retab    " Replace all tab with spaces
autocmd BufWritePre * set fileformat=unix  " Replace CRLF to LF (windows to linux line ending)

" Colorscheme configuration
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'

set nonumber
set expandtab "use space instead of tab
set shiftwidth=2 "number of space char inserted for identation
set tabstop=2

" map escape key to leave terminal mode
:tnoremap <Esc> <C-\><C-n>

" resize window using 7, 8, 9 and 0 keys
nmap 6 :res +2<CR> " increase pane by 2
nmap 7 :res -2<CR> " decrease pane by 2
nmap 8 :vertical res +2<CR> " vertical increase pane by 2
nmap 9 :vertical res -2<CR> " vertical decrease pane by 2

" relative line number with auto switch to normal in insert mode and without pane focus
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Reduce update to 0.1s (from 4s) so the coc and VIM-gitgutter work better
set updatetime=100

" Auto close netrw when exiting last opened file in neovim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Share the VIM clipboard with the X11 clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard
  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Set ruler at 100 char
set colorcolumn=100

" Set auto line return after 100 char
set tw=100

""""""""""" VIM-Airline configuration
let g:airline_powerline_fonts = 1
" Make airline looks like powerline
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" The following 8 lines place the windows number is the left of vim-airline
function! WindowNumber(...)
  let builder = a:1
  let context = a:2
  call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
  return 0
endfunction
call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')

""""" SPACE mapping

" Switch buffer with SPACE + <number>
nnoremap <space>1 1<C-w>w
nnoremap <space>2 2<C-w>w
nnoremap <space>3 3<C-w>w
nnoremap <space>4 4<C-w>w
nnoremap <space>5 5<C-w>w
nnoremap <space>6 6<C-w>w
nnoremap <space>7 7<C-w>w
nnoremap <space>8 8<C-w>w
nnoremap <space>9 9<C-w>w

" SPACE-f     Open/close file explorer (netrw)
" SPACE-k     Switch between last two active buffer
" SPACE-h/l   Go to next/previous buffer
" SPACE-b     Open a new buffer (tab)
" SPACE-t     Toggle Tagbar
" SPACE-s     Search file (fuzzy)
" SPACE-r     Run go project (same as 'go run file.go')
" SPACE-c     Run Neogen to add comment with the correct syntax
nnoremap <space>f     :NERDTreeTabsToggle<CR>
nnoremap <space>b     :tabnew<CR>
nnoremap <space>b     <Esc>:tabnew<CR>
nnoremap <space>s     :Telescope find_files<CR>
nnoremap <space>r     :GoRun<CR>
nnoremap <space>c     :Neogen<CR>
" move to the previous/next tabpage.
nnoremap <space>h gT
nnoremap <space>l gt
" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <space>k :exe "tabn ".g:lasttab<cr>
" Toggle tagbar
nnoremap <space>t :TagbarToggle<CR>



""""""" Tagbar configuration

" Remape Tagbar show prototype to o (default is space, but it fuck up SPACE + number)
let g:tagbar_map_showproto = "o"

""""""" Netrw (file browser) configuration

" Remove banner
let g:netrw_banner = 0
" Configre netrw like default nerdtree
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

""""""" Coc configuration

" This is just a copy of the example in https://github.com/neoclide/coc.nvim. Following standard
" recommandation.

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Add `:Format` command to format current buffer. (Like gg=G but better)
command! -nargs=0 Format :call CocAction('format')

""""""" Treesiter configuration from there Github documentation.
" Without that, treesitter is not enabled by default.
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    },
  ensure_installed = { "norg", --[[ other parsers you would wish to have ]] },
  }
EOF

" neogen config
lua <<EOF
require('neogen').setup {
        enabled = true,             --if you want to disable Neogen
        input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
}
EOF


""""""" Leap configuration
" To jump to an on-screen word, just use s (forward) or S (backward) and write the word.
lua <<EOF
require'leap'.set_default_keymaps()
EOF
