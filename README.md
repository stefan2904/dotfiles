# dotfiles 

Here, my public dotfiles.  *Follow the white rabbit.*

## Install

```bash
cd ~
git clone https://github.com/stefan2904/dotfiles.git .dotfiles
cd .dotfiles
stow <module>
```


### Activate module

```bash
cd .dotfiles
stow <module>
```


### Deactivate module

```bash
cd .dotfiles
stow -D <module>
```


### Stow?

`GNU Stow is a symlink farm manager which ...` well, whatever. Just install it using `apt-get install stow`, use it as described above, and [RTFM](https://www.gnu.org/software/stow/) later.


## Inspired by

* [@f0rki](https://github.com/f0rki/dotvim)/[dotvim](https://github.com/f0rki/dotvim)
* [@nbraud](https://github.com/nbraud)
* [GitHub ❤ ~/](https://dotfiles.github.io/)
