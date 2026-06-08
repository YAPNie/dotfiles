return {
	"mason-org/mason.nvim",
	cmd = "Mason",
	opts = {
        -- The provider implementations to use for resolving supplementary
        -- package metadata (e.g., all available versions).
		--   - mason.providers.registry-api  - uses the
		--     https://api.mason-registry.dev API
		--   - mason.providers.client        - uses only client-side tooling to
		--     resolve metadata
		providers = {
			"mason.providers.registry-api",
		},
	},
}
