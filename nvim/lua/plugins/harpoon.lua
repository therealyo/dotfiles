return { 
    "ThePrimeagen/harpoon", 
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        local function toggle_move()
            if (vim.v.count > 0) then
                require("harpoon.ui").nav_file(vim.v.count)
            else
                require('harpoon.mark').toggle_file()
            end
        end

        vim.keymap.set("n", "<leader>a", toggle_move)
        vim.keymap.set("n", "<leader>A", ui.toggle_quick_menu)
    end

}
