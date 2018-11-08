### Na primeira parte iremos efetuar a instalação do Bacula e suas dependências.
*******

##### 1º Atualizar os pacotes e instalar possíveis atualizações do sistema:

```
apt-get update && apt-get upgrade -y
```

##### 2º Devemos adicionar repositórios extras em nosso Ubuntu:

```
nano /etc/apt/source.list
deb http://br.archive.ubuntu.com/ubuntu/ bionic main restricted
deb http://br.archive.ubuntu.com/ubuntu/ bionic-updates main restricted
deb http://br.archive.ubuntu.com/ubuntu/ bionic universe
deb http://br.archive.ubuntu.com/ubuntu/ bionic-updates universe
deb http://br.archive.ubuntu.com/ubuntu/ bionic multiverse
deb http://br.archive.ubuntu.com/ubuntu/ bionic-updates multiverse
deb http://br.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu bionic-security main restricted
deb http://security.ubuntu.com/ubuntu bionic-security universe
deb http://security.ubuntu.com/ubuntu bionic-security multiverse
apt-get update
```

##### 3º Logo após efetuar o download e descompactação da última versão do Bacula:

```
wget -qO- https://sourceforge.net/projects/bacula/files/bacula/9.2.1/bacula-9.2.1.tar.gz | tar -xzvf - -C /usr/src
```

##### 4º Instalando dependências: 

```
apt-get install build-essential libreadline6-dev zlib1g-dev liblzo2-dev mt-st mtx postfix libacl1-dev libssl-dev libmysql++-dev mysql-server
```

##### 5º Com as dependências instaladas, vamos customizar a instalação:

```
cd /usr/src/bacula*

./configure --with-readline=/usr/include/readline --disable-conio --bindir=/usr/bin --sbindir=/usr/sbin --with-scriptdir=/etc/bacula/scripts --with-working-dir=/var/lib/bacula --with-logdir=/var/log --enable-smartalloc --with-mysql --with-archivedir=caminho_para_backup --with-job-email=seu@email.com.br --with-hostname=ip_nome_servidor
```

##### 6º Compilando, instalando e habilitando daemons para iniciar com boot do sistema:

```
make -jnucleos_processador && make install && make install-autostart
```

##### 7º Tornando scripts executáveis, para criação do banco de dados:

```
chmod o+rx /etc/bacula/scripts/*
```

##### 8º Criando banco de dados e definindo usuário:

```
cd /etc/bacula/scripts
./grant_mysql_privileges
./create_mysql_database -u root
./make_mysql_tables -u bacula
```

##### 9º Na sequência vamos executar um script de segurança que irá remover algumas configurações padrões que vem por default:

```
mysql_secure_installation
```

##### 10º Vamos logar no console do MySQL e alterar a senha do usuário Bacula:

```
mysql -u root -p
mysql>use mysql;
update user set authentication_string=password('novasenha') where user='bacula';
FLUSH PRIVILEGES;
exit
```

##### 11º Devemos alterar a senha de conexão do banco de dados, primeiramente devemos ir no diretorio do bacula: /etc/bacula e alterar o bacula-dir.conf:

```
Catalog {
  Name = "MyCatalog"
  Password = "senha_definida"
  User = "bacula"
  DbName = "bacula"
```

##### 12º Definindo permissões de pastas:

```
chmod 777 -R /etc/bacula*           - Diretório do bacula e scripts
chmod 777 -R /mnt/BKP_RAID0         - Armazenamento dos Backups
chmod 777 -R /usr/sbin/dbcheck      - BD
```

##### 13º Agora iremos iniciar todos os serviços do Bacula:

```
service bacula-fd start && service bacula-sd start && service bacula-dir start
```

*******

### Nessa segunda parte iremos efetuar a instalação do Baculum
*******
##### 1º Efetuar importação da chave pública:

```
wget -qO - http://bacula.org/downloads/baculum/baculum.pub | apt-key add -
```

##### 2º Configurando repositório:

```
echo "deb [ arch=amd64 ] http://bacula.org/downloads/baculum/stable/ubuntu xenial main
deb-src http://bacula.org/downloads/baculum/stable/ubuntu xenial main
" > /etc/apt/sources.list.d/baculum.list
```

##### 3º Instalando dependências: 

```
apt-get update && apt-get install php-bcmath php7.2-mbstring baculum-api baculum-api-apache2 baculum-common bacula-console baculum-web baculum-web-apache2
```

##### 4º Colocando o usuário apache no “sudoers” para execução do bconsole e outras opções do Bacula:

```
echo "Defaults:apache "'!'"requiretty
www-data ALL=NOPASSWD: /usr/sbin/bconsole
www-data ALL=NOPASSWD: /usr/sbin/bdirjson
www-data ALL=NOPASSWD: /usr/sbin/bsdjson
www-data ALL=NOPASSWD: /usr/sbin/bfdjson
www-data ALL=NOPASSWD: /usr/sbin/bbconsjson
" > /etc/sudoers.d/baculum

chown www-data /etc/bacula/
a2enmod rewrite
a2ensite baculum-web baculum-api
service apache2 restart
```

##### 6º Logo após efetuado todos os procedimentos, iremos efetuar a configuração via interface WEB:

```
Primeiramente configuramos a API para integração com o Bacula, para acesso utilizar o ip do servidor com a porta: 9096. 

Depois iremos configurar o Frontend, para isso basta acessar o servidor com a porta: 9095.
```

*******

### Terceiro passo é efetuar a Instalação do cliente Linux (Ubuntu/Debian)
*******
##### 1º Efetuando o download dos binários:

```
wget -qO- https://sourceforge.net/projects/bacula/files/bacula/9.2.1/bacula-9.2.1.tar.gz | tar -xzvf - -C /usr/src
```

##### 2º Instalação dos pacotes e dependências:

```
apt-get install -y build-essential zlib1g-dev liblzo2-dev libacl1-dev libssl-dev
```

##### 3º Com as dependências instaladas, vamos customizar a instalação:

```
cd /usr/src/bacula*

./configure --enable-client-only --enable-build-dird=no --enable-build-stored=no --bindir=/usr/bin --sbindir=/usr/sbin --with-scriptdir=/etc/bacula/scripts --with-working-dir=/var/lib/bacula --with-logdir=/var/log --enable-smartalloc
```

##### 4º Compilando, instalando e habilitando daemons para iniciar com boot do sistema:

```
make -j1 && make install && make install-autostart-fd
```

##### 5º Iniciando o serviço:

```
service bacula-fd start
```

##### 6º Reiniciando o Serviço:

```
service bacula-fd restart
```
