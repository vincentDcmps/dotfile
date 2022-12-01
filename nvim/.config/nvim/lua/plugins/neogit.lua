local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
    return
end

neogit.setup{
    disable_commit_confirmation = true,
    disable_context_highlighting = true
}

vim.keymap.set('n', '<LEADER>gs', ':Neogit kind=split<CR>', {silent = true})
