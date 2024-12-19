#!/usr/bin/env bash

# Import utilities
# shellcheck source=.print-utils.sh
source ".print-utils.sh"
# shellcheck source=.usage.sh
source ".usage.sh"

# Exit and show help if the command line is empty
[[ ! "$*" ]] && usage "Not enough arguments"

# Initialise options
PROJECT_OPTION=""
REPO_OPTION=""
OWNER_OPTION=""
OWNER_NAME_OPTION=""
COPYRIGHT_HOLDER_OPTION=""
DEFAULT_BRANCH=""

# Parse command line options
while getopts "p:r:o:n:c:d:h" option; do
  #shellcheck disable=SC2220
  case $option in
    p) PROJECT_OPTION=$OPTARG ;;
    r) REPO_OPTION=$OPTARG ;;
    o) OWNER_OPTION=$OPTARG ;;
    n) OWNER_NAME_OPTION=$OPTARG ;;
    c) COPYRIGHT_HOLDER_OPTION=$OPTARG ;;
    d) DEFAULT_BRANCH=$OPTARG ;;
    h) usage ;;
  esac
done
shift $((OPTIND - 1)); # take out the option flags

readonly PROJECT_NAME="$PROJECT_OPTION"
if [ -z "$PROJECT_NAME" ] ; then
  usage "The project name is mandatory"
fi
readonly REPO_NAME="${REPO_OPTION:-$PROJECT_NAME}"
readonly OWNER="${OWNER_OPTION:-ba-st}"
readonly OWNER_NAME="${OWNER_NAME_OPTION:-"${OWNER_OPTION:-"Buenos Aires Smalltalk"}"}"
readonly COPYRIGHT_HOLDER="${COPYRIGHT_HOLDER_OPTION:-"${OWNER_NAME_OPTION:-"${OWNER_OPTION:-"Buenos Aires Smalltalk Contributors"}"}"}"
readonly DEFAULT_BRANCH="${DEFAULT_BRANCH:-release-candidate}"

print_notice "Creating template for $PROJECT_NAME hosted at https://github.com/$OWNER/$REPO_NAME"

print_info "  Selected options"
print_success "  - Project name: $PROJECT_NAME"
print_success "  - Repo: $REPO_NAME"
print_success "  - Owner: $OWNER"
print_success "  - Owner name: $OWNER_NAME"
print_success "  - Copyright holder: $COPYRIGHT_HOLDER"
print_success "  - Default branch: $DEFAULT_BRANCH"

readonly EXPORT_LOCATION="build/$PROJECT_NAME"
if [ -d "$EXPORT_LOCATION" ]; then
  rm --recursive --force "$EXPORT_LOCATION"
fi
print_info "  Creating base directories..."
mkdir -p "$EXPORT_LOCATION"/{assets,source,docs,docs/explanation,docs/how-to,docs/reference,docs/tutorial}
print_success "  [OK]"

readonly REPLACE_TEMPLATE_VARS="
s/{{PROJECT_NAME}}/$PROJECT_NAME/g
s/{{REPO_NAME}}/$REPO_NAME/g
s/{{BASELINE_NAME}}/${REPO_NAME//-}/g
s/{{OWNER}}/$OWNER/g
s/{{OWNER_NAME}}/$OWNER_NAME/g
s/{{COPYRIGHT_HOLDER}}/$COPYRIGHT_HOLDER/g
s/{{DEFAULT_BRANCH}}/$DEFAULT_BRANCH/g
"

print_info "  Copying readme..."
sed "$REPLACE_TEMPLATE_VARS" templates/README.md > "$EXPORT_LOCATION/README.md"
print_success "  [OK]"

print_info "  Copying contribution guidelines..."
sed "$REPLACE_TEMPLATE_VARS" templates/CONTRIBUTING.md > "$EXPORT_LOCATION/CONTRIBUTING.md"
print_success "  [OK]"

print_info "  Copying license..."
sed "$REPLACE_TEMPLATE_VARS" templates/LICENSE > "$EXPORT_LOCATION/LICENSE"
print_success "  [OK]"

print_info "  Copying basic documentation..."
sed "$REPLACE_TEMPLATE_VARS" templates/docs/README.md > "$EXPORT_LOCATION/docs/README.md"
sed "$REPLACE_TEMPLATE_VARS" templates/docs/reference/loading-targets.md > "$EXPORT_LOCATION/docs/reference/loading-targets.md"
print_success "  [OK]"


print_info "  Copying installation instructions..."
sed "$REPLACE_TEMPLATE_VARS" templates/docs/how-to/how-to-load-in-pharo.md > "$EXPORT_LOCATION/docs/how-to/how-to-load-in-pharo.md"
sed "$REPLACE_TEMPLATE_VARS" templates/docs/how-to/how-to-use-as-dependency-in-pharo.md > "$EXPORT_LOCATION/docs/how-to/how-to-use-as-dependency-in-pharo.md"
print_success "  [OK]"

print_info "  Copying source code format properties file..."
cp templates/.properties "$EXPORT_LOCATION/source/.properties"
sed "$REPLACE_TEMPLATE_VARS" templates/.project > "$EXPORT_LOCATION/.project"
cp templates/.gitattributes "$EXPORT_LOCATION/.gitattributes"
print_success "  [OK]"

print_info "  Copying GitHub Actions configuration..."
cp -r templates/.github "$EXPORT_LOCATION/.github"
mkdir "$EXPORT_LOCATION/.smalltalkci"
for filename in templates/.smalltalkci/*; do
  sed "$REPLACE_TEMPLATE_VARS" "$filename" > "$EXPORT_LOCATION/.smalltalkci/$(basename "$filename")"
done
print_success "  [OK]"

print_notice "Review the proposed files in the build directory and adapt it to your own needs"
