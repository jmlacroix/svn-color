#!/bin/bash

#TODO
# check zsh support

function svn
{
	CMD=" $* "
	CMDLEN=${#CMD}

	# parse disabling arg
	CMD=${CMD/ --nocol / }

	# check if disabled
	test "$CMDLEN" = "${#CMD}"
	if [ $? = 1 ] || [ ! -t 1 ]
	then
		$(whereis svn) $CMD
		return
	fi

	# actions that outputs "status-like" data
	if [[ "$1" =~ ^(st|add) ]]
	then
		$(whereis svn) $CMD | while IFS= read RL
		do
			if   [[ $RL =~ ^\ ?M ]]; then C="\033[34m";
			elif [[ $RL =~ ^\ ?C ]]; then C="\033[41m\033[37m\033[1m";
			elif [[ $RL =~ ^A ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^D ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^X ]]; then C="\033[37m";
			elif [[ $RL =~ ^! ]]; then C="\033[43m\033[37m\033[1m";
			elif [[ $RL =~ ^I ]]; then C="\033[33m";
			else C=
			fi

			echo -e "$C$RL\033[0m\033[0;0m"
		done

	# actions that outputs "diff-like" data
	elif [[ "$1" =~ ^diff ]]
	then
		$(whereis svn) $CMD | while IFS= read RL
		do
			if   [[ $RL =~ ^Index:\  ]]; then C="\033[34m\033[1m";
			elif [[ $RL =~ ^@@ ]]; then C="\033[37m";

			# removed
			elif [[ $RL =~ ^-\<\<\< ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^-\>\>\> ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^-=== ]]; then C="\033[31m\033[1m";
			elif [[ $RL =~ ^- ]]; then C="\033[31m";

			# added
			elif [[ $RL =~ ^\+\<\<\< ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^\+\>\>\> ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^\+=== ]]; then C="\033[32m\033[1m";
			elif [[ $RL =~ ^\+ ]]; then C="\033[32m";

			else C=
			fi

			echo -e "$C$RL\033[0m\033[0;0m"
		done
	fi

}
