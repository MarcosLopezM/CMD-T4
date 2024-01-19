%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                    %%
%%                 fc-hw-template.cls                 %%
%%                                                    %%
%% ================================================== %%
%%                                                    %%
%% Version:     0.1 (2024/01/19)                      %%
%% Author:      Marcos López Merino                   %%
%% License:     MIT LICENSE                           %%
%% GitHub Repo: https://tvj.one/ml-tex                %%
%% Compiler:    lualatex                              %%
%%                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fc-hw-template}[2024/01/19 Facultad de Ciencias Assignment Template]

%% Class and Options
\def\@@ptsize{12pt} % Default font size
\DeclareOption{9pt}{\def\@@ptsize{9pt}}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\def\@twoside{0} % default as oneside
\DeclareOption{oneside}{\def\@twoside{0}} % one-side document
\DeclareOption{twoside}{\def\@twoside{1}} % two-side document
\ProcessOptions\relax
\LoadClass[letterpaper,\@@ptsize]{article}

%% Page Settings
\RequirePackage[inner=2.0cm,outer=2.0cm,top=1.2cm,bottom=3.5cm]{geometry}
\newcommand{\firstfooteradditionalheight}{2em} % additional height for footer on the first page
\hfuzz=.5em % disable false positive of overfull \hbox

%% Document Propertities
\global\let\@assignno\@empty
\global\let\@semester\@empty
\global\let\@studentID\@empty
\global\let\@instructor\@empty
\global\let\@duedate\@empty
\global\let\@author\@empty
\global\let\@subject\@empty
\newcommand{\assignno}[1]{\gdef\@assignno{#1}} % Assignment Number
\newcommand{\semester}[1]{\gdef\@semester{#1}} % Semester
\newcommand{\studentID}[1]{\gdef\@studentID{#1}} % Student ID
\newcommand{\instructor}[1]{\gdef\@instructor{#1}} % Instructor
\newcommand{\duedate}[1]{\gdef\@duedate{#1}} % Due Date of the Assignment
\newcommand{\subject}[1]{\gdef\@subject{#1}} % Subject

%% Graphics Settings
\RequirePackage{graphicx} % Inclusion of graphics
\usepackage[export]{adjustbox} % Extends the “key=value” interface of \includegraphics 
\graphicspath{{img/}}

%% Fonts and Colors
\RequirePackage{fontspec}
\RequirePackage[dvipsnames]{xcolor}
\definecolor{base3}{RGB}{253, 246, 227}%
\definecolor{pinkwave}{RGB}{255, 0, 128}%
\definecolor{customBlue}{RGB}{11, 61, 98}%

%% List Settings
\RequirePackage[inline]{enumitem}

%% TikZ Rule
\RequirePackage{tikz}
\usetikzlibrary{fadings, calc}
\newcommand{\tikzrule}[3][]{\tikz{\fill[#1] (0,0) rectangle (#2,#3);}}

%% Sections Settings
\RequirePackage[explicit]{titlesec} % explained in https://tex.stackexchange.com/a/292307/234654
\RequirePackage{suffix}
% http://mirrors.ctan.org/macros/latex/contrib/titlesec/titlesec.pdf
\pgfdeclarelayer{background}
\pgfsetlayers{background,main}
\global\let\@problempts\@empty
\newcommand{\problempts}[1]{\gdef\@problempts{#1}} % Points of the Problem
\newcommand{\problemptsprint}{\ifx\@problempts\@empty\else(\@problempts~points)\fi}
\newcommand{\sectionheadname}{Problem} % Name for the Section (default as 'Problem')
% Reference: https://tex.stackexchange.com/a/12269/234654
% For numbered section, i.e. \section{}
% \titleformat{\section}% <command>
%     {\Large\bfseries}% <format>
%     {}% <label>
%     {0pt}% <sep>
%     {\sectionheadname{} \thesection: #1}% <before-code>
%     [%
%         \vspace{-2.2\baselineskip}\hfill{\normalfont\small\problemptsprint}%
%         \problempts{}% clear the problem points
%     ]% <after-code>
% % For unnumbered section, i.e. \section*{}
% \titleformat{name=\section,numberless}% <command>
%     {\Large\bfseries}% <format>
%     {}% <label>
%     {0pt}% <sep>
%     {\sectionheadname{} \thesection: #1}% <before-code>
%     [%
%         \vspace{-2.2\baselineskip}\hfill{\normalfont\small\problemptsprint}%
%         \problempts{}% clear the problem points
%     ]% <after-code>
% \newcommand{\setproblem}[1]{\ifx#1\@empty\else\setcounter{section}{#1}\fi} % force the number of problem
% \newcommand{\setsubproblem}[1]{\ifx#1\@empty\else\setcounter{subsection}{#1}\fi} % force the number of subproblem
% \newcommand{\problem}[2][]{\problempts{#1}\section[\thesection~#2]{#2}}%
% \WithSuffix\newcommand\problem*[2][]{\problempts{#1}\section*{#2}}%
% \newcommand{\solutionname}{Solution}%
% \newcommand{\startsolution}[1][print]{%
%     \setproblem{0}% reset the section counter
%     \def\startsolutionprintoption{print}
%     \def\startsolutionprintuseroption{#1}
%     \ifx\startsolutionprintuseroption\startsolutionprintoption{%
%         {%
%             \fontfamily{LinuxLibertineT-OsF}\selectfont% select font as Linux Libertine
%             \centering\LARGE\scshape%
%             \vspace{\baselineskip}%
%             \solutionname{}\\[-0.2em]%
%         }%
%         \noindent%
%         \tikzrule[WildStrawberry, path fading=west]{.5\textwidth}{.2em}%
%         \tikzrule[WildStrawberry, path fading=east]{.5\textwidth}{.2em}%
%     }\fi%
% }
% \titlespacing*{\section}{0em}{2.5\baselineskip}{1\baselineskip}
% \titleformat{\subsection}[runin]{\large\bfseries}{(\arabic{subsection})}{0.33em}{#1}
% \newcommand{\subproblem}[1]{\subsection[(\arabic{subsection}) #1]{#1}}
% \WithSuffix\newcommand\subproblem*[1]{\subsection*{#1}}
% \titleformat{\subsubsection}[runin]{\bfseries}{\arabic{subsubsection}.}{0.33em}{#1}
% \newcommand{\subsubproblem}[1]{\subsubsection[\arabic{subsubsection}. #1]{#1}}
% \WithSuffix\newcommand\subsubproblem*[1]{\subsubsection*{#1}}

%% Maths Settings
\RequirePackage{mathtools}
\RequirePackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{bm} % \bm command
\RequirePackage{derivative}
\RequirePackage{empheq}
\RequirePackage{lualatex-math}
\RequirePackage{mismath}
\RequirePackage{nicematrix} % Better matrix handling
\RequirePackage{simples-matrices} % Fast matrix typing
\numberwithin{equation}{section}

%% Physics Settings
% \RequirePackage{phfqit} % Neccesary commands for quantum mechanics
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

%% Subfiles Managment Settings
\RequirePackage{subfiles}

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
    unicode=true%
}

\setlength{\headheight}{52pt}
\setlength{\marginparwidth}{2cm}
\pagestyle{fancy}
\if\@twoside0
    \lhead{
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \textsc{\@title~\@assignno} -- \@studentID~\@author
    }
    \rhead{\thepage}
    \renewcommand\headrule{\vspace{-0.7em}\tikzrule[BrickRed, path fading=east]{.5\textwidth}{0.3mm}}
\else
    \fancyhf{}
    \renewcommand\headrule{%
        \ifodd\thepage
            \vspace{-0.7em}\tikzrule[BrickRed, path fading=east]{.5\textwidth}{0.3mm}
        \else
            \vspace{-0.7em}\hfill\tikzrule[BrickRed, path fading=west]{.5\textwidth}{0.3mm}
        \fi
    }
    \fancyhead[LO]{
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \textsc{\@subject \@title~\@assignno}
        \renewcommand\headrule{\vspace{-0.7em}\tikzrule[BrickRed, path fading=east]{.5\textwidth}{0.3mm}}
    }
    \fancyhead[RE]{
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \textsc{\@subject \@title~\@assignno}
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
        % \fontfamily{LinuxLibertineT-OsF}\selectfont
        % \vspace*{-\firstfooteradditionalheight}
        % \vspace{-1.5em}
        % \tikzrule[purple, path fading=west]{.5\textwidth}{.15em}%
        % \tikzrule[purple, path fading=east]{.5\textwidth}{.15em}
        \includegraphics[scale = 0.2, valign = c]{LogoFCUNAMcolor.pdf}
    }
}

%% Title Settings
\RequirePackage{tabularx}
\RequirePackage{afterpage}
\newcommand{\pdftitleadditionalname}{Solution}
\makeatletter         
\renewcommand\maketitle{
    \thispagestyle{firstpage}
    \fontfamily{LinuxLibertineT-OsF}\selectfont % set font as Linux Libertine
    \enlargethispage{-\firstfooteradditionalheight} % make room for the footer
    \begin{minipage}{10.5cm}
        \centering
        {
            \fontsize{36}{48}\selectfont
            \textcolor{Plum}{\scshape \@subject}
        }\\[.5em]
        {
            \@studentID~\@author
            \qquad
            \textit{Instructor:~\@instructor}
        }
    \end{minipage}
    \begin{minipage}{5cm}
        \vspace{0.7em}
        \centering
        {
            \normalsize
            \fontfamily{LinuxBiolinumT-OsF}\selectfont
            \textcolor{BrickRed}{\@semester}
            \vspace{2mm}
        }
        \LARGE\@title~{\fontfamily{bch}\selectfont\@assignno}
    \end{minipage}
    \\[.3em]
    \tikzrule[customBlue, path fading=east]{\textwidth}{.4em}

    \fontfamily{cmr}\selectfont % Computer Modern

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
