Coc_flush = {
  tab = {},
  flush = function()
    pcall(vim.fn.CocActionAsync, "diagnosticList", function(err, res)
      if err ~= vim.NIL then return end
      if type(res) == "table" then
        return
      end
      local result = {}

      local bufname2bufnr = {}
      for _, diagnostic in ipairs(res) do
        local bufname = diagnostic.file

        local bufnr = bufname2bufnr[bufname]
        if not bufnr then
          bufnr = vim.fn.bufnr(bufname)
          bufname2bufnr[bufname] = bufnr
        end

        if bufnr ~= -1 then
          result[bufnr] = {}
          if diagnostic.severity == "Error" then
            result[bufnr].error = 1
          end

          if diagnostic.severity == "Warning" then
            result[bufnr].warning = 1
          end
        end
      end
      Coc_flush.tab = result
    end)
  end
}
return Coc_flush
