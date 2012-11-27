# This file contains user-specific git completion options,
# mostly for the purposes of having easy aliases

# __git_shortcut and __define_git_completion functions courtesy of
# https://github.com/bronson/dotfiles/blob/731bfd951be68f395247982ba1fb745fbed2455c/.bashrc#L81
# as originally discussed at
# http://git.661346.n2.nabble.com/Bash-tab-completion-for-git-fetch-alias-is-broken-on-Git-1-7-7-1-td6980366.html

__define_git_completion () {
eval "
    _git_$2_shortcut () {
        COMP_LINE=\"git $2\${COMP_LINE#$1}\"
        let COMP_POINT+=$((4+${#2}-${#1}))
        COMP_WORDS=(git $2 \"\${COMP_WORDS[@]:1}\")
        let COMP_CWORD+=1

        local cur words cword prev
        _get_comp_words_by_ref -n =: cur words cword prev
        _git_$2
    }
    "
}
__git_shortcut () {
    type _git_$2_shortcut &>/dev/null || __define_git_completion $1 $2
    alias $1="git $2 $3"
    complete -o default -o nospace -F _git_$2_shortcut $1
}

alias   grs="git reset --soft HEAD^"
alias  grsh="git reset --hard HEAD^"
__git_shortcut grbt rebase '-i trunk'
alias  grbc="git rebase --continue"
alias  grbs="git rebase --skip"
__git_shortcut gca commit '-a -v'
__git_shortcut gci commit '-v'
__git_shortcut ga add
__git_shortcut gs show '-U6'
__git_shortcut gsw show '-w -U6'
__git_shortcut gss show --stat
__git_shortcut gvn svn
__git_shortcut gvl svn 'log --show-commit'
__git_shortcut gl log '--abbrev-commit --date=local --decorate'
__git_shortcut glp log '--abbrev-commit --date=local --decorate -p'
__git_shortcut gls log '--abbrev-commit --date=local --decorate --stat'
__git_shortcut glm log '--abbrev-commit --date=local --decorate --author=eletuchy --all-match'
alias gvain="git shortlog -n --author=eletuchy --since=1.week.ago"
alias gvain_rev="g shortlog --since=1.week.ago --grep='Reviewed by: eletuchy' -i -n"
alias gvain_com="g log --since=1.week.ago --grep='Reviewers: .*eletuchy.*' -i --all-match --oneline"
__git_shortcut gpr pull --rebase
__git_shortcut gdi diff '-U6'
__git_shortcut gdc diff '--cached -U6'
__git_shortcut gds diff --stat
__git_shortcut gb branch
__git_shortcut gba branch -a
__git_shortcut gco checkout

complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
	|| complete -o default -o nospace -F _git g
