call plug#begin()
"Plug 'preservim/nerdtree'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'sheerun/vim-polyglot'
"Plug 'vim-syntastic/syntastic'
"Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
"Plug 'ryanoasis/vim-devicons'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'OmniSharp/omnisharp-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'  " General fuzzy finder
Plug 'jesseleite/vim-agriculture'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'EdenEast/nightfox.nvim' 
"Plug 'dense-analysis/ale'
"Plug 'ervandew/supertab'
call plug#end()

" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent><a-k> :BufferLineCycleNext<CR>
nnoremap <silent><a-j> :BufferLineCyclePrev<CR>
nnoremap <silent><a-w> :bd<CR>

lua <<EOF
local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
  fox = "nightfox", -- change the colorscheme to use nordfox
  styles = {
    comments = "NONE", -- change style of comments to be italic
    keywords = "NONE", -- change style of keywords to be bold
    functions = "NONE" -- styles can be a comma separated list
  },
  inverse = {
    match_paren = false, -- inverse the highlighting of match_parens
  },
  colors = {},
  hlgroups = {
    Todo = { fg = "${white_dm}", bg = "NONE" }, -- remove that bg changes on note/todo
  }
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
EOF

lua <<EOF
--require'nvim-treesitter.install'.compilers = { "clang" }
--
--require'nvim-treesitter.configs'.setup {
--  highlight = {
--    enable = true,
--    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--    -- Using this option may slow down your editor, and you may see some duplicate highlights.
--    -- Instead of true it can also be a list of languages
--    additional_vim_regex_highlighting = false,
--  },
--}

--require'nvim-treesitter.configs'.setup {
--  incremental_selection = {
--    enable = true,
--    keymaps = {
--      init_selection = "gnn",
--      node_incremental = "grn",
--      scope_incremental = "grc",
--      node_decremental = "grm",
--    },
--  },
--}
--
--require'nvim-treesitter.configs'.setup {
--  indent = {
--    enable = true
--  }
--}
EOF

lua <<EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfox',
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
  tabline = {},
  extensions = {}
}
EOF

lua <<EOF
require('bufferline').setup {
  options = {
      diagnostics = "nvim_lsp",
      show_close_icon = false,
      show_buffer_close_icons = false,
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
  }
}

EOF

lua <<EOF

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

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
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--local servers = { "omnisharp-roslyn" }

local omnisharp_bin = "c:/programs/omnisharp/OmniSharp.exe"
require('lspconfig').omnisharp.setup {
    on_attach = on_attach,
    flags = { debounce_text_changes = 150 },
    cmd = { omnisharp_bin, '--languageserver' , '--hostPID', tostring(pid) }
}

-- for _, lsp in pairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
-- end
EOF

set splitbelow
set splitright

" Enable folding
"set foldmethod=expr
set foldmethod=indent
"set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

"Enable folding with the spacebar
"nnoremap <space> za

"map <C-n> :NERDTreeToggle<CR>

syntax on

" local nvimrc autoload
set exrc

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set smartindent
set fileformat=unix
set encoding=utf-8

"inoremap <silent> ,s <C-r>=CocActionAsync('showSignatureHelp')<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fs <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>gi <cmd>Telescope lsp_implementations<cr>
nnoremap <leader>fe <cmd>Telescope resume<cr>

"" air-line
"let g:airline_powerline_fonts = 1
"let g:airline_theme = 'deep_space'
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1

" move among buffers with CTRL
"map <a-k> :bnext<CR>
"map <a-j> :bprev<CR>

"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"
"" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"
"" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

set laststatus=2
" set showtabline=2
set t_Co=256
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
"colorscheme deep-space
"colorscheme nightfox
"let g:material_style = "deep ocean"
"highlight Normal guifg=#77869E guibg=#0E171F

set nu rnu
"set clipboard=unnamed
set ruler
set showcmd
set noswapfile
set noshowmode
"set omnifunc=syntaxcomplete#Complete

set backspace=indent,eol,start " let backspace delete over lines
set autoindent
set smartindent
"set pastetoggle=<F2> " enable paste mode
"nnoremap <expr> <c-/> empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'
nnoremap fo :copen<CR>
nnoremap fc :cclose<CR>

set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch

inoremap <C-e> <C-x><C-o>
nnoremap <C-h> :noh<return>

" search visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

set completeopt=noselect,longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" run code
"nnoremap \ :te<enter>
"nnoremap <f6> <esc>:w<enter>:!g++ -std=c++11 %<enter>
"tnoremap <Esc> <C-\><C-n>

" automatically enter insert mode on new neovim terminals
"augroup terminal
"  au TermOpen * startinsert
"augroup END

nnoremap <c-z> <nop>
nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :RgRaw ""<Cr>

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

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
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" COC BEGIN ---------------------------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-n> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif
"
"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nmap <silent> gs :CocCommand clangd.switchSourceHeader<CR>
"
"" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  elseif (coc#rpc#ready())
"    call CocActionAsync('doHover')
"  else
"    execute '!' . &keywordprg . " " . expand('<cword>')
"  endif
"endfunction
"
"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)
"
"" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"
"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder.
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)
"
"" Remap <C-f> and <C-b> for scroll float windows/popups.
""if has('nvim-0.4.0') || has('patch-8.2.0750')
""  nnoremap <silent><nowait><expr> <A-k> coc#float#has_scroll() ? coc#float#scroll(1) : "\<A-k>"
""  nnoremap <silent><nowait><expr> <A-j> coc#float#has_scroll() ? coc#float#scroll(0) : "\<A-j>"
""  inoremap <silent><nowait><expr> <A-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
""  inoremap <silent><nowait><expr> <A-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
""  vnoremap <silent><nowait><expr> <A-k> coc#float#has_scroll() ? coc#float#scroll(1) : "\<A-k>"
""  vnoremap <silent><nowait><expr> <A-j> coc#float#has_scroll() ? coc#float#scroll(0) : "\<A-j>"
""endif
"
"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)
"
"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocAction('format')
"
"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"
"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"
""" Toggle duplicate LS sources
""function Disable_ls_duplicates()
"":call CocAction('toggleSource', 'cs-2')
"":call CocAction('toggleSource', 'cs-3')
"":call CocAction('toggleSource', 'cs-4')
""endfunction
""
""" Map the function call
""nnoremap dld :call Disable_ls_duplicates()
"
"let g:coc_sources_disable_map = { 'cs': ['cs-2', 'cs-3'] }

"autocmd FileType c,cpp,h,hpp nnoremap <buffer> <F1> :!.\build.bat<CR>
"autocmd FileType cs nnoremap <buffer> <F1> :!.\build_quantum_debug.bat<CR>
"autocmd FileType cs nnoremap <buffer> <F2> :!.\build_quantum_release.bat<CR>
"autocmd FileType cs nnoremap <buffer> <F3> :!.\build_unity_debug.bat<CR>
"autocmd BufNewFile,BufRead *.cs nnoremap <buffer> <F1> :!.\build.bat<CR>
"autocmd BufNewFile,BufRead *.cs nnoremap <buffer> <F2> :!.\run.bat<CR>
" COC END ----------------------------------------------

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
