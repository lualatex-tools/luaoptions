# `luaoptions`
Option handling for LuaLaTeX packages

This package has been extracted from
[`lyluatex`](https://github.com/jperon/lyluatex) where it was originally
developed as supporting functionality. However, as it turned out it is useful
as a building block for LuaLaTeX packages in general, and the development of
[`luaformatters`](https://github.com/lualatex-tools/luaformatters) made it
clear that the option handling code had to be moved to a standalone package.

Initially there is no extensive documentation available since the package wasn't
originally intended to be exposed to third-party packages or even end-users;
the best sources of documentation are `lyluatex` and `luaformatters` codes,
and the docstrings of `luaoptions.lua` and `luaoptions-lib.lua`.
