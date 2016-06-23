#!/bin/bash

#---------------------
#Descr: this script is used to push code from svn to git
#Please follow the below steps:
#	1. Create a new repository in stash/bitbucket (https://vcm.wal-mart.com)
#	2. Call this script: bash lyssvn2git.sh <name of git repo> <name of svn>
#	3. validate through stash/bitbucket webpage
# git: https://lcle@vcm.wal-mart.com/scm/~lcle/svn2git.git 
# svn: https://svn01.wal-mart.com/svn/repos/gci/CustomerKnowledgePlatform/CKP-Automation/matching-automation/trunk
function init_main
{
	echo "initialize important variables here"
	[[ -n ${GIT} ]] || error_exit "Variable not initialize"
	[[ -n ${SVN} ]] || error_exit "Variable not initialize"
}

function get_from_svn
{
	echo "${FUNCNAME[0]}"
	echo "svn export ${SVN} ${project_name}"
}

function clone_repo
{
	echo "${FUNCNAME[0]}"
	echo "git clone ${GIT}"
}

#add all files to git repo
function sync_to_git
{
	echo "${FUNCNAME[0]}"
	echo "git init"
	echo "git add --all"
	echo "git commit -m \"ititial import from svn\""
	echo "git remote add origin ${GIT}"
	echo "git push -u origin master"
}

function get_projectname_fromgit
{
	local gitrepo="$1"
	project_name=$(echo "${gitrepo}" | rev | cut -d/ -f1 | rev | cut -d. -f1)
}

function start_main
{
	echo "$(date) Starting svn to git conversion" 
	init_main
	get_projectname_fromgit "${GIT}"
	#get the project name from the git repo, ie, get "something" from something.git
	echo "project name: $project_name"
	#clone_repo
	get_from_svn	
	echo "cd project_name"
	sync_to_git
	echo "$(date) Done! Please check stash/bitbucket to make sure your files are there"
}

#------UNIT TEST------#
function run_test
{
	clone_repo_test
}

function assertEquals
{
	msg=$1; shift
	expected=$1; shift
	actual=$1; shift
	/bin/echo -n "$msg: "
	if [ "$expected" != "$actual" ]; then
		echo "FAILED: EXPECTED=$expected ACTUAL=$actual" 

	else
		echo "PASSED" 
	fi
}

function clone_repo_test
{
	get_projectname_fromgit		
	assertEquals "${FUNCNAME[0]}" "https://lcle@vcm.wal-mart.com/scm/~lcle/svn2git.git" "${project_name}"
}
