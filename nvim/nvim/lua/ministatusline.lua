--- *mini.statusline* Statusline
--- *MiniStatusline*
---
--- MIT License Copyright (c) 2021 Evgeni Chasnovski
---
---@alias __statusline_args table Section arguments.
---@alias __statusline_section string Section string.

-- Module definition ==========================================================
local MiniStatusline = {}
local H = {}

--- Module setup
---
---@param config table|nil Module config table. See |MiniStatusline.config|.
---
---@usage `require('mini.statusline').setup({})` (replace `{}` with your `config` table)
MiniStatusline.setup = function(config)
  -- Export module
  _G.MiniStatusline = MiniStatusline

  -- Setup config
  config = H.setup_config(config)

  -- Apply config
  H.apply_config(config)

  -- Define behavior
  H.create_autocommands()

  -- - Disable built-in statusline in Quickfix window
  vim.g.qf_disable_statusline = 1

  -- Create default highlighting
  H.create_default_hl()
end

--- Module config
---
--- Default values:
MiniStatusline.config = {
  -- Whether to use icons by default
  use_icons = true,
}

-- Module functionality =======================================================
--- Compute content for active window
MiniStatusline.active = function()
  -- stylua: ignore start
  local mode, mode_hl = MiniStatusline.section_mode()
  local git           = MiniStatusline.section_git()
  local location      = MiniStatusline.section_location()
  local filename      = MiniStatusline.section_filename()
  local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

  -- Usage of `MiniStatusline.combine_groups()` ensures highlighting and
  -- correct padding with spaces between groups (accounts for 'missing'
  -- sections, etc.)
  return MiniStatusline.combine_groups({
    { hl = mode_hl,                  strings = { mode } },
    { hl = 'MiniStatuslineDevinfo',  strings = { git } },
    '%<', -- Mark general truncate point
    { hl = 'MiniStatuslineFilename', strings = { filename } },
    '%=', -- End left alignment
    { hl = 'MiniStatuslineFileinfo', strings = { search } },
    { hl = mode_hl,                  strings = { location } },
  })
  -- stylua: ignore end
end

--- Compute content for inactive window
MiniStatusline.inactive = function()
  return MiniStatusline.combine_groups({
    { hl = 'MiniStatuslineInactive' },
    '%=', -- End left alignment
    { strings = { '%f' } },
    '%=', -- End left alignment
  })
end

--- Combine groups of sections
---
--- Each group can be either a string or a table with fields `hl` (group's
--- highlight group) and `strings` (strings representing sections).
---
--- General idea of this function is as follows;
--- - String group is used as is (useful for special strings like `%<` or `%=`).
--- - Each table group has own highlighting in `hl` field (if missing, the
---   previous one is used) and string parts in `strings` field. Non-empty
---   strings from `strings` are separated by one space. Non-empty groups are
---   separated by two spaces (one for each highlighting).
---
---@param groups table Array of groups.
---
---@return string String suitable for 'statusline'.
MiniStatusline.combine_groups = function(groups)
  local parts = vim.tbl_map(function(s)
    --stylua: ignore start
    if type(s) == 'string' then return s end
    if type(s) ~= 'table' then return '' end

    local string_arr = vim.tbl_filter(function(x) return type(x) == 'string' and x ~= '' end, s.strings or {})
    local str = table.concat(string_arr, ' ')

    -- Use previous highlight group
    if s.hl == nil then
      return (' %s '):format(str)
    end

    -- Allow using this highlight group later
    if str:len() == 0 then
      return string.format('%%#%s#', s.hl)
    end

    return string.format('%%#%s# %s ', s.hl, str)
    --stylua: ignore end
  end, groups)

  return table.concat(parts, '')
end

--- Decide whether to truncate
---
--- This basically computes window width and compares it to `trunc_width`: if
--- window is smaller then truncate; otherwise don't. Don't truncate by
--- default.
---
--- Use this to manually decide if section needs truncation or not.
---
---@param trunc_width number|nil Truncation width. If `nil`, output is `false`.
---
---@return boolean Whether to truncate.
MiniStatusline.is_truncated = function(trunc_width)
  -- Use -1 to default to 'not truncated'
  local cur_width = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
  return cur_width < (trunc_width or -1)
end

-- Sections ===================================================================
-- Functions should return output text without whitespace on sides.
-- Return empty string to omit section.

--- Section for Vim |mode()|
---
--- Short output is returned if window width is lower than `args.trunc_width`.
---
---@return ... Section string and mode's highlight group.
MiniStatusline.section_mode = function()
  local mode_info = H.modes[vim.fn.mode()]

  return mode_info.short, mode_info.hl
end

--- Section for Git information
---
--- Normal output contains name of `HEAD` (via |b:gitsigns_head|) and chunk
--- information (via |b:gitsigns_status|). Short output - only name of `HEAD`.
--- Note: requires 'lewis6991/gitsigns' plugin.
---
--- Short output is returned if window width is lower than `args.trunc_width`.
---
---@return __statusline_section
MiniStatusline.section_git = function()
  if H.isnt_normal_buffer() then return '' end

  local signs = vim.b.gitsigns_status or ''

  if signs == '' then return '' end

  return string.format('%s %s', '', signs)
end

--- Section for file name
---
--- There are three states of file name depending on filename lenght:
--- 1. File name with path relative to current directory.
--- 2. File name with shortened path from current directory.
--- 3. Only file name.
---
---@return __statusline_section
MiniStatusline.section_filename = function()
  -- In terminal always use plain name
  if vim.bo.buftype == 'terminal' or vim.bo.buftype == 'quickfix' then
    return '%t'
  end

  local filename = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  if filename:len() > 50 then filename = vim.fn.pathshorten(filename) end
  if filename:len() > 50 then filename = '%t' end

  return string.format('%s %s%s', H.get_filetype_icon(), filename, '%m%r') -- 'modified', 'readonly' flags
end

--- Section for location inside buffer
---
---@return __statusline_section
MiniStatusline.section_location = function()
  return '%l:%v (%p%%)'
end

--- Section for current search count
---
--- Show the current status of |searchcount()|. Empty output is returned if
--- window width is lower than `args.trunc_width`, search highlighting is not
--- on (see |v:hlsearch|), or if number of search result is 0.
---
--- `args.options` is forwarded to |searchcount()|.  By default it recomputes
--- data on every call which can be computationally expensive (although still
--- usually same order of magnitude as 0.1 ms). To prevent this, supply
--- `args.options = {recompute = false}`.
---
---@param args __statusline_args
---
---@return __statusline_section
MiniStatusline.section_searchcount = function(args)
  if vim.v.hlsearch == 0 or MiniStatusline.is_truncated(args.trunc_width) then return '' end
  -- `searchcount()` can return errors because it is evaluated very often in
  -- statusline. For example, when typing `/` followed by `\(`, it gives E54.
  local ok, s_count = pcall(vim.fn.searchcount, (args or {}).options or { recompute = true })
  if not ok or s_count.current == nil or s_count.total == 0 then return '' end

  if s_count.incomplete == 1 then return '?/?' end

  local too_many = ('>%d'):format(s_count.maxcount)
  local current = s_count.current > s_count.maxcount and too_many or s_count.current
  local total = s_count.total > s_count.maxcount and too_many or s_count.total
  return ('%s/%s'):format(current, total)
end

-- Helper data ================================================================
-- Module default config
H.default_config = MiniStatusline.config

-- Showed diagnostic levels
H.diagnostic_levels = {
  { id = vim.diagnostic.severity.ERROR, sign = 'E' },
  { id = vim.diagnostic.severity.WARN, sign = 'W' },
  { id = vim.diagnostic.severity.INFO, sign = 'I' },
  { id = vim.diagnostic.severity.HINT, sign = 'H' },
}

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
H.setup_config = function(config)
  -- General idea: if some table elements are not present in user-supplied
  -- `config`, take them from default config
  vim.validate({ config = { config, 'table', true } })
  config = vim.tbl_deep_extend('force', H.default_config, config or {})

  -- Validate per nesting level to produce correct error message
  vim.validate({
    use_icons = { config.use_icons, 'boolean' },
  })

  return config
end

H.apply_config = function(config)
  MiniStatusline.config = config
end

H.create_autocommands = function()
  local augroup = vim.api.nvim_create_augroup('MiniStatusline', {})

  local au = function(event, pattern, callback, desc)
    vim.api.nvim_create_autocmd(event, { group = augroup, pattern = pattern, callback = callback, desc = desc })
  end

  local set_active = function() vim.wo.statusline = '%!v:lua.MiniStatusline.active()' end
  au({ 'WinEnter', 'BufEnter' }, '*', set_active, 'Set active statusline')

  local set_inactive = function() vim.wo.statusline = '%!v:lua.MiniStatusline.inactive()' end
  au({ 'WinLeave', 'BufLeave' }, '*', set_inactive, 'Set inactive statusline')
end

--stylua: ignore
H.create_default_hl = function()
  local set_default_hl = function(name, data)
    data.default = true
    vim.api.nvim_set_hl(0, name, data)
  end

  set_default_hl('MiniStatuslineModeNormal',  { link = 'Cursor' })
  set_default_hl('MiniStatuslineModeInsert',  { link = 'DiffChange' })
  set_default_hl('MiniStatuslineModeVisual',  { link = 'DiffAdd' })
  set_default_hl('MiniStatuslineModeReplace', { link = 'DiffDelete' })
  set_default_hl('MiniStatuslineModeCommand', { link = 'DiffText' })
  set_default_hl('MiniStatuslineModeOther',   { link = 'IncSearch' })

  set_default_hl('MiniStatuslineDevinfo',  { link = 'StatusLine' })
  set_default_hl('MiniStatuslineFilename', { link = 'StatusLineNC' })
  set_default_hl('MiniStatuslineFileinfo', { link = 'StatusLine' })
  set_default_hl('MiniStatuslineInactive', { link = 'StatusLineNC' })
end

H.get_config = function(config)
  return vim.tbl_deep_extend('force', MiniStatusline.config, vim.b.ministatusline_config or {}, config or {})
end

-- Mode -----------------------------------------------------------------------
-- Custom `^V` and `^S` symbols to make this file appropriate for copy-paste
-- (otherwise those symbols are not displayed).
local CTRL_S = vim.api.nvim_replace_termcodes('<C-S>', true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes('<C-V>', true, true, true)

-- stylua: ignore start
H.modes = setmetatable({
  ['n']    = { long = 'Normal',   short = 'N',   hl = 'MiniStatuslineModeNormal' },
  ['v']    = { long = 'Visual',   short = 'V',   hl = 'MiniStatuslineModeVisual' },
  ['V']    = { long = 'V-Line',   short = 'V-L', hl = 'MiniStatuslineModeVisual' },
  [CTRL_V] = { long = 'V-Block',  short = 'V-B', hl = 'MiniStatuslineModeVisual' },
  ['s']    = { long = 'Select',   short = 'S',   hl = 'MiniStatuslineModeVisual' },
  ['S']    = { long = 'S-Line',   short = 'S-L', hl = 'MiniStatuslineModeVisual' },
  [CTRL_S] = { long = 'S-Block',  short = 'S-B', hl = 'MiniStatuslineModeVisual' },
  ['i']    = { long = 'Insert',   short = 'I',   hl = 'MiniStatuslineModeInsert' },
  ['R']    = { long = 'Replace',  short = 'R',   hl = 'MiniStatuslineModeReplace' },
  ['c']    = { long = 'Command',  short = 'C',   hl = 'MiniStatuslineModeCommand' },
  ['r']    = { long = 'Prompt',   short = 'P',   hl = 'MiniStatuslineModeOther' },
  ['!']    = { long = 'Shell',    short = 'Sh',  hl = 'MiniStatuslineModeOther' },
  ['t']    = { long = 'Terminal', short = 'T',   hl = 'MiniStatuslineModeOther' },
}, {
  -- By default return 'Unknown' but this shouldn't be needed
  __index = function()
    return   { long = 'Unknown',  short = 'U',   hl = '%#MiniStatuslineModeOther#' }
  end,
})
-- stylua: ignore end

-- Utilities ------------------------------------------------------------------
H.isnt_normal_buffer = function()
  -- For more information see ":h buftype"
  return vim.bo.buftype ~= ''
end

H.get_filetype_icon = function()
  -- Skip if NerdFonts is disabled
  if not H.get_config().use_icons then return '' end
  -- Have this `require()` here to not depend on plugin initialization order
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  if not has_devicons then return '' end

  local file_name, file_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
  return devicons.get_icon(file_name, file_ext, { default = true })
end

H.get_diagnostic_count = function(id) return #vim.diagnostic.get(0, { severity = id }) end

return MiniStatusline
