#!/bin/bash
#Autor: Bruno Moreto de Oliveira.

#pendencias do script
# por o script como executavel.
#realizar perguntas de (nomes de base) e se (usuario gostaria de verificar visão sumarizada da quantidade registros total removidos de uma tabela),
#realizar perguntas se a data extraida do sistema eh a que o usuario realmente quer usar .
#dar um echo para o usuario observar se nao houve erros de execucao

#RESULTADO ESPERADO DO SCRIPT no teste sem o dump ,
#1- base de dados auxiliar para receber novo dump e atualizacao e  limpeza criada,
#2- nome do schema hrto_teste alterado dentro da base de dados com a data do dia
#3-tabela teste no schema public da base auxiliar apagada.
#4- funcao funcionando.  


#RESULTADO ESPERADO DO SCRIPT  TESTE COM O DUMP.

#ATIVIDADES FORA DO SCRIPT PARA FINS DE TESTE NO GPRC

#CRIAR UMA BASE PARA RECEBER O DUMP E TRATAR ELA COMO ATUAL. COM O SCHEMA (HRTO_ATUAL). OU SEJA NAO FOI FEITA A LIMPEZA E ATUALIZACAO


#CRIAR UMA BASE AUXILIAR (LIMPEZATESTE) PARA FAZER BACKUP DA ATUAL QUE TEM O O SCHEMA(HRTO_ATUAL) E RECEBER O MESMO DUMP MAS, SIMULANDO UM NOVO. 

#NA BASE AUXILIAR , RENOMEAR O SCHEMA (HRTO_ATUAL) PARA (HRTO_ATUAL_DATAATUAL) E APAGAR TABELAS NECESSARIAS. E EXECUTAR OS PROCEDIMENTOS   


# POR FIM TROCAR NOME DA BASE HRTO_ATUAL PARA OLD_DATAATUAL E A  (HRTO_ATUAL_DATAATUAL) QUE FOI FEITA A LIMPEZA VIRA A (HRTO_ATUAL)

#VERIFICAR quantidade registros total removidos de uma tabela NO BANCO QUE FOI FEITO A LIMPEZA



#INICIO DO SCRIPT DE ATUALIZACAO E LIMPEZA.

#LOGAR COMO SUPERUSUARIO ANTES DE EXECUTAR O SCRIPT ex: sudo su.

#INICIALMENTE REALIZAR A COPIA DO BANCO ATUAL 

pg_dump -h localhost -U postgres -E utf8 -d postgres > bancoCopiaTeste_Atual333.backup
#senha do usuario aqui


#CRIAR UMA BASE AUXILIAR PARA RECEBER ESSA COPIA DO BANCO ATUAL ,OBS: ESSA BASE VAI RECEBER TAMBEM O NOVO DUM , E RECEBER A LIMPEZA E SE TORNARA A NOVA BASE ATUAL.

createdb -h localhost -U postgres -E utf8 bancoAuxLimpezaeReceberDumpNovo
#senha do usuario aqui


#RESTAURANDO A COPIA DO BANCO ATUAL NO BANCO AUXILIAR PARA INICIAR OS PROCEDIMENTOS DE LIMPEZA E ATUALIZACAO

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo < bancoCopiaTeste_Atual333.backup
#senha do usuario aqui


#Alterando o nome do schema da base, que eh o atual,  para identificar que ele esta sendo manipulado nessa limpeza, incluir data no nome do schema para equipes se orientar.

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo -f alterar_nome_schema.sql

#RECEBENDO NOVO DUMP na base auxiliar que esta com uma cópia da base atual.

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo <  banco_new_dump.backup
#senha do usuario aqui


#aqui havera mais tabelas para apagar no schema public e necessario verificar como vai ficar os nomes delas . 

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo -f drop_tabela_schemaplubic.sql
#senha do usuario aqui

#executar querys agora

#<FORA DO SCRIPT PARA TESTE INTERNO NO GPRC>TESTANDO FUNCAO QUE FAZ UM SELECT DA TABELA TESTE NO SCHEMA hrto_teste_20190810


# NESSE PROCEDIMENTO as tabelas de log estarão criadas no schema public.
#SELECT hrto.gerar_metadados();

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo -f f_hrto_gerar_metadados.sql
#senha do usuario aqui

# Nesta etapa a tabela ‘delecao’ será gerada indicando quantos registros foram removidos e sua tabela de origem
#SELECT hrto.executar_limpeza_consultas_pacientes();

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo -f f_hrto_executar_limpeza_consultas_pacientes.sql	
#senha do usuario aqui

#gerar metadados novamente
#SELECT hrto.gerar_metadados();

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo -f f_hrto_gerar_metadados.sql
#senha do usuario aqui

#analise de consistência.
#ATENCAO !!!!!!! VERIFICAR SE alguma inconsistência numérica seja detectada 
#SELECT hrto.avaliar_metadados();

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo -f f_hrto_avaliar_metadados.sql
#senha do usuario aqui

#O PASSO SEGUINTE EH OPCIONAL fazer um if aqui
#Para uma visão sumarizada da quantidade registros total removidos de uma tabela, basta descomentar a seguinte query.
#SELECT nome_tabela, SUM(qtd_registros) FROM delecao GROUP BY nome_tabela;

psql -h localhost -U postgres -d bancoAuxLimpezaeReceberDumpNovo -f query_visaosumarizada_resultprocedimento.sql
#senha do usuario aqui

#FIM DO SCRIPT



