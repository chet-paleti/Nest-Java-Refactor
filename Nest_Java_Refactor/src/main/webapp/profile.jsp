<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.sql.* "%>
    

    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<!DOCTYPE html>

 <%        
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", -1);
 %>
<html>


<head>
<meta charset="ISO-8859-1">


</head>
<body>

<c:import url="header.jsp" />

<%
	  
    String text = "";
	//HttpSession sess = request.getSession();
	String user = (String) session.getAttribute("appuser");
	
	if(user == null){
		return;
	}
	
	

String query = "select user,text from profiles where user='" + user + "'" ;



Connection cn ;
cn = (Connection)getServletContext().getAttribute("DBCon");
   	

try
{
	PreparedStatement st = cn.prepareStatement(query);
	ResultSet rs = st.executeQuery();
	
		
			
		if (rs.next())
		{
			text = rs.getString("text") ;
		} 
	
}
catch (Exception ex)
{
	//log it
	ex.printStackTrace();
}

   
     
  %>

<h3>Your Profile</h3>

<%

String path = request.getContextPath();
String user_pic = path + "/resources/" + user + ".jpg" ;

%>
<!--  
<img src="${pageContext.request.contextPath}/resources/<%= user %>.jpg" style='float:left;'>
-->

<img src="images?profile=<%= user%>" style='float:left;'>

<%= text %> <br style='clear:left;'><br>



	<form data-ajax='false' method='post'
        action='profile' enctype='multipart/form-data'>
      <h3>Enter or edit your details and/or upload an image</h3>
      <textarea name='text'><%=text%></textarea>><br>
      Image: <input type='file' name='file' size='14'>
      <input type='submit' value='Save Profile'>
      </form>
    </div><br>

</body>
</html>