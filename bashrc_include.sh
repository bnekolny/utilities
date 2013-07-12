#!/bin/bash

bashrc_include_dir="$(dirname $BASH_SOURCE[0])"

gist()
{
    # here we are just trying to get the current directory
    the_url=$($bashrc_include_dir/gist/to_gist.py)
    echo $the_url | pbcopy
    echo "$the_url -- also on your clipboard"
}
