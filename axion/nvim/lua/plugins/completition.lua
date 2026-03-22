return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",

		version = "v0.*",

		opts = {
			keymap = { preset = "default", ["<CR>"] = { "select_and_accept", "fallback" } },

			cmdline = {
			  enabled = false
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			signature = { enabled = true },
		},
	},
}
