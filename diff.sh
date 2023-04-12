#!/usr/bin/env bash

# Get the script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Get the diff for each dotfile in this directory
for DOTFILE_HERE in "${SCRIPT_DIR}/."*
do
    DOTFILE_NAME="$(basename "${DOTFILE_HERE}")"
    DOTFILE_HOME="${HOME}/${DOTFILE_NAME}"
    if [ -f "${DOTFILE_HOME}" ]
    then
        # Ignore .DS_Store
        if [ "${DOTFILE_NAME}" = ".DS_Store" ]
        then
            break
        fi
        # If the two files are different, echo the name and diff
        if ! diff "${DOTFILE_HERE}" "${DOTFILE_HOME}" >/dev/null
        then
            echo "Changed: ${DOTFILE_NAME}"
            diff --color "${DOTFILE_HERE}" "${DOTFILE_HOME}"
            echo
        fi
    else
        # If the file does not exist in HOME, echo the name
        echo "Deleted: ${DOTFILE_NAME}"
    fi
done

# For each dotfile in HOME, check if it is present
for DOTFILE_HOME in "${HOME}/."*
do
    DOTFILE_NAME="$(basename "${DOTFILE_HOME}")"
    DOTFILE_HERE="${SCRIPT_DIR}/${DOTFILE_NAME}"
    if [ -f "${DOTFILE_HOME}" ] && [ ! -f "${DOTFILE_HERE}" ]
    then
        echo "Added: ${DOTFILE_NAME}"
    elif [ -d "${DOTFILE_HOME}" ] && [ ! -d "${DOTFILE_HERE}" ]
    then
        echo "Added: ${DOTFILE_NAME}/"
    fi
done
