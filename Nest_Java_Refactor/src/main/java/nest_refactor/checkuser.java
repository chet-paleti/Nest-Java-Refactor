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
 * Servlet implementation class checkuser
 */
@WebServlet("/checkuser")
public class checkuser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public checkuser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String user = request.getParameter("user") ;
		String passwd = request.getParameter("pass") ;
		String exists = "";
		String query = "select user from members where user='" + user + "'" ;
		System.out.println(query);
		
		Connection cn ;
	    cn = (Connection)getServletContext().getAttribute("DBCon");
	    try
		{
			PreparedStatement st = cn.prepareStatement(query);
			ResultSet rs = st.executeQuery();
			
			if (rs.next())
			{
				exists = "<span class='taken'>&nbsp;&#x2718; " + "The username " +  user +  " is taken</span>" ;
			} else {
				
				exists = "<span class='available'>&nbsp;&#x2714; " + "The username " +  user +  " is available</span>" ;
				
			}
			
		}
		catch (Exception ex)
		{
			//log it
			ex.printStackTrace();
		}
		
		 PrintWriter out = response.getWriter();
		  out.write(exists);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
