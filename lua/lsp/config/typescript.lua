local status, typescript = pcall(require, "typescript")
if not status then
  vim.notify("没有找到 typescript")
  return
end
local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    -- common.disableFormat(client)
    common.keyAttach(bufnr)


  end,
}
return {
  on_setup = function(_)
    typescript.setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false, -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
      },
      server = opts,
    })
  end,
}

