#/bin/bash

gulp
cp -rf src/README.md README.md
rm -rf {grammars,settings,snippets}/gfm.cson script src gulpfile.js clean.sh

#Merge Conflicts
#apm publish minor
#git checkout master
