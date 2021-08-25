---
title: My Puppet VimRC
date: 2016-01-12
---

Those who know me, know that I'm a Vim user. I've been using Vim exclusively for over ten years. I've tried different
editors, and this isn't the place to start the editor-holy-war-debate, but I've always found myself drawn back to Vim
for its extensibility, flexibility and power. When I started at FanDuel, I left behind configuration management with
Chef and began my journey to understanding Puppet. The excerpt below comes from my `~/.vimrc` Vim configuration file,
and defines the settings applied to Puppet `.pp` files.

```vim
...
Plugin 'rodjek/vim-puppet'
...
""" puppet files
au BufNewFile,BufRead *.pp set syntax=puppet
au BufNewFile,BufRead *.pp setlocal tabstop=2
au BufNewFile,BufRead *.pp setlocal shiftwidth=2
au BufNewFile,BufRead *.pp setlocal noexpandtab
au FileType puppet setlocal isk+=:
au FileType puppet nnoremap <c-]> :exe "tag " . substitute(expand("<cword>"), "^::", "", "")<CR>  
au FileType puppet nnoremap <c-w><c-]> :tab split<CR>:exe "tag " . substitute(expand("<cword>"), "^::", "", "")<CR>
let g:syntastic_mode_map = { 'passive_filetypes': ['puppet']  }
let g:tagbar_type_puppet = {
    \ 'ctagstype': 'puppet',
    \ 'kinds': [
        \'c:class',
        \'s:site',
        \'n:node',
        \'d:definition'
      \]
    \}
```

Line 2 uses [Vundle](https://github.com/VundleVim/Vundle.vim) to load
[rodjek/vim-puppet](https://github.com/rodjek/vim-puppet), a plugin to provide some conveniences when editing Puppet
code. In this case, some nice syntax highlighting and automatic formatting, and automatic alignment of hash rockets
among other things.

Lines 5 through 8 set some local defaults for editing: enabling Puppet syntax, making tabs two spaces wide and using
hard tabs. Yup, hard tabs.  Don't ask.

Line 9 makes sure that the ':' colon character is treated as a keyword separator for Puppet files. This is useful
because of the way Puppet uses '::' as a namespace separator, e.g. `foo::bar::baz` refers to a class `baz`, defined
within a class `bar`, defined within a class `foo`. I can use Vim movements to move between the different segments of
that identifier etc.

To remove ambiguity when scoping identifiers in Puppet, *top-scoping* can be used. Top-scoping involves preceding an
identifier with a pair of colon characters, e.g. `::foo::bar::baz`. This syntax ensures the Puppet parser does not try
to locate `foo::bar::baz` relative to the scope in which its defined, rather to locate it from the top level of its
symbol table.

I use *[ctags](https://en.wikipedia.org/wiki/Ctags)* extensively in Vim to let me move around source code quickly. Ctags
is used to build a map of identifiers in code, and the files where those identifiers are defined. With a proper tags
file, I can use `Ctrl+]` on an identifier, and Vim will open up the current buffer with the file and location where that
identifier is defined. The problem is, for top-scoped puppet identifiers, the identifier doesn't map to a file location
directly, because of the leading '::'. The key binding defined on lines 10 and 11 (courtesy of Marius Gedminas,
[@mgedmin](https://twitter.com/mgedmin)) remaps the default tag movement key, to first strip any leading '::' from the
identifier under my cursor, before trying to locate and move to the corresponding definition. Line 10 follows the tag in
the current buffer, and line 11 opens the tag in a new tab.

Line 12 disables active [Syntastic](https://github.com/scrooloose/syntastic) syntax checking. Puppet syntax checking can
be done by shelling out to the Puppet parser, but that's quite an expensive operation. I prefer to just do an explicit
syntax check before I commit changes to Git.  If anybody knows of a non-expensive way to leave active syntax checking
turned on without causing Vim to run like a snail, let me know!

Line 13 onwards makes sure that when [Tagbar](https://majutsushi.github.io/tagbar/) is toggled, I can see, and navigate
using any tags available for the Puppet file I'm editing.
