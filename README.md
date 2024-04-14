# nvim-conf
sudo pacman -S nvim 
git clone git@github.com:BingCoke/nvim-conf.git ~/.config/nvim

# require

- ripgrep for telescope.nvim

# code require

- npm
- go
- python3
- unzip

# dap

## about chrome debuger

install vscode-js-debug

```shell
git clone https://github.com/microsoft/vscode-js-debug
cd vscode-js-debug
npm install --legacy-peer-deps
npx gulp vsDebugServerBundle
mv dist out
```

set your vscode-js-debug postion in dap/dap-ts.lua

```lua
debugger_path = "/home/bk/tools/vscode-js-debug",
```

make google-chrome start with debug (make sure 9222 port)

```
google-chrome-stable --remote-debugging-port=9222

```
