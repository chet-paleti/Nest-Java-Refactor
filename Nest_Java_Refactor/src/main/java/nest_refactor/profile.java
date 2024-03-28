package nest_refactor;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet implementation class profile
 */
@MultipartConfig
@WebServlet("/profile")
public class profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public profile() {
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
		HttpSession sess = request.getSession();
		String user = (String) sess.getAttribute("appuser");
		String text = (String) request.getParameter("text") ;
		String filename = "";
		
		
		String query = "select user,text from profiles where user='" + user + "'" ;
		String insert = "insert into profiles(user,text) values('" + user + "','" + text + "')" ;
		String update = "update profiles set text = ' " + text + "' where user = '" + user + "'" ;
		Part part = request.getPart("file");
		
		String header = part.getHeader("content-disposition");
		
		ServletContext sc = getServletContext();
		String path_1 = sc.getRealPath("/");
		
		File fileToSave_1 = new File(path_1 + "resources\\" + user + ".jpg");
		
		
		String path = sc.getInitParameter("images");
		
		
		StringTokenizer tokenizer = new StringTokenizer(header, ";");
		while(tokenizer.hasMoreTokens()) {
			String tmp = tokenizer.nextToken() ;
			if(tmp.contains("filename")) {
				 filename = tmp.substring((tmp.indexOf("=")) + 1);
				//System.out.println(filename);
			}
		}
		
		
		if((filename.length() > 2)) {
			
			System.out.println("ready to upload file");
			
			
			InputStream fileInputStream = part.getInputStream();
			File fileToSave = new File(path + "\\" + user + ".jpg");
			
			
			Files.copy(fileInputStream, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
			//Files.copy(fileToSave_1.toPath(), fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
		    			
		}
		
				
		Connection cn ;
	    cn = (Connection)getServletContext().getAttribute("DBCon");
	       	
	   
	    try
		{
			PreparedStatement st = cn.prepareStatement(query);
			ResultSet rs = st.executeQuery();
			
				
			if (rs.next())
			{
				
				PreparedStatement st_update = cn.prepareStatement(update);
				int i = st_update.executeUpdate();
			}
			else {
				
				PreparedStatement st_insert = cn.prepareStatement(insert);
				int j = st_insert.executeUpdate();
				
			}
			
			
		}
		catch (Exception ex)
		{
			//log it
			ex.printStackTrace();
		}
		
	  
	    response.sendRedirect("profile.jsp");
		
		
	}

}
