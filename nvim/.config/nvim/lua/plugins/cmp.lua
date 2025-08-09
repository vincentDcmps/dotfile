return {
    {
    
        "https://github.com/Saghen/blink.cmp",
        version = "v1.*",
        event = "VeryLazy",
        config = function()
            require("blink.cmp").setup({
                keymap = {
                    preset = "enter",
                },
            })
        end,
    },
}
