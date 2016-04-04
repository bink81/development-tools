#!/bin/sh

# Block commit if one of the changes in the commit contain NOCOMMIT (case insensitive).

# To use this hook, place it in the '.git/hooks' directory in your repository and make sure it is named 'pre-commit'.
#
# To force commit anyway:
#    git commit --no-verify
#
# Eclipse:
# 	Eclipse's GIT integration 'eGit' does not run the commit hooks :/
# 	see: https://bugs.eclipse.org/bugs/show_bug.cgi?id=299315
#
# IntelliJ:
# 	IntelliJ runs the commit hooks like a champ.
# 	see: http://java.dzone.com/articles/why-idea-better-eclipse
# 	(bla bla bla I'm Mr. Burns bla bla bla)
#
# Windows:
# 	If you are using Windows, and do not have access to sh, use some superior bat-scripting and open source your script :)
# 	If you are using Windows and have installed Git Bash along with Git, it should Just Work.

SUCCESS=0
FORBIDDEN='nocommit';

if git-rev-parse --verify HEAD > /dev/null 2>&1; then
	AGAINTST=HEAD
else
	AGAINTST=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

git diff-index -p -M --cached $AGAINTST -- | grep '^+' | grep -i "$FORBIDDEN" 
if [ $? -eq $SUCCESS ]; then
	echo "COMMIT REJECTED. Found '$FORBIDDEN' references."
	echo ""
	echo "Offending files with linenumbers:"
	git diff --cached --name-only | \
	GREP_COLOR='4;5;37;41' xargs grep --with-filename -n -i "$FORBIDDEN"
	echo "Clean up the offending files before commiting or use 'git commit --no-verify' to force commit anyway"
	exit 1;
else
	# echo "Commit does not contain forbidden references."
	:
fi
