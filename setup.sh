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
COPYRIGHT_HOLDER_OPTION=""
DEFAULT_BRANCH=""
BUILD_SERVICE_OPTION=""

# Parse command line options
while getopts "p:r:o:c:d:b:h" option; do
  #shellcheck disable=SC2220
  case $option in
    p) PROJECT_OPTION=$OPTARG ;;
    r) REPO_OPTION=$OPTARG ;;
    o) OWNER_OPTION=$OPTARG ;;
    c) COPYRIGHT_HOLDER_OPTION=$OPTARG ;;
    d) DEFAULT_BRANCH=$OPTARG ;;
    b) BUILD_SERVICE_OPTION=$OPTARG ;;
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
readonly COPYRIGHT_HOLDER="${COPYRIGHT_HOLDER_OPTION:-"Buenos Aires Smalltalk Contributors"}"
readonly DEFAULT_BRANCH="${DEFAULT_BRANCH:-release-candidate}"
readonly BUILD_SERVICE="${BUILD_SERVICE_OPTION:-github}"

if [ "${BUILD_SERVICE}" != "github" ] && [ "${BUILD_SERVICE}" != "travis" ]; then
  usage "Invalid build service. Valid options are github or travis."
fi

print_notice "Creating template for $PROJECT_NAME hosted at https://github.com/$OWNER/$REPO_NAME"

readonly EXPORT_LOCATION="build/$PROJECT_NAME"
if [ -d "$EXPORT_LOCATION" ]; then
  rm --recursive --force "$EXPORT_LOCATION"
fi
print_info "  Creating base directories..."
mkdir -p "$EXPORT_LOCATION"/{assets/logos,source,docs}
print_success "  [OK]"

readonly REPLACE_TEMPLATE_VARS="
s/{{PROJECT_NAME}}/$PROJECT_NAME/g
s/{{REPO_NAME}}/$REPO_NAME/g
s/{{BASELINE_NAME}}/${REPO_NAME//-}/g
s/{{OWNER}}/$OWNER/g
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

print_info "  Copying installation instructions..."
sed "$REPLACE_TEMPLATE_VARS" templates/Installation.md > "$EXPORT_LOCATION/docs/Installation.md"
print_success "  [OK]"

print_info "  Copying source code format properties file..."
cp templates/.properties "$EXPORT_LOCATION/source/.properties"
cp templates/.project "$EXPORT_LOCATION/.project"
cp templates/.gitattributes "$EXPORT_LOCATION/.gitattributes"
print_success "  [OK]"

if [ "${BUILD_SERVICE}" == "github" ]; then
  print_info "  Copying GitHub Actions configuration..."
  cp -r templates/.github "$EXPORT_LOCATION/.github"
  mkdir "$EXPORT_LOCATION/.smalltalkci"
  for filename in templates/.smalltalkci/*; do
    sed "$REPLACE_TEMPLATE_VARS" "$filename" > "$EXPORT_LOCATION/.smalltalkci/$(basename "$filename")"
  done
elif [ "${BUILD_SERVICE}" == "travis" ]; then
  print_info "  Copying Travis CI configuration..."
  sed "$REPLACE_TEMPLATE_VARS" templates/.travis.yml > "$EXPORT_LOCATION/.travis.yml"
  sed "$REPLACE_TEMPLATE_VARS" templates/.smalltalkci/unit-tests.ston > "$EXPORT_LOCATION/.smalltalk.ston"
fi
print_success "  [OK]"
