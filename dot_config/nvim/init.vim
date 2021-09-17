call plug#begin('~/.vim/plugged')
Plug 'mfussenegger/nvim-jdtls'
Plug 'hrsh7th/nvim-cmp', {'branch':'main'}
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-buffer', {'branch':'main'}
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'mfussenegger/nvim-fzy', {'branch':'main'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch':'main'}
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
call plug#end()
if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({cmd = {'launcher.sh'}})
    nnoremap <A-CR> <Cmd>lua require('jdtls').code_action()<CR>
    vnoremap <A-CR> <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
    nnoremap <leader>r <Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>

    nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
    nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
    vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
    nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
    vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
    vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
  augroup end
endif

lua vim.o.completeopt = 'menuone,noselect'
lua << EOF
   local luasnip = require 'luasnip'
   local cmp = require'cmp'
   cmp.setup{
        snippet = {
                expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                end,
        },
        mapping = {
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                },
                ['<Tab>'] = function(fallback)
                  if vim.fn.pumvisible() == 1 then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
                  elseif luasnip.expand_or_jumpable() then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
                  else
                        fallback()
                  end
                end,
                ['<S-Tab>'] = function(fallback)
                  if vim.fn.pumvisible() == 1 then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
                  elseif luasnip.jumpable(-1) then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
                  else
                        fallback()
                  end
                end, 
        }, 
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
}
EOF
lua require('jdtls.ui').pick_one_async = require('fzy').pick_one
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set copyindent

