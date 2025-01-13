vim.g.git = { head = "", ahead = 0, behind = 0 }

local function set(key, value)
	local git = vim.g.git
	git[key] = value
	vim.g.git = git
end

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

local function update()
	get_branch()
	get_commits()
end

update()
local timer = vim.uv.new_timer()
timer:start(0, 10000, vim.schedule_wrap(update))
