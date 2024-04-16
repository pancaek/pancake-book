\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pancake-book}[2021/09/09 Annotated book class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass{book}

%* Headings
% \RequirePackage{titlesec}
% \titleformat{\chapter}[hang]{\normalfont\Huge}{\chaptertitlename\ \thechapter\hspace{.5em}\vrule width .7pt}{.5em}{}
% \titleformat{\section}[hang]{\normalfont\Large}{\thesection}{.5em}{}
% \titleformat{\subsection}[hang]{\normalfont\large}{\thesubsection}{.5em}{}
% \titleformat{\subsubsection}[hang]{\normalfont\normalsize}{\thesubsubsection}{.5em}{}

%* Header/footer
\RequirePackage{emptypage}

\RequirePackage{fancyhdr}
\pagestyle{fancy}

\fancyhf{}
\renewcommand{\headrulewidth}{.4pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[LE,RO]{\thepage}
\fancyhead[LE]{\nouppercase{\textsc{\leftmark}}}
\fancyhead[RO]{\nouppercase{\rightmark}}

\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyfoot[LE,RO]{\thepage}
}

%* Side notes
\RequirePackage{sidenotes}
\RequirePackage{marginfix}

\setlength{\marginparsep}{2em}
\setlength{\marginparpush}{1em}

\newcommand{\smartragged}{\checkoddpage \ifoddpage\raggedright \else \raggedleft\fi}

\providecommand{\marginaliasize}{\footnotesize}
\DeclareCaptionFont{marginaliasize}{\marginaliasize}
\let\oldmarginpar\marginpar
\def\marginpar#1{\oldmarginpar{\marginaliasize\smartragged #1}}

\DeclareCaptionJustification{smartragged}{\smartragged}

\DeclareCaptionStyle{marginfigure}{font=marginaliasize,justification=smartragged}
\DeclareCaptionStyle{margintable}{font=marginaliasize,justification=smartragged}

\makeatletter
\newcommand{\ifdraft}[2][]{\ifdim\overfullrule>\z@
  \expandafter#2\else\expandafter#1\fi}
\makeatother
\newcommand{\notetoself}[1]{\ifdraft{\sidenote{\color{gray}#1}}}

%* Structure enhancements
\RequirePackage{parskip}
\RequirePackage{booktabs}
\RequirePackage{enumitem}
\RequirePackage{soul}
\RequirePackage{xcolor}

\newlength{\listsep}
\setlength{\listsep}{.5em}

\setlist{topsep=0em, itemsep=\dimexpr\listsep - \parskip\relax}
\setlist[itemize]{label=---}

\RequirePackage{datetime2}

\RequirePackage{pancake-ling}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{cleveref}
\RequirePackage[
  backend=biber,
  style=apa,
  sorting=ynt
]{biblatex}
\RequirePackage[outer=6cm, inner=3cm]{geometry}
