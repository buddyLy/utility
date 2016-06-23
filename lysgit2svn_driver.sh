#!/bin/bash

function init_main
{
	set -e #stop on errors

	if [[ ${VERBOSE} -eq 1 ]];then
		set -x #print commands that are run.
	fi

	set -u #error on unbound variable
	set -o pipefail #captures errors on piped commands
}

function usage
{
cat << EOF
usage: $0 options

This script will do a svn to git migration 

OPTIONS:
   -h      show usage 
   -s      svn location
   -g      git location
   -v      verbose
   -r      run script 
   -t      run test case
EOF
}

SVN=""
GIT=""
VERBOSE=""
RUN=""
RUNTEST=""

##get script options
while getopts "ths:g:vr" opt 
do
	case $opt in
 		h)
			usage
			exit 1
			;;
		s)
			SVN=$OPTARG
			;;
		g)
			GIT=$OPTARG
			;;
		v)
			VERBOSE=1
			;;
		r) 
			RUN=1
			;;
		t) 
			RUNTEST=1
			;;
		?)
			RUN=1
			exit
			;;
	esac
done

#initializer
init_main

#run unit test
if [[ ${RUNTEST} -eq 1 ]];then
	echo "run_test"
	source lysgit2svn.sh
	run_test
fi

#run main script 
if [[ ${RUN} -eq 1 ]];then
	#check for required repository
	if [[ ${SVN} == "" || ${GIT} == "" ]]; then
		usage
		exit 1
	fi

	#main
	source lysgit2svn.sh
	echo "start_main"
	start_main
else
	usage
fi
