<%@page import="java.sql.ResultSet"%>
<%@page import="database.DBQuery"%>
<%@page import="classes.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String user = request.getParameter("user");
	String pass = request.getParameter("pass");
	
	String saida = ""; 

	Usuario usuario = new Usuario ( user, pass, user);
	
	//VERIFICA SE O USUÁRIO EXISTE E RETORNA VALORES PARA HOME
	if ( usuario.checkLogin() ){
		String where = "email = " + "'"+user+"'";
		String tableName 	= "servcomida.usuarios";
		String fields 		= "idUsuario,idRestaurante,email,senha,idNivelUsuario";
		String fieldKey 	= "idUsuario";
		DBQuery dbQuery = new DBQuery(tableName, fields, fieldKey);
		
		ResultSet resultSet = dbQuery.select("email ='"+user+"' "+ "AND senha='"+pass+"'");
		
		int level = 0;
		
		//RETORNA ID, NÍVEL DE ACESSO E ID DO RESTAURANTE DO USUÁRIO PARA HOME
		while(resultSet.next()){
			session.setAttribute("userlogin", resultSet.getString("idUsuario"));
			session.setAttribute("level", resultSet.getString("idNivelUsuario"));
			session.setAttribute("idRestaurante", resultSet.getString("idRestaurante"));
		}
		
		
		System.out.println(usuario.getIdRestaurante());
		saida = "{ \"login\": \"true\",\"level\": \""+level+"\" }";
		
	}else{
		session.setAttribute("userlogin", 0);
		session.setAttribute("level", 0);
		saida = "{ \"login\": \"false\"}";
	}
	System.out.println(saida);
	out.write(saida);
%>