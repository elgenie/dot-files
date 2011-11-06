#!/usr/bin/env bash
# modified from https://github.com/fnichol/macosx-iterm2-settings
set -e

working_prefs="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
repo_prefs="$(dirname $0)/com.googlecode.iterm2.plist"

printf "==> Copying working preferences from: $working_prefs ...\n"
plutil -convert xml1 -o - $working_prefs | xmllint --format - > $repo_prefs
exit_status=$?
printf "==> Updated XML in $(basename $repo_prefs).\n"

if [[ 0 -eq $exit_status ]]; then
    printf "==> Running git diff to see changes.\n";
    (cd $(dirname $0) && git diff $repo_prefs);
fi
exit $exit_status

