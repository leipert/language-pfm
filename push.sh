#/bin/bash

gulp
cp -rf src/README.md README.md
rm -rf {grammars,settings,snippets}/gfm.cson script spec src gulpfile.js
#git stash
#git checkout dist
#git stash pop

#Merge Conflicts
#apm publish minor
#git checkout master
