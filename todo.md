- Remove navic dead code
- Check for `smoothscroll` and remove my wrap cursor behavior
- Check for virtual inline text `nvim_buf_set_extmark()`
- vim.diagnostic.config() now accepts a function for the virtual_text.prefix
  option, which allows for rendering e.g., diagnostic severities differently.
