# -*- sh -*-

add_lib()  { export LD_LIBRARY_PATH="$1:$LD_LIBRARY_PATH"; }
add_path() { export PATH="$1:$PATH"; }
add_man()  { export MANPATH="$1:$MANPATH"; }

addpost_lib()  { export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$1"; }
addpost_path() { export PATH="$PATH:$1"; }
addpost_man()  { export MANPATH="$MANPATH:$1"; }

source_one () {
    for i in $@; do
	if [ -f $i ]; then
	    source $i
	    return
	else
	    shift 1
	fi
    done
    return 1
}

parse_git_branch() {
  (git symbolic-ref -q HEAD && (git symbolic-ref -q HEAD | sed 's/^refs\/heads\///')) || "no branch";
}

_epoch () {
    DATE="jan 1 1970 utc $1 sec"
    date +%s -d"$DATE"
    date -d"$DATE"
    date -ud"$DATE"
}

if file -L /usr/bin/which | grep -vq 'shell script'; then
    # this is the function recommended by the gnu which man page but some
    # platforms (debian, mac) have shitty script implementations
    which () {
        (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@;
    }
    export -f which;
fi

_sj() {
    COMMAND=$@

    NORMAL="\033[0m"
    GREY="\033[31m"
    WHITE="\033[1;37m"

    if [ "x$COMMAND" = x ]; then
	false
    else
	prepost_line () {
	    awk "{ print \"${1}\"\$0\"${2}\" }"
	}
	out_filter () {
	    prepost_line $NORMAL $NORMAL
	}
	err_filter () {
	    prepost_line $GREY $NORMAL
	}

	(((${COMMAND} | out_filter) 3>&1 1>&2 2>&3 | err_filter) 3>&1 1>&2 2>&3) 2>&1
    fi
}
