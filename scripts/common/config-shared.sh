% \input{\pGlobConfCom/"config-shared.tex"}
%
% Shared Configuration Block
%
% This file defines the base paths and configuration sequence for LaTeX projects.
% The `\type` macro is expected to be injected dynamically (e.g., `docs`, `pres`).
% All paths and configurations adapt based on the injected `\type`.

% Define Base Paths
\newcommand{\pGithub} {\HomePath/GitHub/}
\newcommand{\pGenesis} {\pGithub/genesis/}
\newcommand{\pType} {\pGenesis/\type/}
\newcommand{\pProj} {\pGenesis/\type/project-name}  % Adjust `project-name` dynamically
\newcommand{\pGlob} {\pGenesis/global/}
\newcommand{\pGlobConf} {\pGlob/config/}
\newcommand{\pGlobConfCom} {\pGlobConf/common/}
\newcommand{\pGlobConfType} {\pGlobConf/\type/}

% Debug Output
\typeout{  **  **  **  **  **  Begin configuration sequence: Global, Pres, Local}
\typeout{  **  **  **  **  **  pGlobConfType = \pGlobConfType}

% Load Configuration Files
\input{\pGlobConfCom/"config-common-01.tex"}
\input{\pGlobConfType/"config-type.tex"}
\input{\pConfig/"config-local.tex"}

\endinput  % End of Shared Configuration Block
