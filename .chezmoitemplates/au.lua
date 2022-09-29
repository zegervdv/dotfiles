--
-- Copied from https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da
--

local function autocmd(this, event, spec)
  local is_table = type(spec) == 'table'
  local pattern = is_table and spec[1] or '*'
  local action = is_table and spec[2] or spec

  local opts = { pattern = pattern }
  if type(action) == 'function' then
    opts.callback = action
  else
    opts.command = action
  end

  vim.api.nvim_create_autocmd(event, opts)
end

local S = {
  __au = {},
}

local X = setmetatable({}, {
  __index = S,
  __newindex = autocmd,
  __call = autocmd,
})

function S.exec(id) S.__au[id]() end

function S.set(fn)
  local id = string.format('%p', fn)
  S.__au[id] = fn
  return string.format('lua require("au").exec("%s")', id)
end

function S.group(grp, cmds)
  vim.api.nvim_create_augroup(grp, { clear = true })
  if type(cmds) == 'function' then
    -- TODO set group?
    cmds(X)
  else
    for _, au in ipairs(cmds) do
      local opts = { group = grp, pattern = au[2] }
      if type(au[3]) == 'function' then
        opts.callback = au[3]
      else
        opts.command = au[3]
      end
      vim.api.nvim_create_autocmd(au[1], opts)
    end
  end
end

return X
