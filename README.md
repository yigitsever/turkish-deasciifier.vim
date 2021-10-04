turkish-deasciifier.vim
=======================

This plugin is a fork of [joom/turkish-deasciifier.vim](https://github.com/joom/turkish-deasciifier.vim) that introduces `opfunc` variants of the functions.
The original plugin pipes visual selection into a Turkish deasciifier.
This fork lets you use `operator {motion}`, just like any other operator of vim (c, y etc.)
Turkish deasciifier is based on Deniz Yüret's [turkish-mode](https://github.com/emres/turkish-mode).

There are three functions, one to deasciify over a motion using `turkish-mode`, one to brute force the deasciification (to fix what `turkish-mode` might have missed) and one to asciify Turkish characters.

You can create key mappings for it like this in your `.vimrc` file:

```vim
" brute force deasciify everything
nnoremap <expr> <Leader>tc TurkishDeasciifyForce()
xnoremap <expr> <Leader>tc TurkishDeasciifyForce()
nnoremap <expr> <Leader>tctc TurkishDeasciifyForce() .. '_'

" use turkish-mode to selectively deasciify
nnoremap <expr> <Leader>tr TurkishDeasciify()
xnoremap <expr> <Leader>tr TurkishDeasciify()
nnoremap <expr> <Leader>trtr TurkishDeasciify() .. '_'

" ascii everything
nnoremap <expr> <Leader>rt TurkishAsciify()
xnoremap <expr> <Leader>rt TurkishAsciify()
nnoremap <expr> <Leader>rtrt TurkishAsciify() .. '_'
```

## Requirements

A Turkish deasciifier executable has to be installed alongside the plugin. There are several ports of it in different languages.

**1)** [emres/turkish-deasciifier](https://github.com/emres/turkish-deasciifier/) Turkish deasciifier in Python. If you are on Arch Linux, this is available on AUR.

```bash
paru turkish-deasciifier-git
```

**2)** [f/deasciifier](https://github.com/f/deasciifier/) is the easier version to install if you have `node` and `npm` installed. This command would install the deasciifier:

```bash
npm install deasciifier -g
```

Then you have to include this line in your .vimrc file:

```vim
let g:turkish_deasciifier_path = 'deasciify'
```

**3)** [joom/turkish-deasciifier.hs](https://github.com/joom/turkish-deasciifier.hs/) is another easy version to install if you have Haskell installed (`cabal` and `ghc`). This command would install the deasciifier:

```bash
cabal install turkish-deasciifier
```

Then you have to include this line in your .vimrc file:

```vim
let g:turkish_deasciifier_path = 'turkish-deasciifier'
```

## Installation

Install it using your plugin installation method of choice.

```vim
Plug 'yigitsever/turkish-deasciifier.vim'
```

## License

MIT
