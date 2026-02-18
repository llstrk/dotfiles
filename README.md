Dependencies:
 - gcc / clang
 - make
 - ripgrep
 - fzf
 - lazygit
 - oh-my-zsh
   - powerline10k
   - zsh-syntax-highlighting
   - zsh-autosuggestions
   - zsh-vi-mode

Stow packages:
 - nvim (`~/.config/nvim`)
 - lazygit (`~/.config/lazygit`)
 - local-bin (`~/.local/bin`)
 - zsh (`~/.zshrc`)
 - tmux (`~/.tmux.conf`)

Apply:

```bash
stow -t "$HOME" nvim lazygit local-bin zsh tmux
```

Dry run:

```bash
stow -n -v -t "$HOME" nvim lazygit local-bin zsh tmux
```
