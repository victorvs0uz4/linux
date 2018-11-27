## Removendo VMware Tools - Debian

```shell
apt-get remove --purge open-vm* -y && apt-get autoremove -y

#Caso o primeiro comando não funcione, seguir a seguinte etapa:
sudo mkdir -p /media/cdrom
sudo mount /dev/cdrom1 /media/cdrom
cd /media/cdrom
sudo cp VM*.tar.gz /tmp
cd /tmp
sudo umount /media/cdrom
sudo tar xzvf VM*.tar.gz
cd vmware-tools-distrib/bin
sudo ./vmware-uninstall-tools
rm -r /media/cdrom
```
