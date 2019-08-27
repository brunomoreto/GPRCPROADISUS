#!/bin/bash
#ainda falta por o script como executavel.
#RESULTADO ESPERADO DO SCRIPT ,1- base de dados auxiliar para receber novo dump e atualizacao e  limpeza criado,2- nome do schema hrto_teste alterado dentro da base de dados
#3-tabela teste no schema public da base auxiliar apagada.4- funcao funcionando  

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
#por senha do usuario aqui

#alterando o nome do banco para identificar que ele esta sendo manipulado nessa limpeza


ALTER SCHEMA hrto_teste RENAME TO hrto_teste_20190810;

/q

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo <  banco_new_dump.backup
#por senha do usuario aqui


psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo
#por senha do usuario aqui


#aqui havera mais tabelas para apagar no schema public e necessario verificar como vai ficar os nomes delas . 
DROP TABLE bancoAuxLimpezaeReceberDumpNovo.public.teste



#executar querys agora

#TESTANDO FUNCAO QUE FAZ UM SELECT DA TABELA TESTE NO SCHEMA hrto_teste_20190810



'
# NESSE PROCEDIMENTO as tabelas de log estarão criadas no schema public.
SELECT hrto.gerar_metadados();

# Nesta etapa a tabela ‘delecao’ será gerada indicando quantos registros foram removidos e sua tabela de origem
SELECT hrto.executar_limpeza_consultas_pacientes();	


#gerar metadados novamente
SELECT hrto.gerar_metadados();

#analise de consistência.
#ATENCAO !!!!!!! VERIFICAR SE alguma inconsistência numérica seja detectada 
SELECT hrto.avaliar_metadados();

#Para uma visão sumarizada da quantidade registros total removidos de uma tabela, basta descomentar a seguinte query.
SELECT nome_tabela, SUM(qtd_registros) FROM delecao GROUP BY nome_tabela;


'

#FIM DO SCRIPT
