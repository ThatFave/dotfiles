local M = {}

M.keywords = {
  TODO = { icon = " ", color = "info" },
  HACK = { icon = " ", color = "warning" },
  WARN = { icon = " ", color = "warning" },
  PERF = { icon = " ", color = "default" },
  NOTE = { icon = " ", color = "hint" },
  TEST = { icon = "⏲ ", color = "test" },
}

M.colors = {
  error   = { "DiagnosticError", "ErrorMsg", "#DC2626" },
  warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
  info    = { "DiagnosticInfo", "#2563EB" },
  hint    = { "DiagnosticHint", "#10B981" },
  default = { "Identifier", "#7C3AED" },
  test    = { "Identifier", "#FF00FF" },
}

M.ns = vim.api.nvim_create_namespace("todo-highlighter")

local function define_signs()
  for kw, opts in pairs(M.keywords) do
    local group = "Todo" .. kw
    local color = M.colors[opts.color or "default"]
    vim.api.nvim_set_hl(0, group, { fg = color[3], bold = true })
    vim.fn.sign_define(group, { text = opts.icon, texthl = group })
  end
end

local function apply(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, M.ns, 0, -1)
  vim.fn.sign_unplace("todo-highlighter", { buffer = bufnr })

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for lnum, line in ipairs(lines) do
    for kw, opts in pairs(M.keywords) do
      local s, e = string.find(line, "%f[%w]" .. kw .. "%f[%W]")
      if s then
        local group = "Todo" .. kw
        vim.fn.sign_place(0, "todo-highlighter", group, bufnr, { lnum = lnum, priority = 10 })
        vim.api.nvim_buf_set_extmark(bufnr, M.ns, lnum - 1, e, {
          virt_text = { { opts.icon .. kw, group } },
          virt_text_pos = "eol",
        })
      end
    end
  end
end

function M.setup()
  define_signs()
  vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("TodoHighlighter", { clear = true }),
    callback = function(args)
      apply(args.buf)
    end,
  })
end

return M


