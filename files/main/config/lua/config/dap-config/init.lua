require ('mason-nvim-dap').setup({
    ensure_installed = {
        'coreclr', 
        'codelldb'
    }
})

require('config/dap-config/omnisharp-config')
