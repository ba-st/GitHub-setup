#!/usr/bin/env bash

# Import utilities
source ".print-utils.sh"
source ".usage.sh"

# Exit and show help if the command line is empty
[[ ! "$*" ]] && usage "Not enough arguments"

# Initialise options
PROJECT_OPTION=""
REPO_OPTION=""
OWNER_OPTION=""
# Parse command line options
while getopts "p:r:o:h" option; do
  case $option in
    p) PROJECT_OPTION=$OPTARG ;;
    r) REPO_OPTION=$OPTARG ;;
    o) OWNER_OPTION=$OPTARG ;;
    h) usage ;;
  esac
done
shift $(($OPTIND - 1)); # take out the option flags

readonly PROJECT_NAME="$PROJECT_OPTION"
if [ -z "$PROJECT_NAME" ] ; then
  usage "The project name is mandatory"
fi
readonly REPO_NAME="${REPO_OPTION:-$PROJECT_NAME}"
readonly OWNER="${OWNER_OPTION:-ba-st}"

print_notice "Creating template for $PROJECT_NAME hosted at https://github.com/$OWNER/$REPO_NAME"

readonly EXPORT_LOCATION="build/$PROJECT_NAME"
if [ -d "$EXPORT_LOCATION" ]; then
  rm --recursive --force "$EXPORT_LOCATION"
fi
print_info "  Creating base directories..."
mkdir --parents "$EXPORT_LOCATION"/{assets/logos,source,docs}
print_success "  [OK]"

readonly REPLACE_TEMPLATE_VARS="
s/<PROJECT_NAME>/$PROJECT_NAME/g
s/<REPO_NAME>/$REPO_NAME/g
s/<BASELINE_NAME>/${REPO_NAME//-}/g
s/<OWNER>/$OWNER/g
"

print_info "  Copying readme..."
sed "$REPLACE_TEMPLATE_VARS" templates/README.md > "$EXPORT_LOCATION/README.md"
print_success "  [OK]"

print_info "  Copying contribution guidelines..."
sed "$REPLACE_TEMPLATE_VARS" templates/CONTRIBUTING.md > "$EXPORT_LOCATION/CONTRIBUTING.md"
print_success "  [OK]"

print_info "  Copying license..."
cp templates/LICENSE "$EXPORT_LOCATION/LICENSE"
print_success "  [OK]"

print_info "  Copying installation instructions..."
sed "$REPLACE_TEMPLATE_VARS" templates/Installation.md > "$EXPORT_LOCATION/Installation.md"
print_success "  [OK]"

print_info "  Copying source code format properties file..."
cp templates/.properties "$EXPORT_LOCATION/source/.properties"
print_success "  [OK]"

print_info "  Copying Travis CI configuration..."
sed "$REPLACE_TEMPLATE_VARS" templates/.travis.yml > "$EXPORT_LOCATION/.travis.yml"
sed "$REPLACE_TEMPLATE_VARS" templates/.smalltalk.ston > "$EXPORT_LOCATION/.smalltalk.ston"
print_success "  [OK]"
