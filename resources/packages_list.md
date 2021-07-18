# Packages List

Here's a list of packages that I install. This list is not complete and is here 
just for my own reference.


## macOS

```bash
brew install \
    dash \
    htop \
    neovim \
    koekeishiya/formulae/yabai \
    koekeishiya/formulae/skhd \
    jq \
    jesseduffield/lazygit/lazygit \
    ffmpegthumbnailer \
    efm-langserver \
    hashicorp/tap/terraform-ls \
    bat \
    exa \
    prettyping \
    diff-so-fancy \
    fd \
    ripgrep
```


## Global NPM packages

Some packages that are useful and should probably be installed into the global 
node modules.

```bash
npm i -g \
    bash-language-server \
    typescript-language-server \
    vls \
    graphql-language-service-cli \
    intelephense \
    vscode-css-languageserver-bin \
    vscode-json-languageserver \
    yaml-language-server \
    dockerfile-language-server-nodejs \
    eslint_d
```


## Python packages

These packages should be installed with the global `pip`:

```sh
pip install \
    Pillow
```

Neovim plugins require that there's a virtualenv with the `neovim` package 
installed. Create a Pyenv virtualenv `neovim3` from Python 3 and `neovim2` from 
Python 2, there:

```bash
pip install \
    neovim \
    neovim-remote \
    pynvim \
    i3-py
```

The location of this virtualenv is configured in 
[`nvim/init.vim`](../config/nvim/init.vim).
