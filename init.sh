#!/bin/sh
#

# TODO check if cleansed git local repo (to avoid to commit undesired files with the submodules)
if [ ! -d Scripts ]; then 

	echo "Adding 'Scripts' to repository && commit changes";
	git submodule add https://github.com/xldeveloper/Scripts.git Scripts \
	&& git commit .gitmodule -m "Added 'Scripts' git sub-module" \
	&& git submodule update --init;

	# git config -f .gitmodules submodule.Scripts.branch master
	
	# add other sub-modules
	if [ -d Scripts ]; then 
		./Scripts/git-add-submodule-pairs.sh "https://github.com/xldeveloper/Samples.git" "Samples";
		git commit -am "Added sub-modules";
	fi;
fi;
#check if '.gitmodules' file exist (!0)
gitmodulesfile=$(ls -a '.gitmodules' 2>/dev/null | sed -e "/\.$/d" | wc -l);
if [ ! $gitmodulesfile -eq 0 ]; then
	echo "Initializing & updating sub-modules";
	git submodule update --recursive --init \
	git submodule foreach --recursive git checkout master
fi;
