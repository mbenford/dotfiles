vim.g.git = { head = "", ahead = 0, behind = 0 }

local function set(key, value)
	local git = vim.g.git
	git[key] = value
	vim.g.git = git
end

-- Returns the current git branch name for the repository
local function get_branch()
	vim.system({
		"git",
		"rev-parse",
		"--abbrev-ref",
		"HEAD",
	}, { text = true }, function(result)
		if result.code ~= 0 then
			set("head", "")
			return
		end

		set("head", result.stdout:gsub("\n", ""))
	end)
end

-- Retrieves and processes the commit counts ahead and behind from upstream branch
local function get_commits()
	vim.system({
		"git",
		"rev-list",
		"--count",
		"--left-right",
		"HEAD...@{upstream}",
	}, { cwd = vim.fn.getcwd(), text = true }, function(result)
		if result.code ~= 0 then
			set("ahead", 0)
			set("behind", 0)
			return
		end

		local ok, ahead, behind = pcall(string.match, result.stdout, "(%d+)%s*(%d+)")
		if not ok then
			ahead, behind = 0, 0
		end

		set("ahead", tonumber(ahead))
		set("behind", tonumber(behind))
	end)
end

-- Checks the git repository status and updates the state with 'clean' if no changes,
-- 'dirty' if there are uncommitted changes
local function get_status()
	vim.system({
		"git",
		"status",
		"--porcelain",
	}, { text = true }, function(result)
		if result.code ~= 0 then
			set("status", nil)
			return
		end

		set("status", result.stdout == "" and "clean" or "dirty")
	end)
end

local function update()
	get_branch()
	get_commits()
	get_status()
end

update()
local timer = vim.uv.new_timer()
timer:start(0, 10000, vim.schedule_wrap(update))

vim.api.nvim_create_autocmd("BufWritePost", {
	group = "Custom",
	callback = require("utils.misc").debounce(function()
		get_status()
	end, 1000),
})
