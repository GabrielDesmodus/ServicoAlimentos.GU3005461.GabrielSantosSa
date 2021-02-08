<%@page import="com.mysql.fabric.Response" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="classes.Comidas"%>
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
		<title>Cadastrar Comida</title>
	</head>
	
	<body>
	
		<%
			String acao				= request.getParameter("rest");
			String btn             = request.getParameter("btn"); 
			
			if (acao != null || btn !=null) {
				int idComida            = 0;
				int idRestaurante		= Integer.valueOf(acao);
				String nome				= request.getParameter("nome");
				String descricao		= request.getParameter("descricao");
				
				Comidas comida = new Comidas(idComida, idRestaurante, nome, descricao);
				comida.save();
				
				response.getWriter().write("Cadastro teve sucesso");
			}
				
			
				response.getWriter().write("<div class='div-form'>"
				+"<form action='cadastroComida.jsp' method='POST'>"
				+"	<h1>Cadastrar Comida</h1>"

				+"		<label for='nome'>Nome:</label>"
				+"		<input type='text' id='nome' name='nome' class='field' required placeholder='Nome'>"
				
				+"		<label for='descricao'>Descrição:</label>"
				+"		<input type='text' id='descricao' name='descricao' class='field' required placeholder='Descrição'>"
				
				+"	<input type='hidden' name='rest' value="+acao+"><input type='hidden' name='rest' value='btn'>"
				+"	<button type='button' id='btnCadastrar' class='btn btn-primary' onclick='this.form.submit();'>Cadastrar</button>"
				+"</form>"
				+"<h4><a href='acessoRestrito.jsp' class='link'>Voltar</a></h4>"
				+"</div>");
	
%>
		
	</body>
</html>