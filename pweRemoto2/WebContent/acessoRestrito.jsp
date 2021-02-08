<%@page import="java.sql.ResultSet"%>
<%@page import="database.DBQuery"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style>

		body{
			background-color: #EEEEEE;
		}
	</style>
	<meta charset="UTF-8">
	<title>Acesso Restrito</title>
</head>
<body>
	<%
	
	String acao				= request.getParameter("show");
	String idRest           = request.getParameter("id");
	String deleteKey         = request.getParameter("deletekey");
	String nivelUser         = request.getParameter("nivelUser");
	String idUser         = request.getParameter("idUser");

	
	int level = 0;
	int idRestaurante = 0;
	String saida = "";
	
	level = (int) session.getAttribute("level");
	idRestaurante = (int) session.getAttribute("idRestaurante");
	
	//LISTAGEM RESTAURANTE, SE NÍVEL DE ACESSO FOR 3 OU FUNCIONÁRIO SER DO RESTAURANTE, BOTÃO DE DETALHAR E EXCLUIR É APRESENTADO
	if(acao!=null){
		if(acao.equals("1")){
			String tableName 	= "servcomida.restaurante";
			String fields 		= "idRestaurante,nome,cpf_cnpj,endereco,bairro,cidade,uf,cep,telefone,email";
			String fieldKey 	= "idRestaurante";
			DBQuery dbQuery = new DBQuery(tableName, fields, fieldKey);
			
			ResultSet resultSet = dbQuery.select("idRestaurante != 1");
			while( resultSet.next()){
				
				saida +="<br/>"   
					+"Nome: "
					+resultSet.getString("nome") + " | "
					+"CPF_CNPJ: "
					+ resultSet.getString("cpf_cnpj") + " | " 
					+"Endereço: "
					+ resultSet.getString("endereco") + " | " 
					+"Bairro: "
					+ resultSet.getString("bairro") + " | "
					+"Cidade: "
					+ resultSet.getString("cidade") + " | "
					+"UF: "
					+ resultSet.getString("uf") + " | "
					+"CEP: "
					+ resultSet.getString("cep") + " | "
					+"Telefone: "
					+ resultSet.getString("telefone") + " | "
					+"Email: "
					+ resultSet.getString("email") + " | ";
					if(level >=3 || String.valueOf(idRestaurante).equals(resultSet.getString("idRestaurante"))){
						saida += "<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='4'><input type='hidden' name='deletekey' value='"+resultSet.getString("idRestaurante")+"'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Excluir</button></form>" 
						+ "<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='id' value='"+resultSet.getString("idRestaurante")+"'><form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='5'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Detalhar</button></form><br/>";
					}
			}
		}
		
		//EXCLUIR RESTAURANTE, RECEBE ID POR JQUERY
		if(acao.equals("4")){
			
			String tableName 	= "servcomida.restaurante";
			String fields 		= "idRestaurante,nome,cpf_cnpj,endereco,bairro,cidade,uf,cep,telefone,email";
			String fieldKey 	= "idRestaurante";
			DBQuery dbQuery = new DBQuery(tableName, fields, fieldKey);
			
			System.out.println(deleteKey);
			System.out.println();
			int result = dbQuery.deleteByKey(deleteKey);
	
			if(result>0){
				saida = "Restaurante excluído";
			}else{
				saida= "Não foi possível excluir";
			}
			response.getWriter().write(saida);
		}
		
		//MOSTRAR OPÇÕES DE EXCLUSÃO OU DETALHAMENTO PARA CADA RESTAURANTE
		if(acao.equals("5")){
			
			saida=	"<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='6'><input type='hidden' name='id' value='"+idRest+"'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Mostrar Comidas</button></form>"
					+ "<form action='cadastroComida.jsp' method='POST'><input type='hidden' name='rest' value='"+idRest+"'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Cadastrar Comida</button></form><br/>";
			
		}
		
		//MOSTRAR COMIDAS DE CADA RESTAURANTE, RECEBE ID DE RESTAURANTE NO JQUERY
		if(acao.equals("6")){
			
			String tableName 	= "servcomida.comidas";
			String fields 		= "idComida, idRestaurante,nome,descricao";
			String fieldKey 	= "idComida";
			DBQuery dbQuery = new DBQuery(tableName, fields, fieldKey);
			
			ResultSet resultSet = dbQuery.select("idRestaurante = '"+idRest+"'");
			while( resultSet.next()){
				
				saida +="<br/>"   
					+"Nome: "
					+resultSet.getString("nome") + " | "
					+"Descrição: "
					+ resultSet.getString("descricao") + " | "
					+"<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='7'><input type='hidden' name='deletekey' value='"+resultSet.getString("idComida")+"'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Excluir</button></form>";

			}
		}
		
		//EXCLUSÃO COMIDA, RECEBE ID DA COMIDA POR JQUERY
		if(acao.equals("7")){
			
			String tableName 	= "servcomida.comidas";
			String fields 		= "idComida, idRestaurante,nome,descricao";
			String fieldKey 	= "idComida";
			DBQuery dbQuery = new DBQuery(tableName, fields, fieldKey);
			
			System.out.println(deleteKey);
			System.out.println();
			int result = dbQuery.deleteByKey(deleteKey);
	
			if(result>0){
				saida = "Comida excluída do cardápio";
			}else{
				saida= "Não foi possível excluir";
			}
		}
		
		//LISTAGEM USUÁRIOS, APENAS PARA NÍVEL 3
		if(acao.equals("2")){
			String tableName	= "servcomida.usuarios"; 
			String fieldsName	= "idUsuario, idRestaurante, email, senha, idNivelUsuario, nome, cpf, endereco, bairro, cidade, uf, cep, telefone";  
			String fieldKey		= "idUsuario";
			
			DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
			
			ResultSet resultSet = dbQuery.select("");
			while( resultSet.next()){
				
				saida +="<br/>"
					+"Email: "
					+ resultSet.getString("email") + " | "
					+"Senha: "
					+ resultSet.getString("senha") + " | "
					+"Nível de Acesso: ";
					if(resultSet.getString("idNivelUsuario").equals("1")){
						saida+="Usuário | ";
					}
					if(resultSet.getString("idNivelUsuario").equals("2")){
						saida+="Funcionário | ";
					}
					if(resultSet.getString("idNivelUsuario").equals("3")){
						saida+="Administrador | ";
					}
					saida+="Nome: "
					+resultSet.getString("nome") + " | "
					+"CPF: "
					+ resultSet.getString("cpf") + " | " 
					+"Endereço: "
					+ resultSet.getString("endereco") + " | " 
					+"Bairro: "
					+ resultSet.getString("bairro") + " | "
					+"Cidade: "
					+ resultSet.getString("cidade") + " | "
					+"UF: "
					+ resultSet.getString("uf") + " | "
					+"CEP: "
					+ resultSet.getString("cep") + " | "
					+"Telefone: "
					+ resultSet.getString("telefone") + " | "
					;
					if(level >=3){
						saida += "<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='8'><input type='hidden' name='deletekey' value='"+resultSet.getString("idUsuario")+"'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Excluir</button></form>" 
						+ "<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='9'><input type='hidden' name='idUser' value='"+resultSet.getString("idUsuario")+"'><input type='hidden' name='nivelUser' value='1'><input type='hidden' name='nivelUser' value='1'><form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='5'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Mudar nível de acesso para Usuário</button></form>"
						+ "<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='9'><input type='hidden' name='idUser' value='"+resultSet.getString("idUsuario")+"'><input type='hidden' name='nivelUser' value='2'><form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='5'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Mudar nível de acesso para Funcionário</button></form>"
						+ "<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='9'><input type='hidden' name='idUser' value='"+resultSet.getString("idUsuario")+"'><input type='hidden' name='nivelUser' value='3'><form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='5'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();'>Mudar nível de acesso para Administrador</button></form><br/>";
					}
			}
		}
		
		//EXCLUSÃO DE USUÁRIO, RECEBE ID POR JQUERY
		if(acao.equals("8")){
			
			String tableName	= "servcomida.usuarios"; 
			String fieldsName	= "idUsuario, idRestaurante, email, senha, idNivelUsuario, nome, cpf, endereco, bairro, cidade, uf, cep, telefone";  
			String fieldKey		= "idUsuario";
			
			DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
			
			System.out.println(deleteKey);
			System.out.println();
			int result = dbQuery.deleteByKey(deleteKey);
	
			if(result>0){
				saida = "Usuário excluído";
			}else{
				saida= "Não foi possível excluir";
			}
		}
		
		//MODIFICAÇÃO DE NÍVEL DE ACESSO, RECEBE ID E NIVEL DE ACESSO POR JQUERY
		if(acao.equals("9")){
			
			String tableName	= "servcomida.usuarios"; 
			String fieldsName	= "idUsuario, idNivelUsuario";  
			String fieldKey		= "idUsuario";
			
			DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
			
			System.out.println(nivelUser);
			String[] temp =  new String[] {idUser,nivelUser};
			int result = dbQuery.update(temp);
	
			if(result>0){
				saida = "Nível de Acesso modificado";
			}else{
				saida= "Não foi possível modificar";
			}
			
		}
		
		response.getWriter().write(saida);
		response.getWriter().write("<br/><br/><br/><br/><br/><br/><br/>");
	}

	
	%>
	<form action="acessoRestrito.jsp" method="POST">
		<input type="hidden" name="show" value="1">
		<button type="button" id="btnRests" class="btn btn-primary" onclick="this.form.submit();">Listar Restaurantes</button>
	</form>
	<br/>
	<%
	
	//SE O NÍVEL DE ACESSO FOR DE ADMINISTRADOR, PERMITE ACESSAR A ÁREA DE LISTAR USUÁRIOS
	if(level>=3){
		response.getWriter().write("<form action='acessoRestrito.jsp' method='POST'><input type='hidden' name='show' value='2'><button type='button' id='btnRests' class='btn btn-primary' onclick='this.form.submit();''>Listar Usuários</button></form>");
	}
	
	%>
	<br/>
	<h4><a href='cadastroRestaurante.jsp' class='link'>Cadastrar Restaurante</a></h4>
	<br/>
	<h4><a href='home.jsp' class='link'>Voltar</a></h4>
	
</body>
</html>