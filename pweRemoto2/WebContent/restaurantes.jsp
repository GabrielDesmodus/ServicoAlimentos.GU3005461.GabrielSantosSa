<%@page import="java.sql.ResultSet"%>
<%@page import="database.DBQuery"%>
<%@page import="mail.SendMail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
body {
	background-color: #EEEEEE;
}
</style>
<meta charset="UTF-8">
<title>Restaurantes</title>
</head>
<body>
	<%
		String acao = request.getParameter("show");
	String idRest = request.getParameter("id");

	int idRestaurante = 0;
	int idUser = 0;
	String saida = "";

	idRestaurante = (int) session.getAttribute("idRestaurante");
	idUser = (int) session.getAttribute("userlogin");

	if (acao == null) {

		//LISTA OS RESTAURANTES
		String tableName = "servcomida.restaurante";
		String fields = "idRestaurante,nome,cpf_cnpj,endereco,bairro,cidade,uf,cep,telefone,email";
		String fieldKey = "idRestaurante";
		DBQuery dbQuery = new DBQuery(tableName, fields, fieldKey);

		ResultSet resultSet = dbQuery.select("idRestaurante != 1");
		while (resultSet.next()) {

			saida += "<br/>" + "Nome: " + resultSet.getString("nome") + " | " + "CPF_CNPJ: "
			+ resultSet.getString("cpf_cnpj") + " | " + "Endereço: " + resultSet.getString("endereco") + " | "
			+ "Bairro: " + resultSet.getString("bairro") + " | " + "Cidade: " + resultSet.getString("cidade")
			+ " | " + "UF: " + resultSet.getString("uf") + " | " + "CEP: " + resultSet.getString("cep") + " | "
			+ "Telefone: " + resultSet.getString("telefone") + " | " + "Email: " + resultSet.getString("email")
			+ " | " + "<form action='restaurantes.jsp' method='POST'><input type='hidden' name='id' value='"
			+ resultSet.getString("idRestaurante")
			+ "'><input type='hidden' name='show' value='1'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Cardápio</button></form><br/>";
		}
		response.getWriter().write(saida);

		//LISTA AS COMIDAS DO RESTAURANTE ESCOLHIDO, RECEBE ID DO RESTAURANTE POR JQUERY
	} else if (acao != null) {
		if (acao.equals("1")) {

			String tableName = "servcomida.comidas";
			String fields = "idComida, idRestaurante,nome,descricao";
			String fieldKey = "idComida";
			DBQuery dbQuery = new DBQuery(tableName, fields, fieldKey);

			ResultSet resultSet = dbQuery.select("idRestaurante = '" + idRest + "'");
			while (resultSet.next()) {

		saida += "<br/>" + "Nome: " + resultSet.getString("nome") + " | " + "Descrição: "
				+ resultSet.getString("descricao") + " | "
				+ "<form action='restaurantes.jsp' method='POST'><input type='hidden' name='show' value='2'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Comprar</button></form>";

			}
			response.getWriter().write(saida);
		}

		//REALIZA A COMPRA, ENVIA EMAIL PARA O USUÁRIO, RECEBE O ID DO USUARIO PELO SESSION
		if (acao.equals("2")) {
			String tableName = "servcomida.usuarios";
			String fieldsName = "idUsuario, idRestaurante, email, senha, idNivelUsuario, nome, cpf, endereco, bairro, cidade, uf, cep, telefone";
			String fieldKey = "idUsuario";

			DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);

			ResultSet resultSet = dbQuery.select("idUsuario =" + idUser);
			while (resultSet.next()) {
		String smtpHost = "smtp.gmail.com";
		String smtpPort = "587";
		String username = "gabrielsnts971@gmail.com";//meu email
		String password = "";//senha
		String auth = "tls";
		SendMail sendMail = new SendMail(smtpHost, smtpPort, username, password, auth);

		String mailFrom = "gabrielsnts971@gmail.com";//meu email
		String mailTo = resultSet.getString("email");
		String mailSubject = "Compra realizada";
		String mailBody = "Seu pedido irá chegar até você em breve!";
		sendMail.send(mailFrom, mailTo, mailSubject, mailBody);

		response.getWriter().write("Compra feita com sucesso!");
			}
		}

	}
	%>
	<br />
	<h4>
		<a href='home.jsp' class='link'>Voltar para o Início</a>
	</h4>
	<h4>
		<a href='restaurantes.jsp' class='link'>Voltar para os
			Restaurantes</a>
	</h4>

</body>
</html>