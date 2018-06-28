#!/usr/bin/env bash

usage() {
    if [ "$*" != "" ] ; then
        echo "Error: $*"
    fi

    cat << EOF
Usage: $(basename $0) -p PROJECT_NAME [-r REPO_NAME] [-o OWNER]
This program will create a project teamplate using ba-st conventions.
Options:
-p PROJECT_NAME   Used for the name of the project
-r REPO_NAME      Used for the code repository.  Defaults to PROJECT_NAME.
-o OWNER          Used as the repository owner. Defaults to ba-st.
-h                Display this usage message and exit

Example:
    $(basename $0) -p "Willow Bootstrap" -r Willow-Bootstrap -o gcotelli
EOF

    exit 1
}
