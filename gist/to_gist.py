#!/usr/bin/python

import requests
import json
import sys
import os
 
gist_url = 'https://api.github.com/gists'

gh_user = os.environ.get('GITHUBUSERNAME')
gh_pass = os.environ.get('GITHUBPASSWORD')
gh_auth = (str(gh_user), str(gh_pass)) if gh_user and gh_pass else None
 
input = []
for line in sys.stdin:
  input.append(line)

# Check to see if there is any input
filename="gistfile"
try:
    title = input[0].strip()
    if 'diff' in title:
        filename+=".diff"
except IndexError as e:
    print "Nothing to Gist"
    sys.exit(3)

content = {
    "decscription": title,
    "public": False,
    "files": {
        filename: {
            "content": ''.join(input)
        }
    }
}
 

r = requests.post(gist_url, auth=gh_auth, data=json.dumps(content),
        headers={'content-type': 'application/json'})

# Check the response code from github, if good don't need to show
if r.status_code not in [200, 201]:
    print "Status Code: %s" % r.status_code
    print "Content: %s" % json.dumps(content)
    sys.exit(1)

# print the url
print r.json().get('html_url')
