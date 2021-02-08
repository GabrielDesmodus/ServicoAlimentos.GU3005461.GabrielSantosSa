<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Usuario"%>
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
		<title>Cadastrar</title>
	</head>
	
	<body>
	
		<%
			String acao				= request.getParameter("acao");
			 
			if (acao != null) {
				int idUsuario			= 0;
				int idRestaurante		= 1;
				String email			= request.getParameter("email");
				String senha 			= new Usuario(email).newPassword();
				int idNivelUsuario		= 1;
				String nome				= request.getParameter("nome");
				String cpf				= request.getParameter("cpf");
				String endereco			= request.getParameter("endereco");
				String bairro			= request.getParameter("bairro");
				String cidade			= request.getParameter("cidade");
				String uf				= request.getParameter("uf");
				String cep				= request.getParameter("cep");
				String telefone			= request.getParameter("telefone");
				Usuario usuario = new Usuario(idUsuario, idRestaurante, email, senha, idNivelUsuario, nome, cpf, endereco, bairro, cidade, uf, cep, telefone);

				//SALVA O USUÁRIO E ENVIA EMAIL
				usuario.save();
					
				String smtpHost = "smtp.gmail.com"; 
				String smtpPort = "587"; 
				String username = "gabrielsnts971@gmail.com";//meu email
				String password = "";//senha
				String auth     = "tls";  
				SendMail sendMail =  new SendMail( smtpHost,  smtpPort,  username,  password,  auth  );
					
				String mailFrom 	= "gabrielsnts971@gmail.com";//meu email
				String mailTo 		= email; 
				String mailSubject 	= "Cadastrar"; 
				String mailBody 	= "Seu email: " + email + ". Sua senha: " + senha; 
				sendMail.send( mailFrom, mailTo, mailSubject, mailBody );
					
				response.getWriter().write("Cadastrado com sucesso!");

			
			}
			
		%>
		<div class="div-form">
			<form action="cadastroUser.jsp" method="POST">
				<h1>Cadastre-se</h1>
				
					<label for="email">Email:</label>
					<input type="email" id="email" name="email" class="field" required placeholder="Email">
				
					<label for="nome">Nome:</label>
					<input type="text" id="nome" name="nome" class="field" required placeholder="Nome">
				
					<label for="cpf">Cpf:</label>
					<input type="text" id="cpf" name="cpf" class="field" required placeholder="Cpf">
					
					<label for="endereco">Endereço:</label>
					<input type="text" id="endereco" name="endereco" class="field" required placeholder="Endereço">
					
					<label for="bairro">Bairro:</label>
					<input type="text" id="bairro" name="bairro" class="field" required placeholder="CPF">
					
					<label for="cidade">Cidade:</label>
					<input type="text" id="cidade" name="cidade" class="field" required placeholder="Cidade">
					
					<label for="uf">UF:</label>
					<input type="text" id="uf" name="uf" class="field" required placeholder="UF">
					
					<label for="cep">CEP:</label>
					<input type="text" id="cep" name="cep" class="field" required placeholder="CEP">
					
					<label for="telefone">Telefone:</label>
					<input type="text" id="telefone" name="telefone" class="field" required placeholder="Telefone">
				
				<input type="hidden" name="acao" value="1">
				<button type="button" id="btnCadastrar" class="btn btn-primary" onclick="this.form.submit();">Cadastrar</button>
				<h4><a href='home.jsp' class='link'>Voltar</a></h4>
			</form>
		</div>
		
		
	</body>
</html>