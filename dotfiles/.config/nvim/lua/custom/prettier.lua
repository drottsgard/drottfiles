local function on_save(buffer)
	buffer = buffer or vim.api.nvim_get_current_buf()

	return vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("Prettier-On-Save", { clear = true }),
		buffer = buffer,
		callback = function()
			local filename = vim.fn.expand("%")
			local command = { "prettierd", filename }

			local savedText = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
			local result = vim.fn.system(command, savedText)

			-- Take prettier's output and turn it into an array of lines
			local formatted_lines = vim.split(result, "\n", { trimempty = true })

			-- Replace the current buffer's contents with those new lines
			vim.api.nvim_buf_set_lines(buffer, 0, -1, false, formatted_lines)
		end
	})
end

return {
	on_save = on_save
}
