%
\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{kproc}%
        [2007/12/05 v0.0.7.3]
\def\@tempa#1#2\@nil{\edef\@classname{#1}}
\expandafter\@tempa\@currnamestack{}{}{}\@nil
\ifx\@classname\@empty \edef\@classname{\@currname}\fi
%%%--
\def\class@name{kproc}

\RequirePackage{etoolbox}
%\RequirePackage{etextools}
%\reserveinserts{128}

%%%
%\def\@namedef#1{\expandafter\def\csname test:#1\endcsname}
%\def\@nameuse#1{\csname #1\endcsname}
\newcounter{PFUtitle}
\newcounter{subtitle}
%% \def\label#1{\@bsphack
%%   \protected@write\@auxout{}%
%%          {\string\newlabel{\thePFUtitle:#1}{{\@currentlabel}{\thepage}}}%
%%   \@esphack}
%% \def\ref#1{\expandafter\@setref\csname r@\thePFUtitle:#1\endcsname\@firstoftwo{\thePFUtitle:#1}}
%% \def\pageref#1{\expandafter\@setref\csname r@\thePFUtitle:#1\endcsname
%%   \@secondoftwo{\thePFUtitle:#1}}
%% %
%% \def\glabel#1{\@bsphack
%%   \protected@write\@auxout{}%
%%          {\string\newlabel{#1}{{\@currentlabel}{\thepage}}}%
%%   \@esphack}
%% \def\gref#1{\expandafter\@setref\csname r@#1\endcsname\@firstoftwo{#1}}
%% \def\gpageref#1{\expandafter\@setref\csname r@#1\endcsname
%%   \@secondoftwo{#1}}
%%%--
\newif\if@Elproofing
\@Elproofingfalse
%

\providecommand{\authorFontShape}{\bfseries}
\providecommand{\authorFontSize}{\normalsize}

\def\tabular@font{}
\def\author@font{\authorFontSize\authorFontShape}
\def\@bibliosize{\small}
\def\@historysize{\small}
\def\@keywordsize{\small}
\def\@overaddressskip{2pt}
% \def\@titlesize{\Large\bfseries}
\def\@subtitlesize{\large\bfseries}
\def\@authorsize{\small}
\def\@keywordheading{{\it Key words: \ }}
\def\@addressstyle{\small\itshape}
\def\@altaddressstyle{\small\itshape}
%\def\@captionsize{\small}
%\def\@tablecaptionsize{\@captionsize}
%\def\@figurecaptionsize{\@captionsize}
\def\@tablesize{\small}
\def\@keywordwidth{.8\textwidth}
% \def\@abstractwidth{.8\textwidth}
\def\@abstractwidth{\textwidth}
\def\@fignumfont#1{#1}
\def\@secnumfont#1{\upshape}
\def\@catchlinesize{\footnotesize}
\def\@runheadsize{\normalsize}
\def\acknowledgmentsname{Acknowledgments}
%
\newtoks\t@glob@notes                   % List of all notes
\newtoks\t@loc@notes                    % List of notes for one element
\newcount\prev@elem \prev@elem=0        % Variables to keep track of
\newcount\cur@elem  \cur@elem=0         % types of elements that are processed
\newcount\note@cnt                      % Number of notes per element
\newcounter{PFUauthor}[PFUtitle]           % Author counter
\newcounter{altauthor}[PFUtitle]           % Author counter
\newcount\n@author                      % Total number of authors
\def\n@author@{1}                       % idem, read from .aux file
\newcounter{collab}                     % Collaboration counter
\newcount\n@collab                      % Total number of collaborations
\def\n@collab@{}                        % idem, read from .aux file
\newcounter{address}[PFUtitle]          % Address counter
\newcounter{altaddress}[PFUtitle]       % AltAddress counter
\def\theHaddress{\arabic{address}}      % for hyperref
\chardef\e@title=1
\chardef\e@subtitle=1
\chardef\e@author=2
\chardef\e@altauthor=2
\chardef\e@collab=3
\chardef\e@address=4
\chardef\e@altaddress=4
\newif\if@newelem                 % Switch to new type of element?
\newif\if@firstauthor             % First author or collaboration?
\newif\if@preface                 % If preface: omit history and abstract
\newif\if@hasabstract             % If abstract / keywords: do not omit rules
\newif\if@haskeywords             % If abstract / keywords: do not omit rules
%%
\newif\if@keywordsAsFooter        % If keywords present as footer
\global\@keywordsAsFooterfalse
%%
\newif\if@receivedAsFooter        % If received present as footer
  % \global\@receivedAsFootertrue
  \global\@receivedAsFooterfalse
%%
%%
\let\report@elt\@gobble
\def\beg@elem{\global\t@loc@notes={}\global\note@cnt\z@}
%\def\beg@elem{}
\def\add@tok#1#2{\global#1\expandafter{\the#1#2}}
\def\add@xtok#1#2{\begingroup
  \no@harm
  \xdef\@act{\global\noexpand#1{\the#1#2}}\@act
\endgroup}
\def\@xnamedef#1{\expandafter\xdef\csname #1\endcsname}

%\def\no@harm{%
%  \let\\=\relax  \let\rm\relax
%  \let\ss=\relax \let\ae=\relax \let\oe=\relax
%  \let\AE=\relax \let\OE=\relax
%  \let\o=\relax  \let\O=\relax
%  \let\i=\relax  \let\j=\relax
%  \let\aa=\relax \let\AA=\relax
%  \let\l=\relax  \let\L=\relax
%  \let\d=\relax  \let\b=\relax \let\c=\relax
%  \let\bar=\relax
%  \def\protect{\noexpand\protect\noexpand}}

\def\no@harm{%
  \let\\=\relax
}

\def\proc@elem#1#2{\begingroup
    \no@harm                             % make a few instructions harmless
    \let\thanksref\@gobble               % remove \thanksref from element
    \@xnamedef{@#1}{#2}%                 % and store as \@#1
  \endgroup
  \prev@elem=\cur@elem                   % keep track of type of previous
  \cur@elem=\csname e@#1\endcsname       % and current element
  \expandafter\elem@nothanksref#2\thanksref\relax}
\def\elem@nothanksref#1\thanksref{\futurelet\@peektok\elem@thanksref}
\def\elem@thanksref{\ifx\@peektok\relax  % No more \thanksref, so now exit
  \else \expandafter\elem@morethanksref \fi}
\def\elem@morethanksref#1{\add@thanksref{#1}\elem@nothanksref}
\def\add@thanksref#1{\global\advance\note@cnt\@ne
  \ifnum\note@cnt>\@ne \add@xtok\t@loc@notes{\note@sep}\fi
  \add@tok\t@loc@notes{\ref{#1}}}
\def\note@sep{,}
% \def\thanks{\@ifnextchar[{\@tempswatrue
%   \thanks@optarg}{\@tempswafalse\thanks@optarg[]}}
\def\thanks@optarg[#1]#2{\refstepcounter{footnote}
  \if@tempswa\label{#1}\else\relax\fi
  \add@tok\t@glob@notes{\footnotetext}%
  \add@xtok\t@glob@notes{[\the\c@footnote]}%
  \add@tok\t@glob@notes{{#2}}}
\let\real@refstepcounter\refstepcounter
% \def\@writecount{\write\@mainaux{\string\global
%   \string\@namedef{n@author@}{\the\n@author}}%
%   \write\@mainaux{\string\global\string
%   \@namedef{n@collab@}{\the\n@collab}}}
\def\@writecount{\write\PFU@aux{\string\global
  \string\@namedef{n@author@}{\the\n@author}}%
  \write\@mainaux{\string\global\string
  \@namedef{n@collab@}{\the\n@collab}}}
\def\runtitle#1{\gdef\@runtitle{#1}}
\def\runauthor#1{\gdef\@runauthor{#1}}
\let\@runauthor\relax
\let\@runtitle\relax
\let\@runningauthor\relax
%
\newbox\t@abstract
% \newinsert\t@abstract
\newif\if@hasabstract             % If abstract / keywords: do not omit rules
\global\@hasabstractfalse       % Default:  no abstract or keywords
\newcount\sv@hyphenpenalty        % Count register to save \hyphenpenalty
\newbox\t@altabstract
\newif\if@hasaltabstract          % If abstract / keywords: do not omit rules
\global\@hasaltabstractfalse       % Default:  no abstract or keywords
\newcount\sv@hyp\newbox\t@abstract
\newif\if@hasabstract             % If abstract / keywords: do not omit rules
\global\@hasabstractfalse       % Default:  no abstract or keywords
\newcount\sv@hyphenpenalty        % Count register to save \hyphenpenaltyhenpenalty
                                % Count register to save \hyphenpenalty
%%%
%%%--
% \def\proc@elem#1#2{\begingroup
%     \no@harm                             % make a few instructions harmless
%     \let\thanksref\@gobble               % remove \thanksref from element
%     \@xnamedef{@#1}{#2}%                 % and store as \@#1
%   \endgroup
%   \prev@elem=\cur@elem                   % keep track of type of previous
%   \cur@elem=\csname e@#1\endcsname       % and current element
%   \expandafter\elem@nothanksref#2\thanksref\relax}
% \def\elem@nothanksref#1\thanksref{\futurelet\@peektok\elem@thanksref}
% \def\elem@thanksref{\ifx\@peektok\relax  % No more \thanksref, so now exit
%   \else \expandafter\elem@morethanksref \fi}
% \def\elem@morethanksref#1{\add@thanksref{#1}\elem@nothanksref}
% \def\add@thanksref#1{\global\advance\note@cnt\@ne
%   \ifnum\note@cnt>\@ne \add@xtok\t@loc@notes{\note@sep}\fi
%   \add@tok\t@loc@notes{\ref{#1}}}
% \def\note@sep{,}
% \def\thanks{\@ifnextchar[{\@tempswatrue
%   \thanks@optarg}{\@tempswafalse\thanks@optarg[]}}
% \def\thanks@optarg[#1]#2{\refstepcounter{footnote}
%   \if@tempswa\label{#1}\else\relax\fi
%   \add@tok\t@glob@notes{\footnotetext}%
%   \add@xtok\t@glob@notes{[\the\c@footnote]}%
%   \add@tok\t@glob@notes{{#2}}}
%%%
%%
%%% Dimension's setup
\chardef\@currsizeindex=6
\widowpenalty=10000
\clubpenalty=10000
\brokenpenalty=10000
\newdimen\linespacing
\lineskip=1pt \lineskiplimit=1pt
\normallineskip=1pt \normallineskiplimit=1pt
\let\baselinestretch=\@empty
%%%
% \paperheight=250mm
% \paperwidth=160mm
% \topmargin=-10mm
% % \hoffset=in
% % \voffset=-70pt
% \oddsidemargin=-7mm
% \evensidemargin=-7mm
%%%
\headheight=5pt \headsep=14pt
\footskip=12pt
\textheight=50.5pc \topskip=10pt
\textwidth=30pc
% \textwidth=135mm
\columnsep=10pt \columnseprule=0pt
\marginparwidth=90pt
\marginparsep=11pt
\marginparpush=5pt
\AtBeginDocument{\settoheight{\footnotesep}{\footnotesize M$^1$}}
%%%
% \AtBeginDvi{\special{%
% papersize=210mm,297mm}}%
%%%
\skip\footins=7pt plus11pt
\skip\@mpfootins=\skip\footins
\fboxsep=3pt \fboxrule=.4pt
\arrayrulewidth=.4pt    \doublerulesep=2pt
\labelsep=5pt           \arraycolsep=\labelsep
\tabcolsep=\labelsep    \tabbingsep=\labelsep
% \floatsep=15pt plus 12pt    \dblfloatsep=15pt plus 12pt
\floatsep=8pt  \dblfloatsep=8pt
\textfloatsep=\floatsep  \dbltextfloatsep=15pt plus 12pt
\intextsep=\floatsep
\@fptop=0pt plus1fil     \@dblfptop=0pt plus1fil
\@fpbot=0pt plus1fil     \@dblfpbot=0pt plus1fil
\@fpsep=8pt plus2fil     \@dblfpsep=8pt plus2fil\relax
\parskip=0pt \relax
\newdimen\normalparindent
% \normalparindent=18pt
\normalparindent=8dd
\parindent=\normalparindent
\partopsep=0pt \relax \parsep=0pt \relax \itemsep=0pt \relax
\@lowpenalty=51         \@medpenalty=151        \@highpenalty=301
\@beginparpenalty=-\@lowpenalty
\@endparpenalty=-\@lowpenalty
\@itempenalty=-\@lowpenalty
%%%
\def\ps@empty{\let\@mkboth\@gobbletwo
  \let\@oddhead\@empty \let\@evenhead\@empty
  \let\@oddfoot\@empty \let\@evenfoot\@empty
  \global\topskip\normaltopskip}
\def\ps@plain{\ps@empty
  \def\@oddfoot{\normalfont\scriptsize \hfil\thepage\hfil}%
  \let\@evenfoot\@oddfoot}
\def\ps@headings{\ps@empty
  \def\@evenhead{\normalfont\scriptsize
      \rlap{\thepage}\hfil \leftmark{}{}\hfil}%
  \def\@oddhead{\normalfont\scriptsize \hfil
      \rightmark{}{}\hfil \llap{\thepage}}%
  \let\@mkboth\markboth
}
\let\sectionname\@empty
\let\subsectionname\@empty
\let\subsubsectionname\@empty
\let\paragraphname\@empty
\let\subparagraphname\@empty
% \def\leftmark{\expandafter\@firstoftwo\topmark{}{}}
% \def\rightmark{\expandafter\@secondoftwo\botmark{}{}}
\def\ps@firstpage{\ps@plain
  \def\@oddfoot{\normalfont\scriptsize \hfil\thepage\hfil
     \global\topskip\normaltopskip}%
  \let\@evenfoot\@oddfoot
  \def\@oddhead{\@serieslogo\hss}%
  \let\@evenhead\@oddhead % in case an article starts on a left-hand page
}
\long\def\@nilgobble#1\@nil{}
\def\markboth#1#2{%
  \begingroup
    \@temptokena{{#1}{#2}}\xdef\@themark{\the\@temptokena}%
    \mark{\the\@temptokena}%
  \endgroup
  \if@nobreak\ifvmode\nobreak\fi\fi}
\def\ps@myheadings{\ps@headings \let\@mkboth\@gobbletwo}
\newskip\normaltopskip
\normaltopskip=10pt \relax
\let\sectionmark\@gobble
\let\subsectionmark\@gobble
\let\subsubsectionmark\@gobble
\let\paragraphmark\@gobble

%{{{ Declarations

\providecommand{\headerFontSize}{\footnotesize}

%}}}

\newif\ifpolyglossia\polyglossiafalse
\AtBeginDocument{%
  \@ifpackageloaded{polyglossia}{\polyglossiatrue}{\polyglossiafalse}
}

%%
\RequirePackage{xkeyval}
\RequirePackage{substr}
%%
\def\ProcessClassOptionsWithKV#1{%
  \let\@tempa\@empty
  \@for\CurrentOption:=\@classoptionslist\do{%
    \@ifundefined{KV@#1@\CurrentOption}%
    {}{\edef\@tempa{\@tempa,\CurrentOption,}}}%
  \edef\@tempa{%
    \noexpand\setkeys{#1}{\@tempa\@ptionlist{\@currname.\@currext}}}%
  \@tempa
  \AtEndOfClass{\let\@unprocessedoptions\relax}}
%%
% \define@key{PFUproc}{series}{%
%   \def\series{#1}%
%   \InputIfFileExists{pfuproc/style/#1.cli}{}{}%
% }
%% \def\SetPFUprocKey#1{{\setkeys{PFUproc}{#1}}}
\def\SetPFUprocKey#1{%
  \let\@tempd\@empty
  \edef\@tempd{\CurrentOption}
  \edef\@tempd{\noexpand\setkeys{#1}{\@tempd}}
  \@tempd
}
%%
\DeclareRobustCommand{\defaultlanguage}[1]{%
  \def\@defaultlanguage{#1}%
}
\DeclareRobustCommand{\defaultaltlanguage}[1]{%
  \def\@defaultaltlanguage{#1}%
}
\let\@defaultlanguage\@empty
\let\@defaultaltlanguage\@empty

%\AtBeginDocument{%
  %\global\def\@biblabel#1{\@ifnotempty{#1}{#1.}}
%  \def\@biblabel#1{#1.}
%}
%%
\RequirePackage{xifthen}
%% Multicolumn
\newboolean{PFUprocMultiColumn}
\setboolean{PFUprocMultiColumn}{false}
% \newif\if@sectionAfterTitle
% \@sectionAfterTitlefalse
\newboolean{sectionAfterTitle}
\setboolean{sectionAfterTitle}{false}

\DeclareRobustCommand{\doi}[1]{%
  \def\@doi{#1}
}
\let\@doi\@empty

\DeclareRobustCommand{\doiPrefix}[1]{%
  \def\@doiPrefix{#1}
}
\let\@doiPrefix\@empty

\DeclareRobustCommand{\doiSuffixBase}[1]{%
  \def\@doiSuffixBase{#1}
}
\let\@doiSuffixBase\@empty

\DeclareRobustCommand{\doiBase}[1]{%
  \def\@doiBase{#1}
}
\let\@doiBase\@empty

\DeclareRobustCommand{\documentType}[1]{%
  \def\@documentType{#1}
}
\let\@documentType\@empty

%% \newif\if@multicolumn
%% \@multicolumnfalse
%%
%% Only default options
%%
%% \DeclareOption{8pt}{%
%%   \PassOptionsToClass{\CurrentOption}{kgeneric}
%% }
%% \DeclareOption{10pt}{%
%%   \PassOptionsToClass{\CurrentOption}{kgeneric}
%% }
%% \DeclareOption{twocolumn}{%
%%   \PassOptionsToClass{\CurrentOption}{kgeneric}
%% }
%%
%% \DeclareOption{onecolumn}{\@twocolumnfalse}
%% \DeclareOption{onecolumn}{\@multicolumnfalse}
%% \DeclareOption{twocolumn}{\@twocolumntrue}
%% \DeclareOption{twocolumn}{\@multicolumntrue}
%% \DeclareOption{onecolumn}{\@twocolumnfalse}
%\DeclareOption{longtable}{%
%  \PassOptionsToPackage{longtable}{caption}%
%}
%% \DeclareOption*{%
%%   \PassOptionsToClass{\CurrentOption}{kgeneric}
%% }
%% \setkeys{PFUproc}{series=pfu-physic}
\DeclareOption*{%
%% %%   \setkeys{PFUproc}{series}
%% %% \setkeys{PFUproc}{\@classoptionslist}
%%   \let\@tempd\CurrentOption
%%   \KV@do\@tempd\relax
%% %%   \setkeys{PFUproc}{\@tempd}
%% %%   \write{\@tempd}
%% %%   \KV@split\CurrentOption==\relax
%%   \@ifundefined{KV@PFUproc@\CurrentOption}%
%%   {%
%% %%     \write{222222}
%% %%     \write{\CurrentOption}
  \IfSubStringInString{=}{\CurrentOption}%
  {% then
    \SetPFUprocKey{PFUproc}
%%     \IfSubStringInString{series}{\CurrentOption}%
%%     {% then
%%       \SetPFUprocKey
%% %%       \setkeys{PFUproc}{series=pfu-physic}
%% %%       \let\@tempc\BehindSubString{=}{\CurrentOption}
%% %%       \InputIfFileExists{pfuproc/pfu-\BehindSubString{=}{\CurrentOption}.cli}{}{}
%%     }%
%%     {% else
%%     }%
%%     \let\@tempc\BeforeSubString{=}{\CurrentOption}
%%     \let\@tempd\BehindSubString{=}{\CurrentOption}
%%     \setkeys{PFUproc}{\@tempc=\@tempd}
%%     \setkeys{PFUproc}{\CurrentOption}
%%     \setkeys{PFUproc}{series=pfu-physic}
%%     \SetPFUprocKey{\CurrentOption}
  }%
  {% else
    \PassOptionsToClass{\CurrentOption}{kgeneric}
  }%
%%     \PassOptionsToClass{\CurrentOption}{kgeneric}
%%   }%
%%   {%
%%     \setkeys{PFUproc}{\CurrentOption}
%% %%     \write{333333}
%% %%     \write{\CurrentOption}
%%   }
}
%% \ExecuteOptions{10dd,twoside,final,singlespace}
%% \ExecuteOptions{8dd,twocolumn,twoside,final,singlespace}
\ProcessOptions*\relax
%% \ProcessClassOptionsWithKV{PFUproc}
%%
%% End Options
%%
%%
%% Presets
%%
%% \RequirePackage{geometry}
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
% \LoadClassWithOptions{kgeneric}
% \RequirePackage{mathtext}
% \RequirePackage[english,russian]{babel}

\LoadClass{kgeneric}
%\LoadClassWithOptions{kgeneric}
%%
  \message{1111111}
%%   \newif\if@twocolumn
%%   \@twocolumntrue%
  \if@twocolumn\typeout{2-col}%
  \else%
  \typeout{1-col}%
  \fi%
  \if@multicolumn\typeout{2-col}%
  \else%
  \typeout{1-col}%
  \fi%
  \ifthenelse{\boolean{@twocolumn}}{\typeout{2-col}}{\typeout{1-col}}
  \ifthenelse{\boolean{PFUprocMultiColumn}}{\typeout{2-col}}{\typeout{1-col}}
%%
%% Required packages
%%

%\RequirePackage{array}
%\setlength{\extrarowheight}{1ex}

%%
%% \RequirePackage{ltxgrid}
%% \RequirePackage{substr}
\RequirePackage{longtable}
\if@multicolumn%
  \RequirePackage{ltxgrid}[2001/07/26]
\else%
  %% FIXME Problem package ``array'' with ``ltxutil''
  \RequirePackage{array}
  \setlength{\extrarowheight}{1ex}
\fi
% \RequirePackage[footnotesize,all]{caption}
\RequirePackage{caption}
\RequirePackage{ltcaption}
% \renewcommand{\@captionsize}{\footnotesize}
% \RequirePackage{longtable}
\RequirePackage{truncate}

% \RequirePackage[unicode]{hyperref}

%% \input{pfuproc/collection.cli}
%% \input{pfuproc/pfu-physic.cli}
%%
%% Declarations
%%
\newwrite\PFU@aux
\def\PFU@auxname{pfu\thePFUtitle}
%%
%%
%% Counters
%%
%% \newcounter{title}
\@addtoreset{section}{PFUtitle}
%%%% floats
\@addtoreset{figure}{PFUtitle}
\@addtoreset{table}{PFUtitle}
%%%
\@addtoreset{footnote}{PFUtitle}
%%%% lists
%\newcounter{textenumerate}
%%
%% Float's parameters
%%
\renewcommand\thefigure{\@arabic\c@figure}
\renewcommand\thetable{\@arabic\c@table}
% \renewcommand{\@makecaption}[2]{}
%\renewcommand{\captionlabeldelim}{.~}
%%
%% \newcounter{title}

\def\label#1{\@bsphack
  \protected@write\@auxout{}%
         {\string\newlabel{\thePFUtitle:#1}{{\@currentlabel}{\thepage}}}%
  \@esphack}
\def\ref#1{\expandafter\@setref\csname r@\thePFUtitle:#1\endcsname\@firstoftwo{\thePFUtitle:#1}}
\def\pageref#1{\expandafter\@setref\csname r@\thePFUtitle:#1\endcsname
  \@secondoftwo{\thePFUtitle:#1}}
%
\def\glabel#1{\@bsphack
  \protected@write\@auxout{}%
         {\string\newlabel{#1}{{\@currentlabel}{\thepage}}}%
  \@esphack}
\def\gref#1{\expandafter\@setref\csname r@#1\endcsname\@firstoftwo{#1}}
\def\gpageref#1{\expandafter\@setref\csname r@#1\endcsname
  \@secondoftwo{#1}}

%%
%% Babel
%%
% \InputIfFileExists{pfuproc/pfuproc_theorem.cli}{}{}%
\InputIfFileExists{pfuproc/theorem.cli}{}{}%
% \InputIfFileExists{pfuproc/mathmisc.cli}{}{}%

%\def\etal{et al.}
%\def\PFUudcName{UDC}

\def\keywordsname{Key words and phrases}
%\AtEndPreamble{%
\AtBeginDocument{%
%\AtEndOfClass{%
%  \providecommand{\etal}{et al.}
%  \providecommand{\PFUudcName}{UDC}
  \@ifpackageloaded{polyglossia}{%
    \addto\captionsrussian@modern{%
      \def\PFUudcName{УДК}
      \def\PFUpacsName{PACS}
      % Статья поступила в редакцию
      \def\PFUreceivedName{{\CYRS}{\cyrt}{\cyra}{\cyrt}{\cyrsftsn}{\cyrya} {\cyrp}{\cyro}{\cyrs}{\cyrt}{\cyru}{\cyrp}{\cyri}{\cyrl}{\cyra} {\cyrv} {\cyrr}{\cyre}{\cyrd}{\cyra}{\cyrk}{\cyrc}{\cyri}{\cyryu}}%
      \def\PFUrevisedName{revised}%
      \def\PFUacceptedName{accepted}%
      \def\PFUpublishedName{published}%
      \def\etal{и др.}
      % Ключевые слова
      \def\keywordsname{Ключевые слова}
      \def\acknowledgmentsname{Благодарности}
    }
    \addto\captionsenglish{%
    \def\PFUudcName{UDC}
    \def\PFUpacsName{PACS}
    \def\PFUreceivedName{received}%
    \def\PFUrevisedName{revised}%
    \def\PFUacceptedName{accepted}%
    \def\PFUpublishedName{published}%
     \def\etal{et al.}
%%    \renewcommand{\etal}{et al.}
%%     \providecommand{\etal}{et al.}
    \def\keywordsname{Key words and phrases}
    \def\acknowledgmentsname{Acknowledgments}
    }
  }{%
    \addto\extrasrussian{%
      \def\PFUudcName{\CYRU\CYRD\CYRK}
      \def\PFUpacsName{PACS}
      % Статья поступила в редакцию
      \def\PFUreceivedName{{\CYRS}{\cyrt}{\cyra}{\cyrt}{\cyrsftsn}{\cyrya} {\cyrp}{\cyro}{\cyrs}{\cyrt}{\cyru}{\cyrp}{\cyri}{\cyrl}{\cyra} {\cyrv} {\cyrr}{\cyre}{\cyrd}{\cyra}{\cyrk}{\cyrc}{\cyri}{\cyryu}}%
      \def\PFUrevisedName{revised }%
      \def\PFUacceptedName{accepted }%
      \def\PFUpublishedName{published }%
      \def\etal{\cyri{} \cyrd\cyrr.}
      % Ключевые слова
      \def\keywordsname{{\CYRK}{\cyrl}{\cyryu}{\cyrch}{\cyre}{\cyrv}{\cyrery}{\cyre}
        {\cyrs}{\cyrl}{\cyro}{\cyrv}{\cyra}}
      \def\acknowledgmentsname{\CYRB\cyrl\cyra\cyrg\cyro\cyrd\cyra\cyrr\cyrn\cyro\cyrs\cyrt\cyri}
    }
  }
  \addto\extrasenglish%
  {
    \def\PFUudcName{UDC}
    \def\PFUpacsName{PACS}
    \def\PFUreceivedName{received }%
    \def\PFUrevisedname{Revised }%
    \def\PFUacceptedname{Accepted }%
    \def\PFUpublishedname{Published }%
     \def\etal{et al.}
%%    \renewcommand{\etal}{et al.}
%%     \providecommand{\etal}{et al.}
    \def\keywordsname{Key words and phrases}
    \def\acknowledgmentsname{Acknowledgments}
  }
}

\AtBeginDocument%
{%
  \@ifpackageloaded{polyglossia}{%
    \addto\captionsrussian{%
      \def\prefacename{%
        {\cyr\CYRP\cyrr\cyre\cyrd\cyri\cyrs\cyrl\cyro\cyrv\cyri\cyre}}%
      % \def\refname{%
      % {\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk
      % \ \cyrl\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyrery}}%
      \def\abstractname{%
        {\cyr\CYRA\cyrn\cyrn\cyro\cyrt\cyra\cyrc\cyri\cyrya}}%
      \def\refname{%
        {\cyr\CYRL\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyra}}%
      \def\bibname{%
        {\cyr\CYRL\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyra}}%
      \def\chaptername{{\cyr\CYRG\cyrl\cyra\cyrv\cyra}}%
      \def\appendixname{%
        {\cyr\CYRP\cyrr\cyri\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyre}}%
      \@ifundefined{thechapter}%
      {\def\contentsname{%
          {\cyr\CYRS\cyro\cyrd\cyre\cyrr\cyrzh\cyra\cyrn\cyri\cyre}}}%
      {\def\contentsname{%
          {\cyr\CYRO\cyrg\cyrl\cyra\cyrv\cyrl\cyre\cyrn\cyri\cyre}}}%
      \def\listfigurename{%
        {\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk
          \ \cyri\cyrl\cyrl\cyryu\cyrs\cyrt\cyrr\cyra\cyrc\cyri\cyrishrt}}%
      \def\listtablename{%
        {\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk
          \ \cyrt\cyra\cyrb\cyrl\cyri\cyrc}}%
      \def\indexname{%
        {\cyr\CYRP\cyrr\cyre\cyrd\cyrm\cyre\cyrt\cyrn\cyrery\cyrishrt
          \ \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn}}%
      \def\authorname{%
        {\cyr\CYRI\cyrm\cyre\cyrn\cyrn\cyro\cyrishrt
          \ \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn}}%
      \def\figurename{Рис.}%
      \def\tablename{Таблица}%
      \def\partname{{\cyr\CYRCH\cyra\cyrs\cyrt\cyrsftsn}}%
      \def\enclname{{\cyr\cyrv\cyrk\cyrl.}}%
      \def\ccname{{\cyr\cyri\cyrs\cyrh.}}%
      \def\headtoname{{\cyr\cyrv\cyrh.}}%
      \def\pagename{{\cyr\cyrs.}}%
      \def\seename{{\cyr\cyrs\cyrm.}}%
      \def\alsoname{{\cyr\cyrs\cyrm.\ \cyrt\cyra\cyrk\cyrzh\cyre}}%
      \def\proofname{{\cyr\CYRD\cyro\cyrk\cyra\cyrz\cyra\cyrt
          \cyre\cyrl\cyrsftsn\cyrs\cyrt\cyrv\cyro}}%
      \def\glossaryname{Glossary}% <-- Needs translation
    }
  }{%
    \addto\captionsrussian{%
      \def\prefacename{%
        {\cyr\CYRP\cyrr\cyre\cyrd\cyri\cyrs\cyrl\cyro\cyrv\cyri\cyre}}%
      % \def\refname{%
      % {\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk
      % \ \cyrl\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyrery}}%
      \def\abstractname{%
        {\cyr\CYRA\cyrn\cyrn\cyro\cyrt\cyra\cyrc\cyri\cyrya}}%
      \def\refname{%
        {\cyr\CYRL\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyra}}%
      \def\bibname{%
        {\cyr\CYRL\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyra}}%
      \def\chaptername{{\cyr\CYRG\cyrl\cyra\cyrv\cyra}}%
      \def\appendixname{%
        {\cyr\CYRP\cyrr\cyri\cyrl\cyro\cyrzh\cyre\cyrn\cyri\cyre}}%
      \@ifundefined{thechapter}%
      {\def\contentsname{%
          {\cyr\CYRS\cyro\cyrd\cyre\cyrr\cyrzh\cyra\cyrn\cyri\cyre}}}%
      {\def\contentsname{%
          {\cyr\CYRO\cyrg\cyrl\cyra\cyrv\cyrl\cyre\cyrn\cyri\cyre}}}%
      \def\listfigurename{%
        {\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk
          \ \cyri\cyrl\cyrl\cyryu\cyrs\cyrt\cyrr\cyra\cyrc\cyri\cyrishrt}}%
      \def\listtablename{%
        {\cyr\CYRS\cyrp\cyri\cyrs\cyro\cyrk
          \ \cyrt\cyra\cyrb\cyrl\cyri\cyrc}}%
      \def\indexname{%
        {\cyr\CYRP\cyrr\cyre\cyrd\cyrm\cyre\cyrt\cyrn\cyrery\cyrishrt
          \ \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn}}%
      \def\authorname{%
        {\cyr\CYRI\cyrm\cyre\cyrn\cyrn\cyro\cyrishrt
          \ \cyru\cyrk\cyra\cyrz\cyra\cyrt\cyre\cyrl\cyrsftsn}}%
      \def\figurename{{\cyr\CYRR\cyri\cyrs.}}%
      \def\tablename{{\cyr\CYRT\cyra\cyrb\cyrl\cyri\cyrc\cyra}}%
      \def\partname{{\cyr\CYRCH\cyra\cyrs\cyrt\cyrsftsn}}%
      \def\enclname{{\cyr\cyrv\cyrk\cyrl.}}%
      \def\ccname{{\cyr\cyri\cyrs\cyrh.}}%
      \def\headtoname{{\cyr\cyrv\cyrh.}}%
      \def\pagename{{\cyr\cyrs.}}%
      \def\seename{{\cyr\cyrs\cyrm.}}%
      \def\alsoname{{\cyr\cyrs\cyrm.\ \cyrt\cyra\cyrk\cyrzh\cyre}}%
      \def\proofname{{\cyr\CYRD\cyro\cyrk\cyra\cyrz\cyra\cyrt
          \cyre\cyrl\cyrsftsn\cyrs\cyrt\cyrv\cyro}}%
      \def\glossaryname{Glossary}% <-- Needs translation
    }
  }
}
%%
\RequirePackage{fancyhdr}%

%% \DeclareRobustCommand{\journal}[1]%
%% {%
%%   \providecommand{\PFUjournal}[1]{#1}
%% }

%% \DeclareRobustCommand{\journalnumber}[1]%
%% {%
%%   \providecommand{\PFUjournalnumber}[1]{#1}
%% }

%% \DeclareRobustCommand{\journalissue}[1]%
%% {%
%%   \providecommand{\PFUjournalissue}[1]{#1}
%% }

%% \DeclareRobustCommand{\journalyear}[1]%
%% {%
%%   \providecommand{\PFUjournalyear}[1]{#1}
%% }

%% \DeclareRobustCommand{\journalseries}[1]%
%% {%
%%   \providecommand{\PFUjournalseries}[1]{#1}
%% }

%% \def\PFUjornalissueName{{\cyr\CYRV\cyrery\cyrp\cyru\cyrs\cyrk}} % ЊІЊлЊЯЊгЊбЊЪ
%% \def\PFUjornalseriesName{{\cyr\CYRS\cyre\cyrr\cyri\cyrya}} % ЊБЊХЊаЊШЊп

%% \providecommand{\PFUheader}%
%% {%
%%   \scshape \PFUjournal,
%%   \PFUjornalseriesName~\textit{\PFUjournalseries}. \PFUjournalyear,
%%   \No~\PFUjournalnumber, \PFUjornalissueName~\PFUjournalissue,
%%   \cyrs.~\pageref{starttitle}--\pageref{endtitle}
%% }

% One or two languages
\provideboolean{singlelanguage}
% Two languages by default
\setboolean{singlelanguage}{false}

% First name before Last name (English)
\provideboolean{isNameFam}
% Last name first by default
\setboolean{isNameFam}{false}

\RequirePackage{xstring}
\AtBeginDocument{%
  \ifx\@defaultlanguage\@empty
    \defaultlanguage{\bbl@main@language}
  \else
  \fi
  \IfStrEq{\@defaultlanguage}{russian}{%
    \defaultaltlanguage{english}
  }{%
    \defaultaltlanguage{russian}
  }
}

%{{{ Set headers

% % \AtEndPreamble{%
% \AtEndOfPackage{%
%   \pagestyle{fancy} 
%   \fancyhead{}%
%   \fancyhead[LE,RO]{\headerFontSize\thepage}%
%   \fancyhead[RE]{\leftmark}%
%   \fancyhead[LO]{%
%     \iflanguage{\@defaultlanguage}%
%     {%
% %%      \headerFontSize\PFUheader
%      \rightmark
%     }
%     {%
%       \begin{otherlanguage*}{\@defaultlanguage}
% %%        \headerFontSize\PFUheader
%      \rightmark
%       \end{otherlanguage*}
%     }
% }
% \fancyfoot{}

% \fancypagestyle{plain}{%
% \fancyhf{} % clear all header and footer fields
% \fancyhead[C]{%
% \headerFontSize\PFUTitleHeader
% }
% %\renewcommand{\headrulewidth}{0pt}
% %\renewcommand{\footrulewidth}{0pt}
% }

% }

%}}}

%%
%\if@compatibility
%  \def\@tempa#1{\let\mathfrak\relax
%     \RequirePackage{amstex}\relax}\expandafter\@tempa
%\else
%  \expandafter\@iden
%\fi
% {% if native mode
% \@ifclasswith{\@classname}{nomath}{%
%   \def\numberwithin#1#2{\@ifundefined{c@#1}{\@nocounterr{#1}}{%
%     \@ifundefined{c@#2}{\@nocounterr{#2}}{%
%     \@addtoreset{#1}{#2}%
%     \toks@\@xp\@xp\@xp{\csname the#1\endcsname}%
%     \@xp\xdef\csname the#1\endcsname
%       {\@xp\@nx\csname the#2\endcsname
%        .\the\toks@}}}}%
% }{%
%   \RequirePackage{amsmath}\relax
% }
% \@ifclasswith{\@classname}{noamsfonts}{%
% }{%
%   \let\mathfrak\relax
%   \IfFileExists{Umsa.fd}{%
%     \RequirePackage{amsfonts}\relax
%   }{%
%     \ClassError{\@classname
%     }{%
%       Font description files Umsa.fd et al. not found; amsfonts.sty
%       not loaded.
%     }{%
%       A font description (.fd) file is needed for every font being used;
%       these files may be in the inputs area along with other style and
%       class files, or in a dedicated subdirectory if your system uses
%       a TDS structure.
%     }%
%   }%
% }
% }% end native mode branch
\newcommand{\uppercasenonmath}[1]{\toks@\@emptytoks
  \@xp\@skipmath\@xp\@empty#1$$%
  \edef#1{\@nx\@upprep\the\toks@}%
}
\newcommand{\@upprep}{%
  \spaceskip1.3\fontdimen2\font plus1.3\fontdimen3\font
  \upchars@}
\newcommand{\upchars@}{%
  \def\ss{SS}\def\i{I}\def\j{J}\def\ae{\AE}\def\oe{\OE}%
  \def\o{\O}\def\aa{\AA}\def\l{\L}\def\Mc{M{\scshape c}}}
\newcommand{\@skipmath}{}
\long\def\@skipmath#1$#2${%
  \@xskipmath#1\(\)%
  \@ifnotempty{#2}{\toks@\@xp{\the\toks@$#2$}\@skipmath\@empty}}%
\newcommand{\@xskipmath}{}
\long\def\@xskipmath#1\(#2\){%
  \uppercase{\toks@\@xp\@xp\@xp{\@xp\the\@xp\toks@#1}}%
  \@ifnotempty{#2}{\toks@\@xp{\the\toks@\(#2\)}\@xskipmath\@empty}}%
%
%%%--
% \def\journal#1{\gdef\@journal{#1}}
%%%

\let\@rauthor\@empty
\let\authorsrunning\@empty
\let\altauthorsrunning\@empty
\let\authorstoc\@empty
\let\altauthorstoc\@empty
\let\authors\@empty
\let\altauthors\@empty
\let\thankses\@empty
\let\addresses\@empty%
\let\altaddresses\@empty%
\let\shorttitle\@empty%
\let\shortalttitle\@empty%

\AtBeginDocument{%
  \iflanguage{english}%
  {%
    \gdef\PFUlanguage{english}
    \gdef\PFUaltlanguage{russian}
  }%
  {%
    \gdef\PFUlanguage{russian}
    \gdef\PFUaltlanguage{english}
  }
}

\renewcommand*{\title}[2][]%
{%
%%  \def\@biblabel##1{\@ifempty{##1}##1.......}
  \@title@hook@pre
  \@title@hook
  \refstepcounter{PFUtitle}
  % \message{*********** \thePFUtitle}
  \refstepcounter{subtitle}
  % \thispagestyle{plain}
  \let\@rauthor\@empty
  \let\authorsrunning\@empty
  \let\altauthorsrunning\@empty
  \let\authorstoc\@empty
  \let\altauthorstoc\@empty
  \let\authors\@empty
  \let\altauthors\@empty
  \let\thankses\@empty
  \let\addresses\@empty%
  \let\altaddresses\@empty%
  \let\@title\empty
  \let\@alttitle\empty
%%   \label{starttitle}
  \ifx\@doiPrefix\@empty
  \else
    \doi{\@doiPrefix{}/\@doiSuffixBase{}-\pageref{starttitle}-\pageref{endtitle}}
  \fi
  \iflanguage{english}%
  {%
    \edef\PFUlanguage{english}
    \edef\PFUaltlanguage{russian}
  }%
  {%
    \edef\PFUlanguage{russian}
    \edef\PFUaltlanguage{english}
  }
  \if@filesw
    \makeatletter
    \@input{\PFU@auxname.aux}%
    \immediate\openout\PFU@aux\PFU@auxname.aux\relax
  \fi
  \gdef\shorttitle{#1}\gdef\@title{#2}
  \@title@hook@post
} % END \title

\def\@title@hook@pre{\global\let\@title@hook@pre\@empty}
% \def\@title@hook{\global\let\@title@hook\@empty}
\def\@title@hook{}
\g@addto@macro\@title@hook{}
% \def\@title@hook@post{\global\let\@title@hook@post\@empty}
\def\@title@hook@post{}
\g@addto@macro\@title@hook@post{}

\providecommand*{\subtitle}[2][]%
{%
  \refstepcounter{subtitle}
  \let\@rauthor\@empty
  \let\authorsrunning\@empty
  \let\altauthorsrunning\@empty
  \let\authorstoc\@empty
  \let\altauthorstoc\@empty
  \let\authors\@empty
  \let\altauthors\@empty
  \let\thankses\@empty
  \let\addresses\@empty%
  \let\altaddresses\@empty%
  \iflanguage{english}%
  {%
    \edef\PFUlanguage{english}
    \edef\PFUaltlanguage{russian}
  }%
  {%
    \edef\PFUlanguage{russian}
    \edef\PFUaltlanguage{english}
  }
  \if@filesw
    \makeatletter
    \@input{\PFU@auxname.aux}%
    \immediate\openout\PFU@aux\PFU@auxname.aux\relax
  \fi
  \gdef\shortsubtitle{#1}\gdef\@subtitle{#2}
} % END \subtitle


% \edef\title{\@nx\@dblarg
%   \@xp\@nx\csname\string\title\endcsname}
\newcommand*{\appendixtitle}[2][]{\stepcounter{PFUtitle}
  \label{starttitle}
  \gdef\shortappendixtitle{#1}\gdef\@appendixtitle{#2}}
\newcommand*{\altappendixtitle}[2][]{\stepcounter{PFUtitle}
  \label{starttitle}
  \gdef\shortaltappendixtitle{#1}\gdef\@altappendixtitle{#2}}
%%%
\newcommand*{\alttitle}[2][]%
{
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
    \gdef\shortalttitle{#1}\gdef\@alttitle{#2}
  \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
}
\let\@alttitle\@empty

% \edef\alttitle{\@nx\@dblarg
%   \@xp\@nx\csname\string\alttitle\endcsname}
%%%
%%%--

\RequirePackage{xparse}
\ExplSyntaxOn

\NewDocumentCommand{\refList}{ m }
 {
   % \clist_map_inline:nn { #1 } { \ref{##1} }
   \seq_set_from_clist:Nn \l_tmpa_seq { #1 }
   \seq_set_map:NNn \l_tmpb_seq \l_tmpa_seq { \exp_not:n { \ref { ##1 } } }
   \seq_use:Nn \l_tmpb_seq { ,~ }   
 }

\ExplSyntaxOff

\def\author{\@ifnextchar[{\author@optarg}{\author@optarg[]}}
\def\author@optarg[#1]#2{\stepcounter{PFUauthor}%
  \beg@elem
  \@for\@tempa:=#1\do{\expandafter\add@thanksref\expandafter{\@tempa}}%
  \report@elt{author}\proc@elem{author}{#2}%
%  \ifnum0\n@collab@=\z@ \runningauthor@fmt \fi
  \def\cauthor{\value{author}}
  \ifnum\c@PFUauthor=\@ne \edef\@rauthor{#2} \fi
%  \author@fmt{\the\c@PFUauthor}{\the\t@loc@notes}{\@author}%
%    \author@fmt{\the\c@PFUauthor}{\the\t@loc@notes}{#2}%
% %  \edef\temp@notes\t@loc@notes
%   \toks@\@xp{\t@loc@notes}
% %  \edef\ftoks{\the\toks@}
% %    \let\@tempc\string{\the\t@loc@notes}
%     \@temptokena\@xp{\t@loc@notes}
%     \edef\@tempc{\the\@temptokena}
  \edef\refListAndify{\refList{#1}}
  \andify\refListAndify
  % \author@fmt{\the\c@PFUauthor}{\refList{#1}}{#2}{}%
  \author@fmt{\the\c@PFUauthor}{\refListAndify}{#2}{}%
%     \author@fmt{\the\c@PFUauthor}{#1}{#2}{}%
     \@author@hook@post
}

\def\@author@hook@post{\global\let\@author@hook@post\@empty}

\def\altauthor{\@ifnextchar[{\altauthor@optarg}{\altauthor@optarg[]}}
\def\altauthor@optarg[#1]#2{\stepcounter{altauthor}%
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
  % \begin{otherlanguage*}{\PFUaltlanguage}
    \beg@elem
    \@for\@tempa:=#1\do{\expandafter\add@thanksref\expandafter{\@tempa}}%
    \report@elt{altauthor}\proc@elem{altauthor}{#2}%
    % \ifnum0\n@collab@=\z@ \runningauthor@fmt \fi
    \def\caltauthor{\value{altauthor}}
    \ifnum\c@altauthor=\@ne \edef\@raltauthor{#2} \fi
%  \author@fmt{\the\c@PFUauthor}{\the\t@loc@notes}{\@author}%
%  \author@fmt{\the\c@PFUauthor}{\the\t@loc@notes}{#2}%
% %  \edef\temp@notes\t@loc@notes
%  \toks@\@xp{\t@loc@notes}
% %  \edef\ftoks{\the\toks@}
% %  \let\@tempc\string{\the\t@loc@notes}
%  \@temptokena\@xp{\t@loc@notes}
%  \edef\@tempc{\the\@temptokena}
    \altauthor@fmt{\the\c@altauthor}{\refList{#1}}{#2}{}%
  % \end{otherlanguage*}
  \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
  \@altauthor@hook@post
}

\def\@altauthor@hook@post{\global\let\@altauthor@hook@post\@empty}

\def\fauthor{\@ifnextchar[{\fauthor@optarg}{\fauthor@optarg[]}}
\def\fauthor@optarg[#1]#2{%
  \stepcounter{PFUauthor}%
  \beg@elem
  \@for\@tempa:=#1\do{\expandafter\add@thanksref\expandafter{\@tempa}}%
  \report@elt{author}\proc@elem{author}{#2}%
  \def\cauthor{\value{author}}
  \ifnum\c@PFUauthor=\@ne \edef\@rauthor{#2} \fi
  \author@fmt{\the\c@PFUauthor}{#1}{#2}{fbox}%
}

\def\altfauthor{\@ifnextchar[{\altfauthor@optarg}{\altfauthor@optarg[]}}
\def\altfauthor@optarg[#1]#2{%
  \stepcounter{altauthor}%
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
  \beg@elem
  \@for\@tempa:=#1\do{\expandafter\add@thanksref\expandafter{\@tempa}}%
  \report@elt{altauthor}\proc@elem{altauthor}{#2}%
  \def\caltauthor{\value{altauthor}}
  \ifnum\c@altauthor=\@ne \edef\@raltauthor{#2} \fi
  \altauthor@fmt{\the\c@altauthor}{#1}{#2}{fbox}%
  \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
}

%%%--
% \def\inicials#1{{\getinicials#1\end}}
% \gdef\mytest{}
% \def\getinicials#1{\def\mychar\next \ifx\mychar\space%
%   \else\g@addto@macro\mytest{\mychar}}
% \def\parseauthor#1\ #2\nil{%
% \def\authorinitials{#1}%
% \def\authorfamily{#2}
% }
% \newcommand{\parseauthor}[1]%
% {%
%   \def\authorfamily{\BehindSubString{ }{#1}}
%   \def\authorinitials{\BeforeSubString{ }{#1}}
% %   \def\authorinitials{ }
% }
%%

% \RequirePackage{stringstrings}

% \extract macro
% USE:
% \def\foo{bar}
% \extract{\foo}{1}
% prints: b
\ExplSyntaxOn
\cs_generate_variant:Nn \tl_item:nn { f }
\DeclareExpandableDocumentCommand \extract { m m }
{
  \tl_item:fn { #1 } { #2 }
}
\ExplSyntaxOff

\long\def\parseauthor#1 #2 #3\nil%
{%
  \edef\@tempc{#3}
  \ifx\@tempc\@empty
    \edef\authorinitials{#1}
    \edef\authorinitialsplain{#1}
    \edef\authorinitialsshort{\extract{#1}{1}.}
    \edef\authorinitialsshortplain{\extract{#1}{1}.}
    \edef\authorfamily{#2}
  \else
    \def\authorinitials{#1\leavevmode\nobreak\thinspace#2}
    \edef\authorinitialsplain{#1 #2}
    \edef\authorinitialsshort{\extract{#1}{1}.\leavevmode\nobreak\thinspace\extract{#2}{1}.}
    \edef\authorinitialsshortplain{\extract{#1}{1}. \extract{#2}{1}.}
    \def\authorfamily{#3}
  \fi
}

% \def\parseauthor#1 #2\par{%
%     \def\authorinitials{#1}
%     \def\authorfamily{#2}
% }
\def\PFUNumRunningauthor{3}
%%%
\def\runningauthor@fmt{%
  \begingroup\no@harm
    \if@firstauthor
      \ifnum0\n@author@ > \PFUNumRunningauthor
        \global\edef\@runningauthor{\@author\ et al.}%
      \else
        \global\let\@runningauthor\@author%
      \fi
    \else % \c@PFUauthor > 1
      \ifnum0\n@author@ = \PFUNumRunningauthor
        \global\edef\@runningauthor{\@runningauthor\ \& \noexpand\@author}%
      \fi
    \fi
  \endgroup
}

\RequirePackage{xspace}

\def\author@fmt#1#2#3#4%
{%
  %% #1 Maximum number of authors in header
  %% #2 Reference to address
  %% #3 Author
  %% #4 Additional format
  %% \author[#2]{#3}

  \@newelemtrue
  \if@firstauthor
    \first@author \global\@firstauthorfalse \fi
  \ifnum\prev@elem=\e@author \global\@newelemfalse \fi
  % \if@newelem \author@fmt@init \fi
  %%%
  % \getinicials{#3}
  % \tracingmacros=1

  \parseauthor#3 \nil
  % \parseauthor{#3}
  % \tracingmacros=0
  % \toks@\@xp{\authorfamily}
  % \edef\atoks{\the\toks@}
  % \renewcommand{\leftmark}{\atoks}
  % \toks0={\authorfamily}
  % \def\atoks{\the\toks0}

  \protected@edef\@tempd{#4}
  \ifx\@tempd\@empty
    \protected@edef\authorFamIn{\authorfamily\,\authorinitials}
    \protected@edef\authorFamInShort{\authorfamily\,\authorinitialsshort}
    \protected@edef\authorInFamShort{\authorinitialsshort\,\authorfamily}
    \protected@edef\authorInFam{\authorinitials\,\authorfamily}
    \protected@xdef\authorFamily{\authorfamily\xspace}
    \protected@xdef\authorInitials{\authorinitials\xspace}
    \protected@xdef\authorInitialsPlain{\authorinitialsplain\xspace}
  \else
    \protected@edef\authorFamIn{\protect\csname\@tempd \endcsname{\authorfamily\,\authorinitials}}
    \protected@edef\authorInFam{\protect\csname\@tempd \endcsname{\authorinitials\,\authorfamily}}
    \protected@edef\authorFamInShort{\protect\csname\@tempd \endcsname{\authorfamily\,\authorinitialsshort}}
    \protected@edef\authorInFamShort{\protect\csname\@tempd \endcsname{\authorinitialsshort\,\authorfamily}}
  \fi

  \ifx\authors\@empty
    \ifbool{isNameFam}{% firstname lastname
      \protected@xdef\authorstoc{\authorInFam}%
      \protected@xdef\authorstocshort{\authorInFamShort}%
      \protected@xdef\authorsrunning{\authorInFamShort}%
      \protected@xdef\authorstocRev{\authorFamIn}%
      \protected@xdef\authorstocshortRev{\authorFamInShort}%
    }{% lastname firstname
      % \gdef\authorstoc{#3}%
      \protected@xdef\authorstoc{\authorFamIn}%
      \protected@xdef\authorstocshort{\authorFamInShort}%
      % \xdef\authorstoc{\authorfamily~\authorinitials}%
      % \gdef\authorsrunning{#3}%
      % \xdef\authorsrunning{\mbox{\authorfamily~\authorinitials}}%
      \protected@xdef\authorsrunning{\authorFamInShort}%
      % \gdef\authorstoc{\authorfamily\ \authorinitials}%
      % \gdef\authorstoc{\atoks\ \authorinitials}%
    }
    \protected@edef\@tempb{#2}
    \ifx\@tempb\@empty
      % \xdef\authors{\authorinitials~\authorfamily}%
      % \protected@xdef\authors{\authorInFam}%
      \ifx\@tempd\@empty
        \g@addto@macro\authors{\protect\mbox{#3}}%
      \else
        \g@addto@macro\authors{\protect\csname\@tempd \endcsname{#3}}%
      \fi
    \else
      % \gdef\authors{#3\,$^{\mathrm{\ref{#2}}}$}%
      % \xdef\authors{\authorinitials~\authorfamily\,$^{\noexpand\mathrm{\noexpand\ref{\noexpand#2}}}$}%
      % \xdef\authorTmp{\authorinitials~\authorfamily}
      % \protected@xdef\authorTmp{\authorInFam}
      % \gdef\authors{\expandafter{\authorTmp}\negthickspace${}^{\mathrm{\ref{#2}}}$}%
      % \protected@xdef\authors{\authorInFam\,$^{\noexpand\mathrm{\noexpand\ref{\noexpand#2}}}$}%
      \ifx\@tempd\@empty
        % \g@addto@macro\authors{\protect\mbox{#3}$^{\mathrm{\ref{#2}}}$}%
        \g@addto@macro\authors{\protect\mbox{#3}$^{\mathrm{{#2}}}$}%
      \else
        % \g@addto@macro\authors{\protect\fbox{#3}$^{\mathrm{\ref{#2}}}$}%
        \g@addto@macro\authors{\protect\csname\@tempd \endcsname{#3}$^{\mathrm{{#2}}}$}%
      \fi
    \fi
  \else
    % \g@addto@macro\authorstoc{\and #3}%
    % \xdef\authorstoc{\authorstoc \and \authorfamily~\authorinitials}%
    % \g@addto@macro\authorstoc{\and \authorFamIn}%
    \ifbool{isNameFam}{% firstname lastname
      \protected@xdef\authorstoc{\authorstoc \and \authorInFam}%
      \protected@xdef\authorstocshort{\authorstocshort \and \authorInFamShort}%
      \protected@xdef\authorstocRev{\authorstocRev \and \authorFamIn}%
      \protected@xdef\authorstocshortRev{\authorstocshortRev \and \authorFamInShort}%
    }{% lastname firstname
      \protected@xdef\authorstoc{\authorstoc \and \authorFamIn}%
      \protected@xdef\authorstocshort{\authorstocshort \and \authorFamInShort}%
    }
    % \show\n@author@
    \ifnum0\n@author@ > \PFUNumRunningauthor
      \ifnum0#1 = \PFUNumRunningauthor % 3
        %% FIXME removing \etal (20031214)
        \g@addto@macro\authorsrunning{ \etal}%
      \fi
    \else
      % \g@addto@macro\authorsrunning{\and #3}%
      % \g@addto@macro\authorsrunning{\and  \authorfamily~\authorinitials}%
      % \xdef\authorsrunning{\authorsrunning \and
      % \authorfamily~\authorinitials}
      \ifbool{isNameFam}{% firstname lastname
        \protected@xdef\authorsrunning{\authorsrunning \and \authorInFamShort}
      }{% lastname firstname
        \protected@xdef\authorsrunning{\authorsrunning \and \authorFamInShort}
      }
    \fi
    % \g@addto@macro\authorstoc{\and \authorfamily\ \authorinitials}%
    \protected@edef\@tempb{#2}
    \ifx\@tempb\@empty
      % \xdef\authors{\authors \and \authorinitials~\authorfamily}%
      % \protected@xdef\authors{\authors \and \authorInFam}%
      \ifx\@tempd\@empty
        \g@addto@macro\authors{\and \protect\mbox{#3}}%
      \else
        \g@addto@macro\authors{\and \protect\csname\@tempd \endcsname{#3}}%
      \fi
    \else
      % \xdef\authors{\authors \and \authorinitials~\authorfamily\,%
      % $^{\noexpand\mathrm{\noexpand\ref{\noexpand#2}}}$}%
      % \edef\authorTmp{\authorinitials~\authorfamily}
      \ifx\@tempd\@empty
        % \g@addto@macro\authors{\and \protect\mbox{#3}$^{\mathrm{\ref{#2}}}$}%
        \g@addto@macro\authors{\and \protect\mbox{#3}$^{\mathrm{{#2}}}$}%
      \else
        % \g@addto@macro\authors{\and \protect\fbox{#3}$^{\mathrm{\ref{#2}}}$}%
        \g@addto@macro\authors{\and \protect\csname\@tempd \endcsname{#3}$^{\mathrm{{#2}}}$}%
      \fi
      % \xdef\authorTmp{\authorinitials~\authorfamily}
      % \g@addto@macro\authors{\and \authorTmp\,$^{\mathrm{\ref{#2}}}$}%
    \fi
  \fi
  % \ifx\@empty\authors
  % \gdef\authors{\author@font%
  % \if@newelem \author@fmt@init \fi
  % \edef\@tempb{#2}%
  % \ifx\@tempb\@empty
  %   #3 \else
  %   #3\,$^{\mathrm{#2}}$%
  % \fi
  % }%
  %   \else
  %   \g@addto@macro\authors{\and
  %   \edef\@tempb{#2}
  %   \ifx\@tempb\@empty
  %   #3 \else
  %   #3\,$^{\mathrm{#2}}$%
  %   \fi
  % }
  %   \fi
  %   \edef\@tempb{#2}\ifx\@tempb\@empty
  %   \hbox{{\auhor@font #3}}\else
  %   \hbox{{\author@font #3}\,$^{\mathrm{#2}}$}%
  %   \else
  %   \g@addto@macro\authors{\and#3\,$^{\mathrm{#2}}$}
  %   \fi
} % END \author@fmt

\def\altauthor@fmt#1#2#3#4%
{%
  %% #1 Maximum number of authors in header
  %% #2 Reference to address
  %% #3 Author
  %% #4 Additional format
  %% \altauthor[#2]{#3}

  \if@firstauthor
    \first@author \global\@firstauthorfalse \fi
  \ifnum\prev@elem=\e@author \global\@newelemfalse \fi
  \parseauthor#3 \nil

  \edef\@tempd{#4}
  \ifx\@tempd\@empty
    \protected@xdef\altauthorFamIn{\authorfamily~\authorinitials}
    \protected@xdef\altauthorFamInShort{\authorfamily~\authorinitialsshort}
    \protected@xdef\altauthorInFam{\authorinitials~\authorfamily}
    \protected@xdef\altauthorFamily{\authorfamily\xspace}
    \protected@xdef\altauthorInitials{\authorinitials\xspace}
    \protected@xdef\altauthorInitialsPlain{\authorinitialsplain\xspace}
  \else
    \protected@xdef\altauthorFamIn{\protect\csname\@tempd \endcsname{\authorfamily\,\authorinitials}}
    \protected@xdef\altauthorInFam{\protect\csname\@tempd \endcsname{\authorinitials\,\authorfamily}}
  \fi

  \ifx\@empty\altauthors
    \protected@xdef\altauthorstoc{\altauthorFamIn}%
    \protected@xdef\altauthorstocshort{\altauthorFamInShort}%
    \protected@xdef\altauthorsrunning{\altauthorFamIn}%
    \edef\@tempb{#2}
    \ifx\@tempb\@empty
      \ifx\@tempd\@empty
        \protected@xdef\altauthors{\altauthorInFam}%
      \else
        \g@addto@macro\altauthors{\protect\csname\@tempd \endcsname{#3}}%
      \fi
    \else
      % \protected@xdef\altauthors{\altauthorInFam\,$^{\noexpand\mathrm{\noexpand\ref{\noexpand#2}}}$}%
      \ifx\@tempd\@empty
        % \g@addto@macro\altauthors{\protect\mbox{#3}$^{\mathrm{\ref{#2}}}$}%
        \g@addto@macro\altauthors{\protect\mbox{#3}$^{\mathrm{{#2}}}$}%
      \else
        % \g@addto@macro\altauthors{\protect\fbox{#3}$^{\mathrm{\ref{#2}}}$}%
        \g@addto@macro\altauthors{\protect\csname\@tempd \endcsname{#3}$^{\mathrm{{#2}}}$}%
      \fi
    \fi
  \else
    \protected@xdef\altauthorstoc{\altauthorstoc \altand \altauthorFamIn}%
    \protected@xdef\altauthorstocshort{\altauthorstocshort \altand \altauthorFamInShort}%
    \ifnum0\n@author@ > 3
      \ifnum0#1 = 2
        %% FIXME removing \etal (20031214)
        % \g@addto@macro\altauthorsrunning{ \etal}%
      \fi
    \else
      \protected@xdef\altauthorsrunning{\altauthorsrunning \altand  \altauthorFamIn}
    \fi
    \edef\@tempb{#2}
    \ifx\@tempb\@empty
      \ifx\@tempd\@empty
        \protected@xdef\altauthors{\altauthors \altand \altauthorInFam}%
      \else
        \g@addto@macro\altauthors{\altand \protect\fbox{#3}}%
      \fi
    \else
      \ifx\@tempd\@empty
        % \g@addto@macro\altauthors{\altand \protect\mbox{#3}$^{\mathrm{\ref{#2}}}$}%
        \g@addto@macro\altauthors{\altand \protect\mbox{#3}$^{\mathrm{{#2}}}$}%
      \else
        % \g@addto@macro\altauthors{\altand \protect\fbox{#3}$^{\mathrm{\ref{#2}}}$}%
        \g@addto@macro\altauthors{\altand \protect\fbox{#3}$^{\mathrm{{#2}}}$}%
      \fi
    \fi
  \fi
} %% enf of \altauthor@fmt

\let\altauthorstoc\@empty

\def\first@author{\author@note@fmt  % re-define \thefootnote as
                                    % appropriate for author/address
  \add@tok\t@glob@notes
    {\author@note@fmt\@corresp@note}}%
\def\author@fmt@init{%
  \par
  \vskip 8\p@ \@plus 4\p@ \@minus 2\p@
  \@authorsize
  \leavevmode}                        % Vertical space above author list
 \def\and{\unskip~and~}
\def\collab{\@ifstar{\collab@arg}{\collab@arg}}
\let\collaboration=\collab
\def\collab@arg#1{\stepcounter{collab}%
  \if@firstauthor \first@collab \global\@firstauthorfalse \fi
  \gdef\@runningauthor{#1}%
  \beg@elem
  \proc@elem{collab}{#1}%
  \collab@fmt{\the\c@collab}{\the\t@loc@notes}{\@collab}%
  \ignorespaces}
\def\collab@fmt#1#2#3{\@newelemtrue
  \ifnum\prev@elem=\e@collab \global\@newelemfalse \fi
  \if@newelem \collab@fmt@init \fi
  \par                                 % Start new paragraph
  {\large \protect\mbox{#3}$^{\mathrm{#2}}$}}
\def\first@collab{
  \collab@note@fmt                     % re-define \thefootnote as
  \add@tok\t@glob@notes                % appropriate for collab/address
    {\collab@note@fmt}}%
\def\collab@fmt@init{\vskip 1em}       % Vertical space above list
\def\author@note@fmt{\setcounter{footnote}{0}%
  \def\thefootnote{\xarabic{footnote}}}
\let\collab@note@fmt=\author@note@fmt
%%%--
\def\address{\@ifstar{\address@star}%
  {\@ifnextchar[{\address@optarg}{\address@noptarg}}}

\def\address@optarg[#1]#2{%
%%   \real@refstepcounter{address}%
%  \beg@elem
  \report@elt{address}\proc@elem{address}{#2}%
%  \address@fmt{\c@address}{\the\t@loc@notes}{\@address}{#1}%
%%   \if@tempswa\label{#1}\else\relax\fi
  \address@fmt{\c@address}{#1}{#2}{#1}%
%%   \label{#1}
%%   \label{qwerty}
%%   \if@Elproofing\else\label{#1}\fi
  \ignorespaces}
%% END % address@optarg

\def\address@noptarg#1{%
%%  \real@refstepcounter{address}%
%  \beg@elem
  \proc@elem{address}{#1}%
%  \address@fmt{\z@}{\the\t@loc@notes}{\@address}{\theaddress}%
  \address@fmt{\z@}{\the\t@loc@notes}{#1}{\theaddress}%
  \ignorespaces}
\def\address@star#1{%
  \beg@elem
  \proc@elem{address}{#1}%
  \address@fmt{\m@ne}{\the\t@loc@notes}{\@address}{*}%
  \ignorespaces}
% \def\theaddress{\fnsymbol{address}}
\def\address@fmt#1#2#3#4{\@newelemtrue
  \if@Elproofing\def\@eltag{#4}\else\def\@eltag{\theaddress}\fi
  \ifnum\prev@elem=\e@address \@newelemfalse \fi
  \g@addto@macro\addresses{
  \if@newelem \address@fmt@init \fi
  \noindent \bgroup \@addressstyle
  \edef\@tempb{#2}%
  \ifx\@tempb\@empty
    \ifnum#1=\z@
%    #3\,$^{\mathrm{#2}}$\space%
      #3\space%
    \else
      \ifnum#1=\m@ne
%      $^{\phantom{\mathrm{\@eltag}}}$\space #3\,$^{\mathrm{#2}}$%
     $^{\phantom{\mathrm{\@eltag}}}$\space #3%
       \else
%      $^{\mathrm{\@eltag}}\space$#3\,$^{\mathrm{#2}}$%
     $^{\mathrm{\@eltag}}\space$#3%
       \fi
     \fi
   \else
   \refstepcounter{address}%
   \label{#2}%
   \ifnum#1=\z@
%    #3\,$^{\mathrm{#2}}$\space%
    $^{\mathrm{\ref{#2}}}$#3\space%
  \else
    \ifnum#1=\m@ne
%      $^{\phantom{\mathrm{\@eltag}}}$\space #3\,$^{\mathrm{#2}}$%
     $^{\mathrm{\ref{#2}}}$\,$^{\phantom{\mathrm{\@eltag}}}$\space #3%
    \else
%      $^{\mathrm{\@eltag}}\space$#3\,$^{\mathrm{#2}}$%
     $^{\mathrm{\ref{#2}}}$\,#3%
    \fi
  \fi
\fi
  \par \egroup}%
} %
\def\address@fmt@init%
{%
  \par                                % Start new paragraph
   \vskip 6\p@ \@plus 3\p@ \@minus 1.5pt}
%%
\def\altaddress{\@ifstar{\altaddress@star}%
  {\@ifnextchar[{\altaddress@optarg}{\altaddress@noptarg}}}
\def\altaddress@optarg[#1]#2%
{
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
  \real@refstepcounter{altaddress}%
%  \beg@elem
  \report@elt{altaddress}\proc@elem{altaddress}{#2}%
%  \address@fmt{\c@address}{\the\t@loc@notes}{\@address}{#1}%
  \altaddress@fmt{\c@altaddress}{#1}{#2}{#1}%
  \if@Elproofing\else\label{#1}\fi
  \ignorespaces%
\ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
} %END \altaddress@optarg

\def\altaddress@noptarg#1%
{
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
 \real@refstepcounter{altaddress}%
%  \beg@elem
  \proc@elem{altaddress}{#1}%
%  \address@fmt{\z@}{\the\t@loc@notes}{\@address}{\theaddress}%
  \altaddress@fmt{\z@}{\the\t@loc@notes}{#1}{\thealtaddress}%
  \ignorespaces%
\ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
} %END \altaddress@noptarg

\def\altaddress@star#1%
{%
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
  \beg@elem
  \proc@elem{altaddress}{#1}%
  \altaddress@fmt{\m@ne}{\the\t@loc@notes}{\@altaddress}{*}%
  \ignorespaces%
\ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
} %END \altaddress@star

\def\thealtaddress{\fnsymbol{altaddress}}
\def\altaddress@fmt#1#2#3#4%
{\@newelemtrue
  \if@Elproofing\def\@eltag{#4}\else\def\@eltag{\thealtaddress}\fi
  \ifnum\prev@elem=\e@altaddress \@newelemfalse \fi
  \g@addto@macro\altaddresses{
  \if@newelem \altaddress@fmt@init \fi
  \noindent \bgroup \@altaddressstyle
  \edef\@tempb{#2}%
  \ifx\@tempb\@empty
  \ifnum#1=\z@
%    #3\,$^{\mathrm{#2}}$\space%
    #3\space%
  \else
    \ifnum#1=\m@ne
%      $^{\phantom{\mathrm{\@eltag}}}$\space #3\,$^{\mathrm{#2}}$%
     $^{\phantom{\mathrm{\@eltag}}}$\space #3%
    \else
%      $^{\mathrm{\@eltag}}\space$#3\,$^{\mathrm{#2}}$%
     $^{\mathrm{\@eltag}}\space$#3%
    \fi
  \fi
\else
   \refstepcounter{address}%
   \label{altaddress:#2}%
  \ifnum#1=\z@
%    #3\,$^{\mathrm{#2}}$\space%
    $^{\mathrm{\ref{#2}}}$#3\space%
  \else
    \ifnum#1=\m@ne
%      $^{\phantom{\mathrm{\@eltag}}}$\space #3\,$^{\mathrm{#2}}$%
     $^{\mathrm{\ref{#2}}}$\,$^{\phantom{\mathrm{\@eltag}}}$\space #3%
    \else
%      $^{\mathrm{\@eltag}}\space$#3\,$^{\mathrm{#2}}$%
     $^{\mathrm{\ref{#2}}}$\,#3%
    \fi
  \fi
\fi
  \par \egroup}%
} %END \altaddress@fmt
\def\altaddress@fmt@init{%
  \par                                % Start new paragraph
   \vskip 6\p@ \@plus 3\p@ \@minus 1.5pt}
%%%
% \renewcommand{\author}[2][]{%
%   \ifx\@empty\authors
%     \gdef\shortauthors{#1}\gdef\authors{#2}%
%   \else
%     \g@addto@macro\shortauthors{\and#1}%
%     \g@addto@macro\authors{\and#2}%
%     \g@addto@macro\addresses{\author{}}%
%   \fi
% }
% \edef\author{\@nx\@dblarg
%   \@xp\@nx\csname\string\author\endcsname}
%%%
% \newcommand{\altauthor}[2][]{%
%   \ifx\@empty\altauthors
%     \gdef\shortaltauthors{#1}\gdef\altauthors{#2}%
%   \else
%     \g@addto@macro\shortaltauthors{\altand#1}%
%     \g@addto@macro\altauthors{\altand#2}%
%     \g@addto@macro\altaddresses{\altauthor{}}%
%   \fi
% }
% \edef\altauthor{\@nx\@dblarg
%   \@xp\@nx\csname\string\altauthor\endcsname}
%\DeclareRobustCommand{\@biblabel}[1]{%
%  #1.%
%}
\DeclareRobustCommand{\udc}[1]{%
  \def\@udcnum{#1}}
\let\@udcnum\@empty
\DeclareRobustCommand{\pacs}[1]{%
  \def\@pacsnum{#1}}
\let\@pacsnum\@empty
%%

% \RequirePackage{datetime2}
\RequirePackage[nodayofweek,us]{datetime}

\DeclareRobustCommand{\received}[3]{%
  \def\@received@day{#1}
  \def\@received@month{#2}
  \def\@received@year{#3}
  % \def\@received{\DTMdate{#3-#2-#1}}
  \def\@received{\formatdate{#1}{#2}{#3}}

}
\let\@received\@empty
\let\@received@day\@empty
\let\@received@month\@empty
\let\@received@year\@empty

\DeclareRobustCommand{\revised}[3]{%
  \def\@revised@day{#1}
  \def\@revised@month{#2}
  \def\@revised@year{#3}
  % \def\@revised{\DTMdate{#3-#2-#1}}
  \def\@revised{\formatdate{#1}{#2}{#3}}
}
\let\@revised\@empty
\let\@revised@day\@empty
\let\@revised@month\@empty
\let\@revised@year\@empty

\DeclareRobustCommand{\accepted}[3]{%
  \def\@accepted@day{#1}
  \def\@accepted@month{#2}
  \def\@accepted@year{#3}
  % \def\@accepted{\DTMdate{#3-#2-#1}}
  \def\@accepted{\formatdate{#1}{#2}{#3}}
}
\let\@accepted\@empty
\let\@accepted@day\@empty
\let\@accepted@month\@empty
\let\@accepted@year\@empty

\DeclareRobustCommand{\published}[3]{%
  \def\@published@day{#1}
  \def\@published@month{#2}
  \def\@published@year{#3}
  % \def\@published{\DTMdate{#3-#2-#1}}
  \def\@published{\formatdate{#1}{#2}{#3}}
}
\let\@published\@empty
\let\@published@day\@empty
\let\@published@month\@empty
\let\@published@year\@empty

\DeclareRobustCommand{\email}[1]{%
  \def\@email{#1}}
\let\@email\@empty

% \def\udc#1{\gdef\@udcnum{#1}}
% \newcommand{\udc}[1]{\gdef\@udcnum{#1}}
%%%--
% \def\udc#1{\CYRU\CYRD\CYRK{} \def\@udc{#1} \hfill\par}
% \def\@udc{\CYRU\CYRD\CYRK{} \@udcnum \hfill\par}
% \newcommand{\journal}{\edef\@journalname{##1}}
% \def\journal#1{\gdef\@journal{#1}}
%%%
%%%
\let\shortauthors\@empty   \let\authors\@empty
\let\addresses\@empty      \let\thankses\@empty
%%%
\let\shortaltauthors\@empty   \let\altauthors\@empty
\let\altaddresses\@empty      \let\thankses\@empty
%%%
% \newcommand{\address}[2][]{\g@addto@macro\addresses{\address{#1}{#2}}}
\newcommand{\curraddr}[2][]{\g@addto@macro\addresses{\curraddr{#1}{#2}}}
%%%
% \newcommand{\altaddress}[2][]{\g@addto@macro\altaddresses{\altaddress{#1}{#2}}}
\newcommand{\altcurraddr}[2][]{\g@addto@macro\altaddresses{\altcurraddr{#1}{#2}}}
%%%
% \newcommand{\altabstracts}[2][]%
% {
%   \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
%     \gdef\shortabstract{#1}\gdef\@altabstracts{#2}
%   \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
% }
% \edef\altabstracts{\@nx\@dblarg
%   \@xp\@nx\csname\string\altabstracts\endcsname}
%%%
% \newcommand{\email}[2][]{\g@addto@macro\addresses{\email{#1}{#2}}}
\newcommand{\urladdr}[2][]{\g@addto@macro\addresses{\urladdr{#1}{#2}}}
\renewcommand{\thanks}[1]{\g@addto@macro\thankses{\thanks{#1}}}
\newcommand{\thanksref}[1]{\g@addto@macro\thankses{#1}}
%\def\enddoc@text{\ifx\@empty\@translators \else\@settranslators\fi
%  \ifx\@empty\addresses \else\@setaddresses\fi}
\def\enddoc@text{\ifx\@empty\@translators \else\@settranslators\fi
%  \ifx\@empty\altaddresses \else\@setaltaddresses\fi
%  \@alttitle
%  \altauthors
  }
\AtEndDocument{\enddoc@text}
%%%
%%%
\def\@setaddresses{\par
  \nobreak \begingroup
\small
%   \def\author##1{\nobreak\addvspace\bigskipamount}%
  \def\\{\unskip, \ignorespaces}%
  \interlinepenalty\@M
  \def\address##1##2{\begingroup
    \par\addvspace\bigskipamount\indent
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\scshape\ignorespaces##2}\par\endgroup}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape Current address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par\endgroup}}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape E-mail address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par\endgroup}}%
  \def\urladdr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape URL}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par\endgroup}}%
  \addresses
  \endgroup
}
%%%
\def\@setaltaddresses{\par
  \nobreak \begingroup
\footnotesize
%   \def\author##1{\nobreak\addvspace\bigskipamount}%
  \def\\{\unskip, \ignorespaces}%
  \interlinepenalty\@M
  \def\address##1##2{\begingroup
    \par\addvspace\bigskipamount\indent
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\scshape\ignorespaces##2}\par\endgroup}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape Current address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par\endgroup}}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape E-mail address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par\endgroup}}%
  \def\urladdr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape URL}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par\endgroup}}%
  \addresses
  \endgroup
}
%%%--
% \def\journal#1{\gdef\@journal{#1}}
% \def\udc#1{\gdef\@udcnum{#1}}
%%%
%%%
\let\@date\@empty
% \def\dedicatory#1{\def\@dedicatory{#1}}
\DeclareRobustCommand{\dedicatory}[1]{%
  \def\@dedicatory{#1}}
\let\@dedicatory=\@empty
\def\dedicatorywidth{0.5\linewidth}

\def\keywords#1{\def\@keywords{#1}}
\let\@keywords=\@empty
\def\altkeywords#1{\def\alt@keywords{#1}}
\let\alt@keywords=\@empty
\def\subjclass#1{\def\@subjclass{#1}}
\let\@subjclass=\@empty
\def\translator#1{%
  \ifx\@empty\@translators \def\@translators{#1}%
  \else\g@addto@macro\@translators{\and#1}\fi}
\let\@translators=\@empty
\def\@settranslators{\par\begingroup
  \addvspace{6\p@\@plus9\p@}%
  \hbox to\columnwidth{\hss\normalfont\normalsize
    Translated by %
    \andify\@translators \uppercasenonmath\@translators
    \@translators}
  \endgroup
}
%%
\newcommand{\xaltandlist}[4]{\@altandlista{{#1}{#2}{#3}}#4\altand\altand}
\def\@altandlista#1#2\altand#3\altand{\@altandlistc{#2}\@ifnotempty{#3}{%
  \@altandlistb#1{#3}}}
\def\@altandlistb#1#2#3#4#5\altand{%
  \@ifempty{#5}{%
    \@altandlistc{#2#4}%
  }{%
    \@altandlistc{#1#4}\@altandlistb{#1}{#3}{#3}{#5}%
  }}
\let\@altandlistc\@iden
\newcommand{\nxaltandlist}[4]{%
  \def\@altandlistc##1{\toks@\@xp{\the\toks@##1}}%
  \toks@{\toks@\@emptytoks \@altandlista{{#1}{#2}{#3}}}%
  \the\@xp\toks@#4\altand\altand
  \edef#4{\the\toks@}%
  \let\@altandlistc\@iden}
%%
\newcommand{\xandlist}[4]{\@andlista{{#1}{#2}{#3}}#4\and\and}
\def\@andlista#1#2\and#3\and{\@andlistc{#2}\@ifnotempty{#3}{%
  \@andlistb#1{#3}}}
\def\@andlistb#1#2#3#4#5\and{%
  \@ifempty{#5}{%
    \@andlistc{#2#4}%
  }{%
    \@andlistc{#1#4}\@andlistb{#1}{#3}{#3}{#5}%
  }}
\let\@andlistc\@iden
\newcommand{\nxandlist}[4]{%
  \def\@andlistc##1{\toks@\@xp{\the\toks@##1}}%
  \toks@{\toks@\@emptytoks \@andlista{{#1}{#2}{#3}}}%
  \the\@xp\toks@#4\and\and
  \edef#4{\the\toks@}%
  \let\@andlistc\@iden}
%%%
\newcommand{\andify}{%
  \nxandlist{\unskip, }{\unskip{},~}{\unskip,~}}
\def\and{\unskip{}, \ignorespaces}
%%%
\newcommand{\altandify}{%
  \nxandlist{\unskip, }{\unskip{},~}{\unskip,~}}
\def\altand{\unskip{}, \ignorespaces}
% \newcommand{\altandify}{%
%   \nxaltandlist{\unskip, }{\unskip{} and~}{\unskip, and~}}
% \def\altand{\unskip{ }and \ignorespaces}
%%%%

%%%

\long\def\@footnotetext#1%
{%
  \insert\footins{%
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
%%    \hbox to\columnwidth\@parboxrestore
%%    \hbox to\columnwidth\@parboxrestore%
    \protected@edef\@currentlabel{%
       \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}
}%

% \RequirePackage{multicol}\relax
\def\maketitle{\par
  \@maketitle@hook@pre
  \@maketitle@hook
  % \begin{otherlanguage}{\PFUlanguage}
  %%   \clearpage
  %   {
  %   \selectlanguage{\PFUlanguage}
  %%%   --
  %   \if@filesw
  %   \makeatletter
  %   \@input{\PFU@auxname.aux}%
  %   \immediate\openout\PFU@aux\PFU@auxname.aux\relax
  %   \fi
  %   \flushbottom
  %   \let\@corresp@note\relax
  \global\t@glob@notes={}
  % \global\c@PFUauthor\z@
  % \global\c@collab\z@ \global\c@address\z@
  % % \sv@mathsurround\mathsurround \m@th
  % \global\n@author=0\n@author@\relax
  % \global\n@collab=0\n@collab@\relax
  % \global\advance\n@author\m@ne   % In comparisons later on we need
  % \global\advance\n@collab\m@ne   % n@author-1 and n@collab-1
  % \global\@firstauthortrue        % set to false by first \author or \collab
  % \global\@hasabstractfalse       % Default:  no abstract or keywords
  % \global\@haskeywordsfalse       % Default:  no abstract or keywords
  % \global\@prefacefalse           %           not preface
  %%%
  % \@topnum\z@ % this prevents figures from falling at the top of page 1
  %% \refstepcounter{title}
  \label{starttitle}
  \message{!!!PFUtitle=\thePFUtitle}
  \@setcopyright
  % \uppercasenonmath\shorttitle
  % \ifx\@empty\shortauthors \let\shortauthors\shorttitle
  % \else \andify\shortauthors
  %   % \uppercasenonmath\shortauthors
  % \fi
  \altandify\altauthors
  \andify\authorsrunning
  \andify\authorstoc
  \altandify\altauthorstoc
  % \renewcommand{\leftmark}{\authors}
  \message{99999}
  \message{\@biblabel{1}}
  \iflanguage{\@defaultlanguage}
  {%
    \message{99999-1}
    % \addcontentsline{toc}{chapter}{%
    %   \raggedright
    %   {\bfseries \authorstoc}\unskip,{}\xspace
    %   % \\
    %   \no@harm \@title}
    % \addcontentsline{tac}{chapter}{%
    %   \raggedright
    %   {\bfseries \altauthorstoc}\unskip,{}\xspace
    %   % \\
    %   \no@harm \@alttitle}
    \addcontentsline{toc}{chapter}{%
      % \raggedright
      {\bfseries \authorstoc}\unskip,{}\xspace
      \no@harm \@title
    }
    \addcontentsline{tac}{chapter}{%
      % \raggedright
      {\bfseries \altauthorstoc}\unskip,{}\xspace
      \no@harm \@alttitle
    }
  }
  {%
    \addtocontents{toc}{\protect\select@language{\@defaultlanguage}}
    \addcontentsline{toc}{chapter}{
      \raggedright
      {\bfseries \altauthorstoc}\unskip,{}\xspace
      % \\
      \no@harm \@alttitle}
    \addtocontents{tac}{\protect\select@language{\@defaultaltlanguage}}
    \addcontentsline{tac}{chapter}{%
      \raggedright
      {\bfseries \authorstoc}\unskip,{}\xspace
      % \\
      \no@harm \@title}
  }
  \message{99999-5}
  % \@mkboth{\@journal}{\authors \@title}
  % \@mkboth{\andify\altauthors}{\shorttitle}
  % \toks@\@xp{\authors}
  % \edef\atoks{\the\toks@}
  % \renewcommand{\leftmark}{\atoks}
  \ifnum\c@PFUauthor>\@ne
  \edef\rauthor{\@rauthor{} \etal}
  \else \edef\rauthor{\@rauthor}
  \fi
  % \renewcommand{\leftmark}{\rauthor\ \textit{\shorttitle}}
  \ifx\shorttitle\@empty
  \let\shorttitle\@title
  \fi
  %% \renewcommand{\leftmark}{\authorsrunning{} {\shorttitle}}
  % \renewcommand{\leftmark}{\truncate{0.8\textwidth}{\hfill \emph{\authorsrunning} {\shorttitle} \hfill}}
  % \renewcommand{\leftmark}{\truncate{0.8\textwidth}{\hfill \headerFontSize {\authorsrunning} \hfill}}
  \renewcommand{\leftmark}{\hfill \headerFontSize {\authorsrunning} \hfill}
  \renewcommand{\rightmark}{\truncate{0.8\textwidth}{\headerFontSize {\shorttitle}}}
  \begingroup
  % \if@twocolumn %
  % \twocolumn[\@maketitle]
  \@maketitle
  % \fi
  % \ifx\@runauthor\relax
  % \global\let\@runauthor\@runningauthor
  % \fi
  \global\n@author=\c@PFUauthor
  % \global\n@collab=\c@collab
  \@writecount
  % \toks@\@xp{\shortauthors}\@temptokena\@xp{\shorttitle}%
  % \edef\@tempa{\@nx\markboth{\the\toks@}{\the\@temptokena}}\@tempa
  \endgroup
  % \message{1111111}
  %% \newif\if@twocolumn
  %% \@twocolumntrue%
  \if@twocolumn\typeout{2-col}%
  \else%
  \typeout{1-col}%
  \fi%
  \if@multicolumn\typeout{2-col}%
  \else%
  \typeout{1-col}%
  \fi%
  \ifthenelse{\boolean{PFUprocMultiColumn}}{\typeout{2-col}}{\typeout{1-col}}
  % \if@twocolumn%
  % \twocolumngrid
  % \fi
  \if@multicolumn%
  \twocolumngrid
  \fi

  %%
  \begingroup
  % \def\@makefntext{\noindent}
  % \renewcommand{\@makefnmark}{}
  % \def\@thefnmark{\!\!}
  \def\@thefnmark{}
  \ifx\@empty\thankses
  \else
  \@footnotetext{%
    \def\par{\let\par\@par}
    \noindent\hspace{-3\footnotesep}\@setthanks
  }
  \fi
  \endgroup
  \normalsize
  \@maketitle@hook@post
  % \begin{multicols*}{2}
  %   \addcontentsline{alt}{alttitle}{\@alttitle}
  %   \addcontentsline{alt}{altauthors}{\altauthors}
  %   \addcontentsline{alt}{altabstracts}{\@altabstracts}
  %   \thispagestyle{firstpage}% this sets first page specifications
  %   \c@footnote\z@
  %   \def\do##1{\let##1\relax}%
  %   \do\maketitle \do\@maketitle \do\title \do\@xtitle \do\@title
  %   \do\author \do\@xauthor \do\address \do\@xaddress
  %   \do\email \do\@xemail \do\curraddr \do\@xcurraddr
  \do\dedicatory \do\@dedicatory
  \do\thanks \do\thankses
  \do\keywords \do\@keywords
  \do\subjclass \do\@subjclass
  %%%
  \let\shortauthors\@empty%
  \let\authors\@empty%
  % \let\authorstoc\@empty%
  %% \let\author\@empty
  \let\addresses\@empty%
  \let\@address\@empty%
  \let\thankses\@empty%
  \let\@keywords\@empty%
  %
  \let\@received\@empty
  \let\@received@day\@empty
  \let\@received@month\@empty
  \let\@received@year\@empty
  \let\@revised\@empty
  \let\@revised@day\@empty
  \let\@revised@month\@empty
  \let\@revised@year\@empty
  \let\@accepted\@empty
  \let\@accepted@day\@empty
  \let\@accepted@month\@empty
  \let\@accepted@year\@empty
  \let\@published\@empty
  \let\@published@day\@empty
  \let\@published@month\@empty
  \let\@published@year\@empty
  %
  \let\@dedicatory\@empty%
  %%%
  % \let\shortaltauthors\@empty   \let\altauthors\@empty
  % \let\altaddresses\@empty
  % \let\altthankses\@empty
  %%% --
  % \let\@udcnum\@empty
  \let\@abstracts\@empty
  \let\@paperid\@empty
  %%%
  % \end{otherlanguage}
  % } % END \selectlanguage
} % END \maketitle

\def\maketitleToc{\par
  \@maketitle@hook@pre
  \@maketitle@hook
  %% \clearpage
  % \selectlanguage{\PFUlanguage}
  %%% --
  % \if@filesw
  % \makeatletter
  % \@input{\PFU@auxname.aux}%
  % \immediate\openout\PFU@aux\PFU@auxname.aux\relax
  % \fi
  % \flushbottom
  % \let\@corresp@note\relax
  \global\t@glob@notes={}
  % \global\c@PFUauthor\z@
  % \global\c@collab\z@ \global\c@address\z@
  % % \sv@mathsurround\mathsurround \m@th
  % \global\n@author=0\n@author@\relax
  % \global\n@collab=0\n@collab@\relax
  % \global\advance\n@author\m@ne   % In comparisons later on we need
  % \global\advance\n@collab\m@ne   % n@author-1 and n@collab-1
  % \global\@firstauthortrue        % set to false by first \author or \collab
  % \global\@hasabstractfalse       % Default:  no abstract or keywords
  % \global\@haskeywordsfalse       % Default:  no abstract or keywords
  % \global\@prefacefalse           %           not preface
  %%%
  % \@topnum\z@ % this prevents figures from falling at the top of page 1
  %% \refstepcounter{title}
  \label{starttitle}
  % \@setcopyright
  % \uppercasenonmath\shorttitle
  % \ifx\@empty\shortauthors \let\shortauthors\shorttitle
  % \else \andify\shortauthors
  %   % \uppercasenonmath\shortauthors
  % \fi
  \altandify\altauthors
  \andify\authorsrunning
  \andify\authorstoc
  \altandify\altauthorstoc
  % \renewcommand{\leftmark}{\authors}
  \iflanguage{\@defaultlanguage}
  {%
    \addcontentsline{toc}{chapter}{{\bfseries \authorstoc} \no@harm \@title}
    \addcontentsline{tac}{chapter}{{\bfseries \altauthorstoc} \no@harm \@alttitle}
  }
  {%
    \addtocontents{toc}{\protect\select@language{\@defaultlanguage}}
    \addcontentsline{toc}{chapter}{{\bfseries \altauthorstoc} \no@harm \@alttitle}
    \addtocontents{tac}{\protect\select@language{\@defaultaltlanguage}}
    \addcontentsline{tac}{chapter}{{\bfseries \authorstoc} \no@harm \@title}
  }
  % \@mkboth{\@journal}{\authors \@title}
  % \@mkboth{\andify\altauthors}{\shorttitle}
  % \toks@\@xp{\authors}
  % \edef\atoks{\the\toks@}
  % \renewcommand{\leftmark}{\atoks}
  \ifnum\c@PFUauthor>\@ne
  \edef\rauthor{\@rauthor{} \etal}
  \else \edef\rauthor{\@rauthor}
  \fi
  % \renewcommand{\leftmark}{\rauthor\ \textit{\shorttitle}}
  \ifx\shorttitle\@empty
  \let\shorttitle\@title
  \fi
  %% \renewcommand{\leftmark}{\authorsrunning{} {\shorttitle}}
  % \renewcommand{\leftmark}{\truncate{0.8\textwidth}{\hfill \emph{\authorsrunning} {\shorttitle} \hfill}}
  % \renewcommand{\leftmark}{\truncate{0.8\textwidth}{\hfill \headerFontSize {\authorsrunning} \hfill}}
  \renewcommand{\leftmark}{\hfill \headerFontSize {\authorsrunning} \hfill}
  \renewcommand{\rightmark}{\truncate{0.8\textwidth}{\headerFontSize {\shorttitle}}}
  \begingroup
  % \if@twocolumn %
  % \twocolumn[\@maketitle]
  % \@maketitle
  % \fi
  % \ifx\@runauthor\relax
  % \global\let\@runauthor\@runningauthor
  % \fi
  \global\n@author=\c@PFUauthor
  % \global\n@collab=\c@collab
  \@writecount
  % \toks@\@xp{\shortauthors}\@temptokena\@xp{\shorttitle}%
  % \edef\@tempa{\@nx\markboth{\the\toks@}{\the\@temptokena}}\@tempa
  \endgroup
  % \message{1111111}
  %% \newif\if@twocolumn
  %% \@twocolumntrue%
  \if@twocolumn\typeout{2-col}%
  \else%
  \typeout{1-col}%
  \fi%
  \if@multicolumn\typeout{2-col}%
  \else%
  \typeout{1-col}%
  \fi%
  \ifthenelse{\boolean{PFUprocMultiColumn}}{\typeout{2-col}}{\typeout{1-col}}
  % \if@twocolumn%
  % \twocolumngrid
  % \fi
  \if@multicolumn%
  \twocolumngrid
  \fi

  %%
  % \begingroup
  % % \def\@makefntext{\noindent}
  % % \renewcommand{\@makefnmark}{}
  % \def\@thefnmark{\!\!}
  % \ifx\@empty\thankses
  % \else
  % \@footnotetext{%
  % \def\par{\let\par\@par}
  % \@setthanks
  % }
  %   \fi
  %   \endgroup
  \normalsize
  \@maketitle@hook@post
  % \begin{multicols*}{2}
  %   \addcontentsline{alt}{alttitle}{\@alttitle}
  %   \addcontentsline{alt}{altauthors}{\altauthors}
  %   \addcontentsline{alt}{altabstracts}{\@altabstracts}
  %   \thispagestyle{firstpage}% this sets first page specifications
  %   \c@footnote\z@
  %   \def\do##1{\let##1\relax}%
  %   \do\maketitle \do\@maketitle \do\title \do\@xtitle \do\@title
  %   \do\author \do\@xauthor \do\address \do\@xaddress
  %   \do\email \do\@xemail \do\curraddr \do\@xcurraddr
  \do\dedicatory \do\@dedicatory
  \do\thanks \do\thankses
  \do\keywords \do\@keywords
  \do\subjclass \do\@subjclass
  %%%
  \let\shortauthors\@empty%
  \let\authors\@empty%
  \let\authorstoc\@empty%
  %% \let\author\@empty
  \let\addresses\@empty%
  \let\@address\@empty%
  \let\thankses\@empty%
  \let\@keywords\@empty%
  % 
  \let\@received\@empty
  \let\@received@day\@empty
  \let\@received@month\@empty
  \let\@received@year\@empty
  \let\@revised\@empty
  \let\@revised@day\@empty
  \let\@revised@month\@empty
  \let\@revised@year\@empty
  \let\@accepted\@empty
  \let\@accepted@day\@empty
  \let\@accepted@month\@empty
  \let\@accepted@year\@empty
  \let\@published\@empty
  \let\@published@day\@empty
  \let\@published@month\@empty
  \let\@published@year\@empty
  %
  \let\@dedicatory\@empty%
  %%%
  % \let\shortaltauthors\@empty   \let\altauthors\@empty
  % \let\altaddresses\@empty
  % \let\altthankses\@empty
  %%% --
  % \let\@udcnum\@empty
  \let\@abstracts\@empty
  \let\@paperid\@empty
  %%%
} % END \maketitleToc

\def\@maketitle@hook@pre{\global\let\@maketitle@hook@pre\@empty}
% \def\@maketitle@hook{\global\let\@maketitle@hook\@empty}
\def\@maketitle@hook{}
% \def\@maketitle@hook@post{\global\let\@maketitle@hook@post\@empty}
\def\@maketitle@hook@post{}
\def\@maketitle{%
  \flushbottom
  \normalfont\normalsize
  \let\@makefnmark\relax  \let\@thefnmark\relax
  % \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  \if@keywordsAsFooter%
    \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords} \fi
  \fi
  % \if@receivedAsFooter%
  %   \ifx\@empty\@received \else        \@footnotetext{\PFUreceivedName \@received} \fi
  % \else
  %   \ifx\@empty\@received \else        \PFUreceivedName \@received \fi
  % \fi
  % \ifx\@empty\thankses\else \@footnotetext{\def\par{\let\par\@par}\@setthanks}
  % \fi
  % \ifx\@empty\thankses\else \footnotetext{\thankses}
  % \fi
  % \@mkboth{\@journalname}{\authors{} \@title}
  % \@mkboth{\@nx\shortauthors}{\@nx\shorttitle}%
  % \global\topskip8pc\relax % 10pc to base of first title line
  % \bigskip
  % \bigskip
  % \vspace{2\bigskipamount}
  \begingroup
  \ifx\@empty\@documentType \else \noindent \hfill\textit{\@documentType}\par \fi
  \ifx\@empty\@udcnum \else \nobreak\smallskip\noindent \footnotesize\PFUudcName{} \@udcnum \hfill\par \fi
  \ifx\@empty\@pacsnum \else \nobreak\smallskip\noindent \footnotesize\PFUpacsName{} \@pacsnum \hfill\par \fi
  \ifx\@empty\@doi \else \nobreak\smallskip\noindent \footnotesize DOI: \@doi \hfill\par \fi
  \nobreak%
  \smallskip
  \@settitle
  \smallskip
  \ifx\@empty\authors \else \@setauthors \fi
  \endgroup
  %%% --
  \nobreak %
  \begingroup
  % \smallskip
  \footnotesize
  \centering
  \addresses
  \par
  \medskip
  \ifx\@empty\@email \else \noindent Email: \@email \par \fi
  \endgroup
  %%%
  \ifx\@empty\@dedicatory
  \else
  \baselineskip26\p@
  % \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
  % \global\dimen@i\prevdepth}\prevdepth\dimen@i
  \begin{flushright}
    \begin{minipage}{\dedicatorywidth}
      \footnotesize\itshape\@dedicatory\par%
    \end{minipage}
  \end{flushright}
  \fi
  %
  \if@receivedAsFooter%
    \ifx\@empty\@received \else \@footnotetext{\hspace{-2.5\footnotesep}\@setreceived} \fi
  \else
    \ifx\@empty\@received \else
      \begin{center}
        \footnotesize
        (%
        \PFUreceivedName:\enspace \@received%
        \ifx\@empty\@accepted%
        \else
          ;
          \PFUacceptedName:\enspace \@accepted%
        \fi
        )
      \end{center}
    \fi
  \fi
  % \@setabstract
  %%% --
  \ifvoid\t@abstract
  \else
  \vskip 8\p@
  \unvbox\t@abstract
  \fi
  % \unvcopy\t@abstract
  %%%
  \normalsize
  % \bigskip
  \medskip
  \if@keywordsAsFooter%
  \else
    \ifx\@empty\@keywords\else \@setkeywords \fi
  \fi
  %
  % \begingroup
  % \par
  % \medskip
  % \ifx\@empty\@udcnum \else \nobreak\smallskip\noindent \footnotesize\PFUudcName{} \@udcnum \hfill\par \fi
  % % \nobreak%
  % \ifx\@empty\@pacsnum \else \nobreak\smallskip\noindent \footnotesize\PFUpacsName{} \@pacsnum \hfill\par \fi
  % % \nobreak%
  % \ifx\@empty\@doi \else \nobreak\smallskip\noindent \footnotesize DOI: \@doi \hfill\par \fi
  % \endgroup
  % \nobreak%
  %
  % \if@titlepage
  % \newpage
  % \else
  \dimen@34\p@ \advance\dimen@-\baselineskip
  % \vskip\dimen@\relax
  \setboolean{sectionAfterTitle}{true}
  % \@sectionAfterTitletrue
  % \fi
  \normalsize
} % end \@maketitle
%%% -- \@makeappendixtitle
\def\makeappendixtitle{\par
  \addcontentsline{toc}{chapter}{\@appendixtitle}
  \addcontentsline{tac}{chapter}{\@altappendixtitle}
  % \renewcommand{\leftmark}{\rauthor\ \textit{\shorttitle}}
  % \renewcommand{\rightmark}{\shorttitle}
  \@makeappendixtitle@hook
  \begingroup
  \@makeappendixtitle
  \endgroup
}
\def\@makeappendixtitle@hook{\global\let\@makeappendixtitle@hook\@empty}
\def\@makeappendixtitle{%
  \normalfont\normalsize
  \let\@makefnmark\relax  \let\@thefnmark\relax
  % \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
  % \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
  % \ifx\@empty\thankses\else \@footnotetext{%
  % \def\par{\let\par\@par}\@setthanks}\fi
  % \@mkboth{\@journalname}{\authors{} \@title}
  % \@mkboth{\@nx\shortauthors}{\@nx\shorttitle}%
  % \global\topskip8pc\relax % 10pc to base of first title line
  \bigskip
  \bigskip
  % \ifx\@empty\@udcnum \else \noindent \CYRU\CYRD\CYRK{} \@udcnum \hfill\par \fi
  % \ifx\@empty\@udcnum \else \noindent \@udcnum \hfill\par \fi
  \@setappendixtitle
  % \ifx\@empty\authors \else \@setauthors \fi
  %%% --
  % \nobreak \begingroup
  % \footnotesize
  % \centering
  % \addresses
  % \par
  % \endgroup
  %%%
  % \ifx\@empty\@dedicatory
  % \else
  % \baselineskip26\p@
  % \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
  % \global\dimen@i\prevdepth}\prevdepth\dimen@i
  % \fi
  % \@setabstract
  %%% --
  % \vskip 8\p@
  % \unvbox\t@abstract
  % %%%
  % \normalsize
  % \if@titlepage
  % \newpage
  % \else
  % \dimen@34\p@ \advance\dimen@-\baselineskip
  % \vskip\dimen@\relax
  % \fi
} % end \@makeappendixtitle
\def\@setappendixtitle{
  \begin{center}%
    % \@titlesize
    \titleFontSize\titleFontShape
    \@appendixtitle
  \end{center}%
}
%%%

\def\makesubtitle{\par
  \global\t@glob@notes={}
%
  \altandify\altauthors
  \andify\authorsrunning
  \ifnum\c@PFUauthor>\@ne
    \edef\rauthor{\@rauthor{} \etal}
  \else \edef\rauthor{\@rauthor}
  \fi
  \ifx\shortsubtitle\@empty
    \let\shortsubtitle\@subtitle
  \fi
%   \renewcommand{\leftmark}{\truncate{0.8\textwidth}{\hfill \emph{\authorsrunning} {\shortsubtitle} \hfill}}
%  \renewcommand{\leftmark}{\truncate{0.8\textwidth}{\hfill \textsc{\authorsrunning} \hfill}}
  \@makesubtitle@hook
  \begingroup
  %\if@twocolumn %
%   \twocolumn[\@maketitle]
  \@makesubtitle
  %\fi
%   \ifx\@runauthor\relax
%    \global\let\@runauthor\@runningauthor
%   \fi
   \global\n@author=\c@PFUauthor
%   \global\n@collab=\c@collab
  \@writecount
%  \toks@\@xp{\shortauthors}\@temptokena\@xp{\shorttitle}%
%   \edef\@tempa{\@nx\markboth{\the\toks@}{\the\@temptokena}}\@tempa
  \endgroup
%%   \newif\if@twocolumn
%%   \@twocolumntrue%
  \if@twocolumn\typeout{2-col}%
  \else%
  \typeout{1-col}%
  \fi%
  \if@multicolumn\typeout{2-col}%
  \else%
  \typeout{1-col}%
  \fi%
  \ifthenelse{\boolean{PFUprocMultiColumn}}{\typeout{2-col}}{\typeout{1-col}}
%  \if@twocolumn%
%  \twocolumngrid
%  \fi
  \if@multicolumn%
    \twocolumngrid
  \fi
%
\let\shortauthors\@empty%
\let\authors\@empty%
\let\authorstoc\@empty%
%% \let\author\@empty
\let\addresses\@empty%
\let\@address\@empty%
\let\thankses\@empty%
% \let\keywords\@empty%
\let\@keywords\@empty%
\let\@received\@empty%
\let\@dedicatory\@empty%
%%%
% \let\shortaltauthors\@empty   \let\altauthors\@empty
% \let\altaddresses\@empty
% \let\altthankses\@empty
%%%--
% \let\@udcnum\@empty
%%%
} % END \makesubtitle

\def\@makesubtitle@hook{\global\let\@makesubtitle@hook\@empty}
\def\@makesubtitle{%
\flushbottom
  \normalfont\normalsize
  \let\@makefnmark\relax  \let\@thefnmark\relax
  \@setsubtitle
%  \bigskip
  \smallskip
  \ifx\@empty\authors \else \@setauthors \fi
%%%--
  \nobreak %
  \begingroup
  \footnotesize
  \centering
  \addresses
  \par
  \endgroup
%%%
  \ifx\@empty\@dedicatory
  \else
    \baselineskip26\p@
%    \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
%      \global\dimen@i\prevdepth}\prevdepth\dimen@i
    \begin{flushright}
      \begin{minipage}{\dedicatorywidth}
        \footnotesize\itshape\@dedicatory\par%
      \end{minipage}
    \end{flushright}
  \fi
%   \@setabstract
%%%--
  \ifvoid\t@abstract
  \else
  \vskip 8\p@
  \unvbox\t@abstract
  \fi
%%%
  \normalsize
%  \bigskip
  \medskip
} % end \@makesubtitle

%%%--
\providecommand{\makealttitle}%
{
  \@makealttitle@hook@pre
  \@makealttitle@hook
  % \begin{otherlanguage}{\PFUaltlanguage}
%%   \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
%   \relax
%   \vspace*{2\bigskipamount}
%   \bigskip
%   \bigskip
%  \par
%  \@topnum\z@ % this prevents figures from falling at the top of page 1
%  \refstepcounter{alttitle}
%  \@setcopyright
  \uppercasenonmath\shortalttitle
  \ifx\@empty\shortaltauthors \let\shortaltauthors\shortalttitle
  \else \andify\shortaltauthors \uppercasenonmath\shortaltauthors \fi
  \altandify\altauthors
%  \addcontentsline{toc}{chapter}{{\bfseries \authors} \@title}
%  \@mkboth{\@journal}{\authors \@title}
%%%
    \message{88888}
    \message{\@biblabel{1}}
  \relax
  \flushbottom
%%   \raggedbottom
%   \bigskip
%   \bigskip
%  \bigskip
%  \hrule width\hsize \relax
%  \filbreak
%%%
  \begingroup
%     \if@twocolumn
%       \@restonecoltrue\onecolumn
%     \else
%       \@restonecolfalse
%     \fi
%  \if@twocolumn%
  \relax%
%  \onecolumngrid
%   \fi
  \if@multicolumn%
    \onecolumngrid
  \fi
  \vspace{2\bigskipamount}
  \@makealttitle
  \label{endtitle}
  %\if@twocolumn
  %\twocolumn[\@makealttitle]
  %\fi
%  \toks@\@xp{\shortauthors}\@temptokena\@xp{\shorttitle}%
%   \edef\@tempa{\@nx\markboth{\the\toks@}{\the\@temptokena}}\@tempa
  \endgroup
%  \onecolumngrid
  \@makealttitle@hook@post
  %\clearpage
%   \end{multicols*}
%   \addcontentsline{alt}{alttitle}{\@alttitle}
%   \addcontentsline{alt}{altauthors}{\altauthors}
%   \addcontentsline{alt}{altabstracts}{\@altabstracts}
%  \thispagestyle{firstpage}% this sets first page specifications
%  \c@footnote\z@
%  \def\do##1{\let##1\relax}%
%  \do\maketitle \do\@maketitle \do\title \do\@xtitle \do\@title
%  \do\author \do\@xauthor \do\address \do\@xaddress
%  \do\email \do\@xemail \do\curraddr \do\@xcurraddr
%  \do\dedicatory \do\@dedicatory \do\thanks \do\thankses
%  \do\keywords \do\@keywords \do\subjclass \do\@subjclass
%%%
% \let\shortauthors\@empty   \let\authors\@empty
%\let\author\@empty
% \let\addresses\@empty      \let\thankses\@empty
%%%
\let\shortaltauthors\@empty
\let\altauthors\@empty
% \let\altauthorstoc\@empty
\let\altaddresses\@empty
% \let\@alttitle\@empty
% \let\thankses\@empty
% \let\addresses\@empty%
%%% --
\let\@udcnum\@empty
\let\@pacsnum\@empty
% \let\@doi\@empty
\let\@documentType\@empty
\let\alt@keywords\@empty
\let\@altabstracts\@empty
%%%
\if@filesw
  \immediate\closeout\PFU@aux\relax
\fi
% \end{otherlanguage}
} % END \makealttitle

\providecommand{\makealttitleTOCOnly}%
{
  \@makealttitle@hook@pre
  \@makealttitle@hook
  \uppercasenonmath\shortalttitle
  \ifx\@empty\shortaltauthors \let\shortaltauthors\shortalttitle
  \else \andify\shortaltauthors \uppercasenonmath\shortaltauthors \fi
  \altandify\altauthors
%  \addcontentsline{toc}{chapter}{{\bfseries \authors} \@title}
%  \@mkboth{\@journal}{\authors \@title}
%%%
  \relax
  \flushbottom
  \begingroup
  \relax%
  \if@multicolumn%
    \onecolumngrid
  \fi
%  \vspace{2\bigskipamount}
%  \@makealttitle
  \label{endtitle}
  \endgroup
  \@makealttitle@hook@post
  %\clearpage
  \let\shortaltauthors\@empty
  \let\altauthors\@empty
  % \let\altauthorstoc\@empty
  \let\altaddresses\@empty
  % \let\@alttitle\@empty
  % \let\thankses\@empty
  % \let\addresses\@empty%
  \let\@udcnum\@empty
  \let\@pacsnum\@empty
  \let\alt@keywords\@empty
  \let\@altabstracts\@empty
  \if@filesw
    \immediate\closeout\PFU@aux\relax
  \fi
} % END \makealttitle*


\def\@makealttitle@hook@pre{\global\let\@makealttitle@hook@pre\@empty}
\def\@makealttitle@hook{\global\let\@makealttitle@hook\@empty}
\def\@makealttitle@hook@post{\global\let\@makealttitle@hook@post\@empty}
\providecommand{\@makealttitle}%
{%
  \begingroup
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
    % \begin{otherlanguage}{\PFUaltlanguage}
    %   \bigskip
    %   \bigskip
    \samepage
    \normalfont\normalsize
    \let\@makefnmark\relax  \let\@thefnmark\relax
    % \ifx\@empty\@subjclass\else \@footnotetext{\@setsubjclass}\fi
    % \ifx\@empty\@keywords\else \@footnotetext{\@setkeywords}\fi
    % \ifx\@empty\thankses\else \@footnotetext{%
    %   \def\par{\let\par\@par}\@setthanks}\fi
    % \@mkboth{\@journalname}{\authors{} \@title}
    % \@mkboth{\@nx\shortauthors}{\@nx\shorttitle}%
    % \global\topskip8pc\relax % 10pc to base of first title line
    % \bigskip\nobreak%
    % \ifx\@empty\@udcnum \else \noindent \@udcnum \hfill\par \fi
    \begingroup
    \ifx\@empty\@udcnum \else \noindent \PFUudcName{} \@udcnum \hfill\par \fi%
    \nobreak%
    \ifx\@empty\@pacsnum \else \noindent \PFUpacsName{} \@pacsnum \hfill\par \fi%
    \nobreak%
    \ifx\@empty\@doi \else \noindent DOI: \@doi \hfill\par \fi
    \nobreak%
    \smallskip
    \@setalttitle%
    \nobreak%
    \smallskip
    \ifx\@empty\altauthors \else \@setaltauthors \fi
    \endgroup
    %%% --
    \nobreak%
    % \begingroup
    \smallskip
    \begin{center}
      \footnotesize
      \samepage%
      \altaddresses
      \medskip
      \ifx\@empty\@email \else \noindent Email: \@email \par \fi
    \end{center}
    \nobreak
    % \par
    % \endgroup
    %%%
    \ifx\@empty\@dedicatory
    \else
      \baselineskip26\p@
      \vtop{\centering{\footnotesize\itshape\@dedicatory\@@par}%
        \global\dimen@i\prevdepth}\prevdepth\dimen@i
    \fi
    % \@setabstract
    %%% --
    \nobreak
    \ifvoid\t@altabstract
  \else
    \vskip 8\p@
    \unvbox\t@altabstract
  \fi
  %%%
  \nobreak
  \smallskip
  \nobreak
  \ifx\@empty\alt@keywords\else \@setaltkeywords \fi
  \normalsize
%   \if@titlepage
%     \newpage
%   \else
%     \dimen@34\p@ \advance\dimen@-\baselineskip
%     \vskip\dimen@\relax
%   \fi
  \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
% \end{otherlanguage}
\endgroup
\normalsize
% \selectlanguage{russian}
} % END \@makealttitle

%%%
\AtBeginDocument{%
  \@ifundefined{publname}{%
    \let\publname\@empty
    \let\@serieslogo\@empty
  }{%
    \def\@serieslogo{%
      \vbox to\headheight{%
        \parindent\z@ \fontsize{6}{7\p@}\selectfont
        \noindent\publname\newline
        \volinfo\endgraf
        \vss
      }%
    }%
  }%
}
\@ifundefined{volinfo}{\let\volinfo\@empty}{}
\def\issueinfo#1#2#3#4{\def\currentvolume{#1}\def\currentissue{#2}%
  \def\currentmonth{#3}\def\currentyear{#4}}
\issueinfo{00}% volume number
  {0}%        % issue number
  {Xxxx}%     % month
  {XXXX}%     % year
\def\copyrightinfo#1#2{\def\copyrightyear{#1}\def\copyrightholder{#2}}
\copyrightinfo{0000}{(copyright holder)}
\def\pagespan#1#2{\setcounter{page}{#1}%
  \ifnum\c@page<\z@ \pagenumbering{roman}\setcounter{page}{-#1}\fi
  \def\start@page{#1}\def\end@page{#2}}
\pagespan{000}{000}
\newinsert\copyins
\skip\copyins=1.5pc
\count\copyins=1000 % magnification factor, 1000 = 100%
\dimen\copyins=.5\textheight % maximum allowed per page
\def\@setcopyright{%
  \ifx\@empty\@serieslogo
  \else\ifx\@empty\copyrightyear
  \else
    \insert\copyins{\hsize\textwidth
      \parfillskip\z@ \leftskip\z@\@plus.9\textwidth
      \fontsize{6}{7\p@}\normalfont\upshape
      \everypar{}%
      \vskip-\skip\copyins \nointerlineskip
      \noindent\vrule\@width\z@\@height\skip\copyins
      \copyright\copyrightyear\ \copyrightholder
      \par
      \kern\z@}%
  \fi\fi
}
\def\@combinefloats{%
  \ifx \@toplist\@empty \else \@cflt \fi
  \ifx \@botlist\@empty \else \@cflb \fi
  \ifvoid\copyins \else \@cflci \fi
}
\def\@cflci{%
  \if\if@twocolumn \if@firstcolumn F\else T\fi\else T\fi T%
      \setbox\@outputbox\vbox{%
        \unvbox\@outputbox
        \vskip\skip\copyins
        \hbox to\columnwidth{%
          \hss\vbox to\z@{\vss\unvbox\copyins}}}%
  \fi
}
% \newcommand{\abstractname}{Abstract}
% \newcommand{\keywordsname}{Key words and phrases}
\newcommand{\subjclassname}{\textup{1991} Mathematics Subject
     Classification}
%\def\@tempb{amsproc}
%\ifx\@classname\@tempb
%  \newcommand{\datename}{\textit{Date}:}
%\else
%  \newcommand{\datename}{Received by the editors}
%\fi
\def\@settitle{
  \begin{center}%
    % \@titlesize
    \titleFontSize\titleFontShape
    \@title
  \end{center}%
}

\def\@setauthors{%
  \begingroup
  \trivlist
  % \centering \fontsize{11}{13\p@}\selectfont\@topsep13\p@\relax
  %%% --
  \centering
  \author@font
  % \bfseries
  %%%
\item\relax
  \andify\authors
  \authors
  \endtrivlist
  \endgroup
}
%%%
\def\@setsubtitle{
  \begin{center}%
    \@subtitlesize
    \@subtitle
  \end{center}%
}
%%% --
\providecommand{\@setalttitle}%
{%
  \begin{center}%
    % \large
    % \bfseries
    \titleFontSize\titleFontShape
    \@alttitle
  \end{center}%
} % END \@setalttitle
\def\@setaltauthors{%
  \begingroup
  \trivlist
%  \centering \fontsize{10}{12\p@}\selectfont\@topsep12\p@\relax
%%%--
  \centering
  \author@font
%  \bfseries
%%%
  \item\relax
  \andify\altauthors
  \altauthors
  \endtrivlist
  \endgroup
}
%%%
\def\@setdate{\datename\ \@date\@addpunct.}
\def\@setsubjclass{%
  {\itshape\subjclassname.}\enspace\@subjclass\@addpunct.}
\def\@setkeywords{%
  % \hskip\parindent%
  \noindent
  \@keywordsize%
  {\DivFontShape \keywordsname:}\enspace \@keywords%\@addpunct.%
}%
\def\@setaltkeywords{%
  \hskip\parindent%
  \@keywordsize%
  {\DivFontShape \keywordsname:}\enspace \alt@keywords%\@addpunct.%
}%
\def\@setthanks{\def\thanks##1{\par##1\@addpunct.}\thankses}
\def\@setreceived{%
  \noindent\PFUreceivedName\enspace \@received\@addpunct.%
}%
%%%--
\newsavebox{\abstractbox}
% \newcommand{\abstracts}[2][]{%
%   \gdef\shortabstract{#1}\gdef\@abstracts{#2}
% }
% \newcommand{\abstracts}[1]{%
%   \gdef\@abstracts{#1}
% }

%\def\abstract{\abstracts{}
%\def\endabstract{\par  }}
%\futurelet\abstract\abstracts\bgroup
%\long\def\abstract#1\csname endabstract \endcsname{\abstracts{#1}}
%\let\endabstract
% \renewenvironment{abstract}{%
%   \begingroup
%   \abstracts{
% }{
%   \endgroup
% }

\newenvironment{abstracta}{%
%  \begin{lrbox}{\abstractbox}
  \global\@hasabstracttrue
  \hyphenpenalty\sv@hyphenpenalty     % restore \hyphenpenalty
  \global\setbox\t@abstract=\vbox\bgroup
  \leftskip=0pt \rightskip\leftskip
   \small
  \parindent 1em                      % \parindent in abstract
  \ignorespaces

  % \ifx\maketitle\relax
  %   \ClassWarning{\@classname}{Abstract should precede
  %     \protect\maketitle\space in AMS documentclasses; reported}%
  % \fi
  % \global\setbox\abstractbox=\vtop \bgroup
  % \normalfont\Small
  % \Small
  % \list{}{\labelwidth\z@
  %   \leftmargin3pc \rightmargin\leftmargin
  %   \listparindent\normalparindent \itemindent\z@
  %   \parsep\z@ \@plus\p@
  %   \let\fullwidthdisplay\relax
  %   }%
  % \item[\hskip\labelsep\scshape\abstractname.]%
}{%
%  \end{lrbox}
  \par \egroup
  % \endlist\egroup
  % \ifx\@setabstract\relax \@setabstracta \fi
}

\newcommand{\abstracts}[1]{%
  \gdef\@abstracts{#1}
  \global\@hasabstracttrue
  \hyphenpenalty\sv@hyphenpenalty     % restore \hyphenpenalty
  \global\setbox\t@abstract=\vbox\bgroup
  \leftskip=0pt \rightskip\leftskip
  \small
  \parindent 1em                      % \parindent in abstract
  \ignorespaces
  #1
  \par \egroup%
}
\let\@abstracts\@empty

\def\abstract{\@ifnextchar[{\@abstract}{\@abstract[]}}
\def\@abstract{%
  \global\@hasabstracttrue
  \hyphenpenalty\sv@hyphenpenalty     % restore \hyphenpenalty
  \global\setbox\t@abstract=\vbox\bgroup
 %  \if@twocolumn\onecolumn \fi
%      \if@twocolumn
%       \@restonecoltrue\onecolumn
%     \else
%       \@restonecolfalse
%     \fi
 %\leftskip\z@
  %\@rightskip\z@ \rightskip\@rightskip \parfillskip\@flushglue
%   \leftskip=0.10753\textwidth \rightskip\leftskip
  \leftskip=0pt \rightskip\leftskip
   \small
  \parindent 1em                      % \parindent in abstract
%  \noindent {\bfseries\abstractname}  % caption `Abstract' (bold)
%  \vskip 0.5\@bls    % half a line of space below
% \noindent
\ignorespaces

%%%
%\def\abstract{\par
%\ifpreprintsty %
%\vskip2.5pc
%\begin{center}%
%{\large \abstractname\par}%
%\end{center}%
%\vskip.5pc
%\fi
%\bgroup
%\ifdim\prevdepth=-1000pt \prevdepth0pt\fi
%\hsize\columnwidth
%\if@twocolumn\else\leftskip=0.10753\textwidth \rightskip\leftskip\fi
%\dimen0=-\prevdepth \advance\dimen0 by17.5pt \nointerlineskip
%\small\vrule width 0pt height\dimen0 \relax
%%%
}
\def\@abstract[#1]{%
  \global\@hasabstracttrue
  \hyphenpenalty\sv@hyphenpenalty     % restore \hyphenpenalty
  \global\setbox\t@abstract=\vbox\bgroup
%  \if@twocolumn\onecolumn \fi
%      \if@twocolumn
%       \@restonecoltrue\onecolumn
%     \else
%       \@restonecolfalse
%     \fi
 %\leftskip\z@
  %\@rightskip\z@ \rightskip\@rightskip \parfillskip\@flushglue
%   \leftskip=0.10753\textwidth \rightskip\leftskip
  \leftskip=0pt \rightskip\leftskip
   \small
  \parindent 1em                      % \parindent in abstract
%  \noindent {\bfseries\abstractname}  % caption `Abstract' (bold)
%  \vskip 0.5\@bls    % half a line of space below
% \noindent
\ignorespaces
%%%
%\def\abstract{\par
%\ifpreprintsty %
%\vskip2.5pc
%\begin{center}%
%{\large \abstractname\par}%
%\end{center}%
%\vskip.5pc
%\fi
%\bgroup
%\ifdim\prevdepth=-1000pt \prevdepth0pt\fi
%\hsize\columnwidth
%\if@twocolumn\else\leftskip=0.10753\textwidth \rightskip\leftskip\fi
%\dimen0=-\prevdepth \advance\dimen0 by17.5pt \nointerlineskip
%\small\vrule width 0pt height\dimen0 \relax
%%%
}
\def\endabstract{\par \egroup}
%%%
%%%--

\newcommand{\altabstracts}[1]{%
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
    \gdef\@altabstracts{#1}
    \global\@hasaltabstracttrue
    \hyphenpenalty\sv@hyphenpenalty     % restore \hyphenpenalty
    \global\setbox\t@altabstract=\vbox\bgroup
    \leftskip=0pt \rightskip\leftskip
    \small
    \parindent 1em                      % \parindent in abstract
    \ignorespaces
    #1
    \par \egroup%
  \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi
}
\let\@altabstracts\@empty

\newcommand{\altabstractname}{Abstract}
\def\altabstract{\@ifnextchar[{\@altabstract}{\@altabstract[]}}
\def\@altabstract[#1]{%
  \ifpolyglossia\begin{otherlanguage}{\PFUaltlanguage}\else\begin{otherlanguage*}{\PFUaltlanguage}\fi
  \global\@hasaltabstracttrue
  \hyphenpenalty\sv@hyphenpenalty     % restore \hyphenpenalty
%     \if@twocolumn
%       \@restonecoltrue\onecolumn
%     \else
%       \@restonecolfalse
%     \fi
  \global\setbox\t@altabstract=\vbox\bgroup
%   \leftskip=0.10753\textwidth \rightskip\leftskip
%  \leftskip=0.10753\columnwidth \rightskip\columnwidth
  \leftskip\z@
%  \leftskip=0.05\textwidth
%  \@rightskip0.5\textwidth \advance\@rightskip \columnsep
  \rightskip\leftskip
%  \advance\@rightskip 0.1\textwidth
%  \rightskip\@rightskip
%  \rightskip0.5\textwidth
%   \@rightskip\z@ \rightskip\@rightskip \parfillskip\@flushglue
   \small
  \parindent 1em                      % \parindent in abstract
%  \noindent {\bfseries\abstractname}  % caption `Abstract' (bold)
%  \vskip 0.5\@bls    % half a line of space below
%\noindent
\ignorespaces
}
 \def\endaltabstract{\par \egroup \ifpolyglossia\end{otherlanguage}\else\end{otherlanguage*}\fi}
%%%
% \newbox\abstractbox
% \newenvironment{abstract}{%
%   \ifx\maketitle\relax
%     \ClassWarning{\@classname}{Abstract should precede
%       \protect\maketitle\space in AMS documentclasses; reported}%
%   \fi
%   \global\setbox\abstractbox=\vtop \bgroup
%   \normalfont\Small
%   \Small
%   \list{}{\labelwidth\z@
%     \leftmargin3pc \rightmargin\leftmargin
%     \listparindent\normalparindent \itemindent\z@
%     \parsep\z@ \@plus\p@
%     \let\fullwidthdisplay\relax
%     }%
%   \item[\hskip\labelsep\scshape\abstractname.]%
% }{%
%   \endlist\egroup
%   \ifx\@setabstract\relax \@setabstracta \fi
% }
% \def\@setabstract{\@setabstracta \global\let\@setabstract\relax}
% \def\@setabstracta{%
%   \ifvoid\abstractbox
%   \else
%     \skip@20\p@ \advance\skip@-\lastskip
%     \advance\skip@-\baselineskip \vskip\skip@
%     \box\abstractbox
%     \prevdepth\z@ % because \abstractbox is a vtop
%   \fi
% }
%%%
% \newbox\altabstractbox
% \newenvironment{altabstract}{%
%   \ifx\maketitle\relax
%     \ClassWarning{\@classname}{Abstract should precede
%       \protect\maketitle\space in AMS documentclasses; reported}%
%   \fi
%   \global\setbox\altabstractbox=\vtop \bgroup
%   \normalfont\Small
%   \Small
%   \list{}{\labelwidth\z@
%     \leftmargin3pc \rightmargin\leftmargin
%     \listparindent\normalparindent \itemindent\z@
%     \parsep\z@ \@plus\p@
%     \let\fullwidthdisplay\relax
%     }%
%   \item[\hskip\labelsep\scshape\altabstractname.]%
% }{%
%   \endlist\egroup
%   \ifx\@setaltabstract\relax \@setaltabstracta \fi
% }
% \def\@setaltabstract{\@setaltabstracta \global\let\@setaltabstract\relax}
% \def\@setaltabstracta{%
%   \ifvoid\altabstractbox
%   \else
%     \skip@20\p@ \advance\skip@-\lastskip
%     \advance\skip@-\baselineskip \vskip\skip@
%     \box\altabstractbox
%     \prevdepth\z@ % because \altabstractbox is a vtop
%   \fi
% }
%%%
\def\titlepage{%
  \clearpage
  \thispagestyle{empty}\setcounter{page}{0}}
\def\endtitlepage{\newpage}
\def\labelenumi{\theenumi.}
\def\theenumi{\@arabic\c@enumi}
\def\labelenumii{(\theenumii)}
\def\theenumii{\@alph\c@enumii}
\def\p@enumii{\theenumi}
\def\labelenumiii{(\theenumiii)}
\def\theenumiii{\@roman\c@enumiii}
\def\p@enumiii{\theenumi(\theenumii)}
\def\labelenumiv{(\theenumiv)}
\def\theenumiv{\@Alph\c@enumiv}
\def\p@enumiv{\p@enumiii\theenumiii}
% \def\labelitemi{$\m@th\bullet$}
\def\labelitemi{---}
\def\labelitemii{\bfseries --}% \upshape already done by \itemize
\def\labelitemiii{$\m@th\ast$}
\def\labelitemiv{$\m@th\cdot$}
% \newenvironment{verse}{\let\\\@centercr
%   \list{}{\itemsep\z@ \itemindent -1.5em\listparindent\itemindent
%   \rightmargin\leftmargin \advance\leftmargin 1.5em}\item[]%
% }{%
%   \endlist
% }
\let\endverse=\endlist % for efficiency
% \newenvironment{quotation}{\list{}{%
%     \leftmargin3pc \listparindent\normalparindent
%     \itemindent\z@
%     \rightmargin\leftmargin \parsep\z@ \@plus\p@}%
%   \item[]%
% }{%
%   \endlist
% }
% \let\endquotation=\endlist % for efficiency
% \newenvironment{quote}{%
%   \list{}{\rightmargin\leftmargin}\item[]%
% }{%
%   \endlist
% }
% \let\endquote=\endlist % for efficiency
\def\trivlist{\parsep\parskip\@nmbrlistfalse
  \@trivlist \labelwidth\z@ \leftmargin\z@
  \itemindent\z@
  \let\@itemlabel\@empty
  \def\makelabel##1{\upshape##1}}
%\renewenvironment{enumerate}{%
%  \ifnum \@enumdepth >3 \@toodeep\else
%      \advance\@enumdepth \@ne
%      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
%      {\csname label\@enumctr\endcsname}{\usecounter
%        {\@enumctr}\def\makelabel##1{\hss\llap{\upshape##1}}}\fi
%}{%
%  \endlist
%}
%\let\endenumerate=\endlist % for efficiency
%\renewenvironment{itemize}{%
%%  \itemindent=0pt
%  \leftmargini=2em
%  \ifnum\@itemdepth>3 \@toodeep
%  \else \advance\@itemdepth\@ne
%    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
%    \list{\csname\@itemitem\endcsname}%
%      {\def\makelabel##1{\hss\llap{\upshape##1}}}%
%  \fi
%}{%
%  \endlist
%}
%\let\enditemize=\endlist % for efficiency
% \newcommand{\descriptionlabel}[1]{\hspace\labelsep \upshape\bfseries #1:}
% \newenvironment{description}{\list{}{%
%   \advance\leftmargini6\p@ \itemindent-12\p@
%   \labelwidth\z@ \let\makelabel\descriptionlabel}%
% }{
%   \endlist
% }
% \let\enddescription=\endlist % for efficiency
%\newenvironment{textenumerate}%
%{
%  \begin{list}%
%  {\paragraphFontShape \arabic{textenumerate}.}%
%  {
%    \usecounter{textenumerate}%
%%     \setlength{\labelsep}{0pt}%
%    \setlength{\leftmargin}{0pt}%
%%     \setlength{\labelwidth}{\parindent}%
%    \setlength{\labelwidth}{0pt}%
%    \setlength{\listparindent}{\parindent}%
%    \setlength{\itemindent}{\parindent}%
%    \setlength{\itemsep}{\medskipamount}%
%  }
%}
%{
%  \end{list}
%} % END textenumerate
\let\upn=\textup
\AtBeginDocument{%
  \settowidth\leftmargini{\labelenumi\hskip\labelsep}%
  \advance\leftmargini by \normalparindent
  \settowidth\leftmarginii{\labelenumii\hskip\labelsep}%
  \advance\leftmarginii by 15pt
  \settowidth\leftmarginiii{\labelenumiii\hskip\labelsep}%
  \advance\leftmarginiii by 12pt
  \settowidth\leftmarginiv{\labelenumiv\hskip\labelsep}%
  \advance\leftmarginiv by 10pt
  \leftmarginv=10pt
  \leftmarginvi=10pt
  \leftmargin=\leftmargini
  \labelsep=5pt
  \labelwidth=\leftmargini \advance\labelwidth-\labelsep
  \@listi}
\newskip\listisep
\listisep\smallskipamount
\def\@listI{\leftmargin\leftmargini \parsep\z@skip
  \topsep\listisep \itemsep\z@skip
  \listparindent\normalparindent}
\let\@listi\@listI
\def\@listii{\leftmargin\leftmarginii
  \labelwidth\leftmarginii \advance\labelwidth-\labelsep
  \topsep\z@skip \parsep\z@skip \partopsep\z@skip \itemsep\z@skip}
\def\@listiii{\leftmargin\leftmarginiii
  \labelwidth\leftmarginiii \advance\labelwidth-\labelsep}
\def\@listiv{\leftmargin\leftmarginiv
  \labelwidth\leftmarginiv \advance\labelwidth-\labelsep}
\def\@listv{\leftmargin\leftmarginv
  \labelwidth\leftmarginv \advance\labelwidth-\labelsep}
\def\@listvi{\leftmargin\leftmarginvi
  \labelwidth\leftmarginvi \advance\labelwidth-\labelsep}
%%%
\def\@startsection#1#2#3#4#5#6{%
  \if@noskipsec \leavevmode \fi
  \par
  \@tempskipa #4\relax
  \@afterindenttrue
  \ifdim \@tempskipa <\z@
    \@tempskipa -\@tempskipa \@afterindentfalse
  \fi
  \if@nobreak
    \everypar{}%
  \else
    \addpenalty\@secpenalty\addvspace\@tempskipa
  \fi
  \@ifstar
    {\@ssect{#3}{#4}{#5}{#6}}%
%     {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
    {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}}
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{%
        \@hangfrom{\hskip #3\relax\@svsec}%
          \interlinepenalty \@M #8\@@par}%
    \endgroup
%    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}
\def\@seccntformat#1{\csname the#1\endcsname.~}
%%%
% \def\@startsection#1#2#3#4#5#6{%
%  \if@noskipsec \leavevmode \fi
%  \par \@tempskipa #4\relax
%  \@afterindenttrue
%  \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \@afterindentfalse\fi
%  \if@nobreak \everypar{}\else
%      \addpenalty\@secpenalty\addvspace\@tempskipa\fi
%  \@ifstar{\@dblarg{\@sect{#1}{\@m}{#3}{#4}{#5}{#6}}}%
%          {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
% }
% \def\@sect#1#2#3#4#5#6[#7]#8{%
%   \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
%   \ifnum #2>\c@secnumdepth \let\@secnumber\@empty
%   \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
%  \ifnum #2>\c@secnumdepth
%    \let\@svsec\@empty
%  \else
%     \refstepcounter{#1}%
%     \edef\@svsec{\ifnum#2<\@m
%        \@ifundefined{#1name}{}{%
%          \ignorespaces\csname #1name\endcsname\space}\fi
%        \@nx\textup{%
%          \csname the#1\endcsname.}\enspace
%     }%
%   \fi
%   \@tempskipa #5\relax
%   \ifdim \@tempskipa>\z@ % the this is not a run-in section heading
%     \begingroup #6\relax
%     \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8\par}%
%     \endgroup
%     \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
%   \else
%   \def\@svsechd{#6\hskip #3\@svsec
%     \@ifnotempty{#8}{\ignorespaces#8\unskip
%        \@addpunct.}%
%     \ifnum#2>\@m \else \@tocwrite{#1}{#8}\fi
%   }%
%   \fi
%   \global\@nobreaktrue
%   \@xsect{#5}}
% \let\@ssect\relax
% \newcounter{part}
% \newcounter{title}
% \newcounter{section}[title]
% \newcounter{subsection}[section]
% \newcounter{subsubsection}[subsection]
% \newcounter{paragraph}[subsubsection]
%%
%%
%% Sections
%%
%% Fonts
%%

\providecommand{\DivFontShape}{\bfseries}

\providecommand{\titleFontShape}{\DivFontShape}
\providecommand{\titleFontSize}{\large}
\providecommand{\titlePosition}{\center}

%\renewcommand{\sectionFontShape}{\scshape}
\renewcommand{\sectionFontSize}{\large}
\renewcommand{\sectionPosition}{\center}
%\renewcommand{\subsectionFontShape}{\scshape}
\renewcommand{\subsectionFontSize}{\normalsize}
\renewcommand{\subsectionPosition}{\center}
%\renewcommand{\subsubsectionFontShape}{\scshape}
\renewcommand{\subsubsectionFontSize}{\normalsize}
\renewcommand{\subsubsectionPosition}{\center}
%%
%\renewcommand{\paragraphFontShape}{\scshape}
\renewcommand{\paragraphFontSize}{\normalsize}
%\renewcommand{\subparagraphFontShape}{\scshape}
\renewcommand{\subparagraphFontSize}{\normalsize}


\renewcommand\thepart          {\arabic{part}}
\renewcommand\thesection       {\arabic{section}}
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection .\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
% \setcounter{secnumdepth}{3}
\setcounter{secnumdepth}{3}
\@addtoreset{equation}{PFUtitle}
\renewcommand\theequation{\@arabic\c@equation}
\def\partname{Part}

\providecommand{\chapaftersnum}{.}
\providecommand{\secaftersnum}{.}

\RequirePackage{titlesec}

\titleformat{\chapter}[block]%
    {\thispagestyle{fancy}\normalfont\chapterFontSize\chapterFontShape}{\ifx\chaptertitlename\@empty\else\chaptertitlename\ \fi\thechapter\chapaftersnum}{0.8\baselineskip}{\chapterFontSize}
\titleformat{\section}[block]%
    {\sectionPosition\normalfont\sectionFontSize\sectionFontShape}{\thesection\secaftersnum}{1em}{}
\titleformat{\subsection}[block]%
    {\subsectionPosition\normalfont\subsectionFontSize\subsectionFontShape}{\thesubsection\secaftersnum}{1em}{}
\titleformat{\subsubsection}[block]%
    {\subsubsectionPosition\normalfont\subsubsectionFontSize\subsubsectionFontShape}{\thesubsubsection\secaftersnum}{1em}{}
\titleformat{\paragraph}[runin]%
    {\normalfont\paragraphFontSize\paragraphFontShape}{\theparagraph\secaftersnum}{1em}{}
\titleformat{\subparagraph}[runin]%
    {\normalfont\subparagraphFontSize\subparagraphFontShape}{\thesubparagraph\secaftersnum}{1em}{}

\titlespacing{\chapter}{\z@}{\z@}{10\p@}
\titlespacing{\section}{\z@}{*4}{*1.5}
% \titlespacing{\section}{\z@}{\if@sectionAfterTitle \z@ \@sectionAfterTitlefalse \else -3.5ex \@plus -1ex \@minus -.2ex \fi}{2.3ex \@plus.2ex}
%\titlespacing{\section}{\z@}{\ifsectionAfterTitle \z@ \else -3.5ex \@plus -1ex \@minus -.2ex \fi}{2.3ex \@plus.2ex}
%\titlespacing{\section}{\z@}{%
%    \ifthenelse{\boolean{sectionAfterTitle}}%
%        {-3.5ex \@plus -1ex \@minus -.2ex}%
%        {\z@ \setboolean{sectionAfterTitle}{false}}%
%    }%
%    {2.3ex \@plus.2ex}

%%%--
% \newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
%                     \thispagestyle{plain}%
%                     \global\@topnum\z@
%                     \@afterindentfalse
%                     \secdef\@chapter\@schapter}
% \def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
%                          \refstepcounter{chapter}%
%                          \typeout{\@chapapp\space\thechapter.}%
%                          \addcontentsline{toc}{chapter}%
%                                    {\protect\numberline{\thechapter}#1}%
%                     \else
%                       \addcontentsline{toc}{chapter}{#1}%
%                     \fi
%                     \chaptermark{#1}%
%                     \addtocontents{lof}{\protect\addvspace{10\p@}}%
%                     \addtocontents{lot}{\protect\addvspace{10\p@}}%
%                     \if@twocolumn
%                       \@topnewpage[\@makechapterhead{#2}]%
%                     \else
%                       \@makechapterhead{#2}%
%                       \@afterheading
%                     \fi}
% \def\@makechapterhead#1{%
%   \vspace*{50\p@}%
%   {\parindent \z@ \raggedright \normalfont
%     \ifnum \c@secnumdepth >\m@ne
%         \huge\bfseries \@chapapp\space \thechapter
%         \par\nobreak
%         \vskip 20\p@
%     \fi
%     \interlinepenalty\@M
%     \Huge \bfseries #1\par\nobreak
%     \vskip 40\p@
%   }}
% \def\@schapter#1{\if@twocolumn
%                    \@topnewpage[\@makeschapterhead{#1}]%
%                  \else
%                    \@makeschapterhead{#1}%
%                    \@afterheading
%                  \fi}
% \def\@makeschapterhead#1{%
%   \vspace*{50\p@}%
%   {\parindent \z@ \raggedright
%     \normalfont
%     \interlinepenalty\@M
%     \Huge \bfseries  #1\par\nobreak
%     \vskip 40\p@
%   }}

%% \renewcommand{\part}[2][]{
%%   \addtocontents{tac}%
%%   {{\vspace{8pt}\protect\noindent\protect\Large\protect\bfseries{#1}%
%%       \vspace{4pt}}}
%%   \addtocontents{toc}%
%%   {{\vspace{8pt}\protect\noindent\protect\Large\protect\bfseries{#2}%
%%       \vspace{4pt}}}
%%   {\interlinepenalty\@M
%%     \begin{center}
%%       \vskip 10\p@ \@plus -1ex \@minus -.2ex
%%       {\Huge \bfseries #2}
%%     \end{center}
%%     \par\nobreak
%%     \vskip 10\p@\@plus -1ex \@minus -.2ex}
%% }
\renewcommand{\part}[2][]%
{%
  {%
    \clearpage
    \vspace*{\baselineskip}
    \interlinepenalty\@M
    \begin{center}
      \vskip 10\p@ \@plus -1ex \@minus -.2ex
      {\LARGE \DivFontShape #2\par}
    \end{center}
    \par\nobreak
    \vskip 10\p@\@plus -1ex \@minus -.2ex%
  }
  \addtocontents{tac}%
  {{\vspace{8dd}\protect\noindent\protect\raggedright\protect\protect\Large\DivFontShape{#1}%
      \@par%
      \vspace{4dd}}}
  \addtocontents{toc}%
  {{\vspace{8dd}\protect\noindent\protect\raggedright\protect\protect\Large\DivFontShape{#2}%
      \@par%
      \vspace{4dd}}}
}

% \newcommand\part{\@ssect           {\z@}%
%                                    %{-3.5ex \@plus -1ex \@minus -.2ex}%
%                                    {-2.5ex \@plus -0.5ex \@minus -.2ex}%
%                                    %{2.3ex \@plus.2ex}%
%                                    {1em}%
%                                    {\center\normalfont\Huge\scshape}}

%% \renewcommand{\section}%
%% {%
%%   \@startsection {section}{1}{\z@}%
%% %  {-3.5ex \@plus -1ex \@minus -.2ex}%
%%   {-2.5ex \@plus -0.5ex \@minus -.2ex}%
%% %  {2.3ex \@plus.2ex}%
%%   {1em}%
%%   {\center\normalfont\sectionFontSize\sectionFontShape}%
%% } % END \section
%% \renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
%%                                      {-3.25ex\@plus -1ex \@minus -.2ex}%
%%                                      {1.5ex \@plus .2ex}%
%%                                      {\subsectionfont}}
%% \renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
%%                                      {-3.25ex\@plus -1ex \@minus -.2ex}%
%%                                      {1.5ex \@plus .2ex}%
%%                                      {\normalfont\normalsize\bfseries}}
%% \renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
%%                                     {3.25ex \@plus1ex \@minus.2ex}%
%%                                     {-1em}%
%%                                     {\normalfont\normalsize\bfseries}}
%% \renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
%%                                        {3.25ex \@plus1ex \@minus .2ex}%
%%                                        {-1em}%
%%                                       {\normalfont\normalsize\bfseries}}
%%%
% \def\part{\@startsection{part}{0}%
%   \z@{\linespacing\@plus\linespacing}{.5\linespacing}%
%   {\normalfont\bfseries\raggedright}}
% \def\specialsection{\@startsection{section}{1}%
%   \z@{2\linespacing\@plus\linespacing}{.5\linespacing}%
%   {\huge\scshape\centering}}
% \def\section{\@startsection{section}{1}%
%   \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
%   {\normalfont\bfseries\centering}}
% %%%--
% \def\section*{\@startsection{section}{1}%
%   \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
%   {\normalfont\bfseries\centering}}
% %%%
% \def\subsection{\@startsection{subsection}{2}%
%   \normalparindent{.5\linespacing\@plus.7\linespacing}{-.5em}%
%   {\normalfont\bfseries}}
% \def\subsubsection{\@startsection{subsubsection}{3}%
%   \normalparindent\z@{-.5em}%
%   {\normalfont\itshape}}
% \def\paragraph{\@startsection{paragraph}{4}%
%   \normalparindent\z@{-\fontdimen2\font}%
%   \normalfont}
% \def\subparagraph{\@startsection{subparagraph}{5}%
%   \z@\z@{-\fontdimen2\font}%
%   \normalfont}
% \def\appendix{\par\c@section\z@ \c@subsection\z@
%    \let\sectionname\appendixname
%    \def\thesection{\@Alph\c@section}}
\def\appendixname{Appendix}
\def\@Roman#1{\@xp\@slowromancap
  \romannumeral#1@}%
\def\@slowromancap#1{\ifx @#1% then terminate
  \else
    \if i#1I\else\if v#1V\else\if x#1X\else\if l#1L\else\if
    c#1C\else\if m#1M\else#1\fi\fi\fi\fi\fi\fi
    \@xp\@slowromancap
  \fi
}
\def\aufm#1{\par\vspace*{12pt}{\flushright #1\par}}
\renewcommand{\@pnumwidth}{1.6em}
\renewcommand{\@tocrmarg}{2.6em}
\setcounter{tocdepth}{0}
\def\@starttoc#1{%
  \begingroup
  %% \toc@pre
    \makeatletter
    \@input{\jobname.#1}%
    \if@filesw
      \expandafter\newwrite\csname tf@#1\endcsname
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax
    \fi
    \@nobreakfalse
%%     \toc@post
  \endgroup
}%
% \def\@starttoc#1#2{\begingroup
%   \par\removelastskip\vskip\z@skip
%   \@startsection{}\@M\z@{\linespacing\@plus\linespacing}%
%     {.5\linespacing}{\centering\scshape}{#2}%
%   \ifx\contentsname#2%
%   \else \addcontentsline{toc}{section}{#2}\fi
%   \makeatletter
%   \@input{\jobname.#1}%
%   \if@filesw
%     \@xp\newwrite\csname tf@#1\endcsname
%     \immediate\@xp\openout\csname tf@#1\endcsname \jobname.#1\relax
%   \fi
%   \global\@nobreakfalse \endgroup
%   \addvspace{32\p@\@plus14\p@}%
%   \let\tableofcontents\relax
% }
\def\contentsname{Contents}
\def\altcontentsname{Contents}
\def\listfigurename{List of Figures}
\def\listtablename{List of Tables}
%%
\def\listaltname{List of Articles}
%%
%%%--
% \newcommand\@pnumwidth{1.55em}
% \newcommand\@tocrmarg{2.55em}
\renewcommand\@dotsep{4.5}
% \setcounter{tocdepth}{2}

\renewcommand{\tableofcontents}{%
  \tableofcontents@hook
  % \if@twocolumn
  %   \@restonecoltrue\onecolumn
  % \else
  %   \@restonecolfalse
  % \fi
  % \section*{\flushleft\textbf{\contentsname}}
  \vspace*{\baselineskip}
  {\contentsnamePosition\contentsnameFontShape\contentsnameFontSize\contentsname}%
  \par\nobreak%
  \vskip 1ex \@plus -1ex \@minus -.2ex%
  % \@mkboth{%
  % \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
  \@starttoc{toc}%
  % \if@restonecol\twocolumn\fi
  \raggedbottom\relax
  % \clearpage
}

\def\tableofcontents@hook{\global\let\tableofcontents@hook\@empty}

% \newcommand\tableofcontents{%
%     \if@twocolumn
%       \@restonecoltrue\onecolumn
%     \else
%       \@restonecolfalse
%     \fi
%     \section*{\flushleft\textbf{\contentsname}
%    \section*{\flushleft\textbf{\so{\contentsname}}}
%         \@mkboth{%
%            \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
%     \@starttoc{toc}%
%     \if@restonecol\twocolumn\fi
%     \clearpage
%     }
%%%--
\newcommand{\tableofaltcontents}{%
  \tableofaltcontents@hook
%     \if@twocolumn
%       \@restonecoltrue\onecolumn
%     \else
%       \@restonecolfalse
%     \fi
  {\contentsnamePosition\contentsnameFontShape\contentsnameFontSize\altcontentsname}%
    \par\nobreak%
    \vskip 1ex \@plus -1ex \@minus -.2ex%
%     \section*{\flushleft\textbf{\altcontentsname}
%         \@mkboth{%
%            \MakeUppercase\altcontentsname}{\MakeUppercase\altcontentsname}}%
    \@starttoc{tac}%
%     \if@restonecol\twocolumn\fi
    \raggedbottom
%    \clearpage
}

\def\tableofaltcontents@hook{\global\let\tableofaltcontents@hook\@empty}
%%%
%%%
% \def\tableofcontents{\@starttoc{toc}\contentsname
% \@mkboth{%
%     \MakeUppercase\contentsname}{\MakeUppercase\contentsname}
%     \newpage
% }
%\newcommand\tableofcontents{%
%    \if@twocolumn
%      \@restonecoltrue\onecolumn
%    \else
%      \@restonecolfalse
%    \fi
%    \specialsection*{\contentsname
%        \@mkboth{%
%           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
%    \@starttoc{toc}%
%    \if@restonecol\twocolumn\fi
%    }
\def\listoffigures{\@starttoc{lof}\listfigurename}
\def\listoftables{\@starttoc{lot}\listtablename}
%%
\def\listofalts{\@starttoc{alt}\listaltname}
%%
\AtBeginDocument{%
  \@for\@tempa:=-1,0,1,2,3\do{%
    \@ifundefined{r@tocindent\@tempa}{%
      \@xp\gdef\csname r@tocindent\@tempa\endcsname{0pt}}{}%
  }%
}
\def\@writetocindents{%
  \begingroup
  \@for\@tempa:=-1,0,1,2,3\do{%
    \let\protect\@unexpandable@protect
    \immediate\write\@auxout{%
      \string\newlabel{tocindent\@tempa}{%
        \csname r@tocindent\@tempa\endcsname}}%
  }%
  \endgroup}
\AtEndDocument{\@writetocindents}

\let\indentlabel\@empty
\def\@tochangmeasure#1{\sbox\z@{#1}%
  \ifdim\wd\z@>\csname r@tocindent\@toclevel\endcsname\relax
    \@xp\xdef\csname r@tocindent\@toclevel\endcsname{\the\wd\z@}%
  \fi
}
\def\@toclevel{0}
\def\@tocline#1#2#3#4#5#6#7{\relax
  \ifnum #1>\c@tocdepth % then omit
  \else
    \par \addpenalty\@secpenalty\addvspace{#2}%
    \begingroup \hyphenpenalty\@M
    \@ifempty{#4}{%
      \@tempdima\csname r@tocindent\number#1\endcsname\relax
    }{%
      \@tempdima#4\relax
    }%
    \parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
    \rightskip\@pnumwidth plus1em \parfillskip-\@pnumwidth
    #5\leavevmode\hskip-\@tempdima #6\relax
    \hfil\hbox to\@pnumwidth{\@tocpagenum{#7}}\par
    \nobreak
    \endgroup
  \fi}
\def\@tocpagenum#1{\hss{\mdseries #1}}
\def\@tocwrite#1{\@xp\@tocwriteb\csname toc#1\endcsname{#1}}
\def\@tocwriteb#1#2#3{%
  \begingroup
    \def\@tocline##1##2##3##4##5##6{%
      \ifnum##1>\c@tocdepth
      \else \sbox\z@{##5\let\indentlabel\@tochangmeasure##6}\fi}%
    \csname l@#2\endcsname{#1{\csname#2name\endcsname}{\@secnumber}{}}%
  \endgroup
  \addcontentsline{toc}{#2}%
    {\protect#1{\csname#2name\endcsname}{\@secnumber}{#3}}}
\def\l@section{\@tocline{1}{0pt}{1pc}{}{}}
\newcommand{\tocsection}[3]{%
  \indentlabel{\@ifnotempty{#2}{\ignorespaces#1 #2.\quad}}#3}
\def\l@subsection{\@tocline{2}{0pt}{1pc}{5pc}{}}
\let\tocsubsection\tocsection
\def\l@subsubsection{\@tocline{3}{0pt}{1pc}{7pc}{}}
\let\tocsubsubsection\tocsection
\def\l@part{\@tocline{-1}{12pt plus2pt}{0pt}{}{\DivFontShape}}
%\let\tocpart\tocsection
% \def\l@chapter{\@tocline{0}{8pt plus1pt}{0pt}{}{}}
\def\l@chapter{\@dottedtocline{0}{0pt}{0pt}}
\let\tocchapter\tocsection
\let\tocappendix\tocchapter
\def\l@figure{\@tocline{0}{3pt plus2pt}{0pt}{}{}}
\let\l@table=\l@figure
%%
%%
\def\l@alttitle#1#2{\begin{center}%
 \large
    \bfseries
  #1
  \end{center}%
}
\def\l@altauthors#1#2{%
  \begingroup
  \trivlist
  \centering
  %\fontsize{11}{13\p@}\selectfont\@topsep13\p@\relax
  \normalsize
  \item\relax
   #1
  \endtrivlist
  \endgroup
}
\def\l@altabstracts#1#2{%
  \begingroup
  \trivlist
%  \centering
%\fontsize{11}{13\p@}\selectfont\@topsep13\p@\relax
%  \normalsize
  \footnotesize
  \item\relax
   #1
  \endtrivlist
  \endgroup
  \bigskip
}
%\newbox\altabstractsbox
%\def\l@altabstracts#1#2{%
%  \begingroup
%  \trivlist
%  \footnotesize
%  \leftmargin3pc \rightmargin\leftmargin
%   #1
%   \endtrivlist
%  \endgroup
%  \global\setbox\altabstractsbox=\vtop \bgroup
%  \normalfont\Small
%  \Small
% \list{}{\labelwidth\z@
%    \leftmargin3pc \rightmargin\leftmargin
%    \listparindent\normalparindent \itemindent\z@
%    \parsep\z@ \@plus\p@
%    \let\fullwidthdisplay\relax
%    }%
% \item[\hskip\labelsep\scshape\altabstractname.]%
%}{%
%  \endlist
% \egroup
%  \ifx\@setaltabstract\relax \@setaltabstracta \fi
%    \relax #1
%}
%\def\l@part4alt#1#2{\begin{center}%
% \Large
%    \bfseries
%  #1
%  \end{center}%
%  \bigskip
%}
\def\l@altpart#1#2{\centering{\Large\scshape #1}\bigskip\bigskip}
%\def\l@alttitle#1#2{\centering{\bfseries #1}\par}
%\def\l@altauthors#1#2{#1\par}
\def\l@altabstract#1#2{#1\par}
%\def\l@alttitle{\@tocline{1}{0pt}{1pc}{}{}}
%\def\l@altauthors{\@tocline{1}{0pt}{1pc}{}{}}
%\newcommand{\l@alttitle}[2]{#1}
%\newcommand{\l@altauthors}[2]{#1}
%%
\def\refname{References}
\def\bibname{Bibliography}
%\def\bibliographystyle#1{%
%   \if@filesw\immediate\write\@auxout
%    {\string\bibstyle{#1}}\fi
%        \def\@tempa{#1}%
%        \def\@tempb{amsplain}%
%        \def\@tempc{}%
%        \ifx\@tempa\@tempb
%                \def\@biblabel##1{##1.}%
%                \def\bibsetup{}%
%        \else
%               \def\@biblabel##1{##1.}%
%               \def\bibsetup{}%
%                % \def\bibsetup{\labelsep6\p@}%
%        \ifx\@tempa\@tempc
%                \def\@biblabel##1{}%
%                \def\bibsetup{\labelwidth\z@ \leftmargin24\p@
%                \itemindent-24\p@
%                          \labelsep\z@ }%
%        \fi
%\fi}
%%
%\providecommand{\bibliographystyle}[1]%
%{%
%  \if@filesw\immediate\write\@auxout
%    {\string\bibstyle{#1}}\fi
%        \def\@tempa{#1}%
%        \def\@tempb{amsplain}%
%        \def\@tempc{}%
%        \ifx\@tempa\@tempb
%                \def\@biblabel##1{##1.}%
%                \def\bibsetup{}%
%        \else
%               \def\@biblabel##1{##1.}%
%               \def\bibsetup{}%
%                % \def\bibsetup{\labelsep6\p@}%
%        \ifx\@tempa\@tempc
%                \def\@biblabel##1{}%
%                \def\bibsetup{\labelwidth\z@ \leftmargin24\p@
%                \itemindent-24\p@
%                          \labelsep\z@ }%
%        \fi
%  \fi%
%}

%%%--
\newdimen\bibindent
\setlength\bibindent{1.5em}
\renewenvironment{thebibliography}[1]
{%
  \section*{\refname}%
%         \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
%  }%
    \message{88888}
    \message{\@biblabel{1}}
%  \def\@biblabel#1{#1)))}
  %\xdef\@biblabel#1{\@ifnotempty{#1}{#1.}}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\renewcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
%%%
% \newenvironment{thebibliography}[1]{%
%  \@xp\section\@xp*\@xp{\refname}%
%   \normalfont\footnotesize\labelsep .5em\relax
%   \renewcommand\theenumiv{\arabic{enumiv}}\let\p@enumiv\@empty
%   \list{\@biblabel{\theenumiv}}{\settowidth\labelwidth{\@biblabel{#1}}%
%     \leftmargin\labelwidth \advance\leftmargin\labelsep
%     \usecounter{enumiv}}%
%   \sloppy \clubpenalty\@M \widowpenalty\clubpenalty
%   \sfcode`\.=\@m
% }{%
%   \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
%   \endlist
% }
\def\bysame{\leavevmode\hbox to3em{\hrulefill}\thinspace}
\def\newblock{}
\newcommand\MR[1]{\relax\ifhmode\unskip\spacefactor3000 \space\fi
  \def\@tempa##1:##2:##3\@nil{%
    \ifx @##2\@empty##1\else\textbf{##1:}##2\fi}%
  \MRhref{#1}{MR \@tempa#1:@:\@nil}}
\newcommand\URL{\begingroup
  \def\@sverb##1{%
    \def\@tempa####1##1{\@URL{####1}\egroup\endgroup}%
    \@tempa}%
  \verb}
\let\URLhref\@gobble
\def\@URL#1{\URLhref{#1}#1}
\newif\if@restonecol
\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
  \columnseprule\z@ \columnsep 35\p@
  \twocolumn[\@xp\section\@xp*\@xp{\indexname}]%
%  \thispagestyle{plain}%
  \let\item\@idxitem
  \parindent\z@  \parskip\z@\@plus.3\p@\relax
  \footnotesize}
\def\indexname{Index}
\def\@idxitem{\par\hangindent 2em}
\def\subitem{\par\hangindent 2em\hspace*{1em}}
\def\subsubitem{\par\hangindent 3em\hspace*{2em}}
\def\endtheindex{\if@restonecol\onecolumn\else\clearpage\fi}
\def\indexspace{\par\bigskip}
\def\footnoterule{\kern-.4\p@
        \hrule\@width 5pc\kern11\p@\kern-\footnotesep}
\def\@makefnmark{\hbox{$\m@th^{\@thefnmark}$}}
\def\@makefntext{\indent\@makefnmark}
% \long\def\@footnotetext#1{\insert\footins{%
%   \normalfont\footnotesize
%   \interlinepenalty\interfootnotelinepenalty
%   \splittopskip\footnotesep \splitmaxdepth \dp\strutbox
%   \floatingpenalty\@MM \hsize\columnwidth
%   \@parboxrestore \parindent\normalparindent \sloppy
%   \edef\@currentlabel{\p@footnote\@thefnmark}%
%   \@makefntext{\rule\z@\footnotesep\ignorespaces#1\unskip\strut\par}}}
\hfuzz=1pt \vfuzz=\hfuzz
\def\sloppy{\tolerance9999 \emergencystretch 3em\relax}
% \setcounter{topnumber}{4}
\setcounter{topnumber}{2}
% \setcounter{bottomnumber}{4}
\setcounter{bottomnumber}{2}
% \setcounter{totalnumber}{4}
\setcounter{totalnumber}{2}
% \setcounter{dbltopnumber}{4}
\setcounter{dbltopnumber}{2}
\renewcommand{\topfraction}{.97}
\renewcommand{\bottomfraction}{.97}
\renewcommand{\textfraction}{.03}
\renewcommand{\floatpagefraction}{.9}
\renewcommand{\dbltopfraction}{.97}
\renewcommand{\dblfloatpagefraction}{.9}
% \setlength{\floatsep}{12pt plus 6pt minus 4pt}
\setlength{\floatsep}{8pt plus 4pt minus 2pt}
% \setlength{\textfloatsep}{15pt plus 8pt minus 5pt}
\setlength{\textfloatsep}{8pt plus 4pt minus 2pt}
% \setlength{\intextsep}{12pt plus 6pt minus 4pt}
% \setlength{\dblfloatsep}{12pt plus 6pt minus 4pt}
% \setlength{\dbltextfloatsep}{15pt plus 8pt minus 5pt}
\setlength{\intextsep}{8pt plus 4pt minus 2pt}
\setlength{\dblfloatsep}{8pt plus 4pt minus 2pt}
\setlength{\dbltextfloatsep}{8pt plus 4pt minus 2pt}
\setlength{\@fptop}{0pt}% removed ``plus 1fil''
\setlength{\@fpsep}{8pt}% removed ``plus 2fil''
\setlength{\@fpbot}{0pt plus 1fil}
\setlength{\@dblfptop}{0pt}% removed ``plus 1fil''
\setlength{\@dblfpsep}{8pt}% removed ``plus 2fil''
\setlength{\@dblfpbot}{0pt plus 1fil}
% \newcommand{\fps@figure}{tbp}
% \newcommand{\fps@table}{tbp}
% \newcounter{figure}[title]
\def\@captionheadfont{\DivFontShape}
\def\@captionfont{\normalfont}
% \def\@captionfont{\DivFontShape}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\ \thefigure}
\def\figurename{Figure}
% \newenvironment{figure}{%
%   \@float{figure}%
% }{%
%   \end@float
% }
%%%
%%\def\@biblabel#1{#1.......}
%%\RequirePackage{bibunits}
% \RequirePackage{mcolfloat}
% \newenvironment{figure}
%                {\@float{figure}}
%                {\end@float}

\newenvironment{acknowledgments}{%
  % \acknowledgments@sw{%
  \section*{\acknowledgmentsname}%
  % }
  {%
    \par
%    \phantomsection
    \addcontentsline{toc}{section}{\protect\numberline{}\acknowledgmentsname}%
  }%
}
{%
  \par
}%
% \@booleantrue\acknowledgments@sw
% \newenvironment{acknowledgements}{%
%   \replace@environment{acknowledgements}{acknowledgments}%
% }
{%
  \endacknowledgments
}%

%%%
%%% Captions
%%%

% \captionsetup{font={sc,footnotesize}}
\captionsetup{font={small}}

\DeclareCaptionFormat{tableRight}{\hfill#1\newline#2#3\par}

\captionsetup[figure]{labelsep=period,position=bottom,justification=centering}

\captionsetup[table]{format=tableRight,labelsep=none,position=top,justification=centering}
% textfont=bf,

%\newcommand{\captionLabelFontShape}{\scshape}
%\newcommand{\captionLabelFontSize}{\footnotesize}
%\newcommand{\captionFontShape}{\bfseries}
%\newcommand{\captionFontSize}{\footnotesize}
%\newcommand{\captionPosition}{\center}


%\renewcommand{\captionlabelfont}{\captionLabelFontSize\captionLabelFontShape}
%\renewcommand{\captionfont}{\captionFontSize\captionFontShape\captionPosition}
%\renewcommand{\captionsize}{\captionFontSize}


%\def\@captionsize{\small}
%\def\@tablecaptionsize{\captionsize}
%\def\@figurecaptionsize{\captionsize}


%\newcaptionstyle{table_right}{%
%  \renewcommand{\captionlabeldelim}{}
%  \usecaptionmargin\captionfont\@figurecaptionsize%
%  {\captionsize\flushright\captionlabelfont\captionlabel\captionlabeldelim\par}
%  \onelinecaption{\captiontext}{\captiontext}
%}


%\newcaptionstyle{table_right}{%
%  \renewcommand{\captionlabeldelim}{}
%  \usecaptionmargin%
%  {\flushright\captionlabelfont\captionlabel\captionlabeldelim\par}
%  \captionfont%
%  \onelinecaption{\captiontext}{\captiontext}
%}
%\renewcaptionstyle{longtable}{%
%  \renewcommand{\captionlabeldelim}{}
%  \usecaptionmargin%
%  {\flushright\captionlabelfont\captionlabel\captionlabeldelim\par}
%  \captionfont
%  \onelinecaption{\captiontext}{\captiontext}
%  }

% \newenvironment{figure}
%                {\@mfloat{figure}}
%                {\end@mfloat}
% %
% \newenvironment{@mfloat}[1]
%              { \def\@captype{#1}%
%                \vspace{\textfloatsep}
%                \noindent\begin{minipage}{\columnwidth}}
%                {\end{minipage}
%                \vspace{\textfloatsep}
%                }
% \newenvironment{figure*}
%                {\@dblfloat{figure}}
%                {\end@dblfloat}
%%%

%%%
%%% Subfigures
%%%

%\RequirePackage{subfig}
%\def\subfigure{\subfloat}

% \InputIfFileExists{pfuproc/caption_explane.cli}{}{}%

% Author index
\InputIfFileExists{kproc/authorindex.cli}{}{}%


% \newcounter{table}[title]
\def\ftype@table{2}
\def\ext@table{lot}
\renewcommand\fnum@table{\tablename\ \thetable}
\def\tablename{Table}
%\renewenvironment{table}{%
%  \captionstyle{table_right}%
%  \@float{table}%
%}{%
%  \end@float
%}
%\renewenvironment{table*}{%
%  \captionstyle{table_right}%
%  \@dblfloat{table}%
%}{%
%  \end@dblfloat
%}
\def\@floatboxreset{\global\@minipagefalse \centering}
%%%--
% \long\def\@makecaption#1#2{%
%   \setbox\@tempboxa\vbox{\color@setgroup
%     \advance\hsize-2\captionindent\noindent
%     \@captionfont\@captionheadfont#1\@xp\@ifnotempty\@xp
%         {\@cdr#2\@nil}{.\@captionfont\upshape\enspace#2}%
%     \unskip\kern-2\captionindent\par
%     \global\setbox\@ne\lastbox\color@endgroup}%
%   \ifhbox\@ne % the normal case
%     \setbox\@ne\hbox{\unhbox\@ne\unskip\unskip\unpenalty\unkern}%
%   \fi
%   \ifdim\wd\@tempboxa=\z@ % this means caption will fit on one line
%     \setbox\@ne\hbox to\columnwidth{\hss\kern-2\captionindent\box\@ne\hss}%
%   \else % tempboxa contained more than one line
%     \setbox\@ne\vbox{\unvbox\@tempboxa\parskip\z@skip
%         \noindent\unhbox\@ne\advance\hsize-2\captionindent\par}%
% \fi
%   \ifnum\@tempcnta<64 % if the float IS a figure...
%     \addvspace\abovecaptionskip
%     \moveright\captionindent\box\@ne
%   \else % if the float IS NOT a figure...
%     \moveright\captionindent\box\@ne
%     \nobreak
%     \vskip\belowcaptionskip
%   \fi
% \relax
% }
%%%
\newskip\abovecaptionskip \abovecaptionskip=12pt \relax
\newskip\belowcaptionskip \belowcaptionskip=12pt \relax
% \newskip\abovecaptionskip \abovecaptionskip=2em \relax
% \newskip\belowcaptionskip \belowcaptionskip=-1em \relax
% \newdimen\captionindent \captionindent=3pc
\newdimen\captionindent \captionindent=0pt
% \RequirePackage{amsthm}[1996/09/24]
\def\@swapped#1#2{#2%
  \@ifnotempty{#1}{\@addpunct{.}\quad#1\unskip}}
\def\thmhead@plain#1#2#3{%
  \thmname{#1}\thmnumber{\@ifnotempty{#1}{ }\@upn{#2}}%
  \thmnote{ \textmd{\upshape(#3)}}}
\def\swappedhead@plain#1#2#3{%
  \thmnumber{\@upn{#2}}\thmname{\@ifnotempty{#2}{. }#1}%
  \thmnote{ \textmd{\upshape(#3)}}}
%\def\th@plain{%
%  \let\thm@indent\indent
%  \thm@headfont{\scshape}% heading font small caps
%  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
%  \thm@preskip.5\baselineskip\@plus.2\baselineskip
%                                    \@minus.2\baselineskip
%  \thm@postskip\thm@preskip
%  \itshape
%}
%\def\th@definition{%
%  \let\thm@indent\indent
%  \thm@headfont{\scshape}% heading font small caps
%  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
%  \thm@preskip.5\baselineskip\@plus.2\baselineskip
%                                    \@minus.2\baselineskip
%  \thm@postskip\thm@preskip
%  \upshape
%}
%\def\th@remark{%
%  \let\thm@indent\indent
%  \thm@headfont{\scshape}% heading font small caps
%  \let\thmhead\thmhead@plain \let\swappedhead\swappedhead@plain
%  \thm@preskip.5\baselineskip\@plus.2\baselineskip
%                                    \@minus.2\baselineskip
%  \thm@postskip\thm@preskip
%  \upshape
%}
%\renewenvironment{proof}[1][\proofname]{\par \normalfont
%  \topsep6\p@\@plus6\p@ \trivlist \itemindent\normalparindent
%  \item[\hskip\labelsep\scshape
%    #1\@addpunct{.}]\ignorespaces
%}{%
%  \qed\endtrivlist
%}
%\if@compatibility
%\let\@newpf\proof \let\proof\relax \let\endproof\relax
%\newenvironment{pf}{\@newpf[\proofname]}{\qed\endtrivlist}
%\newenvironment{pf*}[1]{\@newpf[#1]}{\qed\endtrivlist}
%\fi
\def\nonbreakingspace{\unskip\nobreak\ \ignorespaces}
\def~{\protect\nonbreakingspace}
% \def\@biblabel#1{\@ifnotempty{#1}{[#1]}}
%% \global\def\@biblabel#1{\@ifnotempty{#1}{#1.}}
\def\@cite#1#2{{%
 \m@th\upshape\mdseries[{\bfseries #1}{\if@tempswa, #2\fi}]}}
\@ifundefined{cite }{%
  \expandafter\let\csname cite \endcsname\cite
  \edef\cite{\@nx\protect\@xp\@nx\csname cite \endcsname}%
}{}
\def\fullwidthdisplay{\displayindent\z@ \displaywidth\columnwidth}
\edef\@tempa{\noexpand\fullwidthdisplay\the\everydisplay}
\everydisplay\expandafter{\@tempa}
\providecommand\seename{see also}%
\providecommand\see[2]{{\em \seename\/} #1}%
%\newcommand\printindex{\@input{\jobname.ind}}%
\DeclareRobustCommand{\@biblabel}[1]{#1.\hfill}%
\DeclareRobustCommand\textprime{\leavevmode
  \raise.8ex\hbox{\check@mathfonts\the\scriptfont2 \char48 }}
\hyphenation{acad-e-my acad-e-mies af-ter-thought anom-aly anom-alies
an-ti-deriv-a-tive an-tin-o-my an-tin-o-mies apoth-e-o-ses
apoth-e-o-sis ap-pen-dix ar-che-typ-al as-sign-a-ble as-sist-ant-ship
as-ymp-tot-ic asyn-chro-nous at-trib-uted at-trib-ut-able bank-rupt
bank-rupt-cy bi-dif-fer-en-tial blue-print busier busiest
cat-a-stroph-ic cat-a-stroph-i-cally con-gress cross-hatched data-base
de-fin-i-tive de-riv-a-tive dis-trib-ute dri-ver dri-vers eco-nom-ics
econ-o-mist elit-ist equi-vari-ant ex-quis-ite ex-tra-or-di-nary
flow-chart for-mi-da-ble forth-right friv-o-lous ge-o-des-ic
ge-o-det-ic geo-met-ric griev-ance griev-ous griev-ous-ly
hexa-dec-i-mal ho-lo-no-my ho-mo-thetic ideals idio-syn-crasy
in-fin-ite-ly in-fin-i-tes-i-mal ir-rev-o-ca-ble key-stroke
lam-en-ta-ble light-weight mal-a-prop-ism man-u-script mar-gin-al
meta-bol-ic me-tab-o-lism meta-lan-guage me-trop-o-lis
met-ro-pol-i-tan mi-nut-est mol-e-cule mono-chrome mono-pole
mo-nop-oly mono-spline mo-not-o-nous mul-ti-fac-eted mul-ti-plic-able
non-euclid-ean non-iso-mor-phic non-smooth par-a-digm par-a-bol-ic
pa-rab-o-loid pa-ram-e-trize para-mount pen-ta-gon phe-nom-e-non
post-script pre-am-ble pro-ce-dur-al pro-hib-i-tive pro-hib-i-tive-ly
pseu-do-dif-fer-en-tial pseu-do-fi-nite pseu-do-nym qua-drat-ic
quad-ra-ture qua-si-smooth qua-si-sta-tion-ary qua-si-tri-an-gu-lar
quin-tes-sence quin-tes-sen-tial re-arrange-ment rec-tan-gle
ret-ri-bu-tion retro-fit retro-fit-ted right-eous right-eous-ness
ro-bot ro-bot-ics sched-ul-ing se-mes-ter semi-def-i-nite
semi-ho-mo-thet-ic set-up se-vere-ly side-step sov-er-eign spe-cious
spher-oid spher-oid-al star-tling star-tling-ly sta-tis-tics
sto-chas-tic straight-est strange-ness strat-a-gem strong-hold
sum-ma-ble symp-to-matic syn-chro-nous topo-graph-i-cal tra-vers-a-ble
tra-ver-sal tra-ver-sals treach-ery turn-around un-at-tached
un-err-ing-ly white-space wide-spread wing-spread wretch-ed
wretch-ed-ly Eng-lish Euler-ian Feb-ru-ary Gauss-ian
Hamil-ton-ian Her-mit-ian Jan-u-ary Japan-ese Kor-te-weg
Le-gendre Mar-kov-ian Noe-ther-ian No-vem-ber Rie-mann-ian Sep-tem-ber}
\def\calclayout{%
  \advance\textheight -\headheight
  \advance\textheight -\headsep
  \oddsidemargin\paperwidth
  \advance\oddsidemargin -\textwidth
  \divide\oddsidemargin\tw@
  \ifdim\oddsidemargin<.5truein \oddsidemargin.5truein \fi
  \advance\oddsidemargin -1truein
  \evensidemargin\oddsidemargin
  \topmargin\paperheight \advance\topmargin -\textheight
  \advance\topmargin -\headheight \advance\topmargin -\headsep
  \divide\topmargin\tw@
  \ifdim\topmargin<.5truein \topmargin.5truein \fi
  \advance\topmargin -1truein\relax
}
% \calclayout % initialize
\pagenumbering{arabic}
\pagestyle{headings}
%\thispagestyle{plain}
\if@compatibility \else\endinput\fi
\def\tiny{\Tiny}
\def\defaultfont{\normalfont}
\def\rom{\textup}
\endinput
%%
%% End of file `pfuproc.cls'.

%%% Local Variables:
%%% coding: utf-8-unix
%%% End:
