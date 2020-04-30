#!/usr/bin/env bash

usage() {
    if [ "$*" != "" ] ; then
        print_error "Error: $*"
    fi

    cat << EOF
Usage: $(basename $0) -p PROJECT_NAME [-r REPO_NAME] [-o OWNER] [-c COPYRIGHT_HOLDER] [-d DEFAULT_BRANCH] [-b BUILD_SERVICE]
This program will create a project template using ba-st conventions.
Options:
-p PROJECT_NAME     Used for the name of the project.
-r REPO_NAME        Used for the code repository.  Defaults to PROJECT_NAME.
-o OWNER            Used as the repository owner. Defaults to ba-st.
-c COPYRIGHT_HOLDER Used as the copyright holder in the license file. Defaults to Buenos Aires Smalltalk Contributors.
-d DEFAULT_BRANCH   Used as the default branch name in the documentation templates. Defaults to release-candidate.
-b BUILD_SERVICE    Used to configure the build service to use. Defaults to github.
                      The valid options are github (GitHub Actions) and travis (Travis CI).
-h                  Display this usage message and exit.

Example:
    $(basename $0) -p "Willow Bootstrap" -r Willow-Bootstrap -o gcotelli -c "Monsters Inc." -d master
EOF

    exit 1
}
