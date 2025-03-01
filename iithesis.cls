% Klasa iithesis sluzy do skladu prac dyplomowych w Instytucie Informatyki UWr.
%%%%% OPCJE KLASY
% polish (domyslnie), english - okresla jezyk pracy
% longabstract (domyslnie), shortabstract - okresla, czy streszczenia w obu
%     jezykach maja zostac zlozone na osobnych stronach (longabstract), czy na
%     jednej (shortabstract); te druga opcje nalezy wybierac tylko wtedy, gdy
%     streszczenia sa dostatecznie krotkie
% declaration - okresla, czy na drugiej stronie pracy ma zostac zlozone
%     oswiadczenie o autorskim wykonaniu pracy; domyslnie nie jest skladane,
%     nie ma tez wiekszego sensu przy pracy kilku autorow
% lic (domyslnie), inz, mgr - okresla rodzaj pracy podany na stronie tytulowej;
%     w przypadku podania opcji 'declaration' rowniez automatycznie okresla
%     stopien studiow (I dla 'lic'/'inz', II dla 'mgr') podawany w oswiadczeniu
% fem, masc - w przypadku podania opcji 'declaration' okresla, czy powinny
%     zostac uzyte zenskie czy meskie formy czasownikow; jesli nie zostanie
%     wybrana zadna z nich, uzywana jest koncowka 'am/em'
% manyadvisors - wymusza uzycie liczby mnogiej slowa 'promotor', jesli praca
%     ma kilku promotorow
%
%%%%% POLECENIA DOSTARCZANE PRZEZ KLASE
% \polishtitle, \englishtitle - sluza, podobnie jak tradycyjne \title, do
%     zadeklarowania tytulow pracy w obu jezykach; \title nie ma zadnego efektu
% \polishabstract, \englishabstract - analogicznie sluza do zadeklarowania
%     streszczen pracy w obu jezykach
% \advisor - sluzy do zadeklarowania nazwiska promotora
% \fmlinebreak - sluzy do lamania linii w obrebie \polishtitle, \englishtitle
%     oraz \advisor (w tym przypadku np. do podania kilku promotorow i/lub ich
%     afiliacji, jesli sa inne niz II UWr)
%
%%%   Dwa kolejne polecenia maja znaczenie tylko z opcja 'declaration' i sluza
%%%   do zadeklarowania napisow pojawiajacych sie w tresci oswiadczenia. Jesli
%%%   zostana pominiete, w oswiadczeniu pojawia sie wykropkowane miejsca do
%%%   pisemnego wypelnienia.
% \transcriptnum - sluzy do zadeklarowania numeru indeksu
% \advisorgen - sluzy do zadeklarowania nazwiska promotora w dopelniaczu; w
%     przypadku kilku nazwisk nalezy je oddzielac przecinkami i spojnikami
%%%   (Wrazliwe dane osobowe, takie jak adresy i nr ewidencyjny PESEL, nie sa
%%%   podawane w wersji elektronicznej pracy dyplomowej i musza w oswiadczeniu
%%%   wypelnione pisemnie.)
%
%%%%% PRZYKLADY: WIELU AUTOROW/PROMOTOROW, W TYM Z AFILIACJAMI/ADNOTACJAMI
% \author{Maksymilian Debesciak \and
%     Karol Sasiedzki \fmlinebreak
%     WPPT PWr}
% \advisor{dr Jan Kowalski \and
%     prof. Janina Nowak \fmlinebreak
%     Instytut Informatyki \fmlinebreak
%     Uniwersytet Jagielloński \fmlinebreak
%     (promotor pomocniczy)}
%
%%%%% PAKIETY WYMAGANE I DOLACZANE PRZEZ KLASE
% babel, geometry, fontenc, hyperref, ifthen, titling
% indentfirst, polski (jezeli iithesis zaladowano z opcja 'polish')
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iithesis}

\LoadClass[a4paper,11pt,onecolumn,twoside,openright,titlepage]{report}

\RequirePackage{ifthen}
\newboolean{Long@Abstract}
\newboolean{Polish@Main}
\newboolean{Decl@ration}
\setboolean{Decl@ration}{false}
\newboolean{Many@Advisors}
\setboolean{Many@Advisors}{false}
\newcommand \@thesislevel {}
\newcommand \@studydegree {I}

\newcommand \@polishtitle        {\ClassWarningNoLine{iithesis}{No \noexpand\polishtitle given}}
\newcommand \@englishtitle       {\ClassWarningNoLine{iithesis}{No \noexpand\englishtitle given}}
\newcommand \@polishabstract     {\ClassWarningNoLine{iithesis}{No \noexpand\polishabstract given}}
\newcommand \@englishabstract    {\ClassWarningNoLine{iithesis}{No \noexpand\englishabstract given}}
\newcommand \@advisor            {\ClassWarningNoLine{iithesis}{No \noexpand\advisor given}}
\newcommand \@email              {\ClassWarningNoLine{iithesis}{No \noexpand\email given}}
\newcommand \@transcriptnum      {\ClassWarningNoLine{iithesis}{No \noexpand\transcriptnum given}\dotfill\str@t}
\newcommand \@advisorgen     [1] {\ClassWarningNoLine{iithesis}{No \noexpand\advisorgen given}\dotfill\str@t\\\null\dotfill\str@t\\}
\newcommand \@gendersuffix       {em/am}
\let\old@title\title
\renewcommand \title         [1] {\ClassWarningNoLine{iithesis}{\noexpand\title ignored}}
\newcommand \polishtitle     [1] {\gdef\@polishtitle{#1}}
\newcommand \englishtitle    [1] {\gdef\@englishtitle{#1}}
\newcommand \polishabstract  [1] {\gdef\@polishabstract{#1}}
\newcommand \englishabstract [1] {\gdef\@englishabstract{#1}}
\newcommand \advisor         [1] {\gdef\@advisor{#1}}
\newcommand \transcriptnum   [1] {\gdef\@transcriptnum{#1}}
\newcommand \advisorgen      [1] {\gdef\@advisorgen{#1}}

\DeclareOption{polish}       {\setboolean{Polish@Main}{true} \PassOptionsToPackage{polish,english}{babel}}
\DeclareOption{english}      {\setboolean{Polish@Main}{false}\PassOptionsToPackage{english,polish}{babel}}
\DeclareOption{lic}          {\renewcommand \@thesislevel {licencjacka}}
\DeclareOption{inz}          {\renewcommand \@thesislevel {in\.zynierska}}
\DeclareOption{mgr}          {\renewcommand \@thesislevel {magisterska} \renewcommand \@studydegree {II}}
\DeclareOption{longabstract} {\setboolean{Long@Abstract} {true} }
\DeclareOption{shortabstract}{\setboolean{Long@Abstract} {false}}
\DeclareOption{declaration}  {\setboolean{Decl@ration}{true}}
\DeclareOption{fem}          {\renewcommand \@gendersuffix {am}}
\DeclareOption{masc}         {\renewcommand \@gendersuffix {em}}
\DeclareOption{manyadvisors} {\setboolean{Many@Advisors} {true}}

\DeclareOption*{\ClassWarningNoLine{iithesis}{Unknown option `\CurrentOption'}}

\ExecuteOptions{polish,lic,longabstract}
\ProcessOptions\relax

\RequirePackage[OT4]{fontenc}
\RequirePackage{babel,titling,geometry}
\geometry{margin=3cm,bindingoffset=1cm,a4paper,onecolumn,twoside}

\pagestyle{headings}

\newcommand \if@pol  [2] {\ifthenelse{\boolean{Polish@Main}  }{#1}{#2}}
\newcommand \if@long [2] {\ifthenelse{\boolean{Long@Abstract}}{#1}{#2}}
\newcommand \if@many [2] {\ifthenelse{\boolean{Many@Advisors}}{#1}{#2}}

% Dodatkowa polonizacja
\if@pol{
  \RequirePackage{indentfirst,polski}
  % Kropka po numerach jednostek struktury
  \renewcommand \thechapter       {\arabic{chapter}.}
  \renewcommand \thesection       {\thechapter \arabic{section}.}
  \renewcommand \thesubsection    {\thesection \arabic{subsection}.}
  \renewcommand \thesubsubsection {\thesubsection \arabic{subsubsection}.}
  \renewcommand \chaptermark  [1] {\markboth{\MakeUppercase{\chaptername\ \thechapter{} #1}}{}}
  \renewcommand \sectionmark  [1] {\markright{\MakeUppercase{\thesection{} #1}}{}}
  \renewcommand \theequation      {\ifnum \c@chapter>\z@ \thechapter\fi \@arabic\c@equation}
  \renewcommand \thefigure        {\ifnum \c@chapter>\z@ \thechapter\fi \@arabic\c@figure}
  \renewcommand \thetable         {\ifnum \c@chapter>\z@ \thechapter\fi \@arabic\c@table}
  \renewcommand \appendix {\par
    \setcounter{chapter}{0}
    \setcounter{section}{0}
    \gdef \@chapapp   {\appendixname}
    \gdef \thechapter {\@Alph\c@chapter}
    % Poprawki w 'dodatkach'
    \renewcommand \thesection      {\thechapter.\arabic{section}.}
    \renewcommand \chaptermark [1] {\markboth{\MakeUppercase{\appendixname\ \thechapter. ##1}}{}}
  }
  % Sterowanie lamaniem stron
  \brokenpenalty=1000
  \clubpenalty=1000
  \widowpenalty=1000
}{}

% Bibliografia pojawia sie jako nienumerowany rozdzial w spisie tresci
\renewenvironment{thebibliography}[1]
 {\chapter*{\bibname}%
  \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
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
  \sfcode`\.\@m%
  \addcontentsline{toc}{chapter}{\bibname}}
 {\def\@noitemerr
   {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}

% Strona tytulowa oraz abstrakty nie resetuja numeracji stron
\renewenvironment {titlepage} {
  \if@twocolumn \@restonecoltrue \onecolumn
  \else \@restonecolfalse \newpage \fi
  \thispagestyle{empty}
}{\if@restonecol \twocolumn \else \newpage \fi}

% Puste strony przed nowymi rozdzialami calkowicie puste, tj. bez naglowkow
\def \cleardoublepage {
  \clearpage
  \if@twoside
    \ifodd \c@page
    \else \hbox{} \thispagestyle{empty} \newpage
      \if@twocolumn \hbox{} \newpage
  \fi \fi \fi
}

\renewcommand \maketitlehookb {
  \vfilneg
  \begin{center}\large
  \if@pol{\selectlanguage{english}(\@englishtitle)}
         {\selectlanguage{polish}(\@polishtitle)}
  \end{center}
  \selectlanguage{polish}
}

\renewcommand \maketitlehookc {
  \vfil
  \begin{center}
  \renewcommand \fmlinebreak {\\ &}
  \renewcommand \and         {\\[0.85em] &}
  \large Praca \@thesislevel\\[0.85em]
  \begin{tabular}[t]{rl}
  \textbf{Promotor\if@many{zy}{}:} & \@advisor
  \end{tabular}\end{center}
  \vfil\vfil\vfil\vfil
  \begin{center}Uniwersytet Wroc\l{}awski\\
  Wydzia\l{} Matematyki i Informatyki\\
  Instytut Informatyki\end{center}
}

\setlength{\parindent}{2em}
\setlength{\parskip}{1.5ex}
\renewcommand \baselinestretch {1.15}

\newcommand \fmlinebreak { }

\newcommand \str@t      {\rule{0em}{1.85em}}
\newcommand \tw@col [1] {\multicolumn{2}{@{}p{20em}}{#1}}

\RequirePackage[pdftex,unicode=true]{hyperref}

\RequirePackage{etoolbox}
\AfterEndPreamble{
  \if@pol{\selectlanguage{polish}\old@title{\bfseries\@polishtitle\mdseries}}
         {\selectlanguage{english}\old@title{\bfseries\@englishtitle\mdseries}}
  \let\old@nd\and
  \renewcommand \and {, }
  \hypersetup{pdfauthor={\@author},pdftitle={\@title} }
  \renewcommand \and \old@nd
  \renewcommand \fmlinebreak {\\}
  \maketitle
  \renewcommand \maketitle {\ClassWarningNoLine{iithesis}{\noexpand\maketitle ignored}}
  \renewcommand \fmlinebreak {, }
  \renewcommand \and {, }
  \ifthenelse{\boolean{Decl@ration}}{
    \selectlanguage{polish}
    \begin{titlepage}\null\vfil
    \begin{tabular}{@{}lll}
    \multicolumn{3}{@{}l}{\@author}\\
    \tw@col{\dotfill\str@t}\\
    \tw@col{\dotfill\str@t}\\
    \multicolumn{2}{c}{\footnotesize{(adres zameldowania)}}\\
    \tw@col{\dotfill\str@t}\\
    \tw@col{\dotfill\str@t}\\
    \multicolumn{2}{c}{\footnotesize{(adres korespondencyjny)}}\\
    PESEL:  & \dotfill\str@t\\
    e-mail: & \dotfill\str@t\\
    \tw@col{Wydzia\l{} Matematyki i~Informatyki\str@t}\\
    \tw@col{stacjonarne studia \@studydegree{} stopnia}\\
    kierunek:  & informatyka\\
    nr albumu: & \@transcriptnum\end{tabular}\vskip 4.5em\par
    \begin{center}\bfseries O\'swiadczenie\\
    o autorskim wykonaniu pracy dyplomowej\end{center}\par
    \frenchspacing Niniejszym o\'swiadczam, \.ze z\l{}o\.zon\k{a} do oceny
    prac\k{e} zatytu\l{}owan\k{a}
    \renewcommand \fmlinebreak { }%
    \emph{\if@pol{\@polishtitle}
      {\selectlanguage{english}\@englishtitle\selectlanguage{polish}}}
    \renewcommand \fmlinebreak {, }%
    wykona\l{}\@gendersuffix{} samodzielnie pod kierunkiem promotor%
    \if@many{\'ow:}{a,} \@advisorgen. O\'swiadczam, \.ze powy\.zsze dane s\k{a}
    zgodne ze stanem faktycznym i~znane mi s\k{a} przepisy ustawy z~dn. 4~lutego
    1994~r. o~prawie autorskim i~prawach pokrewnych (tekst jednolity: Dz.~U.
    z~2006~r. nr 90, poz. 637, z~p\'o\'zniejszymi zmianami) oraz \.ze tre\'s\'c
    pracy dyplomowej przedstawionej do obrony, zawarta na przekazanym no\'sniku
    elektronicznym, jest identyczna z~jej wersj\k{a} drukowan\k{a}.
    \vskip 1.5em\par Wroc\l{}aw, \@date
    \vskip 3em\par\hfill\footnotesize{(czytelny podpis)}\hskip 6em\null
    \par\vfil\null\end{titlepage}
  }{}
  \if@pol {\selectlanguage{polish}}{\selectlanguage{english}}
  \cleardoublepage\begin{abstract}
  \renewcommand \fmlinebreak {\\}\par
  \if@pol {\frenchspacing\@polishabstract}{\noindent\@englishabstract}
  \if@long{\end{abstract}}{\begin{center}\rule[3pt]{300pt}{1pt}\end{center}\par}
  \if@pol {\selectlanguage{english}}{\selectlanguage{polish}}
  \if@long{\clearpage\begin{abstract}\par}{}
  \if@pol {\noindent\@englishabstract\selectlanguage{polish}}
          {\frenchspacing\@polishabstract\selectlanguage{english}}
  \end{abstract}
  \if@long{\if@pol{\selectlanguage{polish}}{\selectlanguage{english}}}{}
  \tableofcontents
}

\endinput