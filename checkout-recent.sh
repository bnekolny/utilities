#!/bin/bash

PS3='Please choose which branch to jump to: '
IFS=$'\n'; options=( $(git show-recent-branches) ); 
select opt in "${options[@]}"
do
  git checkout $opt
  break
done
