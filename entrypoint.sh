#!/bin/bash
#if [ $MYVAR ]; then
#  echo "found variable myvar, setting value "
#  else
#  echo "did not find myvar variable, setting default "
#  echo "myvar is: default" > /myfile
#fi

/app/gserver/gamserver --updates /app/updates --server http://0.0.0.0:8123 --daemon --air-gapped
