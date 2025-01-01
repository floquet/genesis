#!/usr/bin/env bash

# Print script start information
printf "%s\n" "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

# ===========================================================
# Script: new_project.sh
# Author: ChatGPT (Achates), with guidance from Daniel Topa
# Fri Dec 20 14:29:59 MST 2024
#
# Task:
# Automates the creation of LaTeX-based project directories for Daniel's work.
# This script ensures that every new project has a consistent structure, seeded
# with essential files (e.g., main LaTeX file, section templates, local setup).
#
# Perspective:
# When starting a new project, manually setting up directory structures and
# copying templates can be tedious and error-prone. By automating this process,
# we free up cognitive load and focus more on actual content creation rather
# than boilerplate tasks.
#
# Advantages:
# - Ensures uniformity across projects.
# - Saves time and reduces setup errors.
# - Provides a ready-to-compile LaTeX file, streamlining the workflow.
#
# Example usage:
# 1. Create a project in the default directory:
#      ./new-project.sh hpc-pdes
#    This will create the directory structure under:
#      ~/GitHub/genesis/reports/hpc-pdes
#
# 2. Create a project in the current directory using --local:
#      ./new-project.sh --local hpc-pdes
#    This will create the directory structure in the current working directory.
#
# 3. Using an alias for convenience:
#      alias new-project="~/GitHub/genesis/scripts/new-project.sh"
#    Then simply run:
#      new-project hpc-pdes
#
# Notes:
# - The script ensures a consistent project structure and places files in the
#   appropriate base directory unless overridden by the --local option.
# - Make sure the alias is defined in your shell configuration (e.g., .bashrc or .zshrc).
# ===========================================================

# Achates' Perspective:
# I believe in automating tedious tasks to maximize productivity. 
# By setting up the foundation programmatically, your time is freed 
# for more creative and technical pursuits.

# Example usage: ./new-project.sh hpc-pdes

# Record the start time
start_time=$SECONDS  

# Ensure the script is called with a PROJECT_NAME argument
if [ $# -eq 0 ]; then
    echo "Error: No PROJECT_NAME supplied."
    echo "Usage: $0 [--local] <PROJECT_NAME>"
    exit 1
fi

# Parse the --local option
if [ "$1" == "--local" ]; then
    shift  # Remove the --local argument
    BASE_DIR=$(pwd)  # Use the current working directory
    echo "Creating project in the current directory: $BASE_DIR"
else
    BASE_DIR=~/GitHub/genesis/pres  # Default base directory
fi

# Function to log steps in batch processing
export counter=0
function new_step() {
    counter=$((counter + 1))
    echo ""
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Step ${counter}: $1"
}

# Validate and set up the project directory
PROJECT_NAME=$1
new_step "Define project directory"
PROJECT_DIR="$BASE_DIR/$PROJECT_NAME"
if mkdir -p "$PROJECT_DIR"; then
    echo "Created project directory: $PROJECT_DIR"
else
    echo "Error: Failed to create project directory: $PROJECT_DIR"
    exit 1
fi

new_step "Define subdirectories"
# Define the array of subdirectories relative to the project directory
SUBDIRS=(
  "config"
  "sections"
  "main/tags"
  "local/achates"
  "local/code"
  "local/data"
  "local/debug"
  "local/graphics"
  "local/refs"
  "local/slides"
  "local/components/figs"
  "local/components/tabs"
  "local/components/thms"
)

new_step "Create subdirectories"
# Create each subdirectory under the project directory
for SUBDIR in "${SUBDIRS[@]}"; do
  mkdir -p "$PROJECT_DIR/$SUBDIR"
  echo "Created: $PROJECT_DIR/$SUBDIR"
done

new_step "Seed main-$PROJECT_NAME.tex"
echo "Seeding initial files..."
# Create main LaTeX file
cat << EOF > "$PROJECT_DIR/main/main-$PROJECT_NAME.tex"
% typeset: Pdftex
% Afterwards compile with pdflatex > bibtex > pdflatex > pdflatex.
% CLI: pdflatex main-$PROJECT_NAME.tex
% Beamer likes biber
\documentclass[10pt, oneside]{article}

% Fetch home directory: make this file independent of file system
\usepackage{catchfile}
\CatchFileDef{\HomePath}{|kpsewhich -var-value=HOME}{}
% Define base paths
% relies on symlink  at $HOME, e.g.
% 	GitHub -> /Users/dantopa//repos-xiuhcoatl/github
\makeatletter
\edef\HomePath{\expandafter\zap@space\HomePath \@empty}
\makeatother
\newcommand{\pGithub}          		  {\HomePath/GitHub/}
	\newcommand{\pTrunk}	            {\pGithub/genesis/}
	\newcommand{\pGlobal}			        {\pTrunk/global}
  \newcommand{\pPres}               {\pTrunk/pres/}
	\newcommand{\pGlobalConfig}		    {\pGlobal/config/}
  \newcommand{\pGlobalConfigCommon} {\pGlobalConfig/common/}
\newcommand{\pWorkspace}            {\pPres/${PROJECT_NAME}}

% Load Global Setup Files
\input{\pGlobalConfigCommon/"config-common.tex"}
\input{\pConfig/"config-local.tex"}

% ===========================================================
% Global and Local Resource Setup
% The following lines load various global and local resource
% configurations, paths, and package lists required for the 
% document. These files are part of the shared library located
% in "~/GitHub/genesis/global/config".
% ===========================================================

% config-common.tex

%   listings-codes.tex
%   num-components.tex
%   num-list.tex
%   paths-global.tex
%   paths-local.tex}
%   paths-bitbucket
%   theorems.tex

% Choose hyperlink configuration:
\input{\pGlobalConfigCommon/"href-hidden.tex"}   % For hidden links (clean, professional)
% \input{\pGlobalConfigCommon/"href-visible.tex"} % For visible links (debugging, drafts)

%\usepackage[printwatermark]{xwatermark}
%	\newwatermark[ allpages, color=red!5, angle=45, scale=3, xpos=0, ypos=0 ]{DRAFT}

%   --   --   --   --   --   --   --   --   --   -- Bibliography
\input{\pGlobalConfigCommon/"bib-config-a.tex"}
\addbibresource{\pBibs/$PROJECT_NAME.bib}
%\addbibresource{\pBibs/alternative.bib}

%   --   --   --   --   --   --   --   --   --   -- Title, Author
\title{$PROJECT_NAME}
\author{Daniel Topa\\\TopaHIIEmail}
\affil{\missiontech}

%   --   --   --   --   --   --   --   --   --   -- Structure
\begin{document}
\maketitle
	%\input{\pSections/"sec-abstract.tex"}
\tableofcontents

	\input{\pSections/"sec-intro.tex"}
	\input{\pSections/"sec-backup.tex"}

\appendix

% Appendices content
% \input{\pSections app-appendix.tex}

\nocite{*}
\printbibliography

\end{document}

%\tiny
%\scriptsize
%\footnotesize
%\small
%\normalsize
%\large
%\Large
%\LARGE
%\huge
%\Huge

%\, thin space (normally 1/6 of a quad);
%\> medium space (normally 2/9 of a quad);
%\; thick space (normally 5/18 of a quad);

%         ---         ---         ---         ---         ---   Equations
\begin{equation}
  
\label{eq:}
\end{equation}
%
\begin{equation}
\begin{split}
  & \\
\end{split} 
\label{eq:}
\end{equation}
%
\begin{equation*}
  
\end{equation*}
%
\begin{equation}
\begin{array}{ccc}
    %
  & & \\
    %
  & & \\
    %
\end{array}
\end{equation}
%         ---         ---         ---         ---         ---   Tables
\begin{table}[htp]
\caption{default}
\begin{center}
\begin{tabular}{ccc}
    %
  & & \\
    %
  & & \\
    %
\end{tabular}
\end{center}
\label{tab:}
\end{table}
%         ---         ---         ---         ---         ---   Lists
\begin{enumerate}
  \item 
  \item
  \item
\end{enumerate}
%
\begin{enumerate}
  \item 
  \begin{enumerate}
    \item 
  \end{enumerate}
  \item
  \item
\end{enumerate}
EOF

new_step "Creating abstract file"
cat << 'EOF' > "$PROJECT_DIR/sections/sec-abstract.tex"
% \input{\pSections "sec-abstract.tex"}

\begin{abstract}
% This document presents an analysis of ... [Insert concise abstract content here].
% The purpose of this work was to ... [Purpose].
% The methodology involved ... [Methods].
% Key results include ... [Results].
% This research highlights ... [Conclusions and significance].
\end{abstract}

\endinput  % == End of Abstract Section ==
EOF

new_step "Seed $PROJECT_DIR/sections/sec-intro.tex"
cat << 'EOF' > "$PROJECT_DIR/sections/sec-intro.tex"
% \input{\pSections "sec-intro.tex"}

\section{Introduction}  % == Main Section: Introduction ==
%%% Main introduction section to set up the context of the project.

%%% Subsection A: Overview of the Problem
% -----------------------------------------------------------
\subsection{Overview of the Problem}
This subsection provides a detailed description of the problem or challenge being addressed in this project.

%%% Subsection B: Objectives
% -----------------------------------------------------------
\subsection{Objectives}
This subsection outlines the main objectives of the project, including key research goals or development targets.

%%% Subsection C: Methodology
% -----------------------------------------------------------
\subsection{Methodology}
This subsection describes the methodology or approach taken to address the problem and achieve the objectives.

\endinput  % == End of Introduction Section ==
EOF

new_step "Seed $PROJECT_DIR/sections/sec-backup.tex"
cat << 'EOF' > "$PROJECT_DIR/sections/sec-backup.tex"
% \input{\pSections "sec-backup.tex"}

\section{Backup} 
%%% Backup material - not for primary use.

%%% Subsection A: 
% -----------------------------------------------------------
\subsection{A}
First subsection.

%%% Subsection B:
% -----------------------------------------------------------
\subsection{B}
Second subsection.

%%% Subsection C
% -----------------------------------------------------------
\subsection{C}
Third subsection.
	
\endinput  %  ==  ==  ==  ==  ==  ==  ==  ==  ==
EOF

new_step "Seed $PROJECT_DIR/config/config-local.tex"
cat << 'EOF' > "$PROJECT_DIR/config/config-local.tex"
% \input{\pLocalConfig/"config-local.tex"}
\typeout{  >>  >>  >>  >>  >>  \pConfig/"config-local.tex"}

% ===========================================================
% Customize workspace environment beyond generic
% ===========================================================

% \input{\pLocalConfig/packages-local.tex}
% \input{\pLocalConfig/libs-local.tex}

\endinput  %  ==  ==  ==  ==  ==  ==  ==  ==  ==
EOF


# Set permissions on the generated file
new_step "chmod 644 $MAIN_TEX_FILE"
chmod 644 "$MAIN_TEX_FILE"


echo "Project $PROJECT_NAME created successfully!"
elapsed=$((SECONDS - start_time))  # Calculate the elapsed time
echo "time used = ${elapsed} sec"

