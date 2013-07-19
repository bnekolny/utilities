#!/usr/bin/python

import urllib2
import string
import base64
import json
import sys
import os

# Request headers, will use basic auth so defining early
headers = {}
 
top_level_url = 'https://api.github.com'
gist_url = '%s/gists' % top_level_url

gh_user = os.environ.get('GITHUBUSERNAME')
gh_pass = os.environ.get('GITHUBPASSWORD')
# If there is a username and password, add it
if gh_user and gh_pass:
    auth = 'Basic ' + string.strip(base64.encodestring(gh_user + ':' + gh_pass))
    headers['Authorization'] = auth
 
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
 
#sys.exit(0)
headers['content-type'] = 'application/json'
req = urllib2.Request(url=gist_url, data=json.dumps(content), headers=headers)

https_handler = urllib2.HTTPSHandler(debuglevel=0)
opener = urllib2.build_opener(https_handler)
urllib2.install_opener(opener)

result = opener.open(req)
status_code = result.getcode()
content = result.read()

# Check the response code from github, if good don't need to show
if status_code not in [200, 201]:
    print "Status Code: %s" % status_code
    print "Content: %s" % content
    sys.exit(1)

json_response = json.loads(content)
# print the url
print json_response.get('html_url')
