return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.4
            end
        end,
        open_mapping = [[<c-t>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
    }
}
