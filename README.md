Utilities
=========

These are some utilities that I find myself using on a regular basis. I've included them in a git repo for portability across systems, and to share with friends and colleagues.

Please feel free to contribute anything you find useful!

Goals
  - Make it as easy as possible for users to include
  - Keep everything super portable


Instructions for use
-----------
1. Source the `bashrc_include.sh` in your `~/.bashrc`

    ```source /path/to/repo/utilities/bashrc_include.sh```
 1. If desired, add your github credentials to your bashrc (without them all gists will be under anonymous)

            export GITHUBUSERNAME="<username>"
            export GITHUBPASSWORD="<password>"

1. Add the git settings to your git config (global) ***NOTE: Requires Git 1.7.10 or higher!***

    ```$ git config --global --edit```

    at the bottom, append this:

        [include]
            path = "/path/to/repo/utilities/git_include.config"
