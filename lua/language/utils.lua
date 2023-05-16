local M = {}

local notify = require("my.notify")
function M.getNode()
  local handler = function(_, result, ctx)
    if not (result and result.contents) then
      return
    end
  end

  M.request(0, "textDocument/hover", M.get_params(), handler)
end

function M.debug(fn)
  local handler = function(_, result, ctx)
    if not (result and result.contents) then
      -- return { 'No information available' }
      return
    end

    if result.actions == nil then
      notify.create_notify_floating_window({ "there is no progrm to debug" }, { timeout = 3000 })
      return
    end

    local args = result.actions[1].commands[1].arguments[1].args
    if args == nil then
      notify.create_notify_floating_window({ "there is no progrm to debug" }, { timeout = 3000 })
      return
    end

    if args.cargoArgs[1] == "run" then
      args.cargoArgs[1] = "build"
    elseif args.cargoArgs[1] == "test" then
      table.insert(args, 2, "--no-run")
    end

    local cargo_args = args.cargoArgs
    for _, value in ipairs(args.cargoExtraArgs) do
      table.insert(cargo_args, value)
    end

    table.insert(cargo_args, "--message-format=json")

    fn(args)
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

function M.setup()
  vim.keymap.set("n", "<F1>", M.getNode, {})
end

return M
