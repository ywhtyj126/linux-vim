# vim 快速配置

## Ubuntu 全自动安装 Vim 
- 安装必要系统包（vim、nodejs、npm、fzf、curl、git）。
- 下载并安装 vim-plug（插件管理器）。
- 覆盖写入我们刚刚的 终极 .vimrc 配置。
- 自动执行 :PlugInstall 安装插件。
- 第一次启动时自动安装 Coc.nvim 常用语言扩展（Python、Go、Rust、JavaScript、Vue、Shell、YAML 等）

### 安装

```bash
curl -s https://github.com/ywhtyj126/linux-vim/main/install-vim-pro-ubuntu.sh | bash
```

### 操作

文件树：Ctrl+N
全局搜索：Ctrl+P
粘贴模式切换：F2
智能补全：输入代码自动提示，支持多语言
文档查看：K
代码格式化：\f
注释代码：gcc（单行），gc（多行选区）

