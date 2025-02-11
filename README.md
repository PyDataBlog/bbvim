# nvim-from-scratch

Personal neovim IDE

## Install

### Backup current config

```sh
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

### Remove current config

```sh
# Linux / MacOS (unix)
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

### Clone and run new config

```sh
git clone https://github.com/PyDataBlog/bbvim.git ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim
```
