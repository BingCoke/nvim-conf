local input = require("my.input")
local M = {}

M.arg = ""

M.build_dap_runner_opt = function(o)
  if o == nil then
    o = {}
  end
  local opt = {}
  opt.file = vim.api.nvim_buf_get_name(0)
  opt.work_dir = vim.api.nvim_call_function("getcwd", {})
  if o.cur_fun ~= nil and o.cur_fun ~= false then
    opt.cur_fun = M.get_current_function_name()
  end
  opt.path = string.format("./%s", vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r"))
  opt.run_arg = M.arg
  return opt
end

M.str2arglist = function(str)
  print("list" .. str)
  local list = {}
  for word in string.gmatch(str, "%S+") do
    table.insert(list, word)
  end
  return list
end

M.str2argtable = function(str)
  print("start trrans" .. str)
  -- trim spaces
  str = string.gsub(str, "^%s*(.-)%s*$", "%1")
  local arg_list = {}

  local start = 1
  local i = 1
  local quote_refs_cnt = 0
  while i <= #str do
    local c = str:sub(i, i)
    if c == '"' then
      quote_refs_cnt = quote_refs_cnt + 1
      start = i
      i = i + 1
      -- find next quote
      while i <= #str and str:sub(i, i) ~= '"' do
        i = i + 1
      end
      if i <= #str then
        quote_refs_cnt = quote_refs_cnt - 1
        arg_list[#arg_list + 1] = str:sub(start, i)
        start = M.find_next_start(str, i + 1)
        i = start
      end
      -- find next start
    elseif c == " " then
      arg_list[#arg_list + 1] = str:sub(start, i - 1)
      start = M.find_next_start(str, i + 1)
      i = start
    else
      i = i + 1
    end
  end

  -- add last arg if possiable
  if start ~= i and quote_refs_cnt == 0 then
    arg_list[#arg_list + 1] = str:sub(start, i)
  end
  return arg_list
end

M.set_args = function()
  return function()
    local opt = {
      title = { { "input args", "TitleString" } },
      ---@diagnostic disable-next-line: redefined-local
      fn = function(input)
        M.arg = input
      end,
    }
    input.get_user_input(opt)
  end
end

M.set_eval_expr = function()
  local opt = {
    title = { { "input eval expr", "TitleString" } },
    ---@diagnostic disable-next-line: redefined-local
    fn = function(input)
      M.eval_expr = input
    end,
  }
  input.get_user_input(opt)
end

M.get_current_function_name = function()
  local params = vim.lsp.util.make_position_params()
  local result = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params)
  if result == nil then
    return ""
  end
  local symbols = result[1].result

  for _, symbol in ipairs(symbols) do
    if symbol.kind == vim.lsp.protocol.SymbolKind.Function then
      local range = symbol.range
      local cursor = vim.api.nvim_win_get_cursor(0)
      if cursor[1] >= range.start.line and cursor[1] <= range["end"].line then
        return symbol.name
      end
    end
  end

  return ""
end

return M
