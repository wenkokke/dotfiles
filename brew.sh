#!/usr/bin/env bash

# Get the script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Get the backup files
TAPS_FILE="$SCRIPT_DIR/brew/taps.csv"
FORMULAS_FILE="$SCRIPT_DIR/brew/formulas.csv"
CASKS_FILE="$SCRIPT_DIR/brew/casks.csv"

# Get the command
COMMAND="${1:-install}"

function install
{
    # Make sure we're using the latest Homebrew.
    brew update

    # Upgrade any already-installed formulas.
    brew upgrade

    # Install taps.
    while read tap; do
        echo "brew tap ${tap}" && brew tap --quiet "${tap}"
    done < "${TAPS_FILE}"

    # Install formulas.
    formulas=""
    while read formula; do
        formulas="${formulas} ${formula}"
    done < "${FORMULAS_FILE}"
    brew install --quiet --formula $formulas

    # Install casks.
    casks=""
    while read cask; do
        casks="${casks} ${cask}"
    done < "${CASKS_FILE}"
    brew install --quiet --cask $casks

    # Remove outdated versions from the cellar.
    brew cleanup
}

function backup
{
    # Backup installed formulas.
    brew leaves -r > "${FORMULAS_FILE}"

    # Backup installed casks.
    brew list --cask > "${CASKS_FILE}"
}

if [ "${COMMAND}" = "install" ]; then
    install
    exit 0
fi
if [ "${COMMAND}" = "backup" ]; then
    backup
    exit 0
fi
echo "Unknown command '${COMMAND}'; expected 'install' or 'backup'."
exit 1
