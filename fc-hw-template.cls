%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                    %%
%%                 fc-hw-template.cls                 %%
%%                                                    %%
%% ================================================== %%
%%                                                    %%
%% Version:     1.3 (2024/01/20)                      %%
%% Author:      Marcos López Merino                   %%
%% License:     MIT LICENSE                           %%
%% GitHub Repo: https://tvj.one/ml-tex                %%
%% Compiler:    lualatex                              %%
%%                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fc-hw-template}[2024/01/20 Facultad de Ciencias Assignment Template]

\RequirePackage{ifthen}
\RequirePackage{xkeyval}

%% Colors
\RequirePackage[dvipsnames]{xcolor}
\definecolor{base3}{RGB}{253, 246, 227}%
\definecolor{pinkwave}{RGB}{255, 0, 128}%
\definecolor{customBlue}{RGB}{11, 61, 98}%

%% Class and Options
\def\@@ptsize{10pt} % Default font size
\DeclareOption{9pt}{\def\@@ptsize{9pt}}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\def\@twoside{0} % default as oneside
\DeclareOption{oneside}{\def\@twoside{0}} % one-side document
\DeclareOption{twoside}{\def\@twoside{1}} % two-side document
\ProcessOptions\relax
% Define default options
\newif\ifdigital\digitalfalse
\DeclareOptionX{digital}[true]{\ifthenelse{\equal{#1}{true}}{\digitaltrue}{\digitalfalse}}

\ProcessOptionsX
\LoadClass[letterpaper,\@@ptsize]{article}

% Define custom macros for changing page color and other actions
\newcommand{\SetDigitalMode}{%
    \ifdigital
        \pagecolor{base3}
    \fi
}

% Execute custom actions based on options after the document class is loaded
\AtBeginDocument{\SetDigitalMode}

%% Page Settings
\RequirePackage[inner=2.0cm,outer=2.0cm,top=1.2cm,bottom=3.5cm]{geometry}
\newcommand{\firstfooteradditionalheight}{2em} % additional height for footer on the first page
\hfuzz=.5em % disable false positive of overfull \hbox

%% LuaLaTeX Specific Package
\RequirePackage{linebreaker} % line-breaker algorithm in LuaLaTeX

%% Fonts
\RequirePackage{fontspec}
\newfontfamily\linuxlibertine[%
    Path = fonts/linux-libertine/,
    Extension = .otf,
    UprightFont = *_R,
    BoldFont = *_RB,
    BoldItalicFont = *_RBI,
    ItalicFont = *_RI,
    Ligatures = {
        TeX,
    }
]{LinLibertine}

\newfontfamily\linuxbiolinum[%
    Path = fonts/linux-biolinum/,
    Extension = .otf,
    UprightFont = *_R,
    BoldFont = *_RB,
    ItalicFont = *_RI,
    Ligatures = {
        TeX,
    }
]{LinBiolinum}

% Line-breaker Settings
\linebreakersetup {
    maxtolerance = 90,
    maxemergencystretch = 1em,
    maxcycles = 4
}

%% Language Settings
\RequirePackage{polyglossia}
\setdefaultlanguage{spanish}
\setotherlanguage{english}
\gappto\captionsspanish{\def\tablename{Tabla}}
\RequirePackage[es]{datetime2}

%% Document Properties
\global\let\@assignno\@empty
\global\let\@group\@empty
\global\let\@semester\@empty
\global\let\@instructor\@empty
\global\let\@duedate\@empty
\global\let\@author\@empty
\global\let\@subject\@empty
\newcommand{\assignno}[1]{\gdef\@assignno{#1}} % Assignment Number
\newcommand{\group}[1]{\gdef\@group{#1}} % Group
\newcommand{\semester}[1]{\gdef\@semester{#1}} % Semester
\newcommand{\instructor}[1]{\gdef\@instructor{#1}} % Instructor
\newcommand{\duedate}[1]{\gdef\@duedate{#1}} % Due Date of the Assignment
\newcommand{\subject}[1]{\gdef\@subject{#1}} % Subject

\setlength{\parindent}{0pt} % Indentation
\setlength{\parskip}{0.5em} % Space in between paragraphs
\linespread{1.1} % Line spacing

%% Graphics Settings
\RequirePackage{graphicx} % Inclusion of graphics
\RequirePackage[export]{adjustbox} % Extends the “key=value” interface of \includegraphics 
\graphicspath{{img/}}

%% List Settings
\RequirePackage[inline]{enumitem}
\RequirePackage{multicol}
\setlist[enumerate, 1] {
    label = (\alph*),
}

% Multicol environment for lists
\SetEnumitemKey{twocol}{
itemsep = 1\itemsep,
parsep = 0.5\parsep,
before = \raggedcolumns\begin{multicols}{2},
after = \end{multicols}}

\SetEnumitemKey{threecol}{
itemsep = 1\itemsep,
parsep = 0.5\parsep,
before = \raggedcolumns\begin{multicols}{3},
after = \end{multicols}}

%% TikZ Rule
\RequirePackage{tikz}
\usetikzlibrary{fadings, calc}
\newcommand{\tikzrule}[3][]{\tikz{\fill[#1] (0,0) rectangle (#2,#3);}}

%% Sections Settings
\RequirePackage[explicit]{titlesec} % explained in https://tex.stackexchange.com/a/292307/234654
\RequirePackage{suffix}
% http://mirrors.ctan.org/macros/latex/contrib/titlesec/titlesec.pdf
\global\let\@problempts\@empty
\newcommand{\problempts}[1]{\gdef\@problempts{#1}} % Points of the Problem
\newcommand{\problemptsprint}{\ifx\@problempts\@empty\else\bfseries(\@problempts~pts)\fi}
\newcommand{\sectionheadname}{Problema} % Name for the Section (default as 'Problema')
% For numbered section with problem name, i.e. \section{} 
\titleformat{\section}% <command>
    {\Large\bfseries}% <format>
    {}% <label>
    {0pt}% <sep>
    {\if\relax\detokenize{#1}\relax\sectionheadname{} \thesection\else\sectionheadname{} \thesection: #1\fi}% <before-code>
    [%
        \vspace{-2\baselineskip}\hfill{\normalfont\small\problemptsprint}%
        \problempts{}% clear the problem points
    ]% <after-code>

\newcommand{\setproblem}[1]{\ifx#1\@empty\else\setcounter{section}{#1}\fi} % force the number of problem
\newcommand{\problem}[2][]{\problempts{#1}\section[\thesection~#2]{#2}}%
\WithSuffix\newcommand\problem*[2][]{\problempts{#1}\section*{#2}}%
\newcommand{\solutionname}{Solución}%
\newcommand{\startsolution}[1][print]{%
    \def\startsolutionprintoption{print}
    \def\startsolutionprintuseroption{#1}
    \ifx\startsolutionprintuseroption\startsolutionprintoption{%
        {%
            \linuxlibertine
            \centering\LARGE\scshape%
            \vspace{\baselineskip}%
            \solutionname{}\\[-0.2em]%
        }%
        \noindent%
        \tikzrule[pinkwave, path fading=west]{.5\textwidth}{.2em}%
        \tikzrule[pinkwave, path fading=east]{.5\textwidth}{.2em}%
        \vspace{1em}
    }\fi%
}
\titlespacing*{\section}{0em}{2.5\baselineskip}{1\baselineskip}

%% Maths Settings
\RequirePackage{mathtools}
\RequirePackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{bm} % \bm command
\RequirePackage{derivative}
\RequirePackage{empheq} % Boxes around equations
\RequirePackage{linop} % Lineal Operators for QM
\RequirePackage{lualatex-math}
\RequirePackage{mismath}
\RequirePackage{nicematrix} % Better matrix handling
\RequirePackage{simples-matrices} % Fast matrix typing
\numberwithin{equation}{section}

\setlength{\jot}{10pt} % Space between lines in multiline eqs

%% Empheq Settings
% Defining a variant of Aboxed command from mathtools
\newcommand\mainresult[1]{\color{pinkwave}\fboxsep=3.5pt\fboxrule=1.2pt\fbox{\color{black}#1}}
\MakeAboxedCommand\Aboxedmain\mainresult
\newcommand*\widefbox[1]{\fboxsep=3.5pt\fboxrule=1.5pt\fbox{#1}}

\newcommand\secondaryresult[1]{\color{customBlue}\fboxsep=3.5pt\fbox{\color{black}#1}}
\MakeAboxedCommand\Aboxedsec\secondaryresult

% Custom boxes for results with background color specified by class option
% Box for main result
\newcommand*\resultbox[1]{%
    \setlength\fboxrule{1.5pt}%
    \ifdigital
        \fcolorbox{pinkwave}{base3}{\hspace{1em}#1\hspace{1em}}%
    \else
        \fcolorbox{pinkwave}{white}{\hspace{1em}#1\hspace{1em}}%
    \fi
}

% Box for relevant result
\newcommand*\secbox[1]{%
    \setlength\fboxrule{1pt}%
    \ifdigital
        \fcolorbox{pinkwave}{base3}{\hspace{1em}#1\hspace{1em}}%
    \else
        \fcolorbox{customBlue}{white}{\hspace{1em}#1\hspace{1em}}%
    \fi
}

%% Physics Settings
% \RequirePackage{phfqit} % Necessary commands for quantum mechanics
\RequirePackage{siunitx} 

% SIUnitX Settings
\sisetup{
	output-decimal-marker = {.}, 
	separate-uncertainty = false,
	exponent-product = \mul,
    inter-unit-product = \ensuremath{{}\cdot{}}
}

%% Dummy Text Settings
\RequirePackage{kantlipsum}

%% Subfiles Management Settings
\RequirePackage{subfiles}

%% Bookmarks Settings
\RequirePackage[numbered]{bookmark}
\RequirePackage{letltxmacro}

%% Captions Settings
\RequirePackage[font=footnotesize,labelfont=bf]{caption}

%% Footnote Settings
\RequirePackage[bottom]{footmisc} % glue footnote to bottom
\renewcommand{\footnoterule}{\noindent\tikzrule[SeaGreen, path fading=east]{.4\textwidth}{.1em}}
\renewcommand{\footnotesep}{1em}

%% Header and Footer
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{hyperref}
\RequirePackage{cleveref}

\hypersetup{
    colorlinks = true,%
    linkcolor={[rgb]{0,0.2,0.6}},%
    citecolor={[rgb]{0,0.6,0.2}},%
    filecolor={[rgb]{0.8,0,0.8}},%
    urlcolor={[rgb]{0.8,0,0.8}},%
    runcolor={[rgb]{0.8,0,0.8}},% 
    menucolor={[rgb]{0,0.2,0.6}},%
    linkbordercolor={[rgb]{0,0.2,0.6}},%
    citebordercolor={[rgb]{0,0.6,0.2}},%
    filebordercolor={[rgb]{0.8,0,0.8}},%
    urlbordercolor={[rgb]{0.8,0,0.8}},%
    runbordercolor={[rgb]{0.8,0,0.8}},%
    menubordercolor={[rgb]{0,0.2,0.6}},% 
    unicode=true,%
}

\setlength{\headheight}{52pt}
\setlength{\marginparwidth}{2cm}
\pagestyle{fancy}
\if\@twoside0
    \lhead{
        \linuxlibertine
        \textsc{\@title~\@assignno} -- ~\@author
    }
    \rhead{\thepage}
    \renewcommand\headrule{\vspace{-0.7em}\tikzrule[pinkwave, path fading=east]{.5\textwidth}{0.3mm}}
\else
    \fancyhf{}
    \renewcommand\headrule{%
        \ifodd\thepage
            \vspace{-0.7em}\tikzrule[pinkwave, path fading=east]{.5\textwidth}{0.3mm}
        \else
            \vspace{-0.7em}\hfill\tikzrule[pinkwave, path fading=west]{.5\textwidth}{0.3mm}
        \fi
    }
    \fancyhead[LO]{
        \linuxlibertine
        \textsc{\@subject~---~\@title~\@assignno}
        \renewcommand\headrule{\vspace{-0.7em}\tikzrule[pinkwave, path fading=east]{.5\textwidth}{0.3mm}}
    }
    \fancyhead[RE]{
        \linuxlibertine
        \textsc{\@subject~---~\@title~\@assignno}
    }
    \fancyhead[LE,RO]{Pág. \thepage \hspace{1pt} de \pageref{LastPage}}
\fi
\cfoot{}
% header and footer style for the first page
\fancypagestyle{firstpage}{
    \renewcommand\headrule{}
    \lhead{}
    \rhead{}
    \cfoot{
        \includegraphics[scale = 0.2, valign = c]{LogoFCUNAMcolor.pdf}
    }
}

%% Title Settings
\RequirePackage{afterpage}
\newcommand{\setduedate}[1]{\DTMDate{#1}}
\makeatletter         
\renewcommand\maketitle{
    \thispagestyle{firstpage}
    \linuxlibertine
    \enlargethispage{-\firstfooteradditionalheight} % make room for the footer
    \begin{minipage}{10.5cm}
        \centering
        {
            \fontsize{36}{48}\selectfont
            \textcolor{Plum}{\scshape \@subject}
        }\\[.5em]
        {
            \@author
            \qquad
            \textit{Prof.:~\@instructor}
        }
    \end{minipage}
    \begin{minipage}{5cm}
        \vspace{0.7em}
        \centering
        {
            \normalsize
            \linuxbiolinum
            \textcolor{BrickRed}{Grupo~\@group~-- \@semester}
            \vspace{2mm}
        }
        \LARGE\@title~{\@assignno}
    \end{minipage}
    \\[.3em]
    \color{customBlue} \hrule width \hsize height 2pt \kern 1mm \hrule width \hsize
    % Due date
    \ifx\@duedate\@empty
        \begin{center}
            \textbf{\normalsize Entrega:~\DTMtoday}
        \end{center}
    \else
        \begin{center}
            \textbf{\normalsize Entrega:~\setduedate{\@duedate}}
        \end{center}
    \fi

    % Set up document meta data
    % Note that it should be placed here because
    % by now \@author and \@title have been set.
    \hypersetup{
        pdfauthor={\@author},
        pdftitle={%
            \@title~\@assignno~
            - \@subject%
        },
        pdfsubject={\@subject},
        pdfkeywords={%
            \@title%
            \ifx\@subject\@empty\else%
                , \@subject%
            \fi%
        },
        pdfcreator={LaTeX with fc-hw-template class},
        pdfproducer={LaTeX, LuaLaTeX}
    }
}
\makeatother
