return {
    {
        "williamboman/mason.nvim",
        require("mason").setup({
            ensure_installed = {
                "lua-language-server",
                "clangd",
                "codelldb",
            }
        }),
    },
}
