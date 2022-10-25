#!/usr/bin/env zsh

# I need to create environments where I can simulate when a reader is starting from scratch.
# This script creates a container name of your git branch and deletes the container upon exit.
# Overwrite the default parameters: You might want to specify another docker image
# or a script or alternative shell for the container. The container puts your tutorial code
# inside the /code folder. Designed for hashicorp/learn-consul-kubernetes, but can be coopted
# to any folder that has a .git folder in its root.
# It turns this: docker run --name webdog/hcp-consul-hcp-vault -v /home/webdog/github/learn-consul-kubernees/hcp-consul-hcp-vault-ca:/code ubuntu:latest /bin/sh`
# Into: `tc -i ubuntu:latest -s /bin/sh`
# Or: docker run --name webdog/hcp-consul-hcp-vault -v /home/webdog/github/learn-consul-kubernetes/hcp-consul-hcp-vault-ca:/code amazonlinux:2 /bin/bash
# To `tc`

# Example Usage:
# tc -i ubuntu:latest -n webdog-hello
# Container Image: ubuntu:latest
#
#Container Name: webdog-hello
#
# Container Map: Local directory contents mapped to /code
#
# Container Entrypoint shell or script: /bin/bash
#
# root@e20f379a3c3b:/#

Help()
{
	# Display Help
	echo "Run this script in your tutorial's code folder."
	# I alias this script to 'tc' i.e. tutorial-container.
  echo "Syntax: tc [-c|-s|-f|-n|-h]"
	echo "Options:"
	echo "-i		Docker image to use. Defaults to amazonlinux:2"
	echo "-s		Script or Shell. Pass a shell path (e.g. /bin/bash) or a startup script that overrides the container\'s entrypoint. No validation of this script is done. Useful if want to streamline prerequisites to test the tutorial itself. Such as installing jq automatically, or running an update"
	echo "-f		Folder on container. The script maps your current directory to the /code directory on the container. If you have alternative needs, put the folder here"
	echo "-n		Container name. Defaults to the branch name unless specified in this argument."
}

CONTAINER_IMAGE="amazonlinux:2"
SHELL_OR_SCRIPT="/bin/bash"
CONTAINER_MAP="/code"
CONTAINER_NAME="$(git branch --show-current | awk -F'/' {'print $NF'})"

 while [[ $# -gt 0 ]] && [[ "$1" == "-"* ]] ;
	do
		opt="$1";
		shift;
		case "$opt" in
			"-" ) break 2;;
		  "-i" )
				CONTAINER_IMAGE="$1"; shift;;
			"-s" )
				SHELL_OR_SCRIPT="$1"; shift;;
			"-f" )
				CONTAINER_MAPPING="$1"; shift;;
			"-n" )
				CONTAINER_NAME="$1"; shift;;
			"-h" )
				Help; shift;;
		esac
 done
  
base_path="${PWD}"
# should be run in the folder inside this repository where your tutorial code lives
tutorial_folder=$(echo $PWD)
container_mapping="${CONTAINER_MAP}"
container_image="${CONTAINER_IMAGE}"
container_shell="${SHELL_OR_SCRIPT}"
container_name="${CONTAINER_NAME}"
echo "\
Container Image: ${container_image} \n
Container Name: ${container_name} \n
Container Map: Local directory contents mapped to ${container_mapping} \n
Container Entrypoint shell or script: ${container_shell}"

# docker run --name webdog/hcp-consul-hcp-vault -v /home/webdog/github/learn-consul-kubernetes/hcp-consul-hcp-vault-ca:/code amazonlinux:2 /bin/bash
docker run --rm --name $container_name  -it -v $tutorial_folder:$container_mapping $container_image $container_shell

