require'fzf-lua'.setup {
  keymap = {
    fzf = {
      ["alt-space"] = "select"
    }
  },
  buffers = {
    cwd_only = true,
  }
}
