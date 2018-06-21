# Prerequisites

Arch, Manjaro, etc

# Installation instructions
You can install the configurations by running the following command:

```bash
$ curl -L https://git.io/fCxJL | bash
```

The install script will ensure that the following packages are installed:
  1. git
  2. curl
  3. vim

It will then clone the repo and symbolically link the configurations.

Then it installs [vim-plug](https://github.com/junegunn/vim-plug) and initializes the plugins specified in the .vimrc.
