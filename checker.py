# from urllib import request
# print (request.urlopen("http://new-fargate-lb-244899165.us-west-2.elb.amazonaws.com/").getcode())
import requests

url = "http://new-fargate-lb-244899165.us-west-2.elb.amazonaws.com/"
status = (requests.head(url).status_code)

msg1 = "{status} | Site is Healthy"
msg2 = "{status} | Site is Unhealthy"

if status == 200:
    print (msg1.format(status=status))
else:
    print (msg2.format(status=status))