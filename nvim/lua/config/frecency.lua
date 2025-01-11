local function get_hash()
  -- The get_hash() is utilised to create an independent "store"
  -- By default `fre --add` adds to global history, in order to restrict this to
  -- current directory we can create a hash which will keep history separate.
  -- With this in mind, we can also append git branch to make sorting based on 
  -- Current dir + git branch
  local str = 'echo "dir:' .. vim.fn.getcwd()
  if vim.b.gitsigns_head then
    str = str .. ';git:' .. vim.b.gitsigns_head .. '"'
  end
  -- vim.print(str)
  local hash = vim.fn.system(str .. " | md5sum | awk '{print $1}'")
  return hash
end

vim.keymap.set(
  "n",
  "<leader>f",
  function()
    require'fzf-lua'.fzf_exec(
      "sh -c 'cat <(fre --sorted) <(fd -t f) | awk \'!x[$0]++\''",
      {
        fzf_opts = {
          ['--no-sort'] = '',
          ['--tiebreak'] = 'index',
        },
      }
    )
  end,
  {desc="Open Files"}
)

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("frecency", {clear=true}),
  callback = function(ev)
    local exclude = { "gitcommit" }

    if not ev.file then return end

    if vim.tbl_contains(exclude, vim.bo[ev.buf].filetype) then
      return
    end

    -- local hash = get_hash()
    vim.fn.system('fre --add ' .. ev.file)
  end
})
