%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                            %%
%% Class ``>UTN Tesis LyX''                                                   %%
%%                                                                            %%
%% Plantilla tesis master Instituto de Posgrado Universidad Técnica del Norte %%
%% Ported to LyX 2.0                                                          %%
%% Version: v1.1                                                              %%
%% Authors: Krishna Kumar                                                     %%
%% Modificado por: Roberto López Hinojosa                                     %%
%% Date: 2015/02/10                                                           %%
%% License: MIT License (c) 2013 Krishna Kumar                                %%
%% Based on: https://github.com/kks32/UTN-thesis-template/                    %%
%% Git Repo: https://github.com/kks32/UTN-MasterTesis-LyX/                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ************************** Class Identification ******************************
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UTN-MasterTesis-LyX}[2016/06/10 version 1.01]
\typeout{https://github.com/erlopezh/UTN-MasterTesis-LyX/}


% ******************************************************************************
% **************************** Class Definition ********************************
% ******************************************************************************

% *********************** Define a Print/Online Version ************************
\newif\if@print\@printfalse
\DeclareOption{print}{\@printtrue}

% ****************************** Define index **********************************
\newif\ifUTN@index\UTN@indexfalse
\DeclareOption{index}{\UTN@indextrue}

% ******************************* Font Option **********************************
\newif\ifsetFont\setFontfalse % Font is not set

\newif\ifUTN@times\UTN@timesfalse % Times with Math Support
\DeclareOption{times}{\UTN@timestrue}

\newif\ifUTN@fourier\UTN@fourierfalse % Fourier with Math Support
\DeclareOption{fourier}{\UTN@fouriertrue}

\newif\ifUTN@customfont\UTN@customfontfalse % Custom Font with Math Support
\DeclareOption{customfont}{\UTN@customfonttrue}

% ******************************* Bibliography *********************************
\newif\ifsetBib\setBibfalse % Using Custom Bibliography

\newif\ifUTN@authoryear\UTN@authoryearfalse % Author-Year citation
\DeclareOption{authoryear}{\UTN@authoryeartrue}

\newif\ifUTN@numbered\UTN@numberedfalse % Numbered citiation
\DeclareOption{numbered}{\UTN@numberedtrue}

\newif\ifUTN@custombib\UTN@custombibfalse % Custom Bibliography
\DeclareOption{custombib}{\UTN@custombibtrue}

% ************************* Header / Footer Styling ****************************
\newif\ifUTN@pageStyleI\UTN@pageStyleIfalse % Set Page StyleI
\DeclareOption{PageStyleI}{\UTN@pageStyleItrue}

\newif\ifUTN@pageStyleII\UTN@pageStyleIIfalse % Set Page StyleII
\DeclareOption{PageStyleII}{\UTN@pageStyleIItrue}

% ***************************** Custom Margins  ********************************
\newif\ifsetMargin\setMarginfalse % Margins are not set

\newif\ifUTN@custommargin\UTN@custommarginfalse % Custom margin
\DeclareOption{custommargin}{\UTN@custommargintrue}

% **************************** Separate Abstract  ******************************
\newif \ifdefineAbstract\defineAbstractfalse %To enable Separate abstract

\newif\ifUTN@abstract\UTN@abstractfalse % Enable Separate Abstract
\DeclareOption{abstract}{
  \UTN@abstracttrue
  \ClassWarning{UTN-MasterTesis-LyX}{You have chosen an option that generates only
the Title page and an abstract with UTN title and author name, if this was
intentional, ignore this warning. Congratulations on submitting your thesis!!
If not, please remove the option `abstract' from the document class and
recompile. Good luck with your writing!}
}

% ****************** Chapter Mode - To print only selected chapters ************
\newif \ifdefineChapter\defineChapterfalse %To enable Separate abstract

\newif\ifUTN@chapter\UTN@chapterfalse % Enable Separate Abstract
\DeclareOption{chapter}{
  \UTN@chaptertrue
  \ClassWarning{UTN-MasterTesis-PSnPDF}{You have chosen an option that generates only selected chapters with references, if this was intentional, ignore this warning. If not, please remove the option `chapter' from the document class and recompile. Good luck with your writing!}
}

\ProcessOptions\relax%

% *************************** Pre-defined Options ******************************

% Font Size
\newcommand\UTN@ptsize{12pt} %Set Default Size as 12

\DeclareOption{10pt}{f
  \ClassWarning{UTN-MasterTesis-LyX}{La guía de tesis del Instituto de Posgrado de la UTN recomienda
  el uso de un tamaño de fuente mínimo de 11pt (12pt preferible) y 10pt para las notas al pie.}
  \renewcommand\UTN@ptsize{10pt}
}
\DeclareOption{11pt}{\renewcommand\UTN@ptsize{11pt}}%
\DeclareOption{12pt}{\renewcommand\UTN@ptsize{12pt}}%
\PassOptionsToClass{\UTN@ptsize}{book}%

% Page Size
\newcommand\UTN@papersize{a4paper} % Set Default as a4paper

\DeclareOption{a4paper}{\renewcommand\UTN@papersize{a4paper}}
\DeclareOption{a5paper}{\renewcommand\UTN@papersize{a5paper}}
\DeclareOption{letterpaper}{
  \ClassWarning{UTN-MasterTesis-LyX}{La guía de tesis del Instituto de Posgrado de la UTN recomienda el uso de papel A4 o A5}
  \renewcommand\UTN@papersize{letterpaper}
}

\PassOptionsToClass{\UTN@papersize}{book}%

% Column layout
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{book}}%
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{book}}%

% Draft Mode
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{book}}%

% Generates Warning for unknown options
\DeclareOption*{
  \ClassWarning{UTN-MasterTesis-LyX}{Unknown or non-standard option
'\CurrentOption'. I'll see if I can load it from the book class. If you get a
warning unused global option(s): `\CurrentOption` then the option is not
supported!}
  \PassOptionsToClass{\CurrentOption}{book}
}

% Determine whether to run pdftex or dvips
\ProcessOptions\relax%
\newif\ifsetDVI\setDVIfalse
\ifx\pdfoutput\undefined
  % we are not running PDFLaTeX
  \setDVItrue
  \LoadClass[dvips,fleqn,openright]{book}%
\else % we are running PDFLaTeX
  \ifnum \pdfoutput>0
    %PDF-Output
    \setDVIfalse
    \LoadClass[pdftex,fleqn,openright]{book}%
  \else
    %DVI-output
    \setDVItrue
    \LoadClass[fleqn,openright]{book}%
  \fi
\fi

%* ***************************** Print / Online ********************************
% Defines a print / online version to define page-layout and hyperrefering
\ifsetDVI
\special{papersize=\the\paperwidth,\the\paperheight}
\RequirePackage[dvips,unicode=true]{hyperref}
\else
\RequirePackage[unicode=true]{hyperref}
\pdfpagewidth=\the\paperwidth
\pdfpageheight=\the\paperheight
\fi

\if@print
    % For Print version
    \hypersetup{
      final=true,
      plainpages=false,
      pdfstartview=FitV,
      pdftoolbar=true,
      pdfmenubar=true,
      bookmarksopen=true,
      bookmarksnumbered=true,
      breaklinks=true,
      linktocpage,
      colorlinks=true,
      linkcolor=black,
      urlcolor=black,
      citecolor=black,
      anchorcolor=black
    }
    \ifUTN@custommargin
        \setMarginfalse
    \else
        \ifsetDVI
        % Odd and Even side Margin for binding and set viewmode for PDF
	\RequirePackage[dvips,paper=\UTN@papersize,hmarginratio=1:1,vmarginratio=1:1,scale=0.75,bindingoffset=5mm]{geometry}
        \else
	\RequirePackage[pdftex,paper=\UTN@papersize,hmarginratio=1:1,vmarginratio=1:1,scale=0.75,bindingoffset=5mm]{geometry}
        \fi
	\setMargintrue
    \fi

    \if@twoside
        \hypersetup{pdfpagelayout=TwoPageRight}
    \else
    	\hypersetup{pdfpagelayout=OneColumn}
    \fi

\else
    % For PDF Online version
    \hypersetup{
      final=true,
      plainpages=false,
      pdfstartview=FitV,
      pdftoolbar=true,
      pdfmenubar=true,
      bookmarksopen=true,
      bookmarksnumbered=true,
      breaklinks=true,
      linktocpage,
      colorlinks=true,
      linkcolor=blue,
      urlcolor=blue,
      citecolor=blue,
      anchorcolor=green
    }

    \ifUTN@custommargin
        \setMarginfalse
    \else
	% No Margin staggering on Odd and Even side
        \ifsetDVI
	\RequirePackage[dvips,paper=\UTN@papersize,hmarginratio=1:1,vmarginratio=1:1,scale=0.75]{geometry}
        \else
	\RequirePackage[pdftex,paper=\UTN@papersize,hmarginratio=1:1,vmarginratio=1:1,scale=0.75]{geometry}
        \fi
        \setMargintrue
    \fi

    \hypersetup{pdfpagelayout=OneColumn}
\fi



% ******************************************************************************
% ******************************** Packages ************************************
% ******************************************************************************


% ************************** Layout and Formatting *****************************
\def\pdfshellescape{1}
\RequirePackage{lscape}   % Supports Landscape Layout
\RequirePackage{setspace} % Define line spacing in paragraph
\RequirePackage{calc}     % To calculate vertical spacing

% ************************* Conditional Statements *****************************
\RequirePackage{ifthen}   % Used in LaTeX Class files for conditional statements
\RequirePackage{ifpdf}    % Check for pdfLaTeX


% *********************** Table of Contents & Appendices ***********************
% add Bibliography, List of figures and tables to contents
\RequirePackage[nottoc]{tocbibind}
% Add appendices
\RequirePackage[title,titletoc]{appendix}

% *************************** Graphics and Figures *****************************
\RequirePackage[usenames, dvipsnames]{color}
\ifpdf
        % Convert eps figures to pdf
        \RequirePackage{epstopdf}
        \RequirePackage[pdftex]{graphicx}
	\DeclareGraphicsExtensions{.png, .jpg, .pdf}
	\pdfcompresslevel=9
	\graphicspath{{Figs/Raster/}{Figs/}}
\else
	\RequirePackage{graphicx}
	\DeclareGraphicsExtensions{.eps, .ps}
	\graphicspath{{Figs/Vector/}{Figs/}}
\fi


% ************************ URL Package and Definition **************************
\RequirePackage{url}
% Redefining urlstyle to use smaller fontsize in References with URLs
\newcommand{\url@leostyle}{%
 \@ifundefined{selectfont}{\renewcommand{\UrlFont}{\sffamily}}
 {\renewcommand{\UrlFont}{\normal}}}
\urlstyle{leo}

% ******************************* Bibliography *********************************
\ifUTN@authoryear
\RequirePackage[natbibapa, numberedbib, includecorporate,tocbib]{apacite} %author year
%-------------------
%\RequirePackage[round, sort, numbers, authoryear]{natbib} %author year
%-------------------
\setBibtrue
\else
     \ifUTN@numbered
     \RequirePackage[numbers,sort&compress]{natbib} % numbered citation
     \setBibtrue
     \else
         \ifUTN@custombib
         \setBibfalse
         \else
         \RequirePackage[numbers,sort&compress]{natbib} % Default - numbered
         \setBibtrue
	 \ClassWarning{UTN-MasterTesis-LyX}{No bibliography style was specified.
Default numbered style is used. If you would like to use a different style, use
`authoryear' or `numbered' in the options in documentclass or use `custombib`
and define the natbibpackage with required style in the Preamble.tex file}
         \fi
     \fi
\fi

% ***************************** Math and SI Units ******************************

\usepackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% *********************** To copy ligatures and Fonts **************************
\RequirePackage{textcomp}
\RequirePackage[utf8,latin9]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage [spanish, es-tabla]{babel} %para generar Cuadros con etiqueta TABLA


% Font Selection
\ifUTN@times
\RequirePackage{mathptmx}  % times roman, including math (where possible)
\setFonttrue
\else
     \ifUTN@fourier
     \RequirePackage{fourier} % Fourier
     \setFonttrue
     \else
          \ifUTN@customfont
          \setFontfalse
          \else
	  \ClassWarning{UTN-MasterTesis-PSnPDF}{Using default font Latin Modern. If you
would like to use other pre-defined fonts use `times' (La guía de tesis del Instituto de Posgrado de la UTN
recomienda  el uso de la fuente Times)  o `fourier' o la carga de una fuente perzonalizada
en el archivo preamble.tex especificando `customfont' en las opciones de clase (class options)}
          \RequirePackage{lmodern}
          \setFonttrue
          \fi
    \fi
\fi


%PARA CAPITULOS
\usepackage{sectsty}
\chapterfont{\normalsize \centering \MakeUppercase}
\sectionfont{\normalsize}
\subsectionfont{\normalsize}
%FIN CCAP


\input{glyphtounicode}
\pdfglyphtounicode{f_f}{FB00}
\pdfglyphtounicode{f_i}{FB01}
\pdfglyphtounicode{f_l}{FB02}
\pdfglyphtounicode{f_f_i}{FB03}
\pdfglyphtounicode{f_f_l}{FB04}
\pdfgentounicode=1


% ******************************************************************************
% **************************** Pre-defined Settings ****************************
% ******************************************************************************

% *************************** Setting PDF Meta-Data ****************************
\ifpdf
\AtBeginDocument{
  \hypersetup{
    pdftitle = {\@title},
    pdfauthor = {\@author},
    pdfsubject={\@subject},
    pdfkeywords={\@keywords}
  }
}
\fi


% ************************** TOC and Hide Sections *****************************
\newcommand{\nocontentsline}[3]{}
\newcommand{\tochide}[2]{
	\bgroup\let
	\addcontentsline=\nocontentsline#1{#2}
	\egroup}
% Removes pagenumber appearing from TOC
\addtocontents{toc}{\protect\thispagestyle{empty}}


% ***************************** Header Formatting ******************************
% Custom Header with Chapter Number, Page Number and Section Numbering

\RequirePackage{fancyhdr} % Define custom header




\renewcommand{\chaptermark}[1]{\markboth{#1}{} \uppercase}



% Set Fancy Header Command is defined to Load FancyHdr after Geometry is defined
\newcommand{\setFancyHdr}{

\pagestyle{fancy}
\ifUTN@pageStyleI
% Style 1: Sets Page Number at the Top and Chapter/Section Name on LE/RO
\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1\ }}
\fancyhf{}
\fancyhead[RO]{\nouppercase \rightmark\hspace{0.25em} | \hspace{0.25em} \bfseries{\thepage}}
\fancyhead[LE]{ {\bfseries\thepage} \hspace{0.25em} | \hspace{0.25em} \nouppercase \leftmark}


\else
\ifUTN@pageStyleII
% Style 2: Sets Page Number at the Bottom with Chapter/Section Name on LO/RE
\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
\fancyhf{}
\fancyhead[RO]{\bfseries\nouppercase \rightmark}
\fancyhead[LE]{\bfseries \nouppercase \leftmark}
\fancyfoot[C]{\thepage}


\else
% Default Style: Sets Page Number at the Top (LE/RO) with Chapter/Section Name
% on LO/RE and an empty footer
\renewcommand{\chaptermark}[1]{\markboth {##1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
\fancyhf{}
\fancyhead[LO]{\nouppercase \rightmark}
\fancyhead[LE,RO]{\bfseries\thepage}
\fancyhead[RE]{\nouppercase \leftmark}
\fi

\fi

}

\setlength{\headheight}{14.5pt}
%\renewcommand{\headrulewidth}{0.5pt}
%\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{
  \fancyhead{}
  \renewcommand{\headrulewidth}{0pt}
}

% If Margin has been set (default margin print/online version)
\ifsetMargin
\setFancyHdr % Apply fancy header settings otherwise apply it in preamble
\fi

% **************** Clear Header Style on the Last Empty Odd pages **************
\renewcommand{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else%
	\hbox{}%
	\thispagestyle{empty}  % Empty header styles
	\newpage%
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}


% ******************************** Roman Pages *********************************
% The romanpages environment set the page numbering to lowercase roman one
% for the contents and figures lists. It also resets
% page-numbering for the remainder of the dissertation (arabic, starting at 1).

\newenvironment{romanpages}{
  \setcounter{page}{1}
  \renewcommand{\thepage}{\roman{page}}}
{\newpage\renewcommand{\thepage}{\arabic{page}}}


% ******************************************************************************
% **************************** Macro Definitions *******************************
% ******************************************************************************
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

% The year and term the degree will be officially conferred
\newcommand{\@degreedate}{}
\newcommand{\degreedate}[1]{\renewcommand{\@degreedate}{#1}}

% The full (unabbreviated) name of the degree
\newcommand{\@degree}{}
\newcommand{\degree}[1]{\renewcommand{\@degree}{#1}}

% The name of your department(eg. Engineering, Maths, Physics)
\newcommand{\@dept}{}
\newcommand{\dept}[1]{\renewcommand{\@dept}{#1}}

% The name of your college (eg. King's)
\newcommand{\@college}{}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}

% The name of your University
\newcommand{\@university}{}
\newcommand{\university}[1]{\renewcommand{\@university}{#1}}

% Nombres del TUTOR
\newcommand{\@tutor}{}
\newcommand{\tutor}[1]{\renewcommand{\@tutor}{#1}}

% Defining the crest
\newcommand{\@crest}{}
\newcommand{\crest}[1]{\renewcommand{\@crest}{#1}}

% Submission Text
\newcommand{\submissiontext}{Plan de trabajo previo al grado de }

% texto dirección/tutoría
\newcommand{\tutortext}{Tutor: }

% keywords (These keywords will appear in the PDF meta-information
% called `pdfkeywords`.)
\newcommand{\@keywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}

% subjectline (This subject will appear in the PDF meta-information
% called `pdfsubject`.)
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{#1}}


% These macros define an environment for front matter that is always
% single column even in a double-column document.
\newenvironment{alwayssingle}{%
       \@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
       \else\newpage\fi}
       {\if@restonecol\twocolumn\else\newpage\fi}

% Set single column even under two column layout
\newcommand{\setsinglecolumn}{
\if@twocolumn
   \onecolumn
\else
\fi
}


% ******************************************************************************
% *************************** Front Matter Layout ******************************
% ******************************************************************************

% ******************************** Title Page **********************************
\renewcommand{\maketitle}{

% To compute the free vertical space in Title page
\computeTitlePageSpacing

\begin{singlespace}
\begin{center}

%Univerdad
{\Huge \@university \par}

% Department
{\LARGE \@dept \par}
\vspace*{5mm}

% Crest
{\@crest \par}
\vspace{.2\UTN@titlepagespacing}

% Title
{\LARGE \bfseries{\@title} \par}
\vspace{.25\UTN@titlepagespacing}


% Author
{\large \bfseries{\@author} \par}
\vspace{.1\UTN@titlepagespacing}


% Submission Text
{\large \submissiontext \par}
\vspace*{1ex}
{\large \textit {\@degree} \par}
\vspace{.1\UTN@titlepagespacing}

% TUTOR
{\large \tutortext \par}
{\large {\@tutor} \par}
\vspace*{1ex}


\end{center}
\vfill
\large
\begin{minipage}{0.49\textwidth}
\flushleft\hspace*{\oddsidemargin}\@college
\end{minipage}
\begin{minipage}{0.49\textwidth}
%\flushright
\@degreedate
\end{minipage}
\end{singlespace}
}


% ********************************* Dedication *********************************
% The dedication environment makes sure the dedication gets its
% own page, centered

\newenvironment{dedication}
{
\cleardoublepage
\setsinglecolumn
\vspace*{0.2\textheight}
\thispagestyle{empty}
\centering
}



% ******************************* Declaration **********************************
% The declaration environment puts a large, bold, centered
% "Declaration" label at the top of the page.

\newenvironment{declaration}{
\cleardoublepage
\setsinglecolumn
\chapter*{\centering \Large Declaratoria}
\thispagestyle{empty}
}{
\flushright
\@author{}\\
\@degreedate{}
\vfill
}



% ****************************** Acknowledgements ********************************
% The acknowledgements environment puts a large, bold, centered
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgements}{
\cleardoublepage
\setsinglecolumn
\chapter*{\centering \Large Agradecimientos}
\thispagestyle{empty}
}



% ******************************* Nomenclature *********************************
\RequirePackage{nomencl}
\makenomenclature
\renewcommand{\nomgroup}[1]{%
\ifthenelse{\equal{#1}{A}}{\item[\textbf{Roman Symbols}]}{%
\ifthenelse{\equal{#1}{G}}{\item[\textbf{Greek Symbols}]}{%
\ifthenelse{\equal{#1}{Z}}{\item[\textbf{Acronyms / Abbreviations}]}{%
\ifthenelse{\equal{#1}{R}}{\item[\textbf{Superscripts}]}{%
\ifthenelse{\equal{#1}{S}}{\item[\textbf{Subscripts}]}{%
\ifthenelse{\equal{#1}{X}}{\item[\textbf{Other Symbols}]}
{}
}% matches mathematical symbols > X
}% matches Subscripts           > S
}% matches Superscripts         > R
}% matches Abbreviations        > Z
}% matches Greek Symbols        > G
}% matches Roman Symbols        > A

% To add nomenclature in the header
\renewcommand{\nompreamble}{\markboth{\nomname}{\nomname}}

% Add nomenclature to contents and print out nomenclature
\newcommand{\printnomencl}[1][]{
\ifthenelse{\equal {#1}{}}
{\printnomenclature}
{\printnomenclature[#1]}
\addcontentsline{toc}{chapter}{\nomname}
}


% ***************************** Create the index *******************************
\ifUTN@index
    \RequirePackage{makeidx}
    \makeindex
    \newcommand{\printthesisindex}{
        \cleardoublepage
        \phantomsection
        \printindex}
\else
    \newcommand{\printthesisindex}{}
\fi


% ***************************** Chapter Mode ***********************************
% The chapter mode allows user to only print particular chapters with references
% All other options are disabled by default
% To include only specific chapters without TOC, LOF, Title and Front Matter
% To send it to supervisior for changes

\ifUTN@chapter
    \defineChaptertrue
    % Disable the table of contents, figures, tables, index and nomenclature
    \renewcommand{\maketitle}{}
    \renewcommand{\tableofcontents}{}
    \renewcommand{\listoffigures}{}
    \renewcommand{\listoftables}{}
    \renewcommand{\printnomencl}{}
    \renewcommand{\printthesisindex}{}
\else
    \defineChapterfalse
\fi


% ******************************** Abstract ************************************
% The abstract environment puts a large, bold, centered "Abstract" label at
% the top of the page. Defines both abstract and separate abstract environment

% To include only the Title and the abstract pages for submission to BoGS
\ifUTN@abstract
    \defineAbstracttrue
    % Disable the table of contents, figures, tables, index and nomenclature
    \renewcommand{\tableofcontents}{}
    \renewcommand{\listoffigures}{}
    \renewcommand{\listoftables}{}
    \renewcommand{\printnomencl}{}
    \renewcommand{\printthesisindex}{}
    \renewcommand{\bibname}{}
    \renewcommand{\bibliography}[1]{\thispagestyle{empty}}
\else
    \defineAbstractfalse
\fi


\newenvironment{abstract} {
\ifUTN@abstract
% Separate abstract as per Student Registry guidelines
	\thispagestyle{empty}
	\setsinglecolumn
	\begin{center}
		{ \Large {\bfseries {\@title}} \par}
		{{\large \vspace*{1em} \@author} \par}
	\end{center}

\else
% Normal abstract in the thesis
	\cleardoublepage
	\setsinglecolumn
	\chapter*{\centering \Large Resumen}
	\thispagestyle{empty}
\fi
}

% ******************************** Line Spacing ********************************
% Set spacing as 1.5 line spacing for the UTN Thesis
% In practice, fortunately, nobody knows really what “one-and-a-half spaced
% type” means exactly (in terms of millimetres baseline distance). The following
% LaTeX setting has routinely been considered perfectly acceptable:

\renewcommand\baselinestretch{1.2}


%*************************************** Listas enumeradas con 1 - 1.1  - 1.1.1
\renewcommand{\labelenumii}{\theenumii}
\renewcommand{\theenumii}{\theenumi.\arabic{enumii}.}
%*************************************** Listas enumeradas ********************

% ******************** To compute empty space in title page ********************
% Boxes below are used to space differt contents on the title page
\newcommand{\computeTitlePageSpacing}{


% Title Box
\newsavebox{\UTN@Title}
\begin{lrbox}{\UTN@Title}
\begin{minipage}[c]{0.98\textwidth}
\centering \Huge \bfseries{\@title}
\end{minipage}
\end{lrbox}

% University Crest Box
\newsavebox{\UTN@crest}
\begin{lrbox}{\UTN@crest}
\@crest
\end{lrbox}

% Author Box
\newsavebox{\UTN@author}
\begin{lrbox}{\UTN@author}
\begin{minipage}[c]{\textwidth}
\centering \Large \bfseries{\@author}
\end{minipage}
\end{lrbox}

% Department Box
\newsavebox{\UTN@dept}
\begin{lrbox}{\UTN@dept}
\begin{minipage}[c]{\textwidth}
\centering {\large \@dept \par}
\vspace*{1ex}
{\large \@university \par}
\end{minipage}
\end{lrbox}

% Submission Box
\newsavebox{\UTN@submission}
\begin{lrbox}{\UTN@submission}
\begin{minipage}[c]{\textwidth}
\begin{center}
\large \submissiontext \par
\vspace*{1ex}
\large \textit {\@degree} \par
\end{center}
\end{minipage}
\end{lrbox}

% College and Date Box
\newsavebox{\UTN@collegedate}
\begin{lrbox}{\UTN@collegedate}
\begin{minipage}[c]{\textwidth}
\large
\begin{minipage}{0.45\textwidth}
\flushleft\@college
\end{minipage}
\begin{minipage}{0.45\textwidth}
\flushright \@degreedate
\end{minipage}
\end{minipage}
\end{lrbox}

%  Now to compute the free vertical space
\newlength{\UTN@titlepagespacing}
\setlength{\UTN@titlepagespacing}{ \textheight %
			- \totalheightof{\usebox{\UTN@Title}}
			- \totalheightof{\usebox{\UTN@crest}}
			- \totalheightof{\usebox{\UTN@author}}
			- \totalheightof{\usebox{\UTN@dept}}
			- \totalheightof{\usebox{\UTN@submission}}
			- \totalheightof{\usebox{\UTN@collegedate}}
}
}
