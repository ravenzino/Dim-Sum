__author__ = 'raven'

'''
# Manually execute following script line-by-line in Python3
# IDLE to act as http client, perform HTTP GET operation
# and retrive response from server

import urllib.request as ur

req = ur.Request(url='http://localhost:8000', method='GET')
req.data = b'hello world!'
(ur.urlopen(req)).read().decode('utf-8')
'''

'''
# Use following commands to restart PyServer
kill -9 `ps -ef | grep PyS | grep -v grep | cut -d " " -f4`
rm ./PSLog.txt
nohup ./PyServer.py 2>&1 > /dev/null &
'''