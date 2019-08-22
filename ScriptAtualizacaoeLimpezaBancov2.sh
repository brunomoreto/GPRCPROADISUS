#!/bin/bash
#ainda falta por o script como executavel.


##psql -U postgres -E UTF8 -d postgres > bancoCopiaTeste_Atual.sql
#pg_dump -h localhost -U postgres -E utf8 -d postgres > bancoCopiaTeste_Atual2.sql
#por senha do usuario aqui

pg_dump -h localhost -U postgres -E utf8 -d postgres > bancoCopiaTeste_Atual2.backup
#por senha do usuario aqui



createdb -h localhost -U postgres -E utf8 bancoAuxLimpezaeReceberDumpNovo
#por senha do usuario aqui



psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo < bancoCopiaTeste_Atual2.backup
#por senha do usuario aqui


psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo


ALTER SCHEMA hrto_teste RENAME TO hrto_teste_20190810;

/q

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo <  banco_new_dump.backup


DROP TABLE postgres.public.test


#executar querys agora





