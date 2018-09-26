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
shift $(($OPTIND - 1));     # take out the option flags

readonly PROJECT_NAME="$PROJECT_OPTION"
if [ -z "$PROJECT_NAME" ] ; then
    usage "The project name is mandatory"
fi
if [ -z "$REPO_OPTION" ] ;
  then REPO_NAME="$PROJECT_NAME"
  else REPO_NAME="$REPO_OPTION"
fi
if [ -z "$OWNER_OPTION" ] ;
  then OWNER="ba-st"
  else OWNER="$OWNER_OPTION"
fi

print_notice "Creating template for $PROJECT_NAME hosted at https://github.com/$OWNER/$REPO_NAME"

readonly EXPORT_LOCATION="build/$PROJECT_NAME"
if [ ! -d "build" ]; then
  mkdir build
fi
rm -rf $EXPORT_LOCATION
print_info "  Creating base directories..."
mkdir $EXPORT_LOCATION
mkdir $EXPORT_LOCATION/assets
mkdir $EXPORT_LOCATION/assets/logos
mkdir $EXPORT_LOCATION/source
mkdir $EXPORT_LOCATION/docs
print_success "  [OK]"

print_info "  Copying readme..."
cp templates/README.md $EXPORT_LOCATION/README.md
sed -i "s/<PROJECT_NAME>/$PROJECT_NAME/g" $EXPORT_LOCATION/README.md
sed -i "s/<REPO_NAME>/$REPO_NAME/g" $EXPORT_LOCATION/README.md
sed -i "s/<BASELINE_NAME>/${REPO_NAME//-}/g" $EXPORT_LOCATION/README.md
sed -i "s/<OWNER>/$OWNER/g" $EXPORT_LOCATION/README.md
print_success "  [OK]"

print_info "  Copying contribution guidelines..."
cp templates/CONTRIBUTING.md $EXPORT_LOCATION/CONTRIBUTING.md
sed -i "s/<REPO_NAME>/$REPO_NAME/g" $EXPORT_LOCATION/CONTRIBUTING.md
sed -i "s/<OWNER>/$OWNER/g" $EXPORT_LOCATION/CONTRIBUTING.md
print_success "  [OK]"

print_info "  Copying license..."
cp templates/LICENSE $EXPORT_LOCATION/LICENSE
print_success "  [OK]"

print_info "  Copying installation instructions..."
cp templates/Installation.md $EXPORT_LOCATION/docs/Installation.md
sed -i "s/<PROJECT_NAME>/$PROJECT_NAME/g" $EXPORT_LOCATION/docs/Installation.md
sed -i "s/<REPO_NAME>/$REPO_NAME/g" $EXPORT_LOCATION/docs/Installation.md
sed -i "s/<BASELINE_NAME>/${REPO_NAME//-}/g" $EXPORT_LOCATION/docs/Installation.md
sed -i "s/<OWNER>/$OWNER/g" $EXPORT_LOCATION/docs/Installation.md
print_success "  [OK]"

print_info "  Copying source code format properties file..."
cp templates/.properties $EXPORT_LOCATION/source/.properties
cp templates/.project $EXPORT_LOCATION/.project
cp templates/.gitattributes $EXPORT_LOCATION/.gitattributes
print_success "  [OK]"

print_info "  Copying Travis CI configuration..."
cp templates/.travis.yml $EXPORT_LOCATION/.travis.yml
sed -i "s/<PROJECT_NAME>/$PROJECT_NAME/g" $EXPORT_LOCATION/.travis.yml
sed -i "s/<REPO_NAME>/$REPO_NAME/g" $EXPORT_LOCATION/.travis.yml
cp templates/.smalltalk.ston $EXPORT_LOCATION/.smalltalk.ston
sed -i "s/<REPO_NAME>/$REPO_NAME/g" $EXPORT_LOCATION/.smalltalk.ston
sed -i "s/<BASELINE_NAME>/${REPO_NAME//-}/g" $EXPORT_LOCATION/.smalltalk.ston
print_success "  [OK]"
