## Instalando o NTPd e configurando servidor NTP. 

```shell
root@ntp:~# apt -y install ntp
root@ntp:~# nano /etc/ntp.conf
```

##### Vamos comentar os servidores padrões:

```shell
# pool 0.debian.pool.ntp.org iburst
# pool 1.debian.pool.ntp.org iburst
# pool 2.debian.pool.ntp.org iburst
# pool 3.debian.pool.ntp.org iburst
```

##### Adicionando servidores para sincronização:

```shell
server a.st1.ntp.br iburst 
server b.st1.ntp.br iburst 
server c.st1.ntp.br iburst 
```

##### Na linha 50 devemos adicionar nossa faixa de rede, para aceitar requisições da mesma:

```shell
restrict 192.168.0.0 mask 255.255.255.0 nomodify notrap
```

##### Reiniciando o serviço e sincronizando os servidores:

```shell
root@ntp:~# service ntp restart
root@ntp:~# ntpq -p 
```

```shell
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 ntp-b3.nict.go. .NICT.           1 u    1   64    1   19.707    5.647   0.383
 ntp1.jst.mfeed. 133.243.236.17   2 u    1   64    1   16.625    5.942   0.657
*ntp2.jst.mfeed. 133.243.236.17   2 u    1   64    1   16.673    5.971   0.487
```



#### OBS: Para uma possível liberação no firewall, o NTP utiliza porta: 123/UDP.
