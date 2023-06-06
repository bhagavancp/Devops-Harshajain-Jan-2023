#!/bin/bash

urlstatus=$(curl -o /dev/null --silent --head --write-out '%{http_code}' "https://www.meesho.com")

if [[ $urlstatus = '200' ]]; then
 echo 'SUCCESS'
else 
	echo "meesho.com is not working, please check"
fi	
