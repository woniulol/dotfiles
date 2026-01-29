return {
    {
        'nvimdev/dashboard-nvim',
        -- event = 'VimEnter',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
        config = function()
            local logo = [[
⠀⠀⠀⠐⠀⣀⢀⢀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂
⠀⠀⠀⠀⠈⠈⠀⠈⠀⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠨⡄⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢐⠀⠀⠀⠀⠡⠀⠂⠀⠀⠀⡀⡠⢔⢮⣫⡺⣪⡳⢲⢀⠀⠀⠀⠀⠀⠀
⠀⠀⠅⠀⠀⠀⢀⠠⠀⠀⠀⢀⢮⡈⡏⣜⢖⡕⠮⢮⣣⡳⡥⠀⠀⠀⠀⠀
⠀⠨⠂⠀⠀⠀⠐⠀⠄⠀⠀⠘⡰⡅⠪⢪⢜⢰⢥⡱⡒⣕⢏⠀⠀⠀⠀⠀
⠀⢐⠂⠀⠀⠀⡀⠀⠀⠀⠀⠀⢣⢭⡙⣎⢗⢧⡣⢮⢺⡪⡮⠀⠀⠀⠀⠀
⠀⠠⠅⠀⠀⠀⠀⠄⠀⠀⠀⠀⠑⠱⡜⢬⢪⡳⡱⡺⡊⠊⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⠠⠀⠀⠀⠀⠀⠀⠀⣓⢤⢸⠪⠳⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⢄⡖⠮⣕⢵⢲⢳⡰⡄⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢗⡕⣗⢺⡽⡸⣱⣣⣓⣕⠮⡳⣀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢯⡚⣪⠚⢀⢔⡝⣜⢆⢌⢮⡓⢇⢯⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡣⣎⠈⣗⢵⢝⣜⠮⣳⣣⡳⣜⠅⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣚⢮⢀⣣⢳⢕⢧⡻⢦⡺⢪⠂⠀⠀⠀⢐⠆⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⣗⠁⢧⡣⣳⢹⢂⢗⡅⡘⠘⠀⠀⠀⠀⠈⡄⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠝⢆⠬⢔⠝⢸⣊⡙⠪⠀⡀⠀⠀⠀⠀⠀⢐⠀⠀
⠀⠀⠀⠀⠀⠀⢀⡠⡤⡺⣜⣝⠕⡮⡢⡤⣄⠰⠪⠁⠀⠀⠀⠀⠀⠐⠆⠀
⠀⠀⠀⠀⠀⢀⠎⢮⣫⠫⣜⢜⢖⢜⣖⠀⣄⠤⣄⣄⢤⣠⣠⡄⠀⠀⠀⠀
⢀⡀⢀⣀⣀⣈⡁⡁⣁⣀⣁⣉⠁⣁⢁⡀⣀⣀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀
⢨⠁⣄⢮⣐⡭⣠⡅⠈⠉⡔⢩⡄⢡⢰⡍⠁⠊⠀⠀⠂⠒⠆⠐⠂⠤⠡
                ]]
            logo = string.rep("\n", 8) .. logo .. "\n\n"

            local function nvim_version()
                local v = vim.version()
                return string.format("v%d.%d.%d", v.major, v.minor, v.patch)
            end

            local function get_os()
                local os = jit and jit.os or vim.loop.os_uname().sysname
                return string.format("%s ", os)
            end

            local function get_arch()
                local arch = jit and jit.arch or vim.loop.os_uname().machine
                return string.format("%s", arch)
            end

            require('dashboard').setup({
                config = {
                    shortcut = {
                        {
                            desc = "Neovim ",
                            key = nvim_version(),
                            action = "",
                        },
                        {
                            desc = get_os(),
                            key = get_arch(),
                            action = "",
                        },
                    },
                    header = vim.split(logo, "\n"),
                    footer = { "", "     People live longer, but people love shorter." },
                    project = { enable = true, limit = 2 }, -- Somehow this is n+1.
                    mru = { limit = 6 },
                }
            })
        end,
    },
}
