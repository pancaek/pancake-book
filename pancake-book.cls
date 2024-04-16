\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pancake-book}[2021/09/09 Annotated book class]
\DeclareOption{sidefootnotes}{
    %* Footnotes to sidenotes
    \renewcommand{\footnote}[2][]{\sidenote[#1]{#2}}
    \renewcommand{\footnotetext}[2][]{\sidenotetext[#1]{#2}}
    \renewcommand{\footnotemark}[1][]{\sidenotemark[#1]}
}
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

%* Marginalia
\RequirePackage{sidenotes}
\RequirePackage{marginfix}

\setlength{\marginparsep}{2em}
\setlength{\marginparpush}{1em}

\newcommand{\smartragged}{\checkoddpage \ifoddpage\raggedright \else \raggedleft\fi}

\providecommand{\marginaliasize}{\footnotesize}
\DeclareCaptionFont{marginaliasize}{\marginaliasize}

\let\oldmarginpar\marginpar
\renewcommand{\marginpar}[2][]{%
  \ifx#1\empty\empty % when #1 is empty, we are really looking to see that \empty = \empty
    \oldmarginpar{\smartragged\marginaliasize #2}%
  \else
    \oldmarginpar[\raggedleft\marginaliasize #1]{\raggedright\marginaliasize #2}%
  \fi
}

\DeclareCaptionJustification{smartragged}{\smartragged}

\DeclareCaptionStyle{marginfigure}{font=marginaliasize,justification=smartragged}
\DeclareCaptionStyle{margintable}{font=marginaliasize,justification=smartragged}
\DeclareCaptionStyle{sidecaption}{font=marginaliasize,justification=smartragged}

%* Assorted random bits
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

%* List adjustments
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
