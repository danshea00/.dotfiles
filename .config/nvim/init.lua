-- Set leaders before defining plugin mappings.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 5
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.termguicolors = true
opt.signcolumn = "yes"
opt.undofile = true
opt.updatetime = 250
opt.completeopt = { "menu", "menuone", "noselect" }

-- Bootstrap the plugin manager. lazy-lock.json records installed revisions.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local output = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath,
    })
    if vim.v.shell_error ~= 0 then
        error("Could not install lazy.nvim:\n" .. output)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({ contrast = "hard" })
            vim.cmd.colorscheme("gruvbox")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search project text" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
            { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Search word under cursor" },
            { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Search diagnostics" },
        },
        config = function()
            require("telescope").setup({})
            require("telescope").load_extension("fzf")
        end,
    },
}, {
    change_detection = { notify = false },
})

-- Language servers must be installed and available on PATH.
vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
})
vim.lsp.config("rust_analyzer", {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json", ".git" },
})
for name, command in pairs({ clangd = "clangd", rust_analyzer = "rust-analyzer" }) do
    if vim.fn.executable(command) == 1 then
        vim.lsp.enable(name)
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
    callback = function(event)
        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gr", function() require("telescope.builtin").lsp_references() end, "Find references")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("[g", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
        map("]g", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
    end,
})
