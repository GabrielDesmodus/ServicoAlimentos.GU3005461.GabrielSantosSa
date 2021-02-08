<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8">
	<title>Serviço de Alimentos</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style>

		body{
			background-color: #EEEEEE;
		}

		#frmLogin{
			width: 400px;
			position: absolute;
			margin: 0;
		}
	</style>
</head>

<body class="body" id="body">
<div id="msgLogin" style="right: 5px; float: left; width: 50%;" ></div>
<br/>
<br/>

<!-- ESSA ÁREA É MOSTRADA SE O USUÁRIO ESTIVER LOGADO -->

<div id="links">
	<h4><a href='restaurantes.jsp' class='link'>Acessar Restaurantes</a></h4>
</div>

<!-- ESSA ÁREA É MOSTRADA SE O USUÁRIO FOR FUNCIONÁRIO OU ADMINISTRADOR -->

<div id="links2">
	<h4><a href='acessoRestrito.jsp' class='link'>Acesso Restrito</a></h4>
</div>
<br/>
<form id="frmLogin" class="form-horizontal">

	Usuário: <input class="form-control" type="text" name="user" id="user" value="" placeholder="Usuário"><br>
	Senha: <input class="form-control" type="password" name="pass" id="pass" value="" placeholder="Senha"><br>
	<input type="button" class="btn btn-primary" id="btnSendFrmLogin" value="Enviar">
	
<!-- 	LINK PARA CADASTRAR USUÁRIO -->
	<h4><a href="cadastroUser.jsp" class="link">Cadastrar</a></h4>

</form>

<script type="text/javascript">
	$(document).ready( 
		function() {
			
// 			DEIXA AS ÁREAS ESCONDIDAS ATÉ O USUÁRIO REALIZAR O LOGIN
			$("#links").hide();
			$("#links2").hide();
			$("#btnSendFrmLogin").click(
					function() {
						
						var formData = $("#frmLogin").serialize();
						//ENVIA INFORMAÇÕES PARA LOGIN.JSP
						$.post( "login.jsp", formData, function( data, status  ) {
								var objReturn = $.parseJSON( data );
								if ( objReturn.login == "true" ){
									$("#frmLogin").hide('slow');
									$("#msgLogin").html("Login realizado com Sucesso");
									$("#links").show();
									//LOGIN.JSP RETORNA O NÍVEL DE ACESSO DO USUÁRIO, SE FUNCIONÁRIO OU ADMINISTRADOR ELE MOSTRA O LINK DE ACESSO RESTRITO
									if(objReturn.level >=2){
										$("#links2").show();
									}
								}else{
									$("#msgLogin").html("Usuário ou Senha inválido(s)");
								}
							}
						);	
					}		
				);
		} 
	);
	
</script>
</body>
</html>