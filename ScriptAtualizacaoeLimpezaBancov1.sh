#!/bin/bash
#ainda falta por o script como executavel.



pg_dump -U postgres -E UTF8 -d postgres > bancoCopiaTeste_LIMPEZA.sql
#por senha do usuario aqui

pg_dump -U postgres -E UTF8 -d postgres > bancoCopiaTeste_LIMPEZA.backup
#por senha do usuario aqui



createdb -h localhost -U postgres -E UTF8 bancoAuxiliarParaLimpezaeReceberDumpNovo
#por senha do usuario aqui



psql -h localhost -U usuario -d bancoAuxiliarParaLimpezaeReceberDumpNovo < bancoCopiaTeste.backup
#por senha do usuario aqui





