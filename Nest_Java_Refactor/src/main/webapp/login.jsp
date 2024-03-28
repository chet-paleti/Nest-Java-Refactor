
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>

<body>

<c:import url="header.jsp" />

<%! 

	
	String errormsg ;
   
    String user = "" ;
    String passwd = "" ;
    
     
  %> 
  
  
  <% 
  user = (String) session.getAttribute("appuser");
  String error = (String) request.getParameter("error");
  

  if(user == null) {
	  user = "";
	  if(error != null)
	  {
	   if(!(error.equals("Y"))) {
		   
		   
	    	errormsg = "Invalid login attempt";
	    } ;
	  } else {
		  errormsg = "";
	  };  %>
	  
	  <form method='post' action='login'>
      <div data-role='fieldcontain'>
        <label></label>
        <span class='error'><%= errormsg %></span>
      </div>
      <div data-role='fieldcontain'>
        <label></label>
        Please enter your details to log in
      </div>
      <div data-role='fieldcontain'>
        <label>Username</label>
        <input type='text' maxlength='16' name='user' value=<%=user%>>
      </div>
      <div data-role='fieldcontain'>
        <label>Password</label>
        <input type='password' maxlength='16' name='pass' value=<%=passwd%>>
      </div>
      <div data-role='fieldcontain'>
        <label></label>
        <input data-transition='slide' type='submit' value='Login'>
      </div>
    </form>
  </div>

<% 	  
  } else { %>
  
   <div class='center'>You are now logged in <%= user %>. Please
             <a data-transition='slide' href='member.jsp?member=<%= user %>'>click here</a>
             to continue.</div>  
  <% }%>

    

</body>
</html>