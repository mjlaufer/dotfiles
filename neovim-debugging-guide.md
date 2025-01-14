# Debugging with Neovim

Set breakpoints with `<leader>db`, and start the debugger with `<leader>dc`.

## Go

You can use Neovim to launch Delve or attach to a running Delve process. To start Delve manually, you can run:

```sh
$ dlv dap -l 127.0.0.1:38697 --log --log-output="dap"
```

## Java

You can remote debug your Java app by running your app with the Java Debug Wire Protocol (JDWP):

```sh
$ java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar [path/to/JAR]
```

## JavaScript

You can either debug in Chrome or use the [VS Code JavaScript debugger](https://github.com/microsoft/vscode-js-debug).

To debug in Chrome, make sure to first run Chrome with remote debugging enabled:

```sh
$ chrome-debug
```

For browser debugging, simply open your web application in Chrome (running in debug mode). If you're using a bundler like Vite, ensure you have source maps enabled.

For Node.js debugging, you must first start your application with the `--inspect` flag (or `--inspect-brk` for processes that aren't long-running). Then with Chrome running in debug mode, navigate to `chrome://inspect`, and click on the **Configure...** button. Add a new target with the address `localhost:<YOUR_PORT>`.

Alternatively, you can use the VS Code JavaScript debugger with `<leader>ds`.
