call plug#begin()
Plug 'akinsho/toggleterm.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'fcpg/vim-fahrenheit'
Plug 'sjl/badwolf'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'Hoffs/omnisharp-extended-lsp.nvim'
Plug 'jesseleite/vim-agriculture'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jakemason/ouroboros'
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
Plug 'benjryan/handmade-vim'
call plug#end()

set cursorline
set colorcolumn=80
set autoindent
set nocindent
set nospell

" also handle lambda correctly, with namespace indent
"set cino+=g-1,j1,(0,ws,Ws,N+s,t0,g0,+0

set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

" Important!!
if has('termguicolors')
    set termguicolors
endif
" For dark version.
set background=dark
" For light version.
"set background=light
" Set contrast.
" This configuration option should be placed before `colorscheme
" gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'
" For better performance
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_statusline_style = 'default'
"colorscheme gruvbox-material
let g:gruvbox_contrast_dark = 'hard'
"colorscheme gruvbox
colorscheme handmade-vim

hi TabLineFill guibg=#ffffff

syntax on
set autoindent
set nosmartindent
set nocindent

"set completeopt=menuone,noinsert,noselect
set completeopt=menuone,noinsert,noselect

set splitbelow
set splitright

set foldmethod=indent
set foldlevel=99

" local nvimrc autoload
set exrc

set tabstop=4
set softtabstop=-1 "will use tabstop value
set shiftwidth=0   "will use tabstop value
set expandtab
set textwidth=80
set fileformat=unix
set encoding=utf-8
set mouse=a

set laststatus=2
set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark

set nu rnu
set ruler
set showcmd
set noswapfile
set noshowmode

set backspace=indent,eol,start " let backspace delete over lines
nnoremap fo :copen<CR>
nnoremap fc :cclose<CR>

set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

nnoremap <silent><a-k> :bn<CR>
nnoremap <silent><a-j> :bp<CR>
nnoremap <silent><a-w> :bd<CR>

" ouroboros
noremap <leader>sw :Ouroboros<CR>
noremap <leader>sv :vsplit \| Ouroboros<CR>
noremap <leader>sh :split \| Ouroboros<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>ft <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fc <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
autocmd FileType cs nnoremap <buffer> <leader>gd <cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>
nnoremap <leader>gi <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>fe <cmd>Telescope resume<cr>

inoremap <C-e> <C-x><C-o>
nnoremap <C-h> :noh<return>

" search visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"set completeopt=noselect,longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" run code
"nnoremap \ :te<enter>
"nnoremap <f6> <esc>:w<enter>:!g++ -std=c++11 %<enter>
tnoremap <Esc> <C-\><C-n>

" automatically enter insert mode on new neovim terminals
"augroup terminal
"  au TermOpen * startinsert
"augroup END

nnoremap <c-z> <nop>
"nnoremap <C-p> :Files<Cr>
"nnoremap <C-g> :RgRaw ""<Cr>

" inverted cursor workaround for windows terminal
if !empty($WT_SESSION)
    " guicursor will leave reverse to the terminal, which won't work in WT.
    " therefore we will set bg and fg colors explicitly in an autocmd.
    " however guicursor also ignores fg colors, so fg color will be set
    " with a second group that has gui=reverse.
    hi! WindowsTerminalCursorFg gui=none
    hi! WindowsTerminalCursorBg gui=none
    set guicursor+=n-v-c-sm:block-WindowsTerminalCursorBg

    function! WindowsTerminalFixHighlight()
        " reset match to the character under cursor
        silent! call matchdelete(99991)
        call matchadd('WindowsTerminalCursorFg', '\%#.', 100, 99991)

        " find fg color under cursor or fall back to Normal fg then black
        let bg = synIDattr(synIDtrans(synID(line("."), col("."), 1)), 'fg#') 
        if bg == "" | let bg = synIDattr(synIDtrans(hlID('Normal')), 'fg#') | endif
        if bg == "" | let bg = "black" | endif
        exec 'hi WindowsTerminalCursorBg guibg=' . bg
        " reset this group so it survives theme changes
        hi! WindowsTerminalCursorFg gui=reverse
    endfunction

    function! WindowsTerminalFixClear()
        " hide cursor highlight
        silent! call matchdelete(99991)

        " make cursor the default color or black in insert mode
        let bg = synIDattr(synIDtrans(hlID('Normal')), 'fg#')
        if bg == "" | let bg = "black" | endif
        exec 'hi WindowsTerminalCursorBg guibg=' . bg
    endfunction

    augroup windows_terminal_fix
        autocmd!
        autocmd FocusLost * call WindowsTerminalFixClear()
        autocmd FocusGained * if mode(1) != "i" | call WindowsTerminalFixHighlight() | endif

        autocmd InsertEnter * call WindowsTerminalFixClear()
        autocmd InsertLeave * call WindowsTerminalFixHighlight()
        autocmd CursorMoved * call WindowsTerminalFixHighlight()
    augroup END
endif

let $FZF_DEFAULT_COMMAND = 'rg --files -g ""'
nnoremap <Esc> :noh<CR>

lua <<EOF
require('telescope').setup{
    defaults = {
        path_display = { truncate = true },
        layout_strategy = "bottom_pane",
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " ", }
    },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    --theme = 'gruvbox',
    --theme = 'gruvbox-material',
    theme = 'handmade-vim',
    --theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {}
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', 
                        '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', 
                        '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', 
                        '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', 
                        '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

require'toggle_lsp_diagnostics'.init({ start_on = false })
vim.api.nvim_set_keymap('n', '<leader>dd', '<Plug>(toggle-lsp-diag)', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
end

local lspconfig = require('lspconfig')
local omnisharp_bin = "c:/programs/omnisharp/omnisharp.exe"
lspconfig.omnisharp.setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    handlers = {
        ["textdocument/definition"] = require('omnisharp_extended').handler,
    },
    cmd = { omnisharp_bin, '--languageserver' , '--hostpid', tostring(pid) },
}

lspconfig.clangd.setup{
    on_attach = on_attach,
}

EOF
