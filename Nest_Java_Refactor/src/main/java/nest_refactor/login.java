package nest_refactor;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
HttpSession sess = request.getSession();
		
		String user = request.getParameter("user") ;
		String passwd = request.getParameter("pass") ;
		String redirect = "login.jsp";
		String query = "select user from members where user='" + user + "' and pass='" + passwd +  "'" ;
		
		
		Connection cn ;
	    cn = (Connection)getServletContext().getAttribute("DBCon");
	    try
		{
			PreparedStatement st = cn.prepareStatement(query);
			ResultSet rs = st.executeQuery();
			
			if (rs.next())
			{
				sess.setAttribute("appuser", user);
			}
			else {
				redirect = redirect + "?error='Y'";
				
			}
		}
		catch (Exception ex)
		{
			//log it
			ex.printStackTrace();
		}
		
		response.sendRedirect(redirect);
		

	}

}
