#!/usr/bin/env bash
set -x

if ! command -v curl >/dev/null ; then
    printf "\n>>>> Could not find curl on your PATH so quitting.\n"
    exit 2
fi

if [[ "$TERM_PROGRAM" == "iTerm.app" ]] ; then
    printf "\n>>>> You appear to be running this script from within iTerm.app which could\n"
    printf " overwrite your new preferences on quit.\n"
    printf ">>>> Please quit iTerm and run this from Terminal.app or an SSH session.\n"
    exit 3
fi

if ps wwwaux | egrep -q 'iTerm\.app' >/dev/null ; then
    printf "\n>>>> You appear to have iTerm.app currently running. Please quit the\n"
    printf " application so your updates won't get overridden on quit.\n\n"
    exit 4
fi

plist="com.googlecode.iterm2.plist"
working_prefs="$HOME/Library/Preferences/$plist"
repo_prefs="$(dirname $0)/$plist"

printf "==> Installing plist from $repo_prefs ...\n"

new_plist="/tmp/$plist"
if $(plutil -convert binary1 -o "$new_plist" "$repo_prefs") ; then
    mv -f "$new_plist" "$working_prefs" && \
        printf "==> iTerm preferences installed/updated in $working_prefs\n"
    exit $?
else
    printf "\n>>>> Conversion from XML to binary failed. Your current\n"
    printf " preferences have not been changed.\n\n"
    exit 5
fi
