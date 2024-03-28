<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<c:import url="header.jsp" />

  <% 
  //HttpSession sess = request.getSession();
  String user = (String) session.getAttribute("appuser");
  
  if(user != null) { 
	  session.invalidate(); %>
	  
	  <br><div class='center'>You have been logged out. Please
      <a data-transition='slide' href='index.jsp'>click here</a>
      to refresh the screen.</div>
	  
 <% } else { %>
 		<div class='center'>You cannot log out because you are not logged in</div>
		 
		 <%  } ; %>
 

</body>
</html>