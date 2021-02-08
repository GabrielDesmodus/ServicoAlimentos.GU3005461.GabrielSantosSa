import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HelloWorldServlet")
public class HelloWorldServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public HelloWorldServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String message = request.getParameter("message");
		String valor = request.getParameter("valor");
		
		
		PrintWriter saida =  response.getWriter();
		
		
		saida.write("Hello World Servlet" + " : "+ message+ " : "+ valor);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
