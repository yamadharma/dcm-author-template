\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pfuproc}%
[2010/03/14 %
v0.1.2 %
Bulletin of Peoples' Friendship University of Russia]

\RequirePackage{xkeyval}
\RequirePackage[a4paper]{geometry}

\ExecuteOptions{a4paper,10pt,twoside,onecolumn,final,openany}
\ProcessOptions*\relax

\define@key{PFUproc}{series}{%
  \def\series{#1}%
  \InputIfFileExists{pfuproc/style/#1.cli}{}{}%
}

\LoadClassWithOptions{kproc}

%{{{ \paperid{}

\RequirePackage{currfile}

\newwrite\paperidFile
\immediate\openout\paperidFile=split-paper

\renewcommand{\paperid}[1]{
  \immediate\write\paperidFile{#1 \thepage}
  \def\PFUpaperid{#1}
}
\let\PFUpaperid\@empty

\AtEndDocument{%
  \immediate\closeout\paperidFile
}

\def\@maketitle@hook@post{%
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
  \def\listauthorsname{Information about the authors}
  \@ifpackageloaded{polyglossia}{%
    \addto\captionsrussian@modern{%
      \def\listauthorsname{Сведения об авторах}
    }
  }{%
    \addto\extrasrussian{%
      \def\listauthorsname{{\CYRS}{\cyrv}{\cyre}{\cyrd}{\cyre}{\cyrn}{\cyri}{\cyrya} {\cyro}{\cyrb} {\cyra}{\cyrv}{\cyrt}{\cyro}{\cyrr}{\cyra}{\cyrh}}
    }
  }
  \addto\captionsenglish{%
    \def\listauthorsname{Information about the authors}
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
    \noindent
    \textbf{\listauthorsname}:
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
      \noindent
      \textbf{\listauthorsname}:%
      \par%
      % \end{otherlanguage}%
      \nopagebreak[4]%
      % \begin{otherlanguage}{english}
      \noindent%
      \@starttoc{\currfilebase.english.loa}
    \end{otherlanguage}
    \par
  }
}

\newcommand{\authorlistFontShape}{\bf}

\newcommand{\pfuproc@bra}{(}
\newcommand{\pfuproc@ket}{)}
\newcommand{\pfuproc@komma}{, }

\AtBeginDocument{%
  \def\pfuproc@phoneName{Phone}
  \@ifpackageloaded{polyglossia}{%
    \addto\captionsrussian@modern{%
      \def\pfuproc@phoneName{тел.}
    }
    \addto\captionsenglish{%
      \def\pfuproc@phoneName{phone}
    }
  }{%
    \addto\extrasrussian{%
      \def\pfuproc@phoneName{{\cyrt }{\cyre }{\cyrl }.}
    }
    \addto\extrasenglish{%
      \def\pfuproc@phoneName{phone}
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

% \def\pfuproc@authorlistentry{}
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
  \def\pfuproc@bra{(}
  \def\pfuproc@ket{)}
  \def\pfuproc@komma{, }
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
  \else{ (\pfuproc@country)}
  \fi~---
    \ifx\pfuproc@authorrank\@empty
    \else
    \pfuproc@authorrank,
    \fi
    \ifx\pfuproc@authordegree\@empty
    \else
    \pfuproc@authordegree,
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
    \pfuproc@komma\protect\mbox{\pfuproc@phoneName:~\pfuproc@phone{}}%
    \fi
    \ifx\pfuproc@orcid\@empty
    \else
    \pfuproc@komma\protect\mbox{ORCID:~https://orcid.org/\pfuproc@orcid{}}%
    \fi
    \ifx\pfuproc@researcherid\@empty
    \else
    \pfuproc@komma\protect\mbox{ResearcherID: \pfuproc@researcherid{}}%
    \fi
    \ifx\pfuproc@scopusauthorid\@empty
    \else
    \pfuproc@komma\protect\mbox{Scopus Author ID: \pfuproc@scopusauthorid{}}%
    \fi
    \pfuproc@ket%
  }

  \ifx\pfuproc@authorfull@english\@empty
  \else
  \def\pfuproc@authorlistentry@english{%
    {\authorlistFontShape
      \pfuproc@authorfull@english}%
    \ifx\pfuproc@country@english\@empty
    \else{ (\pfuproc@country@english)}
    \fi~---
    \ifx\pfuproc@authorrank@english\@empty
    \else
    \pfuproc@authorrank@english,
    \fi
    \ifx\pfuproc@authordegree@english\@empty
    \else
    \pfuproc@authordegree@english,
    \fi
    \ifx\pfuproc@authorpost@english\@empty
    \else
    \pfuproc@authorpost@english{}
    \fi
    \pfuproc@bra%
    \ifx\pfuproc@mail\@empty
    \else
    \mbox{\-e-mail}:~\protect\url{\pfuproc@mail}%
    \fi
    \ifx\pfuproc@phone\@empty
    \else
    \pfuproc@komma\protect\mbox{phone:~\pfuproc@phone{}}%
    \fi
    \ifx\pfuproc@orcid\@empty
    \else
      \pfuproc@komma\protect\mbox{ORCID:~https://orcid.org/\pfuproc@orcid{}}%
    \fi
    \ifx\pfuproc@researcherid\@empty
    \else
      \pfuproc@komma\protect\mbox{ResearcherID: \pfuproc@researcherid{}}%
    \fi
    \ifx\pfuproc@scopusauthorid\@empty
    \else
      \pfuproc@komma\protect\mbox{Scopus Author ID: \pfuproc@scopusauthorid{}}%
    \fi
    \pfuproc@ket%
  }
  \fi

  % \addtocontents{loa}{\begin{otherlanguage}{russian}\pfuproc@authorlistentry\end{otherlanguage}\newline}
  \addtocontents{loa}{\pfuproc@authorlistentry\newline}
  \global\setbool{isListofauthorsEmpty}{false}
  % \protected@write\authorlistFile{\let\label\@gobble
  % \let\index\@gobble
  % \let\glossary\@gobble}{\pfuproc@authorlistentry\newline}
  \addtocontents{\currfilebase.loa}{\pfuproc@authorlistentry\newline}
  \ifx\pfuproc@authorlistentry@english\@empty
  \else
  \addtocontents{\currfilebase.english.loa}{\pfuproc@authorlistentry@english\newline}
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


\RequirePackage{scrlfile}
\BeforeClosingMainAux{%
  \let\pfuproc@titleslist@entry\@empty
  \g@addto@macro\pfuproc@titleslist@entry{%
    \string\clearpage
    % {\LARGE \textbf{{\CYRN}{\cyra}{\cyrsh}{\cyri} {\cyra}{\cyrv}{\cyrt}{\cyro}{\cyrr}{\cyrery}}}
    \string\InputIfFileExists{default.loa}{}{}
  }

  \g@addto@macro\pfuproc@titleslist@entry{%
    \string\end{document}
  }
  \addtocontents{titlelist.tex}{\pfuproc@titleslist@entry}
  \let\pfuproc@titleslist@entry\@empty
}

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
  \setlength{\lheadwidth}{0.07\linewidth}
  \settowidth{\rheadwidth}{\PFUjournalURL}
  \setlength{\cheadwidth}{\textwidth}
  \addtolength{\cheadwidth}{-\rheadwidth}
  \addtolength{\cheadwidth}{-\lheadwidth}
  \addtolength{\headheight}{\baselineskip}
  % \addtolength{\cheadwidth}{-1cm}
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \lhead{}
  \rhead{}
  
  \lhead{%
    \noindent
    \begin{minipage}[c]{\lheadwidth}
      \includegraphics[width=\linewidth]{\PFUtitlelogo}
    \end{minipage}
    \hfill
  }
  \chead{%
    \hspace*{-4.8cm}
    \vspace*{-24pt}
    \begin{minipage}[c]{\cheadwidth}
      \begin{center}
        \headerFontSize
        \PFUtitlelogoTop\\[-6pt]
        \nointerlineskip
        \noindent\rule{\linewidth}{2pt}\\[2pt]
        \PFUtitlelogoBottom
      \end{center}
    \end{minipage}
    }
    \rhead{%
    % \hfill
    \begin{minipage}[c]{\rheadwidth}
      \begin{center}
        \headerFontSize
        \textbf{%
          \PFUjournalyear{} Vol.\,\PFUjournalvolume{}
          No.\,\PFUjournalnumber{}%
          \ifthenelse{\pageref{starttitle}=\pageref{endtitle}}%
          {, \pageref{starttitle}}% then
          {, \pageref{starttitle}--\pageref{endtitle}}% else
        }\\
        \PFUjournalURL
      \end{center}
    \end{minipage}
  }
  % \vspace{\baselineskip}
}

% \AtBeginDocument{
%   \addtolength\headsep{\baselineskip}%
% }

\def\@maketitle@hook@pre{%
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
  \begin{otherlanguage*}{russian}
    \noindent
    \textbf{{\CYRD}{\cyrl}{\cyrya}
    {\cyrc}{\cyri}{\cyrt}{\cyri}{\cyrr}{\cyro}{\cyrv}{\cyra}{\cyrn}{\cyri}{\cyrya}:}
  \end{otherlanguage*}\\
  \iflanguage{russian}{%
    \ifpolyglossia\begin{otherlanguage}{\PFUlanguage}\else\begin{otherlanguage*}{\PFUlanguage}\fi
      \emph{\authorstocshort} \@title{}~//
      \PFUjournal{}. \CYRS\cyre\cyrr\cyri\cyrya: \PFUjournalseries{}.~---
      \PFUjournalyear.~---\ifx\PFUjournalvolume\@empty\else{} \CYRT.~\PFUjournalvolume\fi\ifx\PFUjournalnumber\@empty\else, \No~\PFUjournalnumber\fi{}.~---
      \CYRS.~\pageref{starttitle}--\pageref{endtitle}.%
      \ifx\@empty\@doi \else{}~--- DOI: \@doi{}.\fi
    \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi%
  }{%
    \ifpolyglossia\begin{otherlanguage}{\PFUlanguage}\else\begin{otherlanguage*}{\PFUlanguage}\fi
      \emph{\authorstocshort} \@title{}~// \PFUjournal{}.~---
      \PFUjournalyear.~---\ifx\PFUjournalvolume\@empty\else{} Vol.~\PFUjournalvolume\fi\ifx\PFUjournalnumber\@empty\else, No~\PFUjournalnumber\fi{}.~---
      Pp.~\pageref{starttitle}--\pageref{endtitle}.%
      \ifx\@empty\@doi \else{}~--- DOI: \@doi{}.\fi
    \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi%
  }
  \par
}

\DeclareRobustCommand{\howtoCiteEn}{%
  \noindent
  \textbf{For citation:}\\
  \iflanguage{english}{%
    \ifpolyglossia\begin{otherlanguage}{\PFUlanguage}\else\begin{otherlanguage*}{\PFUlanguage}\fi
      \authorstocshort{} \@title{}, \PFUjournal{}%
      \ifx\PFUjournalvolume\@empty\else{} \textbf{\PFUjournalvolume}\fi\ifx\PFUjournalnumber\@empty\else{} (\PFUjournalnumber)\fi{}
      (\PFUjournalyear)
      \pageref{starttitle}--\pageref{endtitle}.
      \ifx\@empty\@doi \else DOI: \@doi{}.\fi{}
    \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi%
  }{%
    \ifpolyglossia\begin{otherlanguage}{english}\else\begin{otherlanguage*}{english}\fi
      \altauthorstocshort{} \@alttitle{}, \PFUjournal{}%
      \ifx\PFUjournalvolume\@empty\else{} \textbf{\PFUjournalvolume}\fi\ifx\PFUjournalnumber\@empty\else{} (\PFUjournalnumber)\fi{}
      (\PFUjournalyear)
      \pageref{starttitle}--\pageref{endtitle}.
      \ifx\@empty\@doi \else DOI: \@doi{}.\fi{}
      In Russian.
    \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi%
  }%
  \par
}

%}}}

%{{{ Логотип для CC лицензии

% По умолчанию лицензия CC-BY
\DeclareRobustCommand{\cclogo}[1]{%
  \def\pfuproc@cclogo{#1}
}
\def\pfuproc@cclogo{by}

\def\papercopyright{%
\graphicspath{{./}{image/}}
\bigskip
\begin{flushleft}
\copyright{} \authorstoc\xspace \PFUjournalyear{}
\end{flushleft}%
\bigskip
\begin{flushleft}
  \includegraphics[width=2cm]{\pfuproc@cclogo}%
  \par%
  \nopagebreak[4]%
  {\footnotesize
  This work is licensed under a Creative Commons Attribution 4.0
  International License
  }
  % This work is licensed under a \href{http://creativecommons.org/licenses/by/4.0/}{Creative Commons Attribution 4.0 International License}.
\end{flushleft}%
\par
}

%}}}

\AtEndPreamble{%
\@ifpackageloaded{tex4ht}{}{%
  \ifthenelse{\boolean{singlelanguage}}{% then
    \def\@putbib@hook@post{%
      \papercopyright
      \medskip
      \howtoCiteEn
      \medskip
      \listofauthorsPerTitleEn
      \makealttitleTOCOnly
      % \label{endtitle}
      \clearpage
    }
  }{% else
    \def\@putaltbib@hook@post{%
      \papercopyright
      \medskip
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

%%% Local Variables:
%%% coding: utf-8-unix
%%% End:
