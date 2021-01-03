#!/usr/bin/env bash
#
# Link linter settings to appropriate locations.
# Please only run this script within the project root.

# Link the linter settings to ~/.config.
# Globals:
#   None
# Arguments:
#   $1: linter settings file
# Returns:
#   0: if no errors occurred
#   1: if either args were missing or malformed
function link() {
    if [[ -z "$1" ]]; then
        echo "\$1 is required."
        echo "\$1: linter settings file"
        return 1
    elif [[ ! -e "$1" ]]; then
        echo "\$1 must be a linter settings file."
        return 1
    fi

    local real
    real="$(pwd)/${1}"

    local file
    file="${1#linters/}"

    local dest
    dest="${HOME}/.config/${file}"

    local old

    if [[ -h "$dest" ]]; then
        local linked
        linked=$(readlink --canonicalize "$dest")
        if [[ "$linked" == "$real" ]]; then
            echo "${file} is already symlinked to ${dest}."
            return 0
        else
            echo "A symlink exists at ${dest}, but it doesn't point to"
            echo "the expected file. Moving to a temporary location."
            old=$(mktemp --tmpdir="${HOME}/.config")
            mv "$dest" "$old"
            echo "Moved old ${dest} to ${old}."
        fi
    elif [[ -e "$dest" ]]; then
        echo "${dest} already exists. Moving to temporary location."
        old=$(mktemp --tmpdir="${HOME}/.config")
        mv "$dest" "$old"
        echo "Moved old ${dest} to ${old}."
    fi

    echo "Linking ${file} to ${dest}"
    ln --symbolic "$real" "$dest"
}


for linter in linters/*; do
    link "$linter"
done
