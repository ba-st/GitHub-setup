#!/usr/bin/env bash

usage() {
    if [ "$*" != "" ] ; then
        echo "Error: $*"
    fi

    cat << EOF
Usage: $(basename $0) -p PROJECT_NAME [-r REPO_NAME] [-o OWNER] [-c COPYRIGHT_HOLDER] [-d DEFAULT_BRANCH]
This program will create a project teamplate using ba-st conventions.
Options:
-p PROJECT_NAME     Used for the name of the project
-r REPO_NAME        Used for the code repository.  Defaults to PROJECT_NAME.
-o OWNER            Used as the repository owner. Defaults to ba-st.
-c COPYRIGHT_HOLDER Used as the copyright holder in the license file. Defaults to Buenos Aires Smalltalk Contributors.
-d DEFAULT_BRANCH   Used as the default branch name in the documentation templates. Defaults to release-candidate
-h                  Display this usage message and exit

Example:
    $(basename $0) -p "Willow Bootstrap" -r Willow-Bootstrap -o gcotelli -c "Monsters Inc." -d master
EOF

    exit 1
}
