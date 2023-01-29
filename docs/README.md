<h1 align="center">
  <a href="https://github.com/z-shell/zi">
    <img align="center" src="https://github.com/z-shell/zi/raw/main/docs/images/logo.png" alt="Logo" width="60px" height="60px" />
  </a> ❮ Zsh Command Architect ❯
</h1>
<h2 align="center">
  <p><samp><code>ZCA</code></samp> allows to copy segments of commands in history, rearrange segments of current command, delete segments of current command. </p>
</h2>
<h3 align="center">
  <p>This way user glues command from parts without using a mouse. Advanced history search (multi word, without duplicate lines) allows to quickly find the parts.</p>
</h3><hr />

<!-- <p><img align="center" src="https://raw.githubusercontent.com/z-shell/z-a-rust/main/docs/images/annex-rust.gif" alt="Zi annex rust" width="100%" height="auto" /></p> -->

## 💡 Wiki: [ZCA](https://wiki.zshell.dev/ecosystem/plugins/zsh-cmd-architect) - [Plugins](https://wiki.zshell.dev/ecosystem/category/%EF%B8%8F-plugins)

| Keys                                                                                        | Description                                                                       |
| ------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| <kbd><kbd>Ctrl</kbd>+<kbd>T</kbd></kbd>                                                     | Start Zsh Command Architect (Zshell binding)                                      |
| <kbd>Enter</kbd>                                                                            | Delete selected segment (command window) or add selected segment (history window) |
| <kbd>[</kbd> or <kbd>]</kbd>                                                                | Move active segment (when in command window)                                      |
| <kbd><kbd>Shift</kbd>+<kbd>left</kbd></kbd> or <kbd><kbd>Shift</kbd>+<kbd>right</kbd></kbd> | Move active segment (when in command window)                                      |
| <kbd>Tab</kbd>                                                                              | Switch between the two available windows                                          |
| <kbd>g</kbd>, <kbd>G</kbd>                                                                  | Beginning and end of the list                                                     |
| <kbd>/</kbd>                                                                                | Start incremental search                                                          |
| <kbd>Esc</kbd>                                                                              | Exit incremental search, clearing filter                                          |
| <kbd><</kbd>,<kbd>></kbd>, <kbd>{</kbd>,<kbd>}</kbd>                                        | Horizontal scroll                                                                 |
| <kbd><kbd>Ctrl</kbd>+<kbd>L</kbd></kbd>                                                     | Redraw of whole display                                                           |
| <kbd><kbd>Ctrl</kbd>+<kbd>O</kbd></kbd>, <kbd>o</kbd>                                       | Enter uniq mode (no duplicate lines)                                              |
| <kbd><kbd>Ctrl</kbd>+<kbd>W</kbd></kbd>                                                     | (in incremental search) - delete whole word                                       |
| <kbd><kbd>Ctrl</kbd>+<kbd>K</kbd></kbd>                                                     | (in incremental search) - delete whole line                                       |
| <kbd><kbd>Ctrl</kbd>+<kbd>D</kbd></kbd>, <kbd><kbd>Ctrl</kbd>+<kbd>U</kbd></kbd>            | Half page up or down                                                              |
| <kbd><kbd>Ctrl</kbd>+<kbd>P</kbd></kbd>, <kbd><kbd>Ctrl</kbd>+<kbd>N</kbd></kbd>            | Previous and next (also done with vim's <kbd>j</kbd>,<kbd>k</kbd>)                |

## Installation

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/z-shell/zsh-cmd-architect/main/doc/install.sh)"
```

To update run the command again.

`ZCA` will be installed at `~/.config/zca/zsh-cmd-architect`, config files will be copied to `~/.config/zca`. `.zshrc` will be updated with code snippet at the bottom.

> After installing and reloading shell give `ZCA` a quick try with <kbd><kbd>Ctrl</kbd>+<kbd>T</kbd></kbd>.

### Installation With [Zi](https://github.com/z-shell/zi)

Add `zi load z-shell/zsh-cmd-architect` to `.zshrc`.

### Installation With Zgen

Add `zgen load z-shell/zsh-cmd-architect` to `.zshrc` and issue a `zgen reset` (this assumes that there is a proper `zgen save` construct in `.zshrc`).

### Installation With Antigen

Add `antigen bundle z-shell/zsh-cmd-architect` to `.zshrc`. There also should be `antigen apply`.

### Manual Installation

After extracting `ZCA` to `{some-directory}` add following two lines to `~/.zshrc`:

```shell
fpath+=( {some-directory} )
source "{some-directory}/zsh-cmd-architect.plugin.zsh"
```

As you can see, no plugin manager is needed to use the `*.plugin.zsh`
file. The above two lines of code are all that almost **all** plugin
managers do. In fact, what's actually needed is only:

```shell
source "{some-directory}/zsh-cmd-architect.plugin.zsh"
```

`ZCA` detects if it is used by **any** plugin manager and can
handle `$fpath` update by itself.

### Single File Manual Installation

Running script `doc/generate_single_file` will create single-file version of `ZCA`.

It can be sourced from `.zshrc`.

> **Note:**
>
> - Don't forget about configuration files (copy them to `~/.config/zca`).

## Performance

`ZCA` is fastest with `Zsh` before `5.0.6` and starting from `5.2`

<details>
<summary>Fixing tmux, screen and linux vt</summary>

If `TERM=screen-256color` (often a case for `tmux` and `screen` sessions) then
`ncv` terminfo capability will have `2`nd bit set. This in general means that
underline won't work. To fix this by creating your own `ncv=0`-equipped
terminfo file, run:

```shell
{ infocmp -x screen-256color; printf '\t%s\n' 'ncv@,'; } > /tmp/t && tic -x /tmp/t
```

A file will be created in directory `~/.terminfo` and will be automatically
used, `tmux` and `screen` will work. Similar is for Linux virtual terminal:

```shell
{ infocmp -x linux; printf '\t%s\n' 'ncv@,'; } > /tmp/t && tic -x /tmp/t
```

It will not display underline properly, but will instead highlight by a color,
which is quite nice. The same will not work for FreeBSD's vt, `ZCA` will detect
if that vt is used and will revert to highlighting elements via `reverse` mode.

</details>

<hr />

> Also check out [Zsh Navigation Tools](https://github.com/z-shell/zsh-navigation-tools) and [Zsh Editing Workbench](https://github.com/z-shell/zsh-editing-workbench)
