#!/bin/bash

bashrc_include_dir="$(dirname $BASH_SOURCE[0])"

gist()
{
    # here we are just trying to get the current directory
    the_url=$($bashrc_include_dir/gist/to_gist.py)
    # Sadly, this only works for mac. I'd like to change that
    echo -n $the_url | pbcopy
    echo "$the_url -- also on your clipboard"
}

createpr()
{
  branchname=$(git rev-parse --abbrev-ref HEAD)
  commitsha=$(git rev-parse HEAD)
  prname=$(git log --oneline -n 1 | cut -d ' ' -f 2-)

  reponame=$(git remote -v | grep "github.com" | head -n 1 | cut -d ':' -f 2 | cut -d '.' -f 1)
  echo "creating PR $prname on $reponame, master...$branchname:$commitsha"

  curl -s -X POST "https://api.github.com/repos/$reponame/pulls?access_token=$GITHUB_TOKEN" -d @- <<EOF | grep "html_url" | head -n 1 | cut -d '"' -f 4 | xargs open
{
  "title": "$prname",
  "body": "cli generated PR",
  "head": "$branchname",
  "base": "master"
}
EOF
}
