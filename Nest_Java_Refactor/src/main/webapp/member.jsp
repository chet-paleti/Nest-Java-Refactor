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
String name = "";
String user = (String) session.getAttribute("appuser");
String member = (String) request.getParameter("member");
String profile = "" ;

if(user == null){
	return;
}

if(user.equals(member)){
	 name = "Your";
	 profile = user ;
} else {
	 
	 profile = member ;
	 name = profile + "'s" ;
}

String query = "select user,text from profiles where user='" + profile + "'" ;



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


<h3><%= name %> Profile</h3>

<img src="images?profile=<%= profile%>" style='float:left;'>
<%= text %> <br style='clear:left;'><br>

 <a data-role='button' data-transition='slide'
          href='messages.jsp?member=<%= member %>'>View <%= name %> messages</a>

</div>
</body>
</html>