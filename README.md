# colorscheme-randomizer.nvim
`colorscheme-randomizer.nvim` introduces the ability to randomly apply various available colorschemes.

## ✨ Features

- Randomly apply available colorschemes
- Automatically finds colorscheme plugins
    - `lazy.nvim` supported
- API to apply more colorschemes randomly

## ⚡️ Requirements

- Modern Neovim

## Optional

- `lazy.nvim` package manager to automatically find installed colorschemes
    - More package manager support to be added later

## 📦 Installation

```lua
require("colorscheme-randomizer").setup(opts)
```

- **opts**: see [Configuration](colorscheme-randomizer.nvim-configuration)

```lua
-- Example using a list of specs with the default options

require("colorscheme-randomizer").setup({
	apply_scheme = true,
	plugin_strategy = nil,
	plugins = nil,
	colorschemes = nil,
	exclude_colorschemes = nil,
})
```

# Configuration

| Property             | Type                               | Description                                                                                                                                                |
| -----------------    | ---------------------------------- | ---------------------------------------------------------------------------------------------                                                              |
| apply_scheme         | `boolean?`                         | Apply the colorscheme after being picked.                                                                                                                  |
| colorschemes         | `table?`                           | list of colorschemes to randomly select from. When specified, this list is the **only** source of truth to choose from.                                    |
| exclude_colorschemes | `table?`                           | list of colorschemes to remove from colorschemes. useful when wanting to use `plugin_strategy` and ignore some colorschemes.                               |
| plugin_strategy      | `string?`                          | `lazy` is the only supported option. Strategy used to resolve `plugin` names to `colorscheme` names                                                        |
| plugins              | `table?`                           | list of colorscheme plugins to look through to resolve colorschemes. When unspecified, all colorschemes are attempted to be resolved via `plugin_strategy` |

## API

<!-- api:start -->

```lua
--- Randomly chooses another colorscheme. Respects `apply_scheme`.
require("colorscheme-randomizer").randomize()
```

```lua
require("colorscheme-randomizer").results = {
    --- string
    curr_colorscheme = ""
    --- table list of colorschemes to choose from
    colorschemes = {}
}
```

<!-- api:end -->

