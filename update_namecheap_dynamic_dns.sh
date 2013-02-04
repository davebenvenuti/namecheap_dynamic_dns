#!/bin/sh

if [ -e ~/.namecheap_dynamic_dns ]; then
  . ~/.namecheap_dynamic_dns
fi

export EXTERNAL_IP=`wget -O - http://ipecho.net/plain 2>/dev/null`

if [ "${NAMECHEAP_HOSTNAME}" = "" ]; then
  echo "no NAMECHEAP_HOSTNAME defined" 1>&2

  exit 1
fi

if [ "${NAMECHEAP_DOMAIN}" = "" ]; then
  echo "no NAMECHEAP_DOMAIN defined" 1>&2

  exit 1
fi

if [ "${NAMECHEAP_PASSWORD}" = "" ]; then 
  echo "no NAMECHEAP_PASSWORD defined" 1>&2

  exit 1
fi

if [ "${EXTERNAL_IP}" = "" ]; then
  echo "could not resolve external ip" 1>&2

  exit 1
fi


echo "setting A record ${NAMECHEAP_HOSTNAME}.${NAMECHEAP_DOMAIN} pointed at ${EXTERNAL_IP}..."
# wget the update url url and grep the response to see if there were no errors
wget -O - "https://dynamicdns.park-your-domain.com/update?host=${NAMECHEAP_HOSTNAME}&domain=${NAMECHEAP_DOMAIN}&password=${NAMECHEAP_PASSWORD}&ip=${EXTERNAL_IP}" 2>/dev/null | grep "<ErrCount>0</ErrCount>" > /dev/null

if [ $? = 0 ]; then
  echo "success"
else
  echo "failed"
fi
