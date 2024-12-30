#!/usr/bin/env bash
printf "%s\n" "$(tput bold)$(date) ${BASH_SOURCE[0]}$(tput sgr0)"

TYPE=$1
DOCUMENT_DIR=$2
DOCUMENT_NAME=$3

echo "Seeding files for $DOCUMENT_NAME"

# Seed main LaTeX file
cat << EOF > "$DOCUMENT_DIR/main/main-$DOCUMENT_NAME.tex"
\documentclass[10pt, oneside]{${TYPE}}
\usepackage{catchfile}
\CatchFileDef{\HomePath}{|kpsewhich -var-value=HOME}{}
% Base paths
\newcommand{\type} {$TYPE}
\newcommand{\pProj} {\HomePath/GitHub/genesis/$TYPE/$DOCUMENT_NAME/}
% Load configuration
\input{\pProj/config/config-local.tex}
\begin{document}
\maketitle
\tableofcontents
\input{\pProj/sections/sec-intro.tex}
\end{document}
EOF

# Seed other files (abstract, intro, backup)
cat << 'EOF' > "$DOCUMENT_DIR/sections/sec-intro.tex"
\section{Introduction}
This is the introduction.
EOF

cat << 'EOF' > "$DOCUMENT_DIR/sections/sec-backup.tex"
\section{Backup}
This is the backup section.
EOF
