#!/usr/bin/env bash
#
# Link linter settings to appropriate locations.
# Please only run this script within the project root.

# Link the linter settings to the appropriate directory.
# Globals:
#   None
# Arguments:
#   $1: linter settings file
#   $2: destination directory; does not need to exist
# Returns:
#   0: if no errors occurred
#   1: if either args were missing or malformed
function link() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Both \$1 and \$2 are required."
        echo "\$1: linter settings file"
        echo "\$2: destination directory"
        return 1
    elif [ ! -f "$1" ]; then
        echo "\$1 must be a linter settings file."
        return 1
    elif [ ! -d "$2" ]; then
        if [ -e "$2" ]; then
            echo "\$2 exists but it isn't a directory."
            return 1
        else
            mkdir --parents "$2"
        fi
    fi

    local REAL
    REAL="$(pwd)/${1}"

    local FILE
    FILE="${1#linters/}"

    local DEST
    DEST="${2}/${FILE}"

    if [[ -e "$DEST" || -h "$DEST" ]]; then
        if [ -h "$DEST" ]; then
            local LINKED
            LINKED=$(readlink --canonicalize "$DEST")
            if [[ "$LINKED" == "$REAL" ]]; then
                echo "${FILE} is already symlinked to ${2}."
                return 0
            fi
        fi

        echo "${FILE} exists in ${2}. Moving to temporary location."
        local OLD
        OLD=$(mktemp --tmpdir="$2")
        mv "$DEST" "$OLD"
        echo "Moved existing ${FILE} to ${OLD}."
    fi

    ln --symbolic "$REAL" "$2"
}

link linters/flake8 ~/.config
link linters/.shellcheckrc ~
