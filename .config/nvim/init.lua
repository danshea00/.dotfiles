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
