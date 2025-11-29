require("silicon").setup({
    -- Configuration here, or leave empty to use defaults
    font = "CaskaydiaCove NF=34",
    output = function()
        return "~/pix/ss/code/" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
    end,
})
