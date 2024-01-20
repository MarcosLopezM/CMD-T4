%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                    %%
%%                 fc-hw-template.cls                 %%
%%                                                    %%
%% ================================================== %%
%%                                                    %%
%% Version:     1.1 (2024/01/20)                      %%
%% Author:      Marcos López Merino                   %%
%% License:     MIT LICENSE                           %%
%% GitHub Repo: https://tvj.one/ml-tex                %%
%% Compiler:    lualatex                              %%
%%                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fc-hw-template}[2024/01/20 Facultad de Ciencias Assignment Template]

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
\LoadClass[letterpaper,\@@ptsize]{article}

%% Page Settings
\RequirePackage[inner=2.0cm,outer=2.0cm,top=1.2cm,bottom=3.5cm]{geometry}
\newcommand{\firstfooteradditionalheight}{2em} % additional height for footer on the first page
\hfuzz=.5em % disable false positive of overfull \hbox

%% Language Settings
\RequirePackage{polyglossia}
\setdefaultlanguage{spanish}
\setotherlanguage{english}
\gappto\captionsspanish{\def\tablename{Tabla}}
\RequirePackage[es]{datetime2}

%% Document Propertities
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
        \vspace{-1\baselineskip}\hfill{\normalfont\small\problemptsprint}%
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
            \fontfamily{LinuxLibertineT-OsF}\selectfont% select font as Linux Libertine
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
        \fontfamily{LinuxLibertineT-OsF}\selectfont
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
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \textsc{\@subject~--~\@title~\@assignno}
        \renewcommand\headrule{\vspace{-0.7em}\tikzrule[pinkwave, path fading=east]{.5\textwidth}{0.3mm}}
    }
    \fancyhead[RE]{
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \textsc{\@subject~--~\@title~\@assignno}
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
\newcommand{\pdftitleadditionalname}{Solution}
\newcommand{\setduedate}[1]{\DTMDate{#1}}
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
            \fontfamily{LinuxBiolinumT-OsF}\selectfont
            \textcolor{BrickRed}{Grupo~\@group~-- \@semester}
            \vspace{2mm}
        }
        \LARGE\@title~{\fontfamily{bch}\selectfont\@assignno}
    \end{minipage}
    \\[.3em]
    \color{customBlue} \hrule width \hsize height 2pt \kern 1mm \hrule width \hsize
    % Due date
    \ifx\@duedate\@empty
        \begin{center}
            % \vspace{4mm}
            \textbf{\normalsize Entrega:~\DTMtoday}
        \end{center}
    \else
        \begin{center}
            \textbf{\normalsize Entrega:~\setduedate{\@duedate}}
        \end{center}
    \fi


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
