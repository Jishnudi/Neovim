return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",

    opts = {
        options = {

            mode = "buffer",
            numbers = "ordinal",
            truncate_names = false,
            padding = 2,
            seperator_style = "thick",
            indicator = {
                style = 'underline',
            },

            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,

            offsets = { { filetype = "NvimTree", text = "", seperator = true, text_align = "center" } }
        },
        highlights = {
            buffer_selected = {
                bold = true,
                italic = false,
            },
        },
    },
}
