<%@page import="org.apache.struts2.components.ElseIf"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

  

</head>
<body>

<c:import url="header.jsp" />

<%! 

    String errormsg = "" ;
   
         
 %> 

<% 

	
	String error = (String) request.getParameter("error");
	String success = (String) request.getParameter("success");
   
	String user = (String) request.getParameter("user");
	String passwd = (String) request.getParameter("pass");
	
  
    if(success != null) { %>
    
    <h4>Account created</h4>Please Log in.</div>
    	
    	
    <% } else {
    	
    	if(error != null) {
    		if(error.equals("1")) {
    			errormsg = "Not all fields were entered" ;
    		} else {
    			errormsg = "That username already exists" ;
    		};
    		
    	} else {
    		user = "";
    		passwd = "";
    	
    	}%>
    
	    <script>
	    function checkUser(user)
	    {
	      if (user.value == '')
	      {
	        $('#used').html('&nbsp;')
	        return
	      }
	
	      $.post
	      (
	        'checkuser',
	        { user : user.value },
	        function(data)
	        {
	          $('#used').html(data)
	        }
	      )
	    }
	  </script> 

		<form method='post' action='signup'><%=errormsg%>
		      <div data-role='fieldcontain'>
		        <label></label>
		        Please enter your details to sign up
		      </div>
		      <div data-role='fieldcontain'>
		        <label>Username</label>
		        <input type='text' maxlength='16' name='user' value='<%=user%>'
		          onBlur='checkUser(this)'>
		        <label></label><div id='used'>&nbsp;</div>
		      </div>
		      <div data-role='fieldcontain'>
		        <label>Password</label>
		        <input type='text' maxlength='16' name='pass' value=<%=passwd%>>
		      </div>
		      <div data-role='fieldcontain'>
		        <label></label>
		        <input data-transition='slide' type='submit' value='Sign Up'>
		      </div>
		    </div>
		</form>
    
   <%  } %>
     
  
</body>
</html>