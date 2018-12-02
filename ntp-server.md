## Instalando o NTPd e configurando servidor NTP para o ajuste da hora. NTP utiliza porta: 123/UDP.

root@dlp:~# apt -y install ntp

root@dlp:~# nano /etc/ntp.conf

Vamos comentar os servidores padrões:

\# pool 0.debian.pool.ntp.org iburst

\# pool 1.debian.pool.ntp.org iburst

\# pool 2.debian.pool.ntp.org iburst

\# pool 3.debian.pool.ntp.org iburst

\# add servers in your timezone to sync times

server ntp.nict.jp iburst 
server ntp1.jst.mfeed.ad.jp iburst 
server ntp2.jst.mfeed.ad.jp iburst 

\# line 50: add the network range you allow to receive requests

restrict 10.0.0.0 mask 255.255.255.0 nomodify notrap

root@dlp:~#

 

[systemctl](https://www.server-world.info/en/command/html/systemctl.html) restart ntp

\# show status

root@dlp:~# 

[ntpq](https://www.server-world.info/en/command/html/ntpq.html) -p 

```
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 ntp-b3.nict.go. .NICT.           1 u    1   64    1   19.707    5.647   0.383
 ntp1.jst.mfeed. 133.243.236.17   2 u    1   64    1   16.625    5.942   0.657
*ntp2.jst.mfeed. 133.243.236.17   2 u    1   64    1   16.673    5.971   0.487
```