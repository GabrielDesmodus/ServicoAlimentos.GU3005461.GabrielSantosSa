package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;
import mail.SendMail;
import multitool.RandomCode;

public class Usuario {
	private int	idUsuario;
	private int	idRestaurante;
	private String 	email;
	private String 	senha;
	private int	idNivelUsuario;
	private String nome;
	private String cpf;
	private String endereco;
	private String bairro;
	private String 	cidade;
	private String 	uf;
	private String 	cep;
	private String 	telefone;
	
	private String tableName	= "servcomida.usuarios"; 
	private String fieldsName	= "idUsuario, idRestaurante, email, senha, idNivelUsuario, nome, cpf, endereco, bairro, cidade, uf, cep, telefone";  
	private String fieldKey		= "idUsuario";
	
	private DBQuery dbQuery = new DBQuery(tableName, fieldsName, fieldKey);
	
	public Usuario() {
	
	}
	
	public Usuario( int idUsuario, int idRestaurante, String email, String senha, int idNivelUsuario, String nome, String cpf, String endereco, String bairro, String cidade, String uf, String cep, String telefone) {
		this.setIdUsuario(idUsuario);
		this.setIdRestaurante(idRestaurante);
		this.setEmail(email);
		this.setSenha(senha);
		this.setIdNivelUsuario(idNivelUsuario);
		this.setNome(nome);
		this.setCpf(cpf);
		this.setEndereco(endereco);
		this.setBairro(bairro);
		this.setCidade(cidade);
		this.setUf(uf);
		this.setCep(cep);
		this.setTelefone(telefone);
	}
	
	public Usuario( String email, String senha, String nome) {
		this.setIdUsuario(0);
		this.setIdRestaurante(0);
		this.setEmail(email);
		this.setSenha(senha);
		this.setIdNivelUsuario(0);
		this.setNome(nome);
	}
	
	public Usuario( String email) {
		this.setIdUsuario(0);
		this.setEmail(email);
	}
	
	public String toString() {
		
		return(
				this.getIdUsuario() + ""+" | "+
				this.getIdRestaurante() + ""+" | "+
				this.getEmail()+" | "+
				"********"+" | "+
				this.getIdNivelUsuario() + ""+" | "+
				this.getNome()+" | "+
				this.getCpf()+" | "+
				this.getEndereco()+" | "+
				this.getBairro()+" | "+
				this.getCidade()+" | "+
				this.getUf()+" | "+
				this.getCep()+" | "+
				this.getTelefone()+" | "
		);
	}
	
	private String[] toArray() {
		
		String[] temp =  new String[] {
				this.getIdUsuario() + "",
				this.getIdRestaurante() + "",
				this.getEmail(),
				this.getSenha(),
				this.getIdNivelUsuario() + "",
				this.getNome(),
				this.getCpf(),
				this.getEndereco(),
				this.getBairro(),
				this.getCidade(),
				this.getUf(),
				this.getCep(),
				this.getTelefone()
		};
		return(temp);
	}
	
	public void save() {
		if( this.getIdUsuario() > 0 ) {
			this.dbQuery.update(this.toArray());
		}else {
			this.dbQuery.insert(this.toArray());
		}
	}
	
	public void delete() {
		if( this.getIdUsuario() > 0 ) {
			this.dbQuery.delete(this.toArray());
		}
	}
	
	public ResultSet selectAll() {
		ResultSet resultset = this.dbQuery.select("");
		return(resultset);
	}
	
	public ResultSet selectBy( String field, String value ) {
		ResultSet resultset = this.dbQuery.select( " "+field+"='"+value+"'");
		return(resultset);
	}
	
	public ResultSet select( String where ) {
		ResultSet resultset = this.dbQuery.select(where);
		return(resultset);
	}
	
	public void enviarEmailComSenha( String mailFrom, String mailTo, String mailSubject, String mailBody ){
		
		String smtpHost = "smtp.gmail.com"; 
		String smtpPort = "587"; 
		String username = "usuario@gmail.com";
		String password = "senha123456";
		String auth     = "tls";  
		
		SendMail sendMail =  new SendMail( smtpHost,  smtpPort,  username,  password,  auth  );		
		sendMail.send( mailFrom, mailTo, mailSubject, mailBody );
		
	}
	
	public String newPassword() {
		
		if (this.getEmail() != "" && this.getEmail()!= null) {
			if ( this.getIdUsuario() > 0 ) {
				try {
					ResultSet resultset = this.select(" email ='"+this.getEmail()+"'");
					boolean existe = resultset.next();
					if ( existe ) {
						this.setSenha(  new RandomCode().generate(32) );
						this.save();
						return( this.getSenha());
					}
					resultset.getInt("idUsuario");
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			} else {
				this.setSenha(  new RandomCode().generate(32));
				return(  this.getSenha() );
			}
		} else {
			// Sem email não deve gerar senha
		}
		return this.getSenha(); 
	}

	public boolean checkLogin() {
		
		int id = 0;
		try {
			ResultSet resultSet = this.select(" email='"+ this.getEmail()+ "' AND senha = '"+this.getSenha()+"'");
			while (resultSet.next()) {
				System.out.println( "\n"+resultSet.getString("nome"));
				id =  resultSet.getInt("idUsuario");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		this.setIdUsuario(id);
		return(id > 0);	
	}
	
	public int getIdUsuario() {
		return idUsuario;
	}
	
	public int getIdRestaurante() {
		return idRestaurante;
	}

	public String listAllHtml() {
		ResultSet rs =  this.dbQuery.select("");
		String saida = "<br>";
		saida += "<table border=1>";
		try {
			while (rs.next()) {
				saida += "<tr>";
		     
				saida += "<td>" + rs.getString("idUsuario" ) +  "</td>";
				saida += "<td>" + rs.getString("idRestaurante" ) +  "</td>";
				saida += "<td>" + rs.getString("email" ) +  "</td>";
				saida += "<td>" + rs.getString("senha" ) +  "</td>";
				saida += "<td>" + rs.getString("idNivelUsuario" ) +  "</td>";
				saida += "<td>" + rs.getString("nome" ) +  "</td>";
				saida += "<td>" + rs.getString("cpf" ) +  "</td>";
				saida += "<td>" + rs.getString("endereco" ) +  "</td>";
				saida += "<td>" + rs.getString("bairro" ) +  "</td>";
				saida += "<td>" + rs.getString("cidade" ) +  "</td>";
				saida += "<td>" + rs.getString("uf" ) +  "</td>";
				saida += "<td>" + rs.getString("cep" ) +  "</td>";
				saida += "<td>" + rs.getString("telefone" ) +  "</td>";
				saida += "</tr> <br>";
			}
	   } catch (SQLException e) {
		 e.printStackTrace();
	   }
	   saida += "</table>";
	   return (saida);
	}

	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	
	public void setIdRestaurante(int idRestaurante) {
		this.idRestaurante = idRestaurante;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public int getIdNivelUsuario() {
		return idNivelUsuario;
	}

	public void setIdNivelUsuario(int idNivelUsuario) {
		this.idNivelUsuario = idNivelUsuario;
	}
	
	public void setIdNivelUsuario(String idNivelUsuario) {
		this.idNivelUsuario = ((idNivelUsuario == "") ? 0 : Integer.parseInt(idNivelUsuario));
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getEndereco() {
		return endereco;
	}

	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}

	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getUf() {
		return uf;
	}

	public void setUf(String uf) {
		this.uf = uf;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

}
