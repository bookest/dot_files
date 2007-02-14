### -*- shell-script -*-

if [ -r $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

export PATH=$PATH:$HOME/bin
unset USERNAME
