### Para evitar futuros problemas, primeiramente iremos alterar a identificação das interfaces de rede para o padrão antigo "eth0":

------

Através do comando dmesg, podemos ver que o dispositivo foi renomeado durante a inicialização do sistema:

```
dmesg | grep -i eth

[    3.050064] e1000 0000:02:01.0 eth0: (PCI:66MHz:32-bit) 00:0c:29:05:a3:e2
[    3.050074] e1000 0000:02:01.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.057410] e1000 0000:02:01.0 ens33: renamed from eth0
```

Alterando o grub file:

```
nano /etc/default/grub
```

Vamos procurar a seguinte opção “**GRUB_CMDLINE_LINUX**”  e adicionar o seguinte comando: ”**net.ifnames=0 biosdevname=0**“.

**De:**

```
GRUB_CMDLINE_LINUX=""
```

**Para:**

```
GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"
```

Gerando novo arquivo grub utilizando o seguinte comando:

```
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Logo após devemos editar nossa interface de rede `"ensX"` para `"ethX" `e reiniciar o servidor. 

```
nano /etc/netplan/*
```



------
### Interface bonding

Configurando LACP interface bonding no Ubuntu 18.04 utilizando `netplan`:

```yaml
root@srv01:~# mv /etc/netplan/50-cloud-init.yaml /etc/netplan/01-netcfg.yaml
root@srv01:~# nano /etc/netplan/01-netcfg.yaml 
network:
    version: 2
    renderer: networkd
    ethernets:
        eth0:
            dhcp4: false
            optional: true
        eth1:
            dhcp4: false
            optional: true

root@srv01:~# nano /etc/netplan/02-bondings.yaml 

network:
    version: 2
    renderer: networkd
    bonds:
        bond0:
            interfaces: [eth0, eth1]
            addresses: [192.168.1.10/24]
            gateway4: 192.168.1.1
            parameters:
                mode: 802.3ad
            nameservers:
                search: [subdomain.example.com]
                addresses: [1.1.1.1, 8.8.8.8]
            dhcp4: false
            optional: true
```
