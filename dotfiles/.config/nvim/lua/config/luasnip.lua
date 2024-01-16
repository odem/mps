-- Import api
local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

vim.keymap.set({ "i", "s" }, "<A-n>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<A-p>", function()
	if ls.expand_or_jumpable(-1) then
		ls.expand_or_jump(-1)
	end
end, { silent = true })

-- Snippets
ls.add_snippets("python", {
	s("hello_simple", {
		t('print("hello world")'),
	}),
})

ls.add_snippets("python", {
	s("print", {
		t('print("'),
		i(1),
		t(""),
		t('")'),
	}),
})

ls.add_snippets("rest", {
	s("template-rest-request", {
		t({
			"# Host",
			"https://httpbin.org:443",
			"",
			"# Curl options",
			"--silent",
			"--insecure",
			"#--include",
			"",
			"# Headers",
			"Accept: application/json;",
			"Connection: keep-alive",
			"Content-Type: application/json; charset=utf-8",
			"User-Agent: VRC",
			"",
			"# Query",
			"POST /anything",
			"",
			"# Body",
			"{",
			'"test" : 1234',
			"}",
		}),
	}),
})
