<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<body>



<c:import url="header.jsp" />

<% 

	String user = (String) session.getAttribute("appuser");

	Boolean loggedin = false;

	if(user != null) { 
		loggedin = true ;
		};
    
  %> 


 
<div class='center'> Welcome to Robin's Nest, <% if (loggedin) { %> 
<%= user %>, you are logged in  <% } else { %> please sign up or log in <% } %>
</div><br>	

</div>

<div data-role="footer">
      <h4>Web App from <i><a href='http://lpmj.net/5thedition'
      target='_blank'>Learning PHP MySQL & JavaScript Ed. 5</a></i></h4>
 </div>
 


</body>
</html>