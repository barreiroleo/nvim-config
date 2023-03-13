P = function(v)
    print(vim.inspect(v))
    return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

DROP_TEX = function(file, line)
    -- From shell: nvim --listen /tmp/SOCKET FILE -c +LINE
    -- Example:    nvim --listen /tmp/nvim.latex src/main.tex -c +24
    -- Example:    nvim --listen /tmp/nvim.latex src/main.tex -c ":call cursor(29,8)"
    file = file or "~/develop/pps/src/main.tex"
    line = line or 10

    local clean = { "\'", "\"" }
    for _, char in ipairs(clean) do
        file = string.gsub(file, "^" .. char, "")
        file = string.gsub(file, char .. "$", "")
    end
    file = string.gsub(file, " ", "\\ ")

    local cmd = string.format(":drop %s|%s", file, line)
    vim.notify(cmd)
    vim.cmd(cmd)
end
--
-- local filename = "/lala lala/main.tex"
-- local chars = { "", "'", "\"" }
-- for _, char in ipairs(chars) do
--     DROP_TEX(char .. filename .. char, 1)
-- end
