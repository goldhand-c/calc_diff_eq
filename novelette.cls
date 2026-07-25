\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{novelette}[2026/6/13 Custom Book]

% Option
\edef\baseclass{article}

% Load the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\ProcessOptions\relax
\LoadClass{\baseclass}


% -------- PAGE SETUP --------
\RequirePackage[ % use \newgeometry{top=7mm,bottom=6mm,...,includehead,includefoot} to keep vertical margin
    a4paper,   % paper size
    top=7mm,   bottom=30mm,  % margin
    left=23mm, right=23mm,
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
\RequirePackage{setuptext, thaitext, setupsci, setcommand}


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

\endinput

novelette.cls, version 1.1

This class provides custom layout for making article or book.

See https://github.com/goldhand-c