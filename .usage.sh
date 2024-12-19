#!/usr/bin/env bash

usage() {
    if [ "$*" != "" ] ; then
        print_error "Error: $*"
    fi

    #shellcheck disable=SC2086
    cat << EOF
Usage: $(basename $0) -p PROJECT_NAME [-r REPO_NAME] [-o OWNER] [-c COPYRIGHT_HOLDER] [-d DEFAULT_BRANCH]
This program will create a project template using ba-st conventions.
Options:
-p PROJECT_NAME     Used for the name of the project.
-r REPO_NAME        Used for the code repository.  Defaults to PROJECT_NAME.
-o OWNER            Used as the repository owner id. Defaults to ba-st.
-n OWNER_NAME       Used as the repository owner name. Defaults to OWNER if one is provided or Buenos Aires Smalltalk if not.
-c COPYRIGHT_HOLDER Used as the copyright holder in the license file. Defaults to Buenos Aires Smalltalk Contributors.
-d DEFAULT_BRANCH   Used as the default branch name in the documentation templates. Defaults to release-candidate.
-h                  Display this usage message and exit.

Example:
    $(basename $0) -p "Willow Bootstrap" -r Willow-Bootstrap -o monsters-inc -n "Monsters" -c "Monsters Inc." -d main
EOF

    exit 1
}
