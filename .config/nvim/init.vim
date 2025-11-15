call plug#begin()
" Plugins

Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'Yggdroot/indentLine'
Plug 'psliwka/vim-smoothie'
Plug 'elkowar/yuck.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovimhaskell/haskell-vim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'ap/vim-css-color'
Plug 'LnL7/vim-nix'
Plug 'lambdalisue/suda.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'timtro/glslView-nvim'
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-surround'
Plug 'suan/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug '3rd/image.nvim'
Plug 'lervag/vimtex'
Plug 'honza/vim-snippets'
Plug 'OmniSharp/omnisharp-vim'
Plug 'nyoom-engineering/oxocarbon.nvim'
Plug 'udalov/kotlin-vim'

"Neo tree
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'

"Remote
Plug 'amitds1997/remote-nvim.nvim'
"Deps
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" Config vars
set updatetime=300
set nu
set fillchars=vert:\┃
set mouse=a
set termguicolors

let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:NERDTreeWinSize = 35
let g:airline_powerline_fonts = 2
let g:airline_left_sep = "\uE0B4"
let g:airline_left_alt_sep = "\uE0B5"
let g:airline_right_sep = "\uE0B6"
let g:airline_right_alt_sep = "\uE0B7"
let g:airline_theme = 'behelit'
let g:haskell_indent_if = 0
let g:coc_max_treeview_width = 20
let g:coc_borderchars = ['─', '│', '─', '│', '╭', '╮', '╯', '╰']

let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\big', '\big'],
  \]

let g:neo_tree_remove_legacy_commands = 1

let mapleader = ";"

let g:instant_markdown_theme = 'dark'

let g:OmniSharp_server_path = "OmniSharp"

syntax on
filetype plugin indent on
set shiftwidth=4
set expandtab
set splitbelow

set guicursor=n-v-c:block,i-ci-ve:hor20,r-cr:ver25,o:hor50
            \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175

" colorscheme oxocarbon
" Neotree

lua << EOF
--[[require("catppuccin").setup {
    dim_inactive = {
        enabled = true,
        shade = "dark",
    },
    custom_highlights = function(colors)
        return {
            VertSplit = { bg = "#181825", fg = "#181825" }
        }
    end,
    integrations = {
        neotree = true,
        barbar = true,
    }
} ]]--

require('barbar').setup {
    auto_hide = true
}

require("remote-nvim").setup()

require("neo-tree").setup({
    popup_border_style = "rounded",
    close_if_last_window = true,
    add_blank_line_at_top = true,
    default_component_configs = {
        indent = {
            with_expanders = true,
        },
        icon = {
            folder_empty = "",
        },
},

})
callback = vim.schedule_wrap(function() 
    vim.cmd("Neotree show")
end)
callback()

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

require("image").setup({
    integrations = {
        markdown = {
            enabled = false
        }
    }
})
EOF
colorscheme oxocarbon
highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
highlight! link NeoTreeDirectoryName NvimTreeFolderName
highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
highlight! link NeoTreeRootName NvimTreeRootFolder
highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
hi! FloatBorder guifg=8 guibg=2
hi! CocInlayHint guifg=#be95ff guibg=NONE
hi! NeoTreeGitAdded guifg=#42be65
hi! NeoTreeGitModified guifg=#ffe191
hi! NeoTreeGitConflict guifg=#ff6f00
hi! NeoTreeGitDeleted guifg=#ee5396

" Aliases
fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
                \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
                \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W","w")
call SetupCommandAlias("nt","Neotree")
call SetupCommandAlias("term","12sp <bar> terminal")
call SetupCommandAlias("config","e ~/.config/nvim/init.vim")

" Mappings
map <F8> :NERDTreeToggle<CR>
map <leader>j ddp
map <leader>k ddkkp
map <c-y> "+y
map <c-p> "+p
"map <leader>h <c-w><
"map <leader>l <c-w>>
map <c-k> <c-w>+
map <c-m> <c-w>-
map <leader><cr> :source %<cr>
map <Space> :noh<cr>

tnoremap <Esc> <c-\><c-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
noremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap = gg=G

" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>

" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>

" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>

" coc.nvim stuff
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"This expression seems to be responsible for coc formatting on enter
" inoremap <silent><expr> <cr> '\C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>'
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"I this just says autocomplete with the first option if pop up menu is open.
"If it is not open, just do a regular tab.
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"

" Autocmds
" autocmd VimEnter * NERDTree | wincmd p
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd TermOpen * setlocal nonumber nobuflisted
autocmd TermClose * if !v:event.status | :q
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']
