package nest_refactor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class messages
 */
@WebServlet("/messages")
public class messages extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public messages() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String msg = (String) request.getParameter("erase");
		String member = (String) request.getParameter("member");
		
		
		String redirect = "messages.jsp?member=" + member ;
		
		if(msg !=null) {
			
		
		int msg_id = Integer.parseInt(msg);
		String query = "DELETE FROM messages WHERE id=?";
		Connection cn ;
	    cn = (Connection)getServletContext().getAttribute("DBCon");
	    
	    
		
		
		try
		{
			PreparedStatement preparedStatement = cn.prepareStatement(query);
			
			preparedStatement.setInt(1, msg_id);
			
			
			int row = preparedStatement.executeUpdate();
			
			
		}
		catch (Exception ex)
		{
			//log it
			ex.printStackTrace();
		}
		
		}
	
		response.sendRedirect(redirect);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession sess = request.getSession();
		String user = (String) sess.getAttribute("appuser");
		String member = (String) request.getParameter("member");
		String pm = (String) request.getParameter("pm").substring(0, 1);
		String text = (String) request.getParameter("text");
		long time = (System.currentTimeMillis()/1000);
		
		String query = "INSERT INTO messages (AUTH, RECIP, PM,TIME,MESSAGE) VALUES (?,?,?,?,?)";
		Connection cn ;
	    cn = (Connection)getServletContext().getAttribute("DBCon");
	    
	    String redirect = "messages.jsp?member=" + member ;
		
		
		try
		{
			PreparedStatement preparedStatement = cn.prepareStatement(query);
			
			preparedStatement.setString(1, user);
			preparedStatement.setString(2, member);
			preparedStatement.setString(3, pm);
			preparedStatement.setLong(4, time);
			preparedStatement.setString(5, text);
			
			 int row = preparedStatement.executeUpdate();
			
			
		}
		catch (Exception ex)
		{
			//log it
			ex.printStackTrace();
		}
	
		response.sendRedirect(redirect);
	}

}
