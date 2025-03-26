\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fhw}[Homework latex template]
%%% ref: https://github.com/fhvirus/FHW

\LoadClass[12pt, a4paper]{article}

%%% [ xeCJK ]

\RequirePackage{fontspec}
\RequirePackage{xeCJK}
\setCJKmainfont[AutoFakeBold=3,AutoFakeSlant=.4]{AR PL UKai TW}
\setCJKmonofont{Noto Sans Mono CJK TC}
\defaultCJKfontfeatures{AutoFakeBold=3,AutoFakeSlant=.4}
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt

\RequirePackage[onehalfspacing]{setspace}
\RequirePackage[parfill]{parskip} % substitute spaces for indent before paragraph.

%%% [ basic packages ]

\RequirePackage{lmodern}    % https://tex.stackexchange.com/a/621536/290605
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{yhmath}
\RequirePackage{mathtools}
\RequirePackage{esint}      % for \oiint
\RequirePackage{physics}    % for \eval \pdv \dv
% \RequirePackage{mleftright} % for removing extra spaces around \left and \right

\RequirePackage{tabularx}
\RequirePackage{enumerate}
\RequirePackage[inline]{enumitem}
\RequirePackage{xcolor}

%%% [ fancyhdr ] % {{{
\RequirePackage{geometry}
\geometry{
	% showframe,
	a4paper,
	ignorefoot,
	ignorehead,
	hmargin=2cm,
	vmargin=2cm,
	headsep=5mm,
	footskip=2\baselineskip,
	footnotesep=8mm,
}

\RequirePackage{titling}
\RequirePackage{fancyhdr} % for fancy header/footer
\RequirePackage{lastpage} % 辨識文章總頁數

\makeatletter
% \newcommand{\DeclareVariable}[1]{
% 	\expandafter\DeclareRobustCommand\csname#1\endcsname[1]{
% 		\expandafter\gdef\csname @#1\endcsname{##1}
% 	}
% }
% \DeclareVariable{CourseID}
% \DeclareVariable{CourseName}
% \DeclareVariable{ID}

\setlength{\headwidth}{\paperwidth-\Gm@lmargin-\Gm@rmargin}
\setlength{\headheight}{15pt}
\setlength{\droptitle}{-1.5cm} %title 與上緣的間距

\fancypagestyle{plain} {
    % \fancyhf{}
    % \lhead{\@CourseName\;|\;\@title}
    % \rhead{\@ID\;\@author}
    % \cfoot{\thepage}
    \fancyhead[L]{}                                      % 頁首左
    \fancyhead[C]{}                                      % 頁首中
    \fancyhead[R]{\thetitle}                             % 頁首右
    \fancyfoot[L]{Student:~\theauthor}                   % 頁腳左
    \fancyfoot[C]{}                                      % 頁腳中
    \fancyfoot[R]{Page \thepage\ of \pageref{LastPage}}  % 頁腳右
    \renewcommand{\headrulewidth}{0.4pt}                 % 頁首分隔線
    \renewcommand{\footrulewidth}{0.4pt}                 % 頁腳分隔線

}
\pagestyle{plain}
\makeatother% }}}

%%% [ theorem style ] % {{{
\usepackage{cleveref}
\newtheoremstyle{theoremstyle}
  {10pt}{16pt}      % 上下間距
  {}                % 內文字體
  {}                % 縮排
  {\bf}             % 標頭字體
  {}                % 標頭後標點
  {1em}             % 內文與標頭距離
  {}                % 標頭規格
\theoremstyle{theoremstyle} % 設定環境Style
%%% Declare theorem environments
\newtheorem{ex}{Example}
\newtheorem{pr}{Problem}
\newtheorem*{pr*}{Problem}
\newtheorem{que}{Question}
\newtheorem{thm}{Theorem}

\newtheoremstyle{italicstyle}
  {10pt}{16pt}      % 上下間距
  {}                % 內文字體
  {}                % 縮排
  {\it}             % 標頭字體
  {.}               % 標頭後標點
  {1em}             % 內文與標頭距離
  {}                % 標頭規格
\theoremstyle{italicstyle} % 設定環境Style
\newtheorem{dfn}{Definition}
\newtheorem{lem}{Lemma}
\newtheorem{recall}{Recall}
\newtheorem{prop}{Proposition}
\newtheorem*{sol}{Solution}

\crefname{lem}{Lemma}{Lemmas}
% }}}

%%% [ misc ]

\RequirePackage[scr=boondoxo,scrscaled=1.05]{mathalfa} % scr font
\RequirePackage{graphicx}
\RequirePackage[minted,breakable]{tcolorbox}
\RequirePackage{minted}

% \RequirePackage{algorithm}
% \RequirePackage{algpseudocode}
% \RequirePackage{tikz-qtree}
% \usetikzlibrary{shapes}

\parindent=24pt
