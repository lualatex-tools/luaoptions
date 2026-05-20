%Luaoptions LaTeX class for the manual.
%
% Copyright (C) 2015-2022 the lualatex-tools Project
% License: MIT
% This file is part of luaoptions.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{luaoptionsmanual}[2026/05/20 v0.9]  %%LUAOPTIONS_DATE LUAOPTIONS_VERSION

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

\makeatletter
\newcommand{\luaoptionsmanualdate}{%
	\begingroup
	\edef\x{\endgroup
		\noexpand\luaoptions@extractdate
		\csname ver@luaoptionsmanual.cls\endcsname
		\noexpand\@nil}%
	\x
}
\def\luaoptions@extractdate#1 #2\@nil{#1}

\newcommand{\luaoptionsmanualversion}{%
	\begingroup
	\edef\x{\endgroup
		\noexpand\luaoptions@extractversion
		\csname ver@luaoptionsmanual.cls\endcsname
		\noexpand\@nil}%
	\x
}
\def\luaoptions@extractversion#1 v#2\@nil{#2}
\makeatother
