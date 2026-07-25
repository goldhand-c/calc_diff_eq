\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{novelette}[2026/6/13 Custom Book]

% Option
\RequirePackage{etoolbox}
\newbool{advance} % initially false
\edef\baseclass{article}
\edef\langpkg{thaitext}
\DeclareOption{adv}{
    \booltrue{advance}
    \xdef\baseclass{book}
}
\DeclareOption{lua}{
    \xdef\langpkg{thaitextlua}
}

% Load the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ProcessOptions\relax
\LoadClass{\baseclass}


% -------- PAGE SETUP --------
\RequirePackage[ % use \newgeometry{top=7mm,bottom=6mm,...,includehead,includefoot} to keep vertical margin
    a4paper,   % paper size
    top=7mm,   bottom=30mm,  % margin
    left=28mm, right=19mm,
    includehead, includefoot, % space header
    % inner=2cm, % outer=5cm, % twoside margin
    marginparwidth=24mm, % sidenote
    marginparsep=2mm,    % gap
    % showframe, % show page structure
]{geometry}

\RequirePackage{silence}
\WarningsOff* % From this point on, don't show me any warnings.
\tracinglostchars=0 % suppress warning for missing characters


% -------- LOCAL PACKAGES --------
\makeatletter \def\input@path{{styles/}} \makeatother  % local package directory

% Use settings in this order to avoid crash
\RequirePackage{setuptext, \langpkg, setupsci, setcommand}


% -------- HEADER/FOOTER --------
\fancyhead[L]{
    \rmfamily \textsc{\titlename}\vspace{7pt}\par
    {\thedate}\vspace{5pt}}

\fancyhead[R]{
    \rmfamily \textsw{Page}\ \thepage\vspace{7pt}\par
    \phantom{a}\vspace{5pt}}

% \fancyhead[C]{
%   \includegraphics[height=60pt]{Images/a.png}}

% \fancyfoot[C]{
%   \includegraphics[height=29pt]{Images/a.png}}
\fancyfoot[C]{}


% ---------------- For adv Option ----------------
\ifbool{advance}{}{\endinput} % end if false


% -------- TABLE OF CONTENTS --------
% Configure subsection entries to run horizontally in the ToC
\RequirePackage{titletoc}

\definecolor{typstblue}{HTML}{0074d9}
\titlecontents{chapter}[0em]
{\large\bfseries}
{} % {\contentslabel{1.5em}} % number
{\hspace*{-1.5em}}
{\ \color{typstblue}\titlerule[.75pt]}%\color{black}\titlerule[.6pt]\contentspage}
[\vspace{-1ex}]

\titlecontents{section}[3.8em] % ie, 1.5em (chapter) + 2.3em
{\bfseries}
{\contentslabel{2.3em}}
{\hspace*{-2.3em}}
{\ \normalfont\titlerule*[1pc]{.}\bfseries\oldmlmodern\contentspage}
[\vspace{-1.5ex}]

\titlecontents*{subsection}[4.8em]
{\small\sffamily}                    % Format for the entry group
{} % {\thecontentslabel~}            % Format before numbered entries
{}                                   % Format before unnumbered entries
{, p.~\oldstylenums\thecontentspage} % Format for the page number
[\;\textbullet\;]                    % Separator between inline items
[\vspace{-0.5ex}]                    % Separator at the very end of the paragraph

\newcommand{\subsectionx}[1]{
    \subsection*{#1}
    \addcontentsline{toc}{subsection}{#1}
}

% Minimal alternative to titletoc
% \RequirePackage{tocloft} % edit toc, lof, lot
% \renewcommand{\cfttoctitlefont}{\hfill\Large\itshape} % centered title
% \renewcommand{\cftaftertoctitle}{\hfill}
% \renewcommand{\cftdot}{\ensuremath{\ast}} % replace dot fill
% % \setcounter{tocdepth}{1} % max depth of contents shown


% -------- SMART HEADER --------
\newcounter{helpchapter} % updates at every chapter
\newcounter{pagechapter} % updates after this page
\newcounter{helpsection}[chapter]
\newcounter{pagesection}[chapter]
\addtolength{\headheight}{-7mm}
\addtolength{\textheight}{7mm}

\fancyhead[L]{
    \ifnum\value{pagechapter}>0
        Chapter\ \ref{ch:\thepagechapter}{}\ \nameref{ch:\thepagechapter}
    \fi
}
\fancyhead[R]{
    \ifnum\value{pagesection}>0
        Section\ \ref{sec:\thepagechapter.\thepagesection}{}\ \nameref{sec:\thepagechapter.\thepagesection}
    \fi
}
\fancyfoot[C]{%
    \oldmlmodern\thepage%
}

\RequirePackage{afterpage} % for coding after current page
\newcommand{\autolabels}{%
    \stepcounter{helpsection}\label{sec:\thehelpchapter.\thehelpsection}%
    \afterpage{\stepcounter{pagesection}\setcounter{helpsection}{\value{pagesection}}}%
}
\newcommand{\autolabelc}{%
    \stepcounter{helpchapter}\label{ch:\thehelpchapter}%
    \afterpage{\stepcounter{pagechapter}\setcounter{helpchapter}{\value{pagechapter}}}%
}

%% PUT THESE AFTER TOC
% \let\oldsection\section
% \renewcommand{\section}[1]{\oldsection{#1}\autolabels}
% \let\oldchapter\chapter
% \renewcommand{\chapter}[1]{\oldchapter{#1}\autolabelc}


% -------- SECTION HEADINGS --------
% \renewcommand{\thepage}{\oldstynum{page}}
\renewcommand{\thechapter}{{\oldmlmodern\arabic{chapter}}}
\renewcommand{\thesection}{{\oldmlmodern\arabic{chapter}.\arabic{section}}}
\renewcommand{\thesubsection}{{\oldmlmodern\arabic{chapter}.\arabic{section}.\arabic{subsection}}}

% \RequirePackage{titlesec} % modify title section
% \titlelabel{\thetitle.\quad}
% \titleformat*{\section}{\large\bfseries\sffamily}
% \titleformat{\chapter}[display]{\sffamily\huge}{Chapter \thechapter}{0pt}{}[]


% -------- BIBLIOGRAPHY --------
% \RequirePackage[numbers,sort&compress]{natbib} % number + sort
% \RequirePackage[]{natbib}
% \bibliographystyle{apalike}

% \bibliography{<bib file>} % make references list

\endinput

novelette.cls, version 1.1

This class provides custom layout for making article or book.

See https://github.com/goldhand-c