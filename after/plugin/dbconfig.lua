local function get_db_config()
    local db_config_path = vim.fn.getcwd() .. "/.dbconfig" -- Adjust the filename as needed

    if vim.fn.filereadable(db_config_path) == 1 then
        local db_config = vim.fn.readfile(db_config_path)
        local p_json = vim.fn.json_decode(db_config)

        local dbs = {}
        for key, value in pairs(p_json) do
            table.insert(dbs, { name = key, url = value })
        end

        return dbs
    else
        return nil
    end
end

vim.g.dbs = get_db_config()


vim.g.db_ui_use_postgres_views = 0
