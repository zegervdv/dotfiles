local wezterm = require 'wezterm'

local localcfg_ok, localcfg = pcall(require, 'localconfig')

local config = {
  hide_tab_bar_if_only_one_tab = true,

  -- Color scheme
  colors = {
    foreground = '#abb2bf',
    background = '#282c34',
    cursor_bg = '#eeeeee',
    cursor_border = '#eeeeee',

    selection_bg = '#ffc24b',

    ansi = {
      '#393e48',
      '#f43753',
      '#c9d05c',
      '#ffc24b',
      '#b3deef',
      '#c678dd',
      '#73cef4',
      '#eeeeee',
    },
    brights = {
      '#393e48',
      '#f43753',
      '#c9d05c',
      '#ffc24b',
      '#b3deef',
      '#c678dd',
      '#73cef4',
      '#ffffff',
    },

    tab_bar = {
      background = '#3a3f4b',
      active_tab = {
        bg_color = '#61afef',
        fg_color = '#282c34',
      },
      inactive_tab = {
        bg_color = '#3a3f4b',
        fg_color = '#abb2bf',
      },
      inactive_tab_hover = {
        bg_color = '#3a3f4b',
        fg_color = '#abb2bf',
        italic = false,
      },
      new_tab = {
        bg_color = '#3a3f4b',
        fg_color = '#abb2bf',
        italic = false,
      },
      new_tab_hover = {
        bg_color = '#3a3f4b',
        fg_color = '#abb2bf',
        italic = false,
      },
    },
  },
  window_padding = {
    left = 8,
    right = 8,
    top = 0,
    bottom = 8,
  },
  -- Font settings
  font = wezterm.font_with_fallback {
    { family = 'Fira Code Retina', weight = 'Medium', italic = false },
    { family = 'Iosevka Term Italic' },
  },
  font_size = 9.0,
}

if localcfg_ok then config.ssh_domains = localcfg.ssh_domains end

return config
