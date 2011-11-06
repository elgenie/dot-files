# -*- bash -*-

# ssh to server by name
fssh () {
    FORMAT=$1
    NUMBER=$2
    shift 2
    HOST=$(printf $FORMAT "$NUMBER")
    sudo ssh $HOST $@
}

mkcd () {
    mkdir -p "$1" && cd "$1";
}

# git commit all with message
gcam () {
    git commit -a -m "$*";
}

# git commit incremental with message
gcim () {
    git commit -m "$*";
}

srch () {
    git show -w $(git svn find-rev r$1);
}
