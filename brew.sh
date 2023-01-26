#!/usr/bin/env bash

# Get the script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Get the backup files
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

    # Install formulas.
    while read formula; do
        brew install --quiet --formula "${formula}"
    done < "${FORMULAS_FILE}"

    # Install casks.
    while read cask; do
        brew install --quiet --cask "${cask}"
    done < "${CASKS_FILE}"

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
