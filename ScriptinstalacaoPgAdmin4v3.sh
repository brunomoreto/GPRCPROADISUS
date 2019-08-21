#!/bin/bash
#Instalação da versão 4.5 do pgAdmin 4 - Ubuntu 19.04 desktop - alterações Bruno moreto
#E IDEAL QUE O UBUNTU ESTEJA ATUALIZADO ANTES DE REALIZAR O SCRIPT
#1 - garantir que o python3.7 esteja instalado :
#com o comando :       python3

#Ele vem nativo há instalação do Ubuntu 19, mas não esta nativo em linha de comando quando digita python somente. não tem problema. não fazer nada em relação a isso
#Executar os seguites comandos no terminal 

sudo apt-get install virtualenv python3-pip libpq-dev python3-dev
#digitar a senha :
#OBS: o prompt deve ficar com # no final.
cd 
#OBS: o prompt deve ficar com ~#: no final.
virtualenv -p python3 pgadmin4
cd pgadmin4
source bin/activate

pip3 install https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v4.5/pip/pgadmin4-4.5-py2.py3-none-any.whl

sudo nano lib/python3.6/site-packages/pgadmin4/config_local.py

#copiar essa seção de codigo para o terminal e salvar :

: '
<inicioDaSecaoParaCopiar>

import os
DATA_DIR = os.path.realpath(os.path.expanduser(u'~/.pgadmin/'))
LOG_FILE = os.path.join(DATA_DIR, 'pgadmin4.log')
SQLITE_PATH = os.path.join(DATA_DIR, 'pgadmin4.db')
SESSION_DB_PATH = os.path.join(DATA_DIR, 'sessions')
STORAGE_DIR = os.path.join(DATA_DIR, 'storage')
SERVER_MODE = False
<fimDaSecaoParaCopiar>
'
sudo pip3 install flask
sudo pip3 install flask_babelex
sudo pip3 install flask_login
sudo pip3 install flask_mail
sudo pip3 install flask_paranoid
sudo pip3 install flask_security
sudo pip3 install flask_sqlalchemy
sudo pip3 install flask_migrate
sudo pip3 install psycopg2
sudo pip3 install sshtunnel
sudo pip3 install flask_gravatar
sudo pip3 install sqlparse
sudo pip3 install psutil
sudo pip3 install flask_htmlmin


cd ~/pgadmin4
sudo python3 lib/python3.7/site-packages/pgadmin4/pgAdmin4.py

#Após a execução ira mostrar que o pgadmin esta rodando no ip http://127.0.0.1:5050/
#CASO NÃO FUNCIONE: 
#Alguns erros são por fala de biblioteca do python ou algum mÓdulo. basta instalar o modulo que #não foi encontrado com o comando 
                           



#OBS: irá pedir módulo até o psutil.
: '
OUTRO ERRO QUE APARECE NO TERMINAL  

após você logar no pgAdmin e tentar criar um servidor e tentar se conectar , pode apresentar alguns erros na linha de comando no prompt :
Se for erro no ssh tunnel é algum problema com o loggin e senha,
e se exigir algum módulo a mais basta instalar com o comando 
 	
		sudo pip3 install NOMEDOMODULO
Deve ser o PgAdmin4 versão 4.5 pois a parti dessa versão o pgAdmin atualizou para trabalhar com a biblioteca mais atualizda do python,  psycopg na versão 2 2.8.

Deve-se usar sudo na frente dos comando igualmente esta acima, alguns momentos não são necessário.

!!!Agora para acessar o pgAdmin basta abrir um terminal   CTRL+T:
sudo su
#digitar a senha :
#OBS: o prompt deve ficar com # no final.
cd 
#OBS: o prompt deve ficar com ~#: no final.
cd pgadmin4
sudo python3 lib/python3.7/site-packages/pgadmin4/pgAdmin4.py
'

