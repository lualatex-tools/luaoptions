---
documentclass: lyluatexmanual
title: "\\texttt{luaoptions}"
subtitle: "1.0 beta"
date: \lyluatexmanualdate
author:
- Fr. Jacques Peron
- Urs Liska
---

\thispagestyle{empty}
\enlargethispage*{3\baselineskip}

# Introduction

`luaoptions` is a  \LuaLaTeX\ package providing extensive support for handling
*options*, on package level and locally.  It is hosted at
<https://github.com/lualatex-tools/luaoptions> and maintained by Jacques Peron
(<cataclop@hotmail.com>) and Urs Liska (<git@ursliska.de>).  The package was
originally developed as part of the `lyluatex`
package^[<https://github.com/jperon/lyluatex>] but has now been extracted as a
standalone package because we realized it can be a useful tool for arbitrary
\LuaLaTeX\ packages having to deal with *options* -- both *package options* and
*optional macro arguments*.  A `lyluatex` installation should not be a
dependency for packages that want to make use of option handling but are not
interested in music engraving \dots

`luaoptions` allows the declaration of sets of options, along with defaults,
expected/allowed values and limited type checking.  These options can be
enforced as package options, changed at any point during a document, or
overwritten locally by optional macro arguments.  It is also possible to
instantiate an `Options` object as an independent Lua object, without linking
it to a package.  `luaoptions` can be used to enforce and prepopulate options,
or it can be used to simply handle the parsing of optional `key=value` arguments
into proper Lua tables.

This initial release does *not* include documentation beyond this short
introduction.  The release is necessary and intended in order to make possible
the release of the `luaformatters`
package^[<https://github.com/lualatex-tools/luaformatters>] -- the development
of which was the motivation for singling out `luaoptions` as a standalone
package.  The plan is to provide a `v1.0f` release along with a version 1 of
`luaformatters`, with a full manual by then.  `luaoptions` can be useful for
arbitrary Lua-based \LaTeX\ packages, and we hope that with a proper manual this
will become actually usable.

For the time being it is possible to look into how some of our own packages make
use of `luaoptions`:

* <https://github.com/jperon/lyluatex/blob/master/lyluatextools.sty>
* <https://github.com/jperon/lyluatex/blob/master/lyluatex.lua>
* <https://github.com/lualatex-tools/luaformatters/blob/master/luaformatters.sty>
* <https://github.com/lualatex-tools/luaformatters/blob/master/luaformatters.lua>
* <https://github.com/lualatex-tools/luaformatters/blob/master/submodules/luaformatters-formatter.lua>
