# This file contains user-specific git completion options,
# mostly for the purposes of having easy aliases

complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
	|| complete -o default -o nospace -F _git g

complete -o default -o nospace -F _git_log gl
complete -o default -o nospace -F _git_log glm
complete -o default -o nospace -F _git_diff gdi
complete -o default -o nospace -F _git_diff gdc
complete -o default -o nospace -F _git_svn gvn
complete -o default -o nospace -F _git_commit gca
complete -o default -o nospace -F _git_commit gci
complete -o default -o nospace -F _git_show gs
complete -o default -o nospace -F _git_show gsw
complete -o default -o nospace -F _git_show gss
