\RequirePackage{expl3}
\ProvidesExplClass
{pfuproc} % Package name
{2024-05-09} % Release datend
{0.1.2} % Release version
{Bulletin of Peoples' Friendship University of Russia} % Description

\RequirePackage{xkeyval}

\RequirePackage[a4paper]{geometry}

\ExecuteOptions{a4paper,10pt,twoside,onecolumn,final,openany}
\ProcessOptions*\relax

\define@key{PFUproc}{series}{%
  \def\series{#1}%
  \InputIfFileExists{pfuproc/style/#1.cli}{}{}%
}

\LoadClassWithOptions{kproc}

\ExplSyntaxOn

\RequirePackage{csquotes}
\RequirePackage[type={CC},modifier={by-nc},version={4.0},imageposition=left,imagewidth=6em]{doclicense}

%%
%% Fonts
%%

% % \providecommand{\DivFontShape}{\sffamily\bfseries}
% \providecommand{\DivFontShape}{\sffamily}

% \providecommand{\titleFontShape}{\DivFontShape}
% \providecommand{\titleFontSize}{\large}
% % \providecommand{\titlePosition}{\center}
% \providecommand{\titlePosition}{\noindent}

% \renewcommand{\chapterFontShape}{\DivFontShape}

% % \renewcommand{\sectionFontShape}{\scshape}
% \renewcommand{\sectionFontShape}{\DivFontShape}
% \renewcommand{\sectionFontSize}{\large}
% % \renewcommand{\sectionPosition}{\center}
% \renewcommand{\sectionPosition}{\noindent}
% % \renewcommand{\subsectionFontShape}{\scshape}
% \renewcommand{\subsectionFontShape}{\DivFontShape}
% \renewcommand{\subsectionFontSize}{\normalsize}
% % \renewcommand{\subsectionPosition}{\center}
% \renewcommand{\subsectionPosition}{\noindent}
% % \renewcommand{\subsubsectionFontShape}{\scshape}
% \renewcommand{\subsubsectionFontShape}{\DivFontShape}
% \renewcommand{\subsubsectionFontSize}{\normalsize}
% % \renewcommand{\subsubsectionPosition}{\center}
% \renewcommand{\subsubsectionPosition}{\noindent}
% %%
% % \renewcommand{\paragraphFontShape}{\scshape}
% \renewcommand{\paragraphFontShape}{\DivFontShape}
% \renewcommand{\paragraphFontSize}{\normalsize}
% % \renewcommand{\subparagraphFontShape}{\scshape}
% \renewcommand{\subparagraphFontShape}{\DivFontShape}
% \renewcommand{\subparagraphFontSize}{\normalsize}


%%
%% Titles
%%
\ProvideDocumentCommand \DivFontShape {} { \sffamily \bfseries }
\ProvideDocumentCommand \DivFontSize {} {}
\ProvideDocumentCommand \DivPosition {} { \flushleft }

\ProvideDocumentCommand \titleFontShape {} { \DivFontShape }
\ProvideDocumentCommand \titleFontSize {} { \Large }
\ProvideDocumentCommand \titlePosition {} { \DivPosition }

\ProvideDocumentCommand \partFontShape {} { \DivFontShape }
\ProvideDocumentCommand \partFontSize {} { \huge }
\ProvideDocumentCommand \partPosition {} { \DivPosition }

\ProvideDocumentCommand \chapterFontShape {} { \DivFontShape }
\ProvideDocumentCommand \chapterFontSize {} { \Large }
\ProvideDocumentCommand \chapterPosition {} { \DivPosition }

\ProvideDocumentCommand \sectionFontShape {} { \DivFontShape }
\ProvideDocumentCommand \sectionFontSize {} { \large }
\ProvideDocumentCommand \sectionPosition {} { \DivPosition }

\ProvideDocumentCommand \subsectionFontShape {} { \DivFontShape }
\ProvideDocumentCommand \subsectionFontSize {} { \large }
\ProvideDocumentCommand \subsectionPosition {} { \DivFontShape }

\ProvideDocumentCommand \subsubsectionFontShape {} { \DivFontShape }
\ProvideDocumentCommand \subsubsectionFontSize {} { \normalsize }
\ProvideDocumentCommand \subsubsectionPosition {} { \DivPosition }

\ProvideDocumentCommand \paragraphFontShape {} { \DivFontShape }
\ProvideDocumentCommand \paragraphFontSize {} { \normalsize }
\ProvideDocumentCommand \paragraphPosition {} { \DivPosition }

\ProvideDocumentCommand \subparagraphFontShape {} { \DivFontShape }
\ProvideDocumentCommand \subparagraphFontSize {} { \normalsize }
\ProvideDocumentCommand \subparagraphPosition {} { \DivPosition }

\ProvideDocumentCommand \contentsnameFontShape {} { \DivFontShape }
\ProvideDocumentCommand \contentsnameFontSize {} { \Large }
\ProvideDocumentCommand \contentsnamePosition {} { \DivPosition }

%%%

\RequirePackage{geometry}
% \geometry{paper=a4paper}
% \geometry{reset}
\geometry{twoside}
\geometry{bindingoffset=0pt}
% % % \geometry{papersize={165mm,250mm}}
% \geometry{papersize={170mm,260mm}}
% \geometry{footskip=16dd}
% % \geometry{total={135mm,225mm}}
% % \geometry{hmargin={15mm,20mm},vmargin={17mm,22mm}}
% \geometry{total={140mm,221mm}}
% \geometry{hmargin={13mm,17mm},vmargin={15mm,20mm}}
% \geometry{marginparwidth=0dd,marginparsep=0dd}
% % \geometry{hmargin={13mm,17mm},vmargin={14mm,19mm}}
% \geometry{twosideshift=0dd}
\geometry{includehead}
% \geometry{includeheadfoot}
% \geometry{includefoot}
\geometry{heightrounded}
% \geometry{centering}
\geometry{nofoot}
\geometry{marginparwidth=0pt,marginparsep=0pt}


% Форматы журнальных изданий по ГОСТ 5773-90
% | Размер листа, мм | Доля листа | Условное обозначение | Размер максимальный, мм | Размер минимальный, мм |
% |------------------+------------+----------------------+-------------------------+------------------------|
% | 700х1080         | 1/8        | 70х108/8             | 265х340                 | 257х333                |
% | 600х900          | 1/8        | 60х90/8              | 220х290                 | 205х275                |
% | 600х840          | 1/8        | 60х84/8              | 205х290                 | 200х285                |
% | 840х1080         | 1/16       | 84х108/16            | 205х260                 | 192х255                |
% | 700х1080         | 1/16       | 70х108/16            | 170х260                 | 158х255                |
% | 700х1000         | 1/16       | 70х100/16            | 170х240                 | 158х230                |
% | 600х900          | 1/16       | 60х90/16             | 145х215                 | 132х205                |
% | 840х1080         | 1/32       | 84х108/32            | 130х200                 | 123х192                |
% | 700х1080         | 1/32       | 70х108/32            | 130х165                 | 125х165                |

%   Форматы полос набора и рекомендуемые размеры полей книжных страниц
% | Формат бумаги | Страница, мм | Формат, кв (I) | Поля, мм (I) | Формат, кв (II) | Поля, мм (II) | Формат, кв (III) | Поля, мм (III) |
% |---------------+--------------+----------------+--------------+-----------------+---------------+------------------+----------------|
% | 60x84/32      |      100x140 | 4½x6½          | 9;13;15;20   | 4¼x6¼           | 11;16;18;22   | 4x6              | 13;18;20;24    |
% | 60x90/32      |      107x140 | 4¾x6½          | 9;13;18;20   | 4½x6¼           | 11;16;20;22   | 4¼x6             | 13;18;23;24    |
% | 70x90/32      |      107x165 | 4¾x7¾          | 9;13;18;23   | 4½x7½           | 11;16;20;24   | 4¼x7¼            | 13;18;20;27    |
% | 75x90/32      |      107x177 | 4¾x8½          | 9;13;18;21   | 4½x8¼           | 11;16;20;22   | 4¼x8             | 13;18;20;25    |
% | 70x100/32     |      120x165 | 5¼x7¾          | 9;13;21;23   | 5x7½            | 11;16;24;24   | 4¾x7¼            | 13;18;26;27    |
% | 70x108/32     |      130x165 | 6x7¾           | 9;13;18;23   | 5¾x7½           | 11;16;21;24   | 5½x7¼            | 13;18;23;27    |
% | 84x108/32     |      130x200 | 6x9 ¾          | 9;13;18;23   | 5¾x9½           | 11;16;21;23   | 5½x9¼            | 13;18;23;26    |
% | 60x84/16      |      145x200 | 6¾x9¾          | 11;16;17;19  | 6½x9½           | 13;18;20;21   | 6¼x9¼            | 16;20;22;24    |
% | 60x90/16      |      145x215 | 6¾x10½         | 11;16;17;20  | 6½x10¼          | 13;18;20;23   | 6¼x10            | 16;20;22;25    |
% | 70x90/16      |      170x215 | 8x10¼          | 11;16;20;25  | 7¾x10           | 13;18;22;27   | 7½x9¾            | 16;20;24;29    |
% | 75x90/16      |      182x215 | 8¾x10¼         | 11;16;19;25  | 8½x10           | 13;18;21;27   | 8¼x9¾            | 16;20;23;30    |
% | 70x100/16     |      170x240 | 8x11½          | 11;16;20;27  | 7¾x11¼          | 13;18;22;30   | 7½x11            | 16;20;24;32    |
% | 70x108/16     |      170x260 | 8x12 ½         | 11;16;20;29  | 7¾x12¼          | 13;18;22;31   | 7½x12            | 16;20;24;34    |
% | 84x108/16     |      205x260 | 9¾x12½         | 11;16;23;29  | 9½x12¼          | 13;18;26;31   | 9¼x12            | 16;20;27;34    |
% | 60x84/8       |      205x290 | 9 ¾x14         | 13;18;21;30  | 9½x13¾          | 16;20;23;33   | 9¼x13½           | 18;22;26;35    |
% | 60x90/8       |      220x290 | 10½x14¼        | 13;18;23;26  | 10¼x14          | 16;20;24;28   | 10x13¾           | 18;22;27;31    |
% | 70x100/8      |      245x340 | 12x17          | 13;18;21;26  | 11¾x16¾         | 16;20;23;29   | 11½x16½          | 18;22;25;31    |
% | 70x108/8      |      265x340 | 13x17          | 13;18;23;26  | 12¾x16¾         | 16;20;25;29   | 12½x16½          | 18;22;27;31    |
% | 84x108/8      |      265x410 | 13x20¾         | 13;18;23;29  | 12¾x20½         | 16;20;25;31   | 12½x20¼          | 18;22;27;34    |
% - Размер корешкового поля страницы рассчитан для твёрдой обложки, переплёт 7БЦ
% - Формат бумаги задаётся в см и долях листа.
% - Страница: размер страницы.
% - Поля: корешковое; верхнее; наружное; нижнее.
% - Формат: формат набора, текстовая область.
% - Квадрат: кв = 48 pt = 18,0412 = 18 мм (Россия); 16,944 = 17 мм (анг.-амер.)
% - Даны три варианта оформления (I, II, III).



%% paper: 170x260 mm
%% 70x108/16
% \DeclareOption{70x108/16}
% {%
\geometry{papersize={170mm,260mm}}
\geometry{total={140mm,215mm}}
\geometry{vmargin={16mm,29mm}}
%% Центрирование для просмотра.
%% Оформить в виде опции
% \geometry{hmargin={11mm,19mm}}
% \geometry{hmarginratio=11:20}
% \geometry{hmarginratio=1:1}
\geometry{hcentering}
% \geometry{papersize={170mm,260mm}}
% \geometry{total={384dd,600dd}}
% \geometry{total={140mm,230mm}}
% }

\setlength{\headwidth}{\textwidth}

% \AtBeginDocument{
%   \newgeometry{%
%   papersize={170mm,260mm},
%   hmargin={20mm,11mm},vmargin={16mm,29mm},
%   twoside,
%   bindingoffset=0pt,
%   marginparwidth=0pt,marginparsep=0pt,
%   includehead,
%   % includefoot,
%   heightrounded,
%   nofoot,
%   nohead
% }
% \savegeometry{titlepage}
% \restoregeometry
% }

%{{{ \paperid{}

\RequirePackage{currfile}

\newwrite\paperidFile
\immediate\openout\paperidFile=split-paper

\newcommand{\paperid}[1]{
  \immediate\write\paperidFile{#1~\thepage}
  \def\PFUpaperid{#1}
}
\let\PFUpaperid\@empty

\AtEndDocument{%
  \immediate\closeout\paperidFile
}

% \def\@maketitle@hook@post{%
%   \paperid{\currfilebase}
% }

\g@addto@macro\@maketitle@hook@post{%
  \paperid{\currfilebase}
}

\def\tableofcontents@hook{%
  \paperid{tableofcontents}
}

\def\tableofaltcontents@hook{%
  \paperid{tableofaltcontents}
}

% \newwrite\trackidFile
% \immediate\openout\trackidFile=split-track

% \newcommand{\trackid}[1]{
%   \immediate\write\trackidFile{#1 \thepage}
% }

% \AtEndDocument{%
%   \immediate\closeout\trackidFile
% }

%}}}

%{{{ List of Authors

\AtBeginDocument{%
  \def\listauthorsname{Information~about~the~authors}
  \@ifpackageloaded{polyglossia}{%
    \addto\captionsrussian@modern{%
      \def\listauthorsname{Сведения~об~авторах}
    }
  }{%
    \addto\extrasrussian{%
      \def\listauthorsname{{\CYRS}{\cyrv}{\cyre}{\cyrd}{\cyre}{\cyrn}{\cyri}{\cyrya} {\cyro}{\cyrb} {\cyra}{\cyrv}{\cyrt}{\cyro}{\cyrr}{\cyra}{\cyrh}}
    }
  }
  \addto\captionsenglish{%
    \def\listauthorsname{Information~about~the~authors}
  }
}


\def\listofauthors{%
\begin{center}
  % \Huge
  \Large
  % \textsc{{\CYRN}{\cyra}{\cyrsh}{\cyri} {\cyra}{\cyrv}{\cyrt}{\cyro}{\cyrr}{\cyrery}}
  % \textsc{{\CYRS}{\cyrv}{\cyre}{\cyrd}{\cyre}{\cyrn}{\cyri}{\cyrya}
  % {\cyro}{\cyrb} {\cyra}{\cyrv}{\cyrt}{\cyro}{\cyrr}{\cyra}{\cyrh}}
  % \textsc{Наши авторы}%
  \textsc{\listauthorsname}
  \addtocontents{toc}{\protect\medskip}
  \addtocontents{tac}{\protect\medskip}
  \addcontentsline{toc}{chapter}{{\bfseries \listauthorsname}}%
  \addtocontents{tac}{\string\select@language{\PFUaltlanguage}}
  \addcontentsline{tac}{chapter}{{\bfseries \string\listauthorsname}}%
  \paperid{listofauthors}
\end{center}%

\normalfont

\bigskip
\begin{raggedright}
\@starttoc{loa}
\end{raggedright}

}

\newbool{isListofauthorsEmpty}
\newbool{isListofauthorsEnglishEmpty}
\setbool{isListofauthorsEmpty}{true}
\setbool{isListofauthorsEnglishEmpty}{true}
\g@addto@macro\@title@hook{%
  \global\setbool{isListofauthorsEmpty}{true}
  \global\setbool{isListofauthorsEnglishEmpty}{true}
}

\def\listofauthorsPerTitleRu{%
  \begin{otherlanguage}{russian}
    \section*{\listauthorsname}
    % \noindent
    % {
    %   \sectionFontShape\sectionFontSize\sectionPosition
    %   \listauthorsname
    % }
    % \smallskip
  \end{otherlanguage}\nopagebreak[4]
  \begin{otherlanguage}{russian}
    \noindent
    \@starttoc{\currfilebase.loa}
  \end{otherlanguage}
  \par
}


\def\listofauthorsPerTitleEn{%
  \ifbool{isListofauthorsEnglishEmpty}{% is empty
  }{% isn't empty
    \begin{otherlanguage}{english}
      % \noindent
      % {
      %   \sectionFontShape\sectionFontSize\sectionPosition
      %   \listauthorsname
      % }
      % \smallskip
      % \par%
      \section*{\listauthorsname}
      % \end{otherlanguage}%
      \nopagebreak[4]%
      % \begin{otherlanguage}{english}
      \noindent%
      \@starttoc{\currfilebase.english.loa}
    \end{otherlanguage}
    \par
  }
}

\ProvideDocumentCommand \authorlistFontShape {} { \DivFontShape }
\ProvideDocumentCommand \authorlistFontSize {} { \footnotesize }
\ProvideDocumentCommand \authorlistPosition {} { }

\newcommand{\pfuproc@bra}{(}
\newcommand{\pfuproc@ket}{)}
\newcommand{\pfuproc@komma}{,~}

% \def\pfuproc@phoneName{Phone}
\tl_new:N \l_phoneName_tl
\tl_set:Nn\l_phoneName_tl{phone}

\AtBeginDocument{%
  % \def\l_phoneName_tl{Phone}
  \@ifpackageloaded{polyglossia}{%
    \addto\captionsrussian@modern{%
      \tl_set:Nn\l_phoneName_tl{тел.}
    }
    \addto\captionsenglish{%
      \tl_set:Nn\l_phoneName_tl{phone}
    }
  }{%
    \addto\extrasrussian{%
      \tl_set:Nn\l_phoneName_tl{{\cyrt }{\cyre }{\cyrl }.}
    }
    \addto\extrasenglish{%
      \tl_set:Nn\l_phoneName_tl{phone}
    }
  }
}

% \def\pfuproc@authorlist{}
% \g@addto@macro\pfuproc@authorlist{}
% \g@addto@macro\@title@hook{\let\pfuproc@authorlist\@empty}
% \newwrite\authorlistFile
% \g@addto@macro\@title@hook{%
%   \immediate\openout\authorlistFile=\jobname.loa
% }


\def\pfuproc@authorlistentry{}
\def\pfuproc@authorlistentry@english{}
\def\pfuproc@authorfull{}
\def\pfuproc@authorfull@english{}
\def\pfuproc@authorrank{}
\def\pfuproc@authorrank@english{}
\def\pfuproc@authordegree{}
\def\pfuproc@authordegree@english{}
\def\pfuproc@authorpost{}
\def\pfuproc@authorpost@english{}
\def\pfuproc@mail{}
\def\pfuproc@orcid{}
\def\pfuproc@scopusauthorid{}
\def\pfuproc@researcerid{}
\def\pfuproc@phone{}
\def\pfuproc@country{}
\def\pfuproc@country@english{}
% \g@addto@macro\pfuproc@authorlistentry{}
% \g@addto@macro\@title@hook{\let\pfuproc@authorlistentry\@empty}

\newenvironment{authordescription}%
{
  \let\pfuproc@authorlistentry\@empty
  \let\pfuproc@authorlistentry@english\@empty
  \let\pfuproc@authorfull\@empty
  \let\pfuproc@authorfull@english\@empty
  \let\pfuproc@authorrank\@empty
  \let\pfuproc@authorrank@english\@empty
  \let\pfuproc@authordegree\@empty
  \let\pfuproc@authordegree@english\@empty
  \let\pfuproc@authorpost\@empty
  \let\pfuproc@authorpost@english\@empty
  \let\pfuproc@mail\@empty
  \let\pfuproc@orcid\@empty
  \let\pfuproc@scopusauthorid\@empty
  \let\pfuproc@researcerid\@empty
  \let\pfuproc@phone\@empty
  \let\pfuproc@country\@empty
  \let\pfuproc@country@english\@empty
  \def\pfuproc@bra{~(}
  \def\pfuproc@ket{)}
  \def\pfuproc@komma{,~}
}%
{
  \ifx\pfuproc@mail\@empty
    \let\pfuproc@komma\@empty
    \ifx\pfuproc@phone\empty
      \let\pfuproc@bra\@empty
      \let\pfuproc@ket\@empty
    \fi
  \fi
  % Добавим в macro всё, что есть сейчас
  % \g@addto@macro
  \def\pfuproc@authorlistentry{%
    {\authorlistFontShape
      \pfuproc@authorfull}%
    \ifx\pfuproc@country\@empty
    \else{~(\pfuproc@country)}
    \fi~---~%
    \ifx\pfuproc@authorrank\@empty
    \else
      \pfuproc@authorrank,~
    \fi
    \ifx\pfuproc@authordegree\@empty
    \else
      \pfuproc@authordegree,~
    \fi
    \ifx\pfuproc@authorpost\@empty
    \else
      \pfuproc@authorpost{}
    \fi
    \pfuproc@bra%
    \ifx\pfuproc@mail\@empty
    \else
    \mbox{\-e-mail:}~\protect\url{\pfuproc@mail}%
    \fi
    \ifx\pfuproc@phone\@empty
    \else
    % \pfuproc@komma\protect\mbox{{\cyrt }{\cyre }{\cyrl }.:~\pfuproc@phone{}}%
    \pfuproc@komma\protect\mbox{{\tl_use:N \l_phoneName_tl}:~\pfuproc@phone{}}%
    \fi
    \ifx\pfuproc@orcid\@empty
    \else
    \pfuproc@komma\protect\mbox{ORCID:~https://orcid.org/\pfuproc@orcid{}}%
    \fi
    \ifx\pfuproc@researcherid\@empty
    \else
    \pfuproc@komma\protect\mbox{ResearcherID:~\pfuproc@researcherid{}}%
    \fi
    \ifx\pfuproc@scopusauthorid\@empty
    \else
    \pfuproc@komma\protect\mbox{Scopus~AuthorID:~\pfuproc@scopusauthorid{}}%
    \fi
    \pfuproc@ket%
  }

  \ifx\pfuproc@authorfull@english\@empty
  \else
    \def\pfuproc@authorlistentry@english{%
      {\authorlistFontShape
        \pfuproc@authorfull@english}%
      \ifx\pfuproc@country@english\@empty
      \else{~(\pfuproc@country@english)}
      \fi---%
      \ifx\pfuproc@authorrank@english\@empty
      \else
        \pfuproc@authorrank@english,~
      \fi
      \ifx\pfuproc@authordegree@english\@empty
      \else
        \pfuproc@authordegree@english,~
      \fi
      \ifx\pfuproc@authorpost@english\@empty
      \else
        \pfuproc@authorpost@english{}
      \fi
      \pfuproc@bra%
      \ifx\pfuproc@mail\@empty
      \else
        % \mbox{\-e-mail}:~\protect\url{\pfuproc@mail}%
        \mbox{\-e-mail}:~\protect\href{mailto:\pfuproc@mail}{\nolinkurl{\pfuproc@mail}}%
      \fi
      \ifx\pfuproc@phone\@empty
      \else
        \pfuproc@komma\protect\mbox{phone:~\pfuproc@phone{}}%
      \fi
      \ifx\pfuproc@orcid\@empty
      \else
        \pfuproc@komma\protect\mbox{ORCID:~\href{https://orcid.org/\pfuproc@orcid}{\pfuproc@orcid}}%
      \fi
      \ifx\pfuproc@researcherid\@empty
      \else
        \pfuproc@komma\protect\mbox{ResearcherID:~\href{https://www.webofscience.com/wos/author/record/\pfuproc@researcherid}{\pfuproc@researcherid}}%
      \fi
      \ifx\pfuproc@scopusauthorid\@empty
      \else
        \pfuproc@komma\protect\mbox{Scopus~Author~ID:~\href{https://www.scopus.com/authid/detail.uri?authorId=\pfuproc@scopusauthorid}{\pfuproc@scopusauthorid}}%
      \fi
      \pfuproc@ket%
      \protect\smallskip
    }
  \fi

  % \addtocontents{loa}{\begin{otherlanguage}{russian}\pfuproc@authorlistentry\end{otherlanguage}\newline}
  \addtocontents{loa}{\authorlistFontSize\pfuproc@authorlistentry\newline}
  \global\setbool{isListofauthorsEmpty}{false}
  % \protected@write\authorlistFile{\let\label\@gobble
  % \let\index\@gobble
  % \let\glossary\@gobble}{\pfuproc@authorlistentry\newline}
  \addtocontents{\currfilebase.loa}{\authorlistFontSize\pfuproc@authorlistentry\newline}
  \ifx\pfuproc@authorlistentry@english\@empty
  \else
  \addtocontents{\currfilebase.english.loa}{\authorlistFontSize\pfuproc@authorlistentry@english\newline}
  \global\setbool{isListofauthorsEnglishEmpty}{false}
  \fi
  \authordescription@hook@post
  \ifbool{isListofauthorsEnglishEmpty}{\message{0000000true}}{\message{00000000false}}
}
\def\authordescription@hook@post{}

\newcounter{c@pfuproc@authorlist}

\RequirePackage{xstring}

% Автор
\DeclareRobustCommand{\authorfull}[2][russian]{%
  \IfStrEq{#1}{russian}{%
    \def\pfuproc@authorfull{#2}
  }{%
    \def\pfuproc@authorfull@english{#2}
  }
}
\let\pfuproc@authorfull\@empty
\let\pfuproc@authorfull@english\@empty

% Учёное звание
\DeclareRobustCommand{\authorrank}[2][russian]{%
  \IfStrEq{#1}{russian}{%
    \def\pfuproc@authorrank{#2}
  }{%
    \def\pfuproc@authorrank@english{#2}
  }
}
\let\pfuproc@authorrank\@empty
\let\pfuproc@authorrank@english\@empty

% Учёная степень
\DeclareRobustCommand{\authordegree}[2][russian]{%
  \IfStrEq{#1}{russian}{%
    \def\pfuproc@authordegree{#2}
  }{%
    \def\pfuproc@authordegree@english{#2}
  }
}
\let\pfuproc@authordegree\@empty
\let\pfuproc@authordegree@english\@empty

% Учёная должность
\DeclareRobustCommand{\authorpost}[2][russian]{%
  \IfStrEq{#1}{russian}{%
    \def\pfuproc@authorpost{#2}
  }{%
    \def\pfuproc@authorpost@english{#2}
  }
}
\let\pfuproc@authorpost\@empty
\let\pfuproc@authorpost@english\@empty

% e-mail
\DeclareRobustCommand{\email}[1]{%
  \def\pfuproc@mail{#1}
}
\let\pfuproc@mail\@empty

% Телефон
\DeclareRobustCommand{\phone}[1]{%
  \def\pfuproc@phone{#1}
}
\let\pfuproc@phone\@empty

% Страна
\DeclareRobustCommand{\country}[2][russian]{%
  \IfStrEq{#1}{russian}{%
    \def\pfuproc@country{#2}
  }{%
    \def\pfuproc@country@english{#2}
  }
}
\let\pfuproc@country\@empty
\let\pfuproc@country@english\@empty

% ORCID
\DeclareRobustCommand{\orcid}[1]{%
  \def\pfuproc@orcid{#1}
}
\let\pfuproc@orcid\@empty

% ResearcherID
\DeclareRobustCommand{\researcherid}[1]{%
  \def\pfuproc@researcherid{#1}
}
\let\pfuproc@researcherid\@empty

% Scopus Author ID
\DeclareRobustCommand{\scopusauthorid}[1]{%
  \def\pfuproc@scopusauthorid{#1}
}
\let\pfuproc@scopusauthorid\@empty

%}}}

%{{{ List of Titles

\def\@startblindtoc#1{%
  \begingroup
    \makeatletter
%    \@input{\jobname.#1}%
    \if@filesw
      \expandafter\newwrite\csname tf@#1\endcsname
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax
    \fi
    \@nobreakfalse
  \endgroup}

\let\pfuproc@titleslist@entry\@empty

\g@addto@macro\pfuproc@titleslist@entry{%
  % \string\documentclass{article}
  % \string\usepackage[cp1251]{inputenc}
  % \string\usepackage[T2A]{fontenc}
  % \string\usepackage[english,russian]{babel}
  \string\input{preamble}
  \string\begin{document}
  \string\fancyhead{}
  \string\fancyfoot{}
}
\addtocontents{titlelist.tex}{\pfuproc@titleslist@entry}
\let\pfuproc@titleslist@entry\@empty

 \def\@maketitle@hook{%
   \let\pfuproc@titleslist@entry\@empty

   \g@addto@macro\pfuproc@titleslist@entry{%

     \par

     % Number of article
     \noindent\textbf{\No~\thePFUtitle}\par

     \string\begin{otherlanguage*}
       {\PFUlanguage}

     \ifx\@udcnum\empty \else
     \string\PFUudcName{}
     \@udcnum \par \fi

     % Authors

     \string\makeatletter
     \textbf{\authorstoc}
     \string\makeatother
     \par
     \textit{\@title}
     \par
     \@abstracts
     \par

     \string\keywordsname:
     \@keywords%

     \string\end{otherlanguage*}
     \par
     \par
     \string\medskip
   }

   \addtocontents{titlelist.tex}{\pfuproc@titleslist@entry}
   \let\pfuproc@titleslist@entry\@empty
 }

 \def\@makealttitle@hook{%
   \let\pfuproc@titleslist@entry\@empty

   \g@addto@macro\pfuproc@titleslist@entry{%

     \par

     \string\begin{otherlanguage*}
       {\PFUaltlanguage}

       \ifx\@udcnum\empty \else
       \string\PFUudcName{}
       \@udcnum \par \fi

       % Authors

       \string\makeatletter
       \textbf{\altauthorstoc}
       \string\makeatother
       \par
       \textit{\@alttitle}
       \par
       \@altabstracts
       \par

       \string\keywordsname:
       \alt@keywords%

       \par

       \string\end{otherlanguage*}

     \par
     \bigskip
   }

   \addtocontents{titlelist.tex}{\pfuproc@titleslist@entry}
   \let\pfuproc@titleslist@entry\@empty
 }


% \RequirePackage{scrlfile}
% \BeforeClosingMainAux{%
%   \let\pfuproc@titleslist@entry\@empty
%   \g@addto@macro\pfuproc@titleslist@entry{%
%     \string\clearpage
%     % {\LARGE \textbf{{\CYRN}{\cyra}{\cyrsh}{\cyri} {\cyra}{\cyrv}{\cyrt}{\cyro}{\cyrr}{\cyrery}}}
%     \string\InputIfFileExists{default.loa}{}{}
%   }

%   \g@addto@macro\pfuproc@titleslist@entry{%
%     \string\end{document}
%   }
%   \addtocontents{titlelist.tex}{\pfuproc@titleslist@entry}
%   \let\pfuproc@titleslist@entry\@empty
% }

\AtEndDocument{%
  \@startblindtoc{titlelist.tex}
}

%}}}

%{{{ Title header

\DeclareRobustCommand{\titlelogo}[1]{%
  \gdef\PFUtitlelogo{#1}
}
\let\PFUtitlelogo\@empty

\DeclareRobustCommand{\titlelogoTop}[1]{%
  \gdef\PFUtitlelogoTop{#1}
}
\titlelogoTop{{\selectlanguage{english}\textbf{\PFUjournalHeader{}}}}

\DeclareRobustCommand{\titlelogoBottom}[1]{%
  \gdef\PFUtitlelogoBottom{#1}
}
\titlelogoBottom{%
  \selectlanguage{russian}
  \textbf{\PFUjournalHeader. \PFUjornalseriesName{}~\PFUjournalseriesHeader{}}
}

\newlength{\lheadwidth}
\newlength{\rheadwidth}
\newlength{\cheadwidth}

\fancypagestyle{title}{%
  % \setlength{\lheadwidth}{0.07\linewidth}
  \setlength{\lheadwidth}{0.1\headwidth}
  \settowidth{\rheadwidth}{\PFUjournalURL}
  \setlength{\cheadwidth}{\headwidth}
  \addtolength{\cheadwidth}{-\rheadwidth}
  \addtolength{\cheadwidth}{-\lheadwidth}
  \addtolength{\headheight}{\baselineskip}
  \addtolength{\cheadwidth}{-1cm}
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \lhead{}
  \rhead{}
  \lhead{%
    \noindent
    \begin{minipage}[c]{\lheadwidth}
      \includegraphics[width=\linewidth]{\PFUtitlelogo}
    \end{minipage}
    \hfill}
  \chead{%
    \hspace*{-3.4cm}
    \vspace*{-10pt}
    \noindent
    \begin{minipage}[c]{\cheadwidth}
      \begin{flushleft}
        \headerFontSize
        % \PFUtitlelogoTop\\[-14pt]
        % \PFUtitlelogoBottom\\[-8pt]
        \PFUtitlelogoTop\\% [-4pt]
        \PFUtitlelogoBottom\\% [-8pt]
        \nointerlineskip
        % \noindent\rule{\linewidth}{2pt}\\
        \noindent\rule{\linewidth}{0.4pt}\\
        ISSN~\PFUissnOnline{}~(Online),~\PFUissnPrint{}~(Print)
      \end{flushleft}
    \end{minipage}
  }
  \rhead{%
    % \hfill
    % \vspace*{10pt}
    \begin{minipage}[c]{\rheadwidth}
      \begin{center}
        \headerFontSize
        \textbf{%
          % \PFUjournalyear{} Vol.\,\PFUjournalvolume{}
          % No.\,\PFUjournalnumber{}%
          \PFUjournalyear{},~
          \PFUjournalvolume{}~(\PFUjournalnumber{})~
          % \ifthenelse{\pageref{starttitle}=\pageref{endtitle}}%
          % {\pageref{starttitle}}% then
          {\@pagerange}% else
        }
        \\
        \PFUjournalURL
      \end{center}
    \end{minipage}
  }
  % \vspace{\baselineskip}
}

% \AtBeginDocument{
%   \addtolength\headsep{\baselineskip}%
% }

\def\@title@hook@pre{%
  \thispagestyle{title}
}

%}}}

%{{{ Колонтитулы на служебных страницах

% Служебные страницы. Например, вторые страницы содержания.
\fancypagestyle{ancillary}{%
  \fancyhf{}
  \fancyhead[LE,RO]{%
    \begin{otherlanguage*}{\PFUlanguage}
      \headerFontSize\thepage
    \end{otherlanguage*}
  }
  \fancyhead[RE,LO]{\headerFontSize \PFUTitleHeader}
}

%}}}

\AtEndPreamble{%
  \ltx@ifpackageloaded{biblatex}{%
    \makeatletter
    \InputIfFileExists{pfuproc/patch/bibunits-biblatex.cli}{}{}%
    \makeatother
  }{%
    \makeatletter
    \InputIfFileExists{pfuproc/patch/bibunits.cli}{}{}%
    \makeatother
  }
}


%{{{ Рекомендуемый формат цитирования

\DeclareRobustCommand{\howtoCiteRu}{%
  % Для цитирования:
  \smallskip
  \begin{otherlanguage*}{russian}
    \noindent
    \textbf{{\CYRD}{\cyrl}{\cyrya}
      {\cyrc}{\cyri}{\cyrt}{\cyri}{\cyrr}{\cyro}{\cyrv}{\cyra}{\cyrn}{\cyri}{\cyrya}:}
  \end{otherlanguage*}%
  \smallskip
  \par
  \iflanguage{russian}{%
    \ifpolyglossia\begin{otherlanguage}{\PFUlanguage}\else\begin{otherlanguage*}{\PFUlanguage}\fi
      \noindent\emph{\authorstocshort} \@title{}~//
      \PFUjournal{}. \CYRS\cyre\cyrr\cyri\cyrya: \PFUjournalseries{}.~---
      \PFUjournalyear.~---\ifx\PFUjournalvolume\@empty\else{} \CYRT.~\PFUjournalvolume\fi\ifx\PFUjournalnumber\@empty\else, \No~\PFUjournalnumber\fi{}.~---
      \CYRS.~\pageref{\thePFUtitle:starttitle}--\pageref{\thePFUtitle:endtitle}.%
      \ifx\@empty\@doi \else{}~--- doi:~\@doi{}.\fi%
    \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi%
  }{%
    \ifpolyglossia\begin{otherlanguage}{\PFUlanguage}\else\begin{otherlanguage*}{\PFUlanguage}\fi
      \noindent\emph{\authorstocshort} \@title{}~// \PFUjournal{}.~---
      \PFUjournalyear.~---\ifx\PFUjournalvolume\@empty\else{} Vol.~\PFUjournalvolume\fi\ifx\PFUjournalnumber\@empty\else, No~\PFUjournalnumber\fi{}.~---
      Pp.~\pageref{\thePFUtitle:starttitle}--\pageref{\thePFUtitle:endtitle}.%
      \ifx\@empty\@doi \else{}~--- doi:~\@doi{}.\fi%
    \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi%
  }
  \par
}

\DeclareRobustCommand{\howtoCiteEn}{%
  \smallskip
  \noindent
  {%
    \footnotesize
    {\DivFontShape To~cite:~}%
    % \smallskip
    % \par
    \iflanguage{english}{%
      % \ifpolyglossia\begin{otherlanguage}{\PFUlanguage}\else\begin{otherlanguage*}{\PFUlanguage}\fi
      %   \noindent
        \authorstocshort{}\unskip,{}\xspace~\@title{}.~\emph{\PFUjournal}
        \ifx\PFUjournalvolume\@empty\else{}~\textbf{\PFUjournalvolume}\fi\ifx\PFUjournalnumber\@empty\else{}~(\PFUjournalnumber)\fi,~\@pagerange.~\ifx\@empty\@doi\else~doi:~\@doi{}.~\fi edn:~\ednurl{\@edn}~(\PFUjournalyear).
        % \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi%
  }{%
    \ifpolyglossia\begin{otherlanguage}{english}\else\begin{otherlanguage*}{english}\fi
      \noindent\altauthorstocshort{}\unskip,{}\xspace \@alttitle{}, \PFUjournal{}%
      \ifx\PFUjournalvolume\@empty\else{} \PFUjournalvolume\fi\ifx\PFUjournalnumber\@empty\else{} (\PFUjournalnumber)\fi{}      
      \zpageref{\thePFUtitle:starttitle}--\zpageref{\thePFUtitle:endtitle}.
      \ifx\@empty\@doi \else~doi:~\@doi{}.\fi{}
      ~edn:~\ednurl{\@edn}~(\PFUjournalyear).
      In Russian.
      \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi%
  }%
  }
  \par
}

%}}}

%{{{ Логотип для CC лицензии

% По умолчанию лицензия CC-BY
\DeclareRobustCommand{\cclogo}[1]{%
  \def\pfuproc@cclogo{#1}
}
\def\pfuproc@cclogo{by-nc}

\def\papercopyrightA{%
  \graphicspath{{./}{image/}}
  \bigskip
  \begin{flushleft}
    \footnotesize
    \copyright{} \authorstocshortRev\unskip,{}\xspace \PFUjournalyear{}
  \end{flushleft}%
  % \bigskip
  \begin{minipage}{0.15\linewidth}
    \begin{flushleft}
      % \includegraphics[width=2cm]{\pfuproc@cclogo}%
      \includegraphics[width=1.0\linewidth]{\pfuproc@cclogo}%
      % \par%
      % \nopagebreak[4]%
    \end{flushleft}
  \end{minipage}
  \hfill
  \begin{minipage}{0.8\linewidth}
    \begin{flushleft}
      {%
        % \footnotesize
        \scriptsize
        This work is licensed under a Creative Commons Attribution 4.0 International License\\
        \url{https://creativecommons.org/licenses/by-nc/4.0/legalcode}
        %This work is licensed under a Creative Commons Attribution 4.0
        %International License\\
        %\url{http://creativecommons.org/licenses/by/4.0/}
      }
      % This work is licensed under a \href{http://creativecommons.org/licenses/by/4.0/}{Creative Commons Attribution 4.0 International License}.
    \end{flushleft}%
  \end{minipage}
  % \par
}

\def\papercopyright{%
  \graphicspath{{./}{image/}}
  \bigskip
  \begin{flushleft}
    \footnotesize
    % \copyright{}~\authorstocshortRev\unskip,{}\xspace~\PFUjournalyear{}
    \copyright{}~\authorstocshort\unskip,{}\xspace~\PFUjournalyear{}
  \end{flushleft}%
  % \bigskip
  \begin{minipage}{0.15\linewidth}
    \begin{flushleft}
      % \includegraphics[width=2cm]{\pfuproc@cclogo}%
      \includegraphics[width=1.0\linewidth]{\pfuproc@cclogo}%
      % \par%
      % \nopagebreak[4]%
    \end{flushleft}
  \end{minipage}
  \hfill
  \begin{minipage}{0.8\linewidth}
    \begin{flushleft}
      {%
        % \footnotesize
        \scriptsize
        This~work~is~licensed~under~a~Creative~Commons~Attribution~4.0~International~License\\
        \url{https://creativecommons.org/licenses/by-nc/4.0/legalcode}
        %This work is licensed under a Creative Commons Attribution 4.0
        %International License\\
        %\url{http://creativecommons.org/licenses/by/4.0/}
      }
      % This work is licensed under a \href{http://creativecommons.org/licenses/by/4.0/}{Creative Commons Attribution 4.0 International License}.
    \end{flushleft}%
  \end{minipage}
  % \par
}

\RequirePackage{float}

\newfloat{PapercopyrightFloat}{b}{cpr}

\g@addto@macro\@maketitle@hook{%
  \begin{PapercopyrightFloat}
    \footnotesize
    \begin{flushleft}
      \copyright{}~\authorstocshort\unskip,{}\xspace~\PFUjournalyear{}
    \end{flushleft}%
    \doclicenseThis%
    % \papercopyright
  \end{PapercopyrightFloat}
}

%}}}

\AtEndPreamble{%
\@ifpackageloaded{tex4ht}{}{%
  \ifthenelse{\boolean{singlelanguage}}{% then
    \def\@putbib@hook@post{%
      % \papercopyright
      % \par
      % \medskip
      \howtoCiteEn
      \medskip
      \listofauthorsPerTitleEn
      \makealttitleTOCOnly
      % \label{endtitle}
      \clearpage
    }
  }{% else
    \def\@putaltbib@hook@post{%
      % \papercopyright
      % \par
      % \medskip
      \howtoCiteRu
      \medskip
      \howtoCiteEn
      \medskip
      \listofauthorsPerTitleRu
      \medskip
      \listofauthorsPerTitleEn
    }
  } % endif
}
}

\AtEndPreamble{
  \@ifpackageloaded{tex4ht}{}{%
    \makeatletter
    \InputIfFileExists{pfuproc/patch/ojs.cli}{}{}%
    \makeatother
  }
}

% \InputIfFileExists{pfuproc/style/\series.cli}{}{}%

\providecommand{\chapaftersnum}{.}
\providecommand{\secaftersnum}{.}

\RequirePackage[noindentafter]{titlesec}

% \titleformat{\chapter}[block]%
% {\thispagestyle{fancy}\normalfont\chapterFontSize\chapterFontShape\chapterPosition}{\ifx\chaptertitlename\@empty\else\chaptertitlename\ \fi\thechapter\chapaftersnum}{0.8\baselineskip}{\chapterFontSize}
% \titleformat{\section}[block]%
% {\normalfont\sectionPosition\sectionFontSize\sectionFontShape}{\thesection\secaftersnum}{1em}{}
% \titleformat{\subsection}[block]%
% {\subsectionPosition\normalfont\subsectionFontSize\subsectionFontShape}{\thesubsection\secaftersnum}{1em}{}
% \titleformat{\subsubsection}[block]%
% {\subsubsectionPosition\normalfont\subsubsectionFontSize\subsubsectionFontShape}{\thesubsubsection\secaftersnum}{1em}{}
% \titleformat{\paragraph}[runin]%
% {\normalfont\paragraphFontSize\paragraphFontShape}{\theparagraph\secaftersnum}{1em}{}
% \titleformat{\subparagraph}[runin]%
% {\normalfont\subparagraphFontSize\subparagraphFontShape}{\thesubparagraph\secaftersnum}{1em}{}

\titleformat{\chapter}%[block]%
{\thispagestyle{fancy}\chapterFontSize\chapterPosition\bfseries\sffamily}{\ifx\chaptertitlename\@empty\else\chaptertitlename\ \fi\thechapter\chapaftersnum}{0.8\baselineskip}{\chapterFontSize}
\titleformat{\section}%[block]
{\sectionPosition\sectionFontSize\bfseries\sffamily}{\thesection\secaftersnum}{1em}{}
\titleformat{\subsection}%[block]%
{\subsectionPosition\subsectionFontSize\bfseries\sffamily}{\thesubsection\secaftersnum}{1em}{}
\titleformat{\subsubsection}%[block]%
{\subsubsectionPosition\subsubsectionFontSize\bfseries\sffamily}{\thesubsubsection\secaftersnum}{1em}{}
\titleformat{\paragraph}[runin]%
{\paragraphFontSize\bfseries\sffamily}{\theparagraph\secaftersnum}{1em}{}
\titleformat{\subparagraph}[runin]%
{\subparagraphFontSize\bfseries\sffamily}{\thesubparagraph\secaftersnum}{1em}{}

\titlespacing{\chapter}{\z@}{\z@}{10\p@}
\titlespacing{\section}{\z@}{*4}{*1.5}



%    ****************************************
%    *                LISTS                 *
%    ****************************************
%

% \RequirePackage{enumitem}
% \setlist[itemize]{noitemsep, topsep=0pt}
% \setlist[enumerate]{noitemsep, topsep=0pt}

\setlength{\itemsep}{0pt}
\setlength{\parsep}{0pt plus 0pt minus 0pt}
\setlength{\topsep}{0pt plus 2pt minus 0pt}

%%% Enumerate

%  Enumeration is done with four counters: enumi, enumii, enumiii
%  and enumiv, where enumN controls the numbering of the Nth level
%  enumeration.  The label is generated by the commands \labelenumi
%  ... \labelenumiv.  The expansion of \p@enumN\theenumN defines the
%  output of a \ref command.
%
% 16 Mar 88 -- changed defs of \labelenum... to use \theenum...

% \def\labelenumi{\theenumi.}
% \def\theenumi{\arabic{enumi}}

% \def\labelenumii{(\theenumii)}
% \def\theenumii{\alph{enumii}}
% \def\p@enumii{\theenumi}

% \def\labelenumiii{\theenumiii.}
% \def\theenumiii{\roman{enumiii}}
% \def\p@enumiii{\theenumi(\theenumii)}

% \def\labelenumiv{\theenumiv.}
% \def\theenumiv{\Alph{enumiv}}
% \def\p@enumiv{\p@enumiii\theenumiii}

%%% Itemize

\renewcommand{\labelitemi}{\bfseries\textendash}
\renewcommand{\labelitemii}{\bfseries\textendash}
\renewcommand{\labelitemiii}{\bfseries\textendash}
\renewcommand{\labelitemiv}{\bfseries\textendash}

%%%% Special section title style for back matter
\newcommand{\supplementary}[1]{
  \par\vspace{6pt}\noindent{\fontsize{9}{11.5}\selectfont\textbf{Supplementary~Materials:~} {#1}\par}}

% \newcommand{\authorcontributions}[1]{%
%   \smallskip
%   \noindent\footnotesize{\DivFontShape Author~Contributions:~} {#1}\par}

\def\authorcontributionsname{Author~Contributions}

\ProvideDocumentEnvironment { authorcontributions } { +b } {%
  \smallskip
  \noindent
  {\footnotesize{\DivFontShape{\authorcontributionsname}:~} { #1 }}
} {}

\def\fundingname{Funding}

% \ProvideDocumentCommand \funding { +m } {%
%   \vspace{6pt}
%   \noindent\footnotesize{\DivFontShape{\fundingname}:~} {#1} \par }

\ProvideDocumentEnvironment { funding } { +b } {%
  \smallskip
  \noindent
  {\footnotesize{\DivFontShape{\fundingname}:~} { #1 }}
} {}

\newcommand{\institutionalreview}[1]{
  \vspace{6pt}\noindent{\fontsize{9}{11.2}\selectfont\textbf{Institutional~Review~Board~Statement:~} {#1}\par}}

\newcommand{\informedconsent}[1]{
  \vspace{6pt}\noindent{\fontsize{9}{11.2}\selectfont\textbf{Informed~Consent~Statement:~} {#1}\par}}

% \newcommand{\dataavailability}[1]{
%   \smallskip
%   \noindent\footnotesize{\DivFontShape Data~Availability~Statement:~} { #1 } \par }

\def\dataavailabilityname{Data~Availability~Statement}

\ProvideDocumentEnvironment { dataavailability } { +b } {%
  \smallskip
  \noindent
  {\footnotesize{\DivFontShape{\dataavailabilityname}:~} { #1 }}
} {}

\newcommand{\publicinvolvement}[1]{% For journal Nursing Reports
  \vspace{6pt}\noindent{\fontsize{9}{11.2}\selectfont\textbf{Public~Involvement~Statement:~} {#1}\par}}

\newcommand{\guidelinesstandards}[1]{% For journal Nursing Reports
  \vspace{6pt}\noindent{\fontsize{9}{11.2}\selectfont\textbf{Guidelines~and~Standards~Statement:~} {#1}\par}}

% \newcommand{\conflictsofinterest}[1]{%
%   \smallskip
%   \noindent
%   {\footnotesize{\DivFontShape Conflicts~of~Interest:~} { #1 }} \par }

\def\conflictsofinterestname{Conflicts~of~Interest}

\ProvideDocumentEnvironment { conflictsofinterest } { +b } {%
  \smallskip
  \noindent
  {\footnotesize{\DivFontShape{\conflictsofinterestname}:~} { #1 }}
} {}

\newcommand{\entrylink}[1]{% For journal Encyclopedia
  \smallskip
  \noindent\footnotesize{\DivFontShape Entry~Link:~} { #1 } \par }

\newcommand{\reviewreports}[1]{%
  \smallskip
  \noindent\footnotesize{\DivFontShape Review~Reports:~} {#1}\par}

\newcommand{\abbreviations}[2]{\vspace{12pt}\noindent{\selectfont\textbf{#1}}{%
    \par\vspace{3pt}\hspace{-0.85cm}{\fontsize{9}{11.2}\selectfont #2}\par}}

% Standby command for adding paragraph in back matter part
\newcommand{\specialsection}[2]{%
  \vspace{12pt}\noindent{\selectfont\textbf{#1}\par\vspace{6pt}\noindent {\fontsize{9}{9}\selectfont #2}\par}}

% Command for author's biography
\newcommand{\bio}[2]{%
  \noindent{#1}\hspace{1.1cm}\noindent {\fontsize{9}{11.2}\selectfont \pbox[b]{13.86cm}{#2}}\par\vspace{6pt}}

% Use for special paragraph requirement in back matter
\newcommand{\backnotes}[2]{
  \smallskip
  \noindent\footnotesize{\DivFontShape #1:} {#2}\par}

\def\acknowledgmentsname{Acknowledgments}

% \newcommand{\acknowledgments}[1]{%
%   \vspace{6pt}
%   \noindent\footnotesize{\DivFontShape\acknowledgmentsname:} { #1 } \par }

\ProvideDocumentEnvironment { acknowledgments } { +b } {%
  \smallskip
  \noindent
  {\footnotesize{\DivFontShape{\acknowledgmentsname}:~} { #1 }}
} {}

\ExplSyntaxOff

%%% Local Variables:
%%% coding: utf-8-unix
%%% End:
