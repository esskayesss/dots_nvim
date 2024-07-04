-- inspired by https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua 

local lualine = require('lualine')

local colors = {
  bg      = "#0D0F18",
  fg      = "#BDBFCB",
  green   = "#7DC893",
  yellow  = "#D0AD7D",
  yellow_d = "#D18926",
  blue    = "#94D6D8",
  blue_d  = "#217182",
  red     = "#D07676",
  aqua    = "#99FAFF",
}

local checks = {
  empty_buffer = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  is_git_workspace = function()
    local handle = io.popen("git rev-parse --is-inside-work-tree 2> /dev/null")
    if not handle then
      print("couldn't execute git rev-parse")
      return false
    end
    local result = handle:read("*a")
    handle:close()

    return result:match("true") ~= nil
  end,
}


-- config here 
local cfg = {
  options = {
    component_separators = '',
    section_separators = '',

    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg }},
      inactive = { c = { fg = colors.fg, bg = colors.bg }},
    },
  },

  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  }
}

local function get_os_logo()
  local os_patterns = {
    ['windows'] = '󰍲 ',
    ['linux'] = ' ',
    ['mac'] = ' ',
    ['darwin'] = ' ',
    ['^mingw'] = '󰍲 ',
    ['^cygwin'] = '󰍲 ',
    ['bsd$'] = ' ',
  }
  local sysname = string.lower(vim.loop.os_uname().sysname)
  for pattern, logo in pairs(os_patterns) do
    if string.match(sysname, pattern) then
      return logo
    end
  end
  return " "
end

local function insert_left(component)
  table.insert(cfg.sections.lualine_c, component)
end

local function insert_right(component)
  table.insert(cfg.sections.lualine_x, component)
end

-- active bar
insert_left {
  function()
    return '▉'
  end,
  color = { fg = colors.fg}, -- Sets highlighting of component
  padding = { left = 0, right = 0 }, -- We don't need space before this
}

-- logo
insert_left {
  function()
    return get_os_logo()
  end,
  color = function()
    local mode_color = {
      n = colors.blue,
      i = colors.green,
      v = colors.yellow,
      [' '] = colors.blue,
      V = colors.yellow,
      c = colors.aqua,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end
}


insert_left {
  'filename',
  cond = checks.empty_buffer,
  color = { fg = colors.aqua, gui = 'bold'}
}

insert_left {
  'filesize',
  cond = checks.empty_buffer,
}

insert_left {
  'location'
}

insert_left {
  'progress',
  color = { fg = colors.fg, gui = 'bold' }
}

insert_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.aqua },
  },
}

insert_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

insert_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
}

insert_right {
  'filetype',
  color = { bg = colors.blue_d }
}

insert_right {
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' ',
  color = { fg = colors.fg, bg = "#252535", gui = 'bold' },
}

lualine.setup(cfg)
