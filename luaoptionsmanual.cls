%Luaoptions LaTeX class for the manual.
%
% Copyright (C) 2015-2022 the lualatex-tools Project
% License: MIT
% This file is part of luaoptions.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{luaoptionsmanual}[2022/10/30 v0.8]  %%LUAOPTIONS_DATE LUAOPTIONS_VERSION

\LoadClass{luaoptionsbase}

\RequirePackage{fontspec}
\RequirePackage{microtype}
\RequirePackage{libertine}
\setmonofont[Scale=MatchLowercase,StylisticSet=1]{InconsolataN}
\defaultfontfeatures{
	Ligatures=TeX,
	Scale=MatchLowercase,
	Numbers=Proportional,
	Numbers=OldStyle
}
\frenchspacing

\RequirePackage{makeidx}
\makeindex

\newcommand{\linkexample}[2]{
    \addcontentsline{toc}{subsection}{#2}
    \hypertarget{#1}{}
}


\newcommand{\luaoptionsmanualdate}{
	\directlua{
		local PC = string.char(37)
		local date_fmt = PC..'Y-'..PC..'m-'..PC..'d'
		local p = io.popen('git log -n1 --date=short --format='..PC..'"ad"', 'r')
		tex.sprint(p and p:read('*a'):sub(1,-2) or os.date(date_fmt))
		if p then p:close() end
	}
}
