fpath=($HOME/.zsh/functions $HOME/.zsh/completion $fpath)
for config_file ($HOME/.zsh/*.zsh) source $config_file

autoload -U compinit
compinit -i

# add npm completion
if (( $+commands[npm] )) ; then
  . <(npm completion)
fi

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jhays/.sdkman"
[[ -s "/Users/jhays/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jhays/.sdkman/bin/sdkman-init.sh"
