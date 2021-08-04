-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local luasnip = require 'luasnip'
-- some shorthands...
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda

local function phpdoc(args, old_state)
	local nodes = {
		t({ "/**", " * " }),
		i(1, "A short Description"),
		t({ "", "" }),
	}

	-- These will be merged with the snippet; that way, should the snippet be updated,
	-- some user input eg. text can be referred to in the new snippet.
	local param_nodes = {}

	if old_state then
		nodes[2] = i(1, old_state.descr:get_text())
	end
	param_nodes.descr = nodes[2]

	-- At least one param.
	if string.find(args[2][1], ", ") then
		vim.list_extend(nodes, { t({ " * ", "" }) })
	end

	local insert = 2
	for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
		-- Get actual name parameter.
		arg = vim.split(arg, " ", true)[2]
		if arg then
			local inode
			-- if there was some text in this parameter, use it as static_text for this new snippet.
			if old_state and old_state[arg] then
				inode = i(insert, old_state["arg" .. arg]:get_text())
			else
				inode = i(insert)
			end
			vim.list_extend(
				nodes,
				{ t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
			)
			param_nodes["arg" .. arg] = inode

			insert = insert + 1
		end
	end

	if args[1][1] ~= "void" then
		local inode
		if old_state and old_state.ret then
			inode = i(insert, old_state.ret:get_text())
		else
			inode = i(insert)
		end

		vim.list_extend(
			nodes,
			{ t({ " * ", " * @return " }), inode, t({ "", "" }) }
		)
		param_nodes.ret = inode
		insert = insert + 1
	end

	vim.list_extend(nodes, { t({ " */" }) })

	local snip = sn(nil, nodes)
	snip.old_state = param_nodes
	return snip
end
luasnip.snippets = {
	php = {
		s('fn', {
			-- d(6, phpdoc, { 5, 4 }),
			-- t("", ""),
			c(1, {
				t("public "),
				t("private "),
				t("protected "),
			}),
			c(2, {
				t(""),
				t("static "),
			}),
			t("function "),
			i(3),
			t("("),
			i(4),
			t(")"),
			c(5, {
				t(""),
				t(": bool"),
				t(": string"),
				t(": int"),
				t(": self"),
				i(nil, ": "),
			}),
			t({ " {", "\t"}),
			i(0),
			t({"", "}"}),
		}),
		s('class', {
			t("class "),
			i(1),
			t(" "),
			c(2, {
				t("{"),
				sn(nil, {
					t("extends "),
					i(1),
					t(" {"),
				}),
				sn(nil, {
					t("implements "),
					i(1),
					t(" {"),
				}),
			}),
			t({"", "\t"}),
			i(0),
			t({ "", "}"}),
		})
	}
}

-- Utility functions for compe and luasnip
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t "<cmd>lua require'luasnip'.jump(1)<CR>"
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t "<cmd>lua require'luasnip'.jump(-1)<CR>"
  else
    return t '<S-Tab>'
  end
end

_G.change_choice = function()
	if luasnip.choice_active() then
		return t "<cmd>lua require'luasnip'.change_choice(1)<CR>"
	else
	return t '<C-E>'
	end
end
