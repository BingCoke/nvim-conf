local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    common.disableFormat(client)
    common.keyAttach(bufnr)
  end,
  vmargs = {
      "-XX:+UseParallelGC",
      "-XX:GCTimeRatio=4",
      "-XX:AdaptiveSizePolicyWeight=90",
      "-Dsun.zip.disableMemoryMapping=true",
      "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
      "-Xmx1G",
      "-Xms100m",
  },
  use_lombok_agent = true,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
