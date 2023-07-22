" Initialize the plugins.
call plug#begin('~/.vim/plugged')

" Editor
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'yggdroot/indentline'

Plug 'gregsexton/MatchTag'

" File Explorer
Plug 'kyazdani42/nvim-tree.lua'

" Theming
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'

" Syntax
Plug 'sheerun/vim-polyglot'

call plug#end()

" Load all the configuration files.
for file in split(glob('~/.dotfiles/nvim/config/*.vim'), '\n')
    exec 'source' file
endfor

lua <<EOF
require'nvim-tree'.setup {
    view = {
        side = 'left',
        width = 30,
        auto_resize = true,
        signcolumn = 'no',
        mappings = {
            -- custom_only = true,
            list = {
                { key = 'i', action = 'vsplit' },
            },
        },
    },
    renderer = {
        highlight_git = true,
        add_trailing = true,
        indent_markers = {
            enable = true,
            icons = {
                corner = '└── ',
                edge   = '│   ',
                item   = '├── ',
                none   = '    ',
            },
        },
        icons = {
            show = {
                file = false,
                folder = true,
                folder_arrow = false,
                git = false,
            },
            glyphs = {
                folder = {
                    default = '▸',
                    empty   = '▸',
                    symlink = '▸',

                    open         = '▾',
                    empty_open   = '▾',
                    symlink_open = '▾',
                },
            },
        },
        special_files = {},
    },
    filters = {
        custom = {
            '.git',
            '.DS_Store',
        },
        exclude = {
            '.gitignore',
        },
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },
}

-- Quit Neovim if the file explorer is the last open buffer.
vim.api.nvim_create_autocmd('BufEnter', {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match('NvimTree_') ~= nil then
            vim.cmd 'quit'
        end
    end
})
EOF
