#!/usr/bin/python
#Send post request
import requests
import sys
# Post fun
def post(data, route):
    pdata = str(data)
    r = requests.post(str(route), data=pdata)
    #print(r.status_code, r.reason)
    #print(r.text[:300] + '...')
    print(r.status_code)
    return 'Sent!'
    pass
