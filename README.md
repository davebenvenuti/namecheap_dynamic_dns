namecheap_dynamic_dns
=====================

A script which will update an A record, setting its value to the external ip returned by ipecho.net, for any namecheap domain with dynamic DNS enabled.  The intended use case is to run this script periodically via a cron job from home servers to mimic the behavior of a router with dyndns configured.

install
=======

```
sudo wget -O /usr/local/bin/update_namecheap_dynamic_dns.sh https://raw.github.com/davebenvenuti/namecheap_dynamic_dns/master/update_namecheap_dynamic_dns.sh
sudo chmod 775 /usr/local/bin/update_namecheap_dynamic_dns.sh
```

configuration
=============

update_namecheap_dns_record.sh requires the following configuration items to be set.  They can either be set in ~/.namecheap_dynamic_dns, or can be set in the environment when executed:

```
NAMECHEAP_PASSWORD=123123123123123123
NAMECHEAP_HOSTNAME=[your hostname]
NAMECHEAP_DOMAIN=[your domain name]
```

Then, put it in your crontab or something.  

```
crontab -e
```

then do something like

```
*/15 * * * * /usr/local/bin/update_namecheap_dynamic_dns.sh
```
