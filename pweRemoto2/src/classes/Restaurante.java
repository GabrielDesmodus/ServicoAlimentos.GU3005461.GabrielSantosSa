package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;


public class Restaurante {
 
	private String	tableName = "";
	private String	fieldsName = "";
	private String	keyField = "";
	private DBQuery	dbQuery = new DBQuery(tableName, fieldsName, keyField);
	

	private int	idRestaurante;
	private String	nome;
	private String	cpf_cnpj;
	private String	endereco;
	private String	bairro;
	private String	cidade;
	private String	uf;
	private String	cep;
	private String	telefone;
	private String	email;

	public Restaurante(){
		this.tableName  = "restaurante";
		this.fieldsName = "idRestaurante, nome, cpf_cnpj, endereco, bairro, cidade, uf, cep, telefone, email";
		this.keyField   = "idRestaurante";
		this.dbQuery = new DBQuery(this.tableName, this.fieldsName, this.keyField);
	}

	public Restaurante(int idRestaurante, String nome, String cpf_cnpj, String endereco, String bairro, String cidade, String uf, String cep, String telefone, String email){
		this.tableName  = "restaurante";
		this.fieldsName = "idRestaurante, nome, cpf_cnpj, endereco, bairro, cidade, uf, cep, telefone, email";
		this.keyField   = "idRestaurante";
		this.dbQuery = new DBQuery(this.tableName, this.fieldsName, this.keyField);
	
		this.setIdInstituicao( idRestaurante);
		this.setNome( nome);
		this.setCpf_cnpj( cpf_cnpj);
		this.setEndereco( endereco);
		this.setBairro( bairro);
		this.setCidade( cidade);
		this.setUf( uf);
		this.setCep( cep);
		this.setTelefone( telefone);
		this.setEmail( email);
	}
	public String toString(){
		return (
			this.getIdRestaurante() +", "+
			this.getNome() +", "+
			this.getCpf_cnpj() +", "+
			this.getEndereco() +", "+
			this.getBairro() +", "+
			this.getCidade() +", "+
			this.getUf() +", "+
			this.getCep() +", "+
			this.getTelefone() +", "+
			this.getEmail() +", "
		);
	 }

	public String[] toArray(){
		return (
			new String[] { 
				""+this.getIdRestaurante(),
				""+this.getNome(),
				""+this.getCpf_cnpj(),
				""+this.getEndereco(),
				""+this.getBairro(),
				""+this.getCidade(),
				""+this.getUf(),
				""+this.getCep(),
				""+this.getTelefone(),
				""+this.getEmail()
			}
		);
	 }

	public void save() {
		  if ((this.getIdRestaurante() == 0 )){
		       this.dbQuery.insert(this.toArray());
          }else{
		      this.dbQuery.update(this.toArray());
          }
        }
	
        public void delete() {
            if (this.getIdRestaurante() > 0 ){
                this.dbQuery.delete( this.toArray() );
            }
        }
	    
	   public String listAll() {
	       ResultSet rs =  this.dbQuery.select("");
           String saida = "<br>";
	       saida += "<table border=1>";
		
		   try {
		      while (rs.next()) {
			     saida += "<tr>";
			     
				 saida += "<td>" + rs.getString("idRestaurante" ) +  "</td>";
				 saida += "<td>" + rs.getString("nome" ) +  "</td>";
				 saida += "<td>" + rs.getString("cpf_cnpj" ) +  "</td>";
				 saida += "<td>" + rs.getString("endereco" ) +  "</td>";
				 saida += "<td>" + rs.getString("bairro" ) +  "</td>";
				 saida += "<td>" + rs.getString("cidade" ) +  "</td>";
				 saida += "<td>" + rs.getString("uf" ) +  "</td>";
				 saida += "<td>" + rs.getString("cep" ) +  "</td>";
				 saida += "<td>" + rs.getString("telefone" ) +  "</td>";
				 saida += "<td>" + rs.getString("email" ) +  "</td>";
			     saida += "</tr> <br>";
		      }
		   } catch (SQLException e) {
			 e.printStackTrace();
		   }
		   saida += "</table>";
		   return (saida);
	   }

	
	public void	setIdInstituicao( int idRestaurante ){
		this.idRestaurante=idRestaurante;
	};
	
	public int	 getIdRestaurante(){
		return ( this.idRestaurante );
	};
	
	public void	setNome( String nome ){
		this.nome=nome;
	};
	
	public String	 getNome(){
		return ( this.nome );
	};
	
	public void	setCpf_cnpj( String cpf_cnpj ){
		this.cpf_cnpj=cpf_cnpj;
	};
	
	public String	 getCpf_cnpj(){
		return ( this.cpf_cnpj );
	};
	
	public void	setEndereco( String endereco ){
		this.endereco=endereco;
	};
	
	public String	 getEndereco(){
		return ( this.endereco );
	};
	
	public void	setBairro( String bairro ){
		this.bairro=bairro;
	};
	
	public String	 getBairro(){
		return ( this.bairro );
	};
	
	public void	setCidade( String cidade ){
		this.cidade=cidade;
	};
	
	public String	 getCidade(){
		return ( this.cidade );
	};
	
	public void	setUf( String uf ){
		this.uf=uf;
	};
	
	public String	 getUf(){
		return ( this.uf );
	};
	
	public void	setCep( String cep ){
		this.cep=cep;
	};
	
	public String	 getCep(){
		return ( this.cep );
	};
	
	public void	setTelefone( String telefone ){
		this.telefone=telefone;
	};
	
	public String	 getTelefone(){
		return ( this.telefone );
	};
	
	public void	setEmail( String email ){
		this.email=email;
	};
	
	public String	 getEmail(){
		return ( this.email );
	};
	
} 