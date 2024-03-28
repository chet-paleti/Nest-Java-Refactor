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
<title>Insert title here</title>
</head>
<body>

<c:import url="header.jsp" />



<%
String text = "";
String name = "";
String user = (String) session.getAttribute("appuser");
//String member = (String) request.getParameter("member");
String profile = "" ;


if(user == null){
	return;
}

%>

<h3>Other Members</h3>
<ul>

<%

String query_1 = "SELECT USER user_1, (SELECT 1 FROM DUAL) flag FROM friends f1 WHERE f1.friend=? AND NOT EXISTS (SELECT * FROM friends f2 WHERE USER=? AND f1.user=f2.friend)";
String query_2 = "SELECT friend user_1, (SELECT 2 FROM DUAL) flag  FROM friends f1 WHERE f1.user=? AND NOT EXISTS (SELECT * FROM friends f2 WHERE friend=? AND f1.friend=f2.user)" ;
String query_3 = "SELECT f1.USER user_1, (SELECT 3 FROM DUAL) flag  FROM friends f1, friends f2 WHERE f1.friend=? AND f1.friend=f2.user AND f2.friend=f1.user" ;
String query_4 = "SELECT USER user_1, (SELECT 0 FROM DUAL) flag FROM members  WHERE USER <> ? and USER NOT IN (SELECT USER FROM friends f2 WHERE f2.friend=? UNION SELECT friend FROM friends f3 WHERE f3.user=?)";

String query = query_1 + " UNION " + query_2 + " UNION " + query_3 + " UNION " + query_4 + " ORDER BY user_1" ;


Connection cn ;
cn = (Connection)getServletContext().getAttribute("DBCon");
   	

try
{
	PreparedStatement st = cn.prepareStatement(query);
	st.setString(1, user);
	st.setString(2, user);
	st.setString(3, user);
	st.setString(4, user);
	st.setString(5, user);
	st.setString(6, user);
	st.setString(7, user);
	st.setString(8, user);
	
	
	ResultSet rs = st.executeQuery();
	
		
			
		while (rs.next())
		{%>
			<li><a data-transition='slide' href='member.jsp?member=<%= rs.getString("user_1") %>'><%= rs.getString("user_1") %></a>
			<% if(rs.getInt("flag") == 3){
					%> 
					&harr; is a mutual friend [<a data-transition='slide' href='members?drop=<%= rs.getString("user_1") %>'>drop</a>]
					
					<%}
			
			else if(rs.getInt("flag") == 2) {
				    
					%>
					 &rarr; is following you [<a data-transition='slide' href='members?add=<%= rs.getString("user_1") %>'>recip</a>]
					  
					<%}
			else if(rs.getInt("flag") == 1) {
					%> 
					&larr; you are following [<a data-transition='slide' href='members?drop=<%= rs.getString("user_1") %>'>drop</a>]
					<%}
			else {
					
					%> 
					[<a data-transition='slide' href='members?add=<%= rs.getString("user_1") %>'>follow</a>]
				
				<%}
			
		 } 
	
}
catch (Exception ex)
{
	//log it
	ex.printStackTrace();
}


%>
</ul></div>
</body>
</html>