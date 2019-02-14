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
*a.st1.ntp.br    .ONBR.           1 u   50 1024  377    3.469    0.675   0.767
-b.st1.ntp.br    200.160.7.197    2 u  220 1024  277   18.595   -2.516   1.296
+c.st1.ntp.br    .ONBR.           1 u  993 1024  377   11.199    1.939   1.954
+d.st1.ntp.br    .ONBR.           1 u  459 1024  377   14.139    2.139   1.777
```



#### OBS: Para uma possível liberação no firewall, o NTP utiliza porta: 123/UDP.
