package nest_refactor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class members
 */
@WebServlet("/members")
public class members extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public members() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession sess = request.getSession();
		String user = (String) sess.getAttribute("appuser");
		String add_member = (String) request.getParameter("add");
		String drop_member = (String) request.getParameter("drop");
		
		String query_1 = "INSERT INTO friends(user,friend) VALUES (?,?)";
		String query_2 = "DELETE FROM friends WHERE user=? and friend=?";
		
		Connection cn ;
	    cn = (Connection)getServletContext().getAttribute("DBCon");
	    
		
		try
		{
			if(add_member != null) {
				
				PreparedStatement preparedStatement = cn.prepareStatement(query_1);
				
				preparedStatement.setString(1, add_member);
				preparedStatement.setString(2, user);
				
				int add = preparedStatement.executeUpdate();
				
			} else if (drop_member != null) {
				
				PreparedStatement preparedStatement = cn.prepareStatement(query_2);
				
				preparedStatement.setString(1, drop_member);
				preparedStatement.setString(2, user);
				
				int drop = preparedStatement.executeUpdate();
				
			}
			
					
		}
		catch (Exception ex)
		{
			//log it
			ex.printStackTrace();
		}
		
		response.sendRedirect("members.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
