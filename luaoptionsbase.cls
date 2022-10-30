%Luaoptions LaTeX class.
%
% Copyright (C) 2015-2022 the lualatex-tools Project
% License: MIT
% This file is part of lualatex-tools.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{luaoptionsbase}[2022/10/30 v0.8]  %%LUAOPTIONS_DATE LUAOPTIONS_VERSION

\LoadClass[DIV=11]{scrartcl}
\RequirePackage{blindtext}
\RequirePackage{libertine}
\RequirePackage{listings}
\RequirePackage{minted}
\RequirePackage{pgffor}
\RequirePackage{fancyvrb}
\RequirePackage[colorlinks=true]{hyperref}


% Common formatting elements for manual and examples
\usepackage{xcolor}
\newcommand{\highlight}[1]{\textcolor{blue}{#1}}
\newcommand{\cmd}[1]{\highlight{\texttt{\textbackslash #1}}}
\newcommand{\option}[1]{\highlight{\texttt{#1}}}
\newcommand{\lyMargin}[1]{%

\medskip
\hspace*{-1em}%
\noindent%
\highlight{#1}
\nopagebreak
}

\newcommand{\lyOption}[2]{\lyMargin{\texttt{#1} {\small \emph{(#2)}}\index{#1}}}
\newcommand{\lyCmd}[1]{%
\lyMargin{\texttt{\textbackslash #1}\index{\textbackslash #1}}}
\newcommand{\lyIssue}[1]{\lyMargin{\textbf{\textcolor{red}{#1}}}}
