\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{kgeneric}
              [2008/01/08 v0.0.0.2
    Non Standard LaTeX document class]
%% load packages
%\RequirePackage{kpaper}
\RequirePackage[a4paper]{geometry}
\RequirePackage{calc}
%\InputIfFileExists{kermit/kpaper.cli}{}{}
%% declarations
\newcounter{tempCntA}
\newcounter{tempCntB}
\newcounter{tempCntC}
% Font size
\newcommand\@ptsize{}
% Base line spacing
\newlength{\baselineinterval}
\setlength{\baselineinterval}{\baselineskip}
%%
\RequirePackage{xifthen}
\newif\if@restonecol
\newif\if@titlepage
%% Multicolumn
\newif\if@twocolumn
\newif\if@multicolumn
\@multicolumnfalse
\newboolean{KermitMultiColumn}
\setboolean{KermitMultiColumn}{false}
\newcounter{NumberOfColumn}
%%
\@titlepagetrue
\newif\if@openright
\newif\if@openrightpart
%% Set base line spacing
\newcommand{\set@baselineinterval}[1]{%
    \AtBeginDocument{%
        \setlength{\@tempdima}{\f@size \p@ * \real{#1} * 100}
        \setlength{\@tempdimb}{\@tempdima / \baselineskip}
        \@tempcntb=\@tempdimb
        \setcounter{tempCntA}{\@tempcntb / 100}
        \setcounter{tempCntB}{\@tempcntb - (\thetempCntA * 100)}
        \renewcommand\baselinestretch{\thetempCntA.\thetempCntB}
        \setlength{\baselineinterval}{\baselinestretch\baselineskip}
    }
}
%%
%%
\RequirePackage{keyval}
%%
\def\ProcessOptionsWithKV#1{%
  \let\@tempa\@empty
  \@for\CurrentOption:=\@classoptionslist\do{%
    \@ifundefined{KV@#1@\CurrentOption}%
    {}{\edef\@tempa{\@tempa,\CurrentOption,}}}%
  \edef\@tempa{%
    \noexpand\setkeys{#1}{\@tempa\@ptionlist{\@currname.\@currext}}}%
  \@tempa
  \AtEndOfClass{\let\@unprocessedoptions\relax}}
%%

\RequirePackage{kvoptions}
%%
%% begin Options
%%
%% Size options

\DeclareOption{8pt}{\renewcommand\@ptsize{8pt}}
\DeclareOption{9pt}{\renewcommand\@ptsize{9pt}}
\DeclareOption{10pt}{\renewcommand\@ptsize{10pt}}
\DeclareOption{11pt}{\renewcommand\@ptsize{11pt}}
\DeclareOption{12pt}{\renewcommand\@ptsize{12pt}}
\DeclareOption{14pt}{\renewcommand\@ptsize{14pt}}
\DeclareOption{17pt}{\renewcommand\@ptsize{17pt}}
\DeclareOption{20pt}{\renewcommand\@ptsize{20pt}}


\DeclareOption{8dd}{\renewcommand\@ptsize{8dd}}
\DeclareOption{9dd}{\renewcommand\@ptsize{9dd}}
\DeclareOption{10dd}{\renewcommand\@ptsize{10dd}}
\DeclareOption{11dd}{\renewcommand\@ptsize{11dd}}
\DeclareOption{12dd}{\renewcommand\@ptsize{12dd}}
\DeclareOption{14dd}{\renewcommand\@ptsize{14dd}}
\DeclareOption{17dd}{\renewcommand\@ptsize{17dd}}
\DeclareOption{20dd}{\renewcommand\@ptsize{20dd}}
%%

%{{{ Paper options

\DeclareOption{a0paper}
   {\setlength\paperheight {1189mm}%
    \setlength\paperwidth  {841mm}}
\DeclareOption{a1paper}
   {\setlength\paperheight {841mm}%
    \setlength\paperwidth  {594mm}}
\DeclareOption{a2paper}
   {\setlength\paperheight {594mm}%
    \setlength\paperwidth  {420mm}}
\DeclareOption{a3paper}
   {\setlength\paperheight {420mm}%
    \setlength\paperwidth  {297mm}}
\DeclareOption{a4paper}
   {\geometry{a4paper}
     \setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\geometry{a5paper}
   \setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}

\DeclareOption{foolscap}
    {\setlength\paperheight{171mm}%
    \setlength\paperwidth{108mm}}
\DeclareOption{crown}
    {\setlength\paperheight{191mm}%
    \setlength\paperwidth{127mm}}
\DeclareOption{post}
    {\setlength\paperheight{194mm}%
    \setlength\paperwidth{122mm}}
\DeclareOption{largepost}
    {\setlength\paperheight{210mm}%
    \setlength\paperwidth{137mm}}
\DeclareOption{demy}
    {\setlength\paperheight{222mm}%
    \setlength\paperwidth{143mm}}
\DeclareOption{medium}
    {\setlength\paperheight{229mm}%
    \setlength\paperwidth{146mm}}
\DeclareOption{royal}
    {\setlength\paperheight{254mm}%
    \setlength\paperwidth{159mm}}
\DeclareOption{superroyal}
    {\setlength\paperheight{267mm}%
    \setlength\paperwidth{171mm}}
\DeclareOption{imperial}
    {\setlength\paperheight{279mm}%
    \setlength\paperwidth{191mm}}

%% paper: 145x200 mm
%% text: 112x175
\provideboolean{LXxXCIVxXVI}
\setboolean{LXxXCIVxXVI}{false}
\DeclareOption{60x84/16}
{%
  \setboolean{LXxXCIVxXVI}{true}
  \geometry{papersize={145mm,200mm}}
  \geometry{total={112mm,175mm}}

    % \setlength \paperheight{200mm}%
    % \setlength \paperwidth {145mm}
    % %% + 1 in
    % \setlength{\hoffset}{-5mm}
    % \setlength{\textwidth}{145mm}
%    \geometry{heightrounded}
% \geometry{includeheadfoot}
%    \geometry{includefoot}
% \geometry{twoside}
%    \geometry{papersize={145mm,200mm}}
%% \geometry{hmargin={11mm,17mm},vmargin={11mm,19mm}}
%    \geometry{total={112mm,175mm}}
%    \geometry{marginparwidth=0pt,marginparsep=0pt}
%\geometry{twosideshift=0pt}
%    \geometry{headheight=0pt}
%    \geometry{headsep=0pt}
%  \geometry{footskip=2mm}
}

%% paper: 145x215 mm
%% 60x90/16
\provideboolean{LXxXLxXVI}
\setboolean{LXxXLxXVI}{false}
\DeclareOption{60x90/16}
{%
  \setboolean{LXxXLxXVI}{true}
  % \geometry{reset}
  \geometry{papersize={145mm,215mm}}
  \geometry{total={112mm,200mm}}

  % \setlength{\paperheight}{215mm}%
  % \setlength{\paperwidth}{145mm}
  
  % \setlength{\textheight}{215mm}
  % \setlength{\textwidth}{112mm}
  
  % \addtolength{\topmargin}{-1in}
  % \geometry{includehead}
  % \geometry{includeheadfoot}
  % \geometry{includefoot}
}

%% paper: 170x240 mm
%% 70x100/16
\DeclareOption{70x100/16}
{%
  \geometry{papersize={170mm,240mm}}
  \geometry{total={384dd,552dd}}
  % \geometry{total={140mm,210mm}}
}

%% paper: 170x260 mm
%% 70x108/16
\DeclareOption{70x108/16}
{%
  \geometry{papersize={170mm,260mm}}
  \geometry{total={384dd,600dd}}
  % \geometry{total={140mm,230mm}}
}

%% paper: a4, margin = 20mm
\DeclareOption{a4wide}
{%
    \geometry{papername=a4paper}
    %\geometry{includeheadfoot}
    \geometry{noheadfoot}
    \geometry{hmargin={20mm,20mm},vmargin={20mm,20mm}}
    % \geometry{heightrounded}
}

%}}}

%%
\DeclareOption{singlespace}{\set@baselineinterval{1.0}}
\DeclareOption{onehalfspace}{\set@baselineinterval{1.5}}
\DeclareOption{doublespace}{\set@baselineinterval{2.0}}
%%
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{titlepage}{\@titlepagetrue}
\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption{openright}{\@openrighttrue \@openrightparttrue}
\DeclareOption{openrightpart}{\@openrightparttrue}
\DeclareOption{openany}{\@openrightfalse \@openrightpartfalse}

%% \DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{onecolumn}{\@twocolumnfalse \@multicolumnfalse}

%% \DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{twocolumn}{\@twocolumntrue \@multicolumntrue}

\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}

\AtEndOfPackage{%
  \geometry{heightrounded}
}

%% \DeclareOption*{%
%%   \setkeys{Kermit}{\CurrentOption}
%% }
\OptionNotUsed
\ExecuteOptions{a4paper,10pt,oneside,onecolumn,final,openany,singlespace}
%\ExecuteOptions{a4paper,10pt,oneside,onecolumn,final,singlespace}
\ProcessOptions\relax
%% \ProcessOptionsWithKV{Kermit}\relax
%%
%% end Options
%%
%% \RequirePackage{fixltx2e}
\RequirePackage{relsize}
% \RequirePackage{geometry}
% \geometry{heightrounded}
%\RequirePackage{array}
%\setlength{\extrarowheight}{1ex}

%%%
%\if@multicolumn
%% \pagegrid@col#1%
% \global\columnwidth\textwidth
% \global\advance\columnwidth\columnsep
% \global\divide\columnwidth 2
% \global\advance\columnwidth-\columnsep
% \global\hsize\columnwidth
% \global\linewidth\columnwidth
% \skip@\baselineskip\advance\skip@-\topskip
%% \@ifnum{\pagegrid@col>\@ne}{\set@marry@skip}{}%
%\fi
%%%

%%
\def\EC@family#1#2#3#4#5{%
  \DeclareFontShape{#1}{#2}{#3}{#4}%
  {<5><6><7><8><9><10><10.95><12><14.4>%
   <17.28><20.74><24.88><29.86><35.83><42.99><51.59>genb*#5}{}}
\EC@family{T1}{cmr}{m}{n}{ecrm}
\EC@family{T1}{cmr}{m}{sl}{ecsl}
\EC@family{T1}{cmr}{m}{it}{ecti}
\EC@family{T1}{cmr}{m}{sc}{eccc}
\EC@family{T1}{cmr}{bx}{n}{ecbx}
\EC@family{T1}{cmr}{b}{n}{ecrb}
\EC@family{T1}{cmr}{bx}{it}{ecbi}
\EC@family{T1}{cmr}{bx}{sl}{ecbl}
\EC@family{T1}{cmr}{bx}{sc}{ecxc}
\EC@family{T1}{cmr}{m}{ui}{ecui}
\DeclareFontShape{OT1}{cmr}{m}{n}%
     {<5><6><7><8><9><10><12>gen*cmr%
      <10.95>cmr10%
      <14.4>cmr12%
      <17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmr17}{}
\DeclareFontShape{OT1}{cmr}{m}{sl}%
     {<5><6><7>cmsl8%
      <8><9>gen*cmsl%
      <10><10.95>cmsl10%
      <12><14.4><17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmsl12%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{it}%
     {<5><6><7>cmti7%
      <8>cmti8%
      <9>cmti9%
      <10><10.95>cmti10%
      <12><14.4><17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmti12%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{sc}%
     {<5><6><7><8><9><10><10.95><12>%
      <14.4><17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmcsc10%
      }{}
\DeclareFontShape{OT1}{cmr}{m}{ui}
   {<5><6><7><8><9><10><10.95><12>%
      <14.4><17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmu10%
      }{}
\DeclareFontShape{OT1}{cmr}{b}{n}
     {<5><6><7><8><9><10><10.95><12>%
      <14.4><17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmb10%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{n}
   {<5><6><7><8><9>gen*cmbx%
      <10><10.95>cmbx10%
      <12><14.4><17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmbx12%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{sl}
      {<5><6><7><8><9>%
      <10><10.95><12><14.4><17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmbxsl10%
      }{}
\DeclareFontShape{OT1}{cmr}{bx}{it}
      {<5><6><7><8><9>%
      <10><10.95><12><14.4><17.28><20.74><24.88><29.86><35.83><42.99><51.59>cmbxti10%
      }{}
%%
\input{k\@ptsize.clo}
%%
\AtBeginDocument{%
%% Set \textheight
    \setlength\@tempdima{\textheight}
    \setcounter{tempCntC}{(\textheight - \topskip)/\baselineinterval}
    \setlength{\textheight}{\baselineinterval * \thetempCntC + \topskip}
}
%%

\DeclareRobustCommand{\paperid}[1]{%
  \def\@paperid{#1}
}
\let\@paperid\@empty

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}{}}%
    \def\sectionmark##1{%
      \markright {%
        \ifnum \c@secnumdepth >\z@
          \thesection. \ %
        \fi
        ##1}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {%
        \ifnum \c@secnumdepth >\m@ne
            \@chapapp\ \thechapter. \ %
        \fi
        ##1}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {\LARGE \@title \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
\newcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}
\fi
%%
%%
%% Sections
%%
%% \def\@startsection#1#2#3#4#5#6{%
%%   \if@noskipsec \leavevmode \fi
%%   \par
%%   \@tempskipa #4\relax
%%   \@afterindenttrue
%%   \ifdim \@tempskipa <\z@
%%     \@tempskipa -\@tempskipa \@afterindentfalse
%%   \fi
%%   \if@nobreak
%%     \everypar{}%
%%   \else
%%     \addpenalty\@secpenalty\addvspace\@tempskipa
%%   \fi
%%   \@ifstar
%%     {\@ssect{#3}{#4}{#5}{#6}}%
%% %     {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
%%     {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
%% \def\@sect#1#2#3#4#5#6[#7]#8{%
%%   \ifnum #2>\c@secnumdepth
%%     \let\@svsec\@empty
%%   \else
%%     \refstepcounter{#1}%
%%     \protected@edef\@svsec{\@seccntformat{#1}\relax}%
%%   \fi
%%   \@tempskipa #5\relax
%%   \ifdim \@tempskipa>\z@
%%     \begingroup
%%       #6{%
%%         \@hangfrom{\hskip #3\relax\@svsec}%
%%           \interlinepenalty \@M #8\@@par}%
%%     \endgroup
%% %    \csname #1mark\endcsname{#7}%
%%     \addcontentsline{toc}{#1}{%
%%       \ifnum #2>\c@secnumdepth \else
%%         \protect\numberline{\csname the#1\endcsname}%
%%       \fi
%%       #7}%
%%   \else
%%     \def\@svsechd{%
%%       #6{\hskip #3\relax
%%       \@svsec #8}%
%%       \csname #1mark\endcsname{#7}%
%%       \addcontentsline{toc}{#1}{%
%%         \ifnum #2>\c@secnumdepth \else
%%           \protect\numberline{\csname the#1\endcsname}%
%%         \fi
%%         #7}}%
%%   \fi
%%   \@xsect{#5}}
%% \def\@seccntformat#1{\csname the#1\endcsname.~}
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thepart         {\@Roman\c@part}
\renewcommand\thechapter      {\@arabic\c@chapter}
\renewcommand\thesection      {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
\newcommand\part{%
  \if@openrightpart
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{plain}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \partname~\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
                \null
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \chapterPosition\normalfont\chapterFontSize\chapterFontShape \@chapapp\space \thechapter.
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \chapterPosition\normalfont\chapterFontSize\chapterFontShape #1\par\nobreak
    \vskip 40\p@
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \chapterPosition\normalfont\chapterFontSize\chapterFontShape  #1\par\nobreak
    \vskip 40\p@
  }}
\newcommand\section{%
  \@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\sectionPosition\normalfont\sectionFontSize\sectionFontShape}%
} % END \section
\newcommand\subsection{%
  \@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\subsectionPosition\normalfont\subsectionFontSize\subsectionFontShape}%
} % END \subsection
\newcommand\subsubsection{
  \@startsection{subsubsection}{3}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\subsubsectionPosition\normalfont\subsubsectionFontSize\subsubsectionFontShape}%
} % END \subsubsection
\newcommand\paragraph{%
  \@startsection{paragraph}{4}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\paragraphPosition\normalfont\paragraphFontSize\paragraphFontShape}%
} % END \paragraph
\newcommand\subparagraph{%
  \@startsection{subparagraph}{5}{\parindent}%
  {3.25ex \@plus1ex \@minus .2ex}%
  {-1em}%
  {\subparagraphPosition\normalfont\subparagraphFontSize\subparagraphFontShape}%
} % END \subparagraph

\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\if@titlepage
  \newenvironment{abstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \begin{center}%
        \bfseries \abstractname
        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
  \newenvironment{abstract}{%
      \if@twocolumn
        \section*{\abstractname}%
      \else
        \small
        \begin{center}%
          {\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
        \end{center}%
        \quotation
      \fi}
      {\if@twocolumn\else\endquotation\fi}
\fi
\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
     \if@twoside\else
        \setcounter{page}\@ne
     \fi
    }
\newcommand\appendixnum{\@Alph\c@chapter}
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\appendixnum}%
  \addtocontents{toc}{\protect\renewcommand{\protect\chaptername}{\appendixname}}%
}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset{equation}{chapter}
\renewcommand\theequation{%
  \ifnum \c@chapter>\z@ \thechapter.\fi\@arabic\c@equation}
% \newcounter{figure}[chapter]
\newcounter{figure}
\renewcommand{\thefigure}%
{%
  \ifnum \c@chapter>\z@\thechapter.\fi \@arabic\c@figure%
}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand{\thetable}%
{%
  \ifnum \c@chapter>\z@\thechapter.\fi\@arabic\c@table%
}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \setlength\@tempdima{3em}%
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename
      \@mkboth{\listfigurename}%
              {\listfigurename}}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename
      \@mkboth{%
          \listtablename}{\listtablename}}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
     {\chapter*{\bibname
        \@mkboth{\bibname}{\bibname}}%
%% FIXME Перенести в класс библиографии (на основе natbib) ?    
        \addcontentsline{toc}{chapter}{\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\indexname}%
                        {\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
% \@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\newcommand\today{}
\edef\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi

%% FIXME убрать для общности ?
%%
%% Headers
%%

\RequirePackage{fancyhdr}%
\AtEndOfClass{
\pagestyle{fancy} 
\fancyhead{}%
\fancyfoot{}%
\fancyhead[LE,RO]{\small \thepage}%
\renewcommand{\headrulewidth}{0.4dd}
\fancyhfoffset{0dd}
}

%%
%% Titles
%%

\providecommand{\DivFontShape}{\bfseries}
\providecommand{\DivFontSize}{}
\providecommand{\DivPosition}{}
%%
\providecommand{\partFontShape}{\DivFontShape}
\providecommand{\partFontSize}{\huge}
\providecommand{\partPosition}{}
%%
\providecommand{\chapterFontShape}{\DivFontShape}
\providecommand{\chapterFontSize}{\Large}
\providecommand{\chapterPosition}{}
%%
\providecommand{\sectionFontShape}{\DivFontShape}
\providecommand{\sectionFontSize}{\large}
\providecommand{\sectionPosition}{\center}
%%
\providecommand{\subsectionFontShape}{\DivFontShape}
\providecommand{\subsectionFontSize}{\large}
\providecommand{\subsectionPosition}{\center}
%%
\providecommand{\subsubsectionFontShape}{\DivFontShape}
\providecommand{\subsubsectionFontSize}{\normalsize}
\providecommand{\subsubsectionPosition}{\center}
%%
\providecommand{\paragraphFontShape}{\DivFontShape}
\providecommand{\paragraphFontSize}{\normalsize}
\providecommand{\paragraphPosition}{}
%%
\providecommand{\subparagraphFontShape}{\DivFontShape}
\providecommand{\subparagraphFontSize}{\normalsize}
\providecommand{\subparagraphPosition}{}
%%
\providecommand{\contentsnameFontShape}{\DivFontShape}
\providecommand{\contentsnameFontSize}{\Large}
\providecommand{\contentsnamePosition}{\flushleft}
%%%
%%%
%%%


%%%
%%% Language
%%%
\RequirePackage{caption}
\AtBeginDocument{%
%\AtEndPreamble{%
% babel
\ifx\bbl@main@language\@undefined
\else
  \InputIfFileExists{kermit/lang/\bbl@main@language.cli}{}{}
\fi
% polyglossia (don't work)
\ifx\xpg@main@language\@undefined
\else
  \newcommand{\mainlanguage}{\xpg@main@language}
  \InputIfFileExists{kermit/lang/\xpg@main@language.cli}{}{}
\fi
}
%%%
%%%
\endinput
%% 
%% End of file `kgeneric.cls'.
