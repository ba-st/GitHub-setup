#!/usr/bin/env bash

readonly ANSI_BOLD="\\033[1m"
readonly ANSI_RED="\\033[31m"
readonly ANSI_GREEN="\\033[32m"
readonly ANSI_YELLOW="\\033[33m"
readonly ANSI_BLUE="\\033[34m"
readonly ANSI_RESET="\\033[0m"
readonly ANSI_CLEAR="\\033[0K"

print_info() {
  printf "${ANSI_BOLD}${ANSI_BLUE}%s${ANSI_RESET}\\n" "$1"
}

print_notice() {
  printf "${ANSI_BOLD}${ANSI_YELLOW}%s${ANSI_RESET}\\n" "$1"
}

print_success() {
  printf "${ANSI_BOLD}${ANSI_GREEN}%s${ANSI_RESET}\\n" "$1"
}

print_error() {
  printf "${ANSI_BOLD}${ANSI_RED}%s${ANSI_RESET}\\n" "$1" 1>&2
}
