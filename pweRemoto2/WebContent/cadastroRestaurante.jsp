<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Restaurante"%>
<%@page import="multitool.RandomCode"%>
<%@page import="mail.SendMail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.css"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		<style>

		body{
			background-color: #EEEEEE;
		}
	</style>
		<title>Cadastrar Restaurante</title>
	</head>
	
	<body>
	
		<%
			String acao				= request.getParameter("acao");
			int level = (int) session.getAttribute("level");
			 
			if (acao != null) {
				int idRestaurante		= 0;
				String nome				= request.getParameter("nome");
				String cpf_cnpj			= request.getParameter("cpf_cnpj");
				String endereco			= request.getParameter("endereco");
				String bairro			= request.getParameter("bairro");
				String cidade			= request.getParameter("cidade");
				String uf				= request.getParameter("uf");
				String cep				= request.getParameter("cep");
				String telefone			= request.getParameter("telefone");
				String email			= request.getParameter("email");
				
				Restaurante restaurante = new Restaurante(idRestaurante, nome, cpf_cnpj, endereco, bairro, cidade, uf, cep, telefone, email);

				
				//CADASTRA E ENVIA EMAIL
				if(level>=2){
					restaurante.save();
					
					String smtpHost = "smtp.gmail.com"; 
					String smtpPort = "587"; 
					String username = "gabrielsnts971@gmail.com";//meu email
					String password = "";//senha
					String auth     = "tls";  
					SendMail sendMail =  new SendMail( smtpHost,  smtpPort,  username,  password,  auth  );
						
					String mailFrom 	= "gabrielsnts971@gmail.com";//meu email
					String mailTo 		= email; 
					String mailSubject 	= "Cadastrar Restaurante"; 
					String mailBody 	= "Restaurante " + nome + " Cadastrado"; 
					sendMail.send( mailFrom, mailTo, mailSubject, mailBody );
						
					response.getWriter().write("Restaurante cadastrado com sucesso!");

				}
				else{
					response.getWriter().write("Não foi possível cadastrar");
				}
				
			
			}
			
		%>
		<div class="div-form">
			<form action="cadastroRestaurante.jsp" method="POST">
				<h1>Cadastrar Restaurante</h1>
				
					<label for="nome">Nome:</label>
					<input type="text" id="nome" name="nome" class="field" required placeholder="Nome">
		
					<label for="cpf">CPF - CNPJ:</label>
					<input type="text" id="cpf_cnpj" name="cpf_cnpj" class="field" required placeholder="CPF_CNPJ">
					
					<label for="endereco">Endereço:</label>
					<input type="text" id="endereco" name="endereco" class="field" required placeholder="Endereço">
					
					<label for="bairro">Bairro:</label>
					<input type="text" id="bairro" name="bairro" class="field" required placeholder="Bairro">
					
					<label for="cidade">Cidade:</label>
					<input type="text" id="cidade" name="cidade" class="field" required placeholder="Cidade">
					
					<label for="uf">UF:</label>
					<input type="text" id="uf" name="uf" class="field" required placeholder="UF">
					
					<label for="cep">CEP:</label>
					<input type="text" id="cep" name="cep" class="field" required placeholder="CEP">
					
					<label for="telefone">Telefone:</label>
					<input type="text" id="telefone" name="telefone" class="field" required placeholder="Telefone">
				
					<label for="email">Email:</label>
					<input type="email" id="email" name="email" class="field" required placeholder="Email">
				
				<input type="hidden" name="acao" value="1">
				<button type="button" id="btnCadastrar" class="btn btn-primary" onclick="this.form.submit();">Cadastrar</button>
				<h4><a href='acessoRestrito.jsp' class='link'>Voltar</a></h4>
				
			</form>
		</div>
		
		
	</body>
</html>