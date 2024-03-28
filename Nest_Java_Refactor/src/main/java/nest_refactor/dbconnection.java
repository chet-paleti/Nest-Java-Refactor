package nest_refactor;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;



/**
 * Servlet implementation class dbconnection
 */
@WebServlet("/dbconnection")
public class dbconnection implements ServletContextListener {
	private static final long serialVersionUID = 1L;
	
	String connectionurl ;
	Connection cn;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
   
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		//cleanup the connection when the context is destroyed
	
	cn = null;
	
	System.out.println("DB connection destroyed");
	}
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		//access the servlet context from the event argument (renamed sce)
		//get db con info from context init params
		ServletContext sc = sce.getServletContext();
		String uid = sc.getInitParameter("dbuserid");
		String pwd = sc.getInitParameter("dbuserpwd");
		String cat = sc.getInitParameter("dbinitcat");
		
		connectionurl = String.format("jdbc:mysql://localhost/%s"
				+ "?user=%s&password=%s"
				, cat
				, uid
				, pwd);
		
		System.out.println(connectionurl);
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		    cn = DriverManager.getConnection(connectionurl);
			sc.setAttribute("DBCon", cn);
			
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
			
		
		System.out.println("DB connection created and added to context");
	}

}
