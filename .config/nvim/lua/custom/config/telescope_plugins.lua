local present, telescope = pcall(require, "telescope")
if not present then
	return
end
local M = {}
M.project = function()
	telescope.load_extension("projects")
end
return M
