package classes;

import java.sql.ResultSet;
import java.sql.SQLException;

import database.DBQuery;


public class Comidas {
 
	private String	tableName = "";
	private String	fieldsName = "";
	private String	keyField = "";
	// private String	where = "";
	private DBQuery	dbQuery = new DBQuery(tableName, fieldsName, keyField);
	

	private int	idComida;
	private int	idRestaurante;
	private String	nome;
	private String	descricao;

	public Comidas(){
		this.tableName  = "servcomida.comidas";
		this.fieldsName = "idComida, idRestaurante, nome, descricao";
		this.keyField   = "idComida";
		this.dbQuery = new DBQuery(this.tableName, this.fieldsName, this.keyField);
	}

	public Comidas(int idComida, int idRestaurante, String nome, String	descricao){
		this.tableName  = "servcomida.comidas";
		this.fieldsName = "idComida, idRestaurante, nome, descricao";
		this.keyField   = "idComida";
		this.dbQuery = new DBQuery(this.tableName, this.fieldsName, this.keyField);
	
		this.setIdComida( idComida);
		this.setIdRestaurante( idRestaurante);
		this.setNome( nome);
		this.setDescricao( descricao);
	}
	
	public String toString(){
		return (
			this.getIdComida() +", "+
			this.getIdRestaurante() +", "+
			this.getNome() +", "+
			this.getDescricao() + ", "
		);
	 }

	public String[] toArray(){
		return (
			new String[] { 
				""+this.getIdComida(),
				""+this.getIdRestaurante(),
				""+this.getNome(),
				""+this.getDescricao()
			}
		);
	 }

	public void save() {
		  if ((this.getIdComida() == 0 )){
		       this.dbQuery.insert(this.toArray());
          }else{
		      this.dbQuery.update(this.toArray());
          }
        }
	
        public void delete() {
            if (this.getIdComida() > 0 ){

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
			     
				 saida += "<td>" + rs.getString("idComida" ) +  "</td>";
				 saida += "<td>" + rs.getString("idRestaurante" ) +  "</td>";
				 saida += "<td>" + rs.getString("nome" ) +  "</td>";
				 saida += "<td>" + rs.getString("descricao" ) +  "</td>";
			     saida += "</tr> <br>";
		      }
		   } catch (SQLException e) {
			 e.printStackTrace();
		   }
		   saida += "</table>";
		   return (saida);
	   }

	
	public void	setIdComida( int idComida ){
		this.idComida=idComida;
	};
	
	public int	 getIdComida(){
		return ( this.idComida );
	};
	
	public void	setIdRestaurante( int idRestaurante ){
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
	
	public void	setDescricao( String descricao ){
		this.descricao=descricao;
	};
	
	public String	 getDescricao(){
		return ( this.descricao );
	};
	
} 