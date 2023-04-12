#!/usr/bin/env bash

# Get the script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Get the diff for each file
for DOTFILE_HERE in "${SCRIPT_DIR}/."*
do
    DOTFILE_NAME="$(basename "${DOTFILE_HERE}")"
    DOTFILE_HOME="${HOME}/${DOTFILE_NAME}"
    if [ -f "${DOTFILE_HOME}" ] && [ "${DOTFILE_NAME}" != ".DS_Store" ]
    then
        if ! diff "${DOTFILE_HERE}" "${DOTFILE_HOME}" >/dev/null
        then
            echo "${DOTFILE_NAME}"
            diff --color "${DOTFILE_HERE}" "${DOTFILE_HOME}"
            echo
        fi
    fi
done
