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

String user = (String) session.getAttribute("appuser");


if(user == null){
	return;
}


String query_1 = "SELECT USER user_1, (SELECT 1 FROM DUAL) flag FROM friends f1 WHERE f1.friend=? AND NOT EXISTS (SELECT * FROM friends f2 WHERE USER=? AND f1.user=f2.friend)";
String query_2 = "SELECT friend user_1, (SELECT 2 FROM DUAL) flag  FROM friends f1 WHERE f1.user=? AND NOT EXISTS (SELECT * FROM friends f2 WHERE friend=? AND f1.friend=f2.user)" ;
String query_3 = "SELECT f1.USER user_1, (SELECT 3 FROM DUAL) flag  FROM friends f1, friends f2 WHERE f1.friend=? AND f1.friend=f2.user AND f2.friend=f1.user" ;
//String query_4 = "SELECT USER user_1, (SELECT 0 FROM DUAL) flag FROM members  WHERE USER <> ? and USER NOT IN (SELECT USER FROM friends f2 WHERE f2.friend=? UNION SELECT friend FROM friends f3 WHERE f3.user=?)";

//String query = query_1 + " UNION " + query_2 + " UNION " + query_3 + " UNION " + query_4 + " ORDER BY user_1" ;


Connection cn ;
cn = (Connection)getServletContext().getAttribute("DBCon");
   	

try
{
	PreparedStatement st1 = cn.prepareStatement(query_3);
	st1.setString(1, user);
	//st1.setString(2, user);
	ResultSet rs1 = st1.executeQuery();
	
	PreparedStatement st2 = cn.prepareStatement(query_2);
	st2.setString(1, user);
	st2.setString(2, user);
	ResultSet rs2 = st2.executeQuery();
	
	PreparedStatement st3 = cn.prepareStatement(query_1);
	st3.setString(1, user);
	st3.setString(2, user);
	ResultSet rs3 = st3.executeQuery();
	
	boolean friends = false;
	
	
	if(rs1.isBeforeFirst()) { friends = true ; %>
	
		<span class='subhead'>Your mutual friends</span><ul>
		
		<%
		
		while(rs1.next()) {
		//System.out.println(rs1.getString("user_1"));
		%>
		
			<li><a data-transition='slide' href='member.jsp?member=<%= rs1.getString("user_1") %>'><%= rs1.getString("user_1") %></a>
			
		<%}%>
			</ul>
		
		
	 <%}
	
	if(rs2.isBeforeFirst()) { friends = true ; %>
	
		<span class='subhead'>Your followers</span><ul>
		
		<%
		
		while(rs2.next()) {
		//System.out.println(rs1.getString("user_1"));
		%>
		
			<li><a data-transition='slide' href='member.jsp?member=<%= rs2.getString("user_1") %>'><%= rs2.getString("user_1") %></a>
			
		<%}%>
			</ul>
	
	
 	<%}
	
	if(rs3.isBeforeFirst()) { friends = true ; %>
	
		<span class='subhead'>Your are following</span><ul>
		
		<%
		
		while(rs3.next()) {
		//System.out.println(rs1.getString("user_1"));
		%>
		
			<li><a data-transition='slide' href='member.jsp?member=<%= rs3.getString("user_1") %>'><%= rs3.getString("user_1") %></a>
			
		<%}%>
			</ul>


	<%}
	
	if(!friends) {%>
		<br>You don't have any friends yet.
	
	<% }
	
}
catch (Exception ex)
{
	//log it
	ex.printStackTrace();
}


%>

</body>
</html>