
local  M = {}


function M.debug()
  
end


function M.hover()
  local handler = function(_, result, ctx)
    if not (result and result.contents) then
      -- return { 'No information available' }
      return
    end
    local json = vim.json
    local res = json.encode(result)


  end
  M.request(0, "textDocument/hover", M.get_params(), handler)
end

function M.get_params()
  return vim.lsp.util.make_position_params(0, nil)
end

function M.mk_handler(fn)
  return function(...)
    local config_or_client_id = select(4, ...)
    local is_new = type(config_or_client_id) ~= "number"
    if is_new then
      fn(...)
    else
      local err = select(1, ...)
      local method = select(2, ...)
      local result = select(3, ...)
      local client_id = select(4, ...)
      local bufnr = select(5, ...)
      local config = select(6, ...)
      fn(err, result, { method = method, client_id = client_id, bufnr = bufnr }, config)
    end
  end
end

function M.request(bufnr, method, params, handler)
  return vim.lsp.buf_request(bufnr, method, params, M.mk_handler(handler))
end


return M
