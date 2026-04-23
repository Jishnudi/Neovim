vim.g.mapleader = " "

vim.keymap.set("n", "<leader>bn", ":bn<cr>")
vim.keymap.set("n", "<leader>bp", ":bp<cr>")
vim.keymap.set("n", "<leader>bd", ":bd<cr>")

vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-u>i]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-d>i]])

vim.keymap.set("n", "<leader>r", function()
    vim.cmd("w")

    if vim.bo.filetype == "python" then
        vim.cmd("!python3 %")
    elseif vim.bo.filetype == "c" then
        vim.cmd("!gcc -Wall -std=c11 % -o %:r && ./%:r")
    elseif vim.bo.filetype == "cpp" then
        vim.cmd("!g++ -std=c++17 -Wall % -o %:r && ./%:r")
    else
        print("Unsupported file type")
    end
end, { silent = true })

-- ONLY for Neovim 0.10+
vim.keymap.set("n", "<C-/>", "gcc", { remap = true })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
vim.keymap.set("v", "<C-/>", "gc", { remap = true })
vim.keymap.set("v", "<C-_>", "gc", { remap = true })

vim.keymap.set("n", "<localleader>ip", function()
    local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
    if venv ~= nil then
        -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
        venv = string.match(venv, "/.+/(.+)")
        vim.cmd(("MoltenInit %s"):format(venv))
    else
        vim.cmd("MoltenInit python3")
    end
end, { desc = "Initialize Molten for python3", silent = true })

vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
vim.keymap.set(
    "n",
    "<localleader>os",
    ":noautocmd MoltenEnterOutput<CR>",
    { desc = "open output window", silent = true }
)

vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
vim.keymap.set(
    "v",
    "<localleader>r",
    ":<C-u>MoltenEvaluateVisual<CR>gv",
    { desc = "execute visual selection", silent = true }
)
vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

-- if you work with html outputs:
vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })

vim.keymap.set("n", "<leader>vib", function()
    local start_line = vim.fn.search("^```python\\s*$", "bnW")
    local end_line = vim.fn.search("^```\\s*$", "nW")

    if start_line > 0 and end_line > start_line + 1 then
        vim.api.nvim_win_set_cursor(0, { start_line + 1, 0 })
        vim.cmd("normal! V")
        vim.api.nvim_win_set_cursor(0, { end_line - 1, 0 })
    else
        print("No python code block found.")
    end
end, { desc = "Select inside Python code block" })
