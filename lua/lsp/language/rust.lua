local M = {}
local keymap = vim.keymap -- for conciseness
local util = require("lspconfig.util")



function M.setup(lspconfig, capabilities, on_attach)
  local rs_cap = require("cmp_nvim_lsp").default_capabilities()

  rs_cap.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  rs_cap.textDocument.completion.completionItem.snippetSupport = true

  rs_cap.experimental = {}
  rs_cap.experimental.hoverActions = true
  rs_cap.experimental.hoverRange = true
  rs_cap.experimental.codeActionGroup = true
  rs_cap.experimental.serverStatusNotification = true
  rs_cap.experimental.ssr = true

  rs_cap.experimental.commands = {
  commands = {
    "rust-analyzer.runSingle",
    "rust-analyzer.debugSingle",
    "rust-analyzer.showReferences",
    "rust-analyzer.gotoLocation",
  },
}
  rs_cap.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

  -- rust analyzer goodies
  --
  local function get_workspace_dir(cmd)
    local co = assert(coroutine.running())

    local stdout = {}
    local stderr = {}
    local jobid = vim.fn.jobstart(cmd, {
      on_stdout = function(_, data, _)
        data = table.concat(data, "\n")
        if #data > 0 then
          stdout[#stdout + 1] = data
        end
      end,
      on_stderr = function(_, data, _)
        stderr[#stderr + 1] = table.concat(data, "\n")
      end,
      on_exit = function()
        coroutine.resume(co)
      end,
      stdout_buffered = true,
      stderr_buffered = true,
    })

    if jobid <= 0 then
      vim.notify(
        ("[lspconfig] cmd (%q) failed:\n%s"):format(table.concat(cmd, " "), table.concat(stderr, "")),
        vim.log.levels.WARN
      )
      return
    end

    coroutine.yield()
    if next(stdout) == nil then
      return nil
    end
    stdout = vim.json.decode(table.concat(stdout, ""))
    return stdout and stdout["workspace_root"] or nil
  end

  -- 检查文件路径是否在文件夹路径中
  local function isPathInFolder(filePath, folderPath)
    -- 使用路径分隔符来确保精确匹配
    filePath = string.gsub(filePath, "\\", "/")
    folderPath = string.gsub(folderPath, "\\", "/")

    -- 确保文件路径和文件夹路径以斜杠结尾
    if string.sub(filePath, -1) ~= "/" then
      filePath = filePath .. "/"
    end
    if string.sub(folderPath, -1) ~= "/" then
      folderPath = folderPath .. "/"
    end

    -- 使用字符串匹配判断文件路径是否在文件夹路径中
    local matchPattern = "^" .. folderPath .. ".*"
    if string.match(filePath, matchPattern) then
      return true
    else
      return false
    end
  end

  lspconfig["rust_analyzer"].setup({
    capabilities = rs_cap,
    on_attach = on_attach,
    root_dir = function(fname)
      -- print(fname)
      local cargo_crate_dir = util.root_pattern("Cargo.toml")(fname)
      local cmd = { "cargo", "metadata", "--no-deps", "--format-version", "1" }
      if cargo_crate_dir ~= nil then
        cmd[#cmd + 1] = "--manifest-path"
        cmd[#cmd + 1] = util.path.join(cargo_crate_dir, "Cargo.toml")
      end

      local cargo_workspace_root = get_workspace_dir(cmd)
      --print(cargo_workspace_root)

      if cargo_workspace_root then
        cargo_workspace_root = util.path.sanitize(cargo_workspace_root)
      end
      if
          isPathInFolder(cargo_workspace_root, "/home/bk/.rustup")
          or isPathInFolder(cargo_workspace_root, "/home/bk/.cargo")
      then
        return ""
      end

      return cargo_workspace_root
          or cargo_crate_dir
          or util.root_pattern("rust-project.json")(fname)
          or util.find_git_ancestor(fname)
    end,

    --rust-analyzer.cargo.buildScripts.invocationStrategy
    --rust-analyzer.files.excludeDirs
    settings = {
      ["rust-analyzer"] = {
        files = {
          excludeDirs = {
            "/home/bk/.rustup/**",
            "/home/bk/.cargo/**",
          },
        },
        cargo = {
          allFeatures = true,
        },
        completion = {
          privateEditable = {
            enable = true,
          },
          snippets = {
            custom = {
              ["ok"] = {
                ["postfix"] = "ok",
                ["body"] = "Ok(${receiver})",
                ["scope"] = "expr",
              },
              ["Some"] = {
                ["postfix"] = "some",
                ["body"] = "Some(${receiver})",
                --["scope"] = "expr",
              },
            },
          },
        },
      },
    },
  })
end

return M
