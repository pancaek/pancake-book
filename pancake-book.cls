\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pancake-book}[2021/09/09 Annotated book class]

%* Footnotes to sidenotes
\DeclareOption{sidefootnotes}{
	\renewcommand{\footnote}[2][]{\sidenote[#1]{#2}}
	\renewcommand{\footnotetext}[2][]{\sidenotetext[#1]{#2}}
	\renewcommand{\footnotemark}[1][]{\sidenotemark[#1]}
}

\DeclareOption{letterpaper}{
	\PassOptionsToPackage{
		letterpaper,
		left=1in,
		top=1in,
		headsep=2\baselineskip,
		textwidth=26pc,
		marginparsep=2pc,
		marginparwidth=12pc,
		textheight=44\baselineskip,
		headheight=1.2\baselineskip
	}{geometry}
}

\DeclareOption{a4paper}{
	\PassOptionsToPackage{
		a4paper,
		left=24.8mm,
		top=27.4mm,
		headsep=2\baselineskip,
		textwidth=107mm,
		marginparsep=8.2mm,
		marginparwidth=49.4mm,
		textheight=49\baselineskip,
		headheight=1.2\baselineskip
	}{geometry}
}

\DeclareOption{b5paper}{
	\PassOptionsToPackage{
		b5paper,
		left=14.66mm,
		top=13.88mm,
		textwidth=102.66mm,
		marginparsep=7.33mm,
		marginparwidth=36.66mm,
		textheight=38\baselineskip,
		includehead
	}{geometry}
}

% Added by me
\DeclareOption{legalpaper}{
	\PassOptionsToPackage{
		legalpaper,
		left=1in,
		top=1in,
		headsep=2\baselineskip,
		textwidth=26pc,
		marginparsep=2pc,
		marginparwidth=12pc,
		textheight=56\baselineskip,
		headheight=1.2\baselineskip
	}{geometry}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass{book}
% Page geometry
\RequirePackage{geometry}

% Header/footer
\RequirePackage{emptypage}
\RequirePackage{fancyhdr}

% Marginalia
\RequirePackage{sidenotes}
\RequirePackage{marginfix}

% Structure enhancements
\RequirePackage{parskip}
\RequirePackage{booktabs}
\RequirePackage{enumitem}
\RequirePackage{soul}
\RequirePackage{xcolor}

% Date
\RequirePackage{datetime2}

% Letterspacing
\RequirePackage{accsupp}

% Patch for accsupp on xelatex
% via https://tex.stackexchange.com/questions/262492/xelatex-misplaces-actualtext-box
\ifxetex
	\def\ACCSUPP@bdc{%
		\special{pdf:code \ACCSUPP@span BDC}%
	}
	\def\ACCSUPP@emc{%
		\special{pdf:code EMC}%
	}
\fi

\IfPackageLoadedTF{fontspec}{}{\RequirePackage{letterspace}}

% PAGE HEAD/FOOT %
\renewcommand{\sectionmark}[1]{\markright{#1}}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\pagestyle{fancy}

\fancyhf{}
\fancyheadoffset{0cm}
\renewcommand{\headrulewidth}{.4pt}
\renewcommand{\footrulewidth}{0pt}

\fancyhead[LE, RO]{\chaptername{} \thechapter}
\fancyhead[RE, LO]{\nouppercase{\leftmark}}
\fancyfoot[LE, RO]{\thepage}


\fancypagestyle{plain}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
	\fancyfoot[LE, RO]{\thepage}
}

% MARGINALIA %
\NewDocumentCommand{\smartragged}{}{\checkoddpage \ifoddpage\raggedright \else \raggedleft\fi}

\NewDocumentCommand{\marginaliasize}{}{\footnotesize}
\DeclareCaptionFont{marginaliasize}{\marginaliasize}

\NewCommandCopy\pancake@marginpar\marginpar
\RenewDocumentCommand{\marginpar}{o m}{%
	\IfNoValueTF{#1}%
	{\pancake@marginpar{\smartragged\marginaliasize #2}}%
	{\pancake@marginpar[\raggedleft\marginaliasize #1]{\raggedright\marginaliasize #2}}%
}

\DeclareCaptionJustification{smartragged}{\smartragged}

\DeclareCaptionStyle{marginfigure}{font=marginaliasize}
\DeclareCaptionStyle{margintable}{font=marginaliasize}
\DeclareCaptionStyle{sidecaption}{font=marginaliasize}

% LIST ADJUSTMENTS
\newlength{\listsep}
\setlength{\listsep}{.5em}
\setlist{topsep=0em, itemsep=\dimexpr\listsep - \parskip\relax}
\setlist[itemize]{label=---}

% COLORS
\definecolor{pancake@coral}{HTML}{DD5745}
\definecolor{pancake@red}{HTML}{C7453B}
\definecolor{pancake@orange}{HTML}{DA662E}
\definecolor{pancake@yellow}{HTML}{D99149}
\definecolor{pancake@lime}{HTML}{60A861}
\definecolor{pancake@green}{HTML}{2C5C39}
\definecolor{pancake@cyan}{HTML}{2B6F94}
\definecolor{pancake@blue}{HTML}{293E6A}
\definecolor{pancake@pink}{HTML}{DB4E6E}
\definecolor{pancake@purple}{HTML}{722B3D}

\NewDocumentCommand{\setaccent}{s m}{
	\IfBooleanTF{#1}
	{\colorlet{pancake@accent}{#2}}
	{\colorlet{pancake@accent}{pancake@#2}}
}


\colorlet{pancake@grey}{gray}
\colorlet{pancake@accent}{pancake@grey}

% ASSORTED
\NewDocumentCommand{\ifdraft}{m}{\ifdimgreater\overfullrule\z@{#1}\expandafter}

% Letterspacing

% For reasons that are a mystery to me, using direct floating point math breaks stuff, so don't try that
% I love magic numbers :)
% I think this is right finally, only open an issue about it if you've found a more correct conversion

\NewDocumentCommand{\spacedtext}{O{20} m}{
	\BeginAccSupp{ActualText=#2}%
	\IfPackageLoadedTF{fontspec}{%
		\addfontfeature{LetterSpace=\the\numexpr#1/10\relax}#2}{\textls[#1]{#2}}%
	\EndAccSupp{}
}

\newcommand{\smallcaps}[1]{{\scshape\spacedtext[50]{#1}}}
\newcommand{\allcaps}[1]{\MakeUppercase{\scshape\spacedtext[200]{#1}}}
% fullwidth
\RequirePackage{changepage}

% Basically, we subtract all space taken up by margin notes
% I have no idea why this is negative but whatever
% we need `changepage` so this will work mid-page
\NewDocumentEnvironment{fullwidth}{}{\begin{adjustwidth*}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}{\end{adjustwidth*}}
