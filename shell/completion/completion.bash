source_one $CONFIG_HOME/completion/ack.bash-completion.sh

# To get a fresh copy: contrib/completion/git-completion.bash
# wget -O git-completion.bash 'http://git.kernel.org/?p=git/git.git;a=blob_plain;f=contrib/completion/git-completion.bash;hb=refs/heads/master'
source_one $CONFIG_HOME/completion/git-completion.bash
source_one $CONFIG_HOME/completion/git-completion-$USER.bash

source_one $CONFIG_HOME/completion/git-prompt.sh
