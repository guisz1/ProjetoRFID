#!/usr/bin/env python
# -*- coding: utf-8 -*-
import time
import sys
import MySQLdb
import re

con = 0

#Função abaixo é responsavel pela conexão a base de dados
def conecta():
	try: #aqui sera testado se é posivel fazder a conexão
		global con #aqui chamamos a variavel global que ira representar a conexão
		con = MySQLdb.connect(host="serverdocker.com", user="root", passwd="Lasse@123", db="dbEvento") #aqui fazemos a conecão com o host do servidor, usuario, senha e nome da base de dados
		con.autocommit(True) #aqui verificamos que apartir de qualquer insert sera feito um comit no banco de dados
	except (MySQLdb.Error, MySQLdb.Warning) as e: #se ñão foi possivel testar a conexão retornara um erro
		print("Falha na conexão")
		print(e)

#Função abaixo é responsavel pela principal função do servidor que é a de controlar a entrada no evento
def controlaPresensa(evento, cod):
	sql = "SELECT controlaPresensa('%s','%s')" % (int(evento), cod) #Aqui criamos a query sql chamando a função-sql com os devidos parametros
	try:
		global con
		cursor = con.cursor() #aqui criamos um cursor para facilitar nossa conexão
		cursor.execute(sql) #aqui executamos a query sqç
		return cursor.fetchone(); #aqui retornamos os valores do retorno da função sql
	except (MySQLdb.Error, MySQLdb.Warning) as e:
		print("falha ao executar")
		print(e)
		return None

#Função abaixo é responsavel por verificar se o evento esta na base de dados
def verificaEvento(evento):
	sql = "SELECT verificaExistencia('%s')" % (int(evento))
	try:
		global con
		cursor = con.cursor()
		cursor.execute(sql)
		return cursor.fetchone();
	except (MySQLdb.Error, MySQLdb.Warning) as e:
		print("falha ao executar")
		print(e)
		return None

#Função onde ativa o status do evento, ou seja, que declara que ele está funcionando
def ativaEvento(evento):
	sql = "CALL ativarEvento('%s')" % (int(evento)) #aqui criamos a query sql setando o procedimento sql com o seu devido parametro
	try:
		global con
		cursor = con.cursor()
		cursor.execute(sql) #aqui não iremos precisar retornar nenhum valor, pois é um procedimento e não uma função
	except (MySQLdb.Error, MySQLdb.Warning) as e:
		print("falha ao executar")
		print(e)

#Função onde desativa o status do evento, ou seja, que declara que ele não está funcionando
def desativaEvento(evento):
	sql = "CALL desativarEvento('%s')" % (int(evento))
	try:
		global con
		cursor = con.cursor()
		cursor.execute(sql)
	except (MySQLdb.Error, MySQLdb.Warning) as e:
		print("falha ao executar")
		print(e)

#Função main é onde tudo acontece, onde todas as funções e validações são feitas
def main():
	global con
	verifica = "0" #setamos a variavel verifica, que é uma das variaveis de validação
	test = True #variavel de validação
	x = True #variavel de validação
	conecta() #aqui chamamos a conexão ao banco de dados
	evento = raw_input("Insira o ID do evento: ") #aqui é feito a leitura da escrita manual do id do evento
	try: #aqui tentamos verificar se o id do evento é um numero inteiro
		evento = int(evento)
	except:
		test = False
	if evento != '' and test == True: #aqui fazemos a validação se o evento é possivel de ser executado sem que retorne erro
		verifica = verificaEvento(evento) #chamamos a função que verifica o evento se esta ativo
		verifica = re.sub('[^0-9]', '', str(verifica)) #aqui tratamos o retorno da fução do sql
		ativaEvento(evento) #aqui sera chamado o procedimento que ativara o evento
	sys.stdout.flush() # aqui ira dar um espação para a proxima linha
	while x != False and verifica != "0": #aqui inicia o loop de leitura do evento
		sys.stdout.flush()
		card = raw_input().upper() #aqui lemos o possivel codigo rfid ou pedido de saida do loop
		sys.stdout.flush()
		if card != "SAIR": #validamos se ele não ira sair
			funcao = controlaPresensa(int(evento), card) #chamamos a função de presensa
		else:
			x = False	
	else:
		if(x == False):
			print('até mais')
			desativaEvento(evento) #aqui desativamos o evento após a frase do card ser sair
		else:
			print('id do evento é inválido')
		con.close()

#Aqui mantemos o loop infinito que mantera o serviço ativo
if __name__ == '__main__':
	main()