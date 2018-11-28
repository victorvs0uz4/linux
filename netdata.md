## Instalando NETDATA.


1. ##### Instalar dependencias:

   ```shell
   apt-get install zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autoconf-archive autogen automake pkg-config curl
   ```


2. ##### Efetuando clone:

   ```shell
   git clone https://github.com/firehol/netdata.git --depth=1
   ```


3. ##### Entrando no diretorio:

   ```shell
   cd netdata
   ```


4. ##### Executar script de instalação:

   ```shell
   ./netdata-installer.sh
   ```


5. ##### Parando processos:

   ```shell
   ps -aux | grep netdata
   killall netdata
   ```


6. ##### Copiar "netdata.service" para o systemd:

   ```shell
   cp system/netdata.service /etc/systemd/system/
   ```


7. ##### Recarregar systemd: 

   ```shell
   systemctl daemon-reload
   ```


8. ##### Habilitando netdata na inicilização do sistema:

   ```shell
   systemctl enable netdata
   ```


9. ##### Iniciando serviço:

   ```
   systemctl start netdata
   ```



Documentação oficial: https://github.com/firehol/netdata
