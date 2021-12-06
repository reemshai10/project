#!/bin/bash
git config --global user.email 
git config --global user.name 
branch="release/$1"
echo $branch
if [ `git branch --list $branch` ]
then
    
    #git checkout "remotes/origin/$branch"
    old_tag=`git tag -l "$1*" --sort=v:refname | tail -1 | cut -d "." -f3`
    new_tag=$(($old_tag+1))
    git pull
    git checkout $branch
    echo "$1.$new_tag" > tag.txt
else
    
    git checkout master
    echo "NOT FOR RELEASE" > v.txt
    echo "$1" >> v.txt
    new_tag="$1.0"
    echo "$new_tag" > tag.txt
    git pull
    git checkout -B "$branch"
    git push --set-upstream origin $branch -f
 #   git branch -B "$branch"
 #   git push -u origin release/$branch
 #   git push --set-upstream origin $branch
fi
