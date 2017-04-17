---
layout: post
title: "Profile Switching With iTerm, tmux and Vim"
date: 2017-04-15 22:40:30 +0100
published: true
author: Max Manders
tags:
categories:
---
I'll start with a little video demo, which I'll discuss in the remainder of this post. The video below shows me using my
default terminal, _iTerm 3_. I use _tmux_ and _Vim_ inside iTerm3 all the time. I use the ever popular Solarized theme /
colour palette. Sometimes though, I'd like to switch between the _dark_ and _light_ versions of Solarized. Before I
made the tweaks I'll discuss below, this was a bit cumbersome, and I typically stuck to the _dark_ theme. Being able to
readily change between _dark_ and _light_ themes is great for giving my eyes a bit of a change, and helping with
fatigue.

{% include youtube.html id="Ly33hecBNCA" %}

If you're not using tmux, you can switch between different iTerm profiles by echoing this handy escape sequence.

{% highlight bash %}
echo -ne "\033]50;SetProfile=ThemeName\a"
{% endhighlight bash %}

Unfortunately, this doesn't work from inside a running tmux session. When inside tmux, the only way I've found to switch
profiles is to use the 'Edit Session' option from the iTerm context menu. This is a few mouse clicks, and I prefer to
keep my hands on the keyboard. My solution is to use a couple of keyboard shortcuts. To switch between the dark and
light themes more easily, I've assigned a couple of keyboard shortcuts. I can press `^⌘k` for dar**k** and `^⌘l` for
**l**ight. You'll notice though that when I switch between the dark and light themes, the tmux status line at the bottom
of the screen doesn't change between dark and light themes.

I use [vim-airline](https://github.com/vim-airline/vim-airline) and [tmuxline](https://github.com/edkolev/tmuxline.vim)
to manage both my Vim and tmux status lines. The vim-airline plugin adds a bit of eye candy to the top tab line and
bottom status line. The tmuxline plugin allows me to apply the same theme to my tmux status line.  Running the
`:TmuxlineSnapshot /path/to/output` command in Vim, will generate a config file that can be sourced by tmux to apply a
consistent style to the tmux status line. This can be sourced in my `tmux.conf` with the `source-file` option.

![tmux vim screenshot](/img/tmux-vim-screenshot.png){:height="600px"}
![tmux vim screenshot light](/img/tmux-vim-screenshot-light.png){:height="600px"}

I can switch between the dark and light versions of the Solarized theme with a key binding, which you can see in the
snippet below: `<Leader>bg`. This looks pretty ugly if I haven't changed the iTerm theme to match. Some parts of the
screen have changed, including the tab and status lines. But the iTerm theme is still affecting some of the window. To
get around this, I can use the keyboard shortcuts I mentioned earlier to flip my iTerm profile to match.

![tmux vim screenshot with inconsistent colours](/img/tmux-vim-screenshot-yuck.png){:height="600px"}

The specific bits of Vim config I use can be seen below.

{% highlight vim %}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
...
set t_Co=256
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>:Tmuxline<CR>
...
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_inactive_collapse = 0
let g:virtualenv_auto_activate = 1
set laststatus=2
...
let g:tmuxline_theme = 'airline'
let g:tmuxline_preset = {
    \ 'a': '#S',
    \ 'b': '#F',
    \ 'c': '#W',
    \ 'win': ['#I', '#W'],
    \ 'cwin': ['#I', '#W'],
    \ 'x': '%a',
    \ 'y': ['%b %d', '%R'],
    \ 'z': ['#h', '#{?pane_synchronized, #[bg=blue] !SYNC! #[default],}'],
    \'options' : {'status-justify' : 'left'}}
{% endhighlight vimrc %}

But what happens if I haven't opened Vim yet? When I open Vim, it will enforce the correct styling for both the Vim and
tmux status lines. If I switch iTerm profiles though, and I haven't opened Vim, I'll get a tmux status line that doesn't
match the colour scheme. To solve this problem, I do open Vim - but just very quickly, via some shell functions, to set
the background style and to call the Tmuxline command.

{% highlight bash %}
setbg() {
  local bg="${1}"
  if egrep -q -i "light|dark" <(echo ${bg}); then
    vim -c ":set background=${bg}" +Tmuxline +qall
  fi
}
{% endhighlight bash %}

With this function, I can easily run `setbg light` or `setbg dark` to make sure my tmux status line matches my iTerm
profile.

I spend a lot of my time in a terminal, so having something that looks aesthetically pleasing, and is functional and
useful, is very important to me. I hope this helps some other folk out there.
