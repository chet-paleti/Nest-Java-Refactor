package nest_refactor;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class signup
 */
@WebServlet("/signup")
public class signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public signup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String user = request.getParameter("user") ;
		String passwd = request.getParameter("pass") ;
		String msg = "";
		String query = "select user from members where user='" + user + "'" ;
		String update = "insert into members(user,pass) values('" + user + "','" + passwd + "')" ;
		String redirect = "signup.jsp";
		
		Connection cn ;
	    cn = (Connection)getServletContext().getAttribute("DBCon");
	    
	    if((user.equals("")) || (passwd.equals(""))) {
	    	redirect = redirect + "?error=1" + "&user=" + user + "&pass=" + passwd ;
	    } else {	
	    
		    try
			{
				PreparedStatement st = cn.prepareStatement(query);
				ResultSet rs = st.executeQuery();
				
				if (rs.next())
				{
					
					redirect = redirect + "?error=2" + "&user=" + user + "&pass=" + passwd ;
				} else {
					
					PreparedStatement st1 = cn.prepareStatement(update);
					int i = st1.executeUpdate();
					redirect = redirect + "?success='Y'";
					
				}
				
			}
			catch (Exception ex)
			{
				//log it
				ex.printStackTrace();
			}
		
	    };
		
	    
		response.sendRedirect(redirect);
	}	

}
