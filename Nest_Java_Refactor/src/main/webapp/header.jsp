<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<%        
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", -1);
 %>
<html>
<head>
 	<meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'> 
    <link rel='stylesheet' href="${pageContext.request.contextPath}/resources/css/jquery.mobile-1.4.5.min.css">
    <link rel='stylesheet' href="${pageContext.request.contextPath}/resources/css/styles.css" type='text/css'>
    <script src="${pageContext.request.contextPath}/resources/javascript.js"></script>
    <script src="${pageContext.request.contextPath}/resources/jquery-2.2.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/jquery.mobile-1.4.5.min.js"></script>


 
<% 	String usrstr  = "Welcome Guest"; 

	String user = (String) session.getAttribute("appuser");
    
    Boolean loggedin = false;
    
    if(user != null) { 
    	loggedin = true ;
    	usrstr  = "Logged in as: " +  user;
    };
    
    %> 


<title>Robin's Nest: <%= usrstr %></title>
</head>

<body>

 <div data-role='page'> 
      <div data-role='header'>
        <div id='logo' class='center'>R<img id=robin src="${pageContext.request.contextPath}/resources/robin.gif">bin's Nest</div>
        <div class='username'><%= usrstr %></div>
      </div>
      <div data-role='content'>
      
   
         <% if(loggedin) { %>  
      			
  		<div class='center'>
  		
  		
  		 <a data-role='button' data-inline='true' data-icon='home'
            data-transition="slide" href='member.jsp?member=<%= user %>'>Home</a>
          <a data-role='button' data-inline='true' data-icon='user'
            data-transition="slide" href='members.jsp'>Members</a>
          <a data-role='button' data-inline='true' data-icon='heart'
            data-transition="slide" href='friends.jsp'>Friends</a><br>
          <a data-role='button' data-inline='true' data-icon='mail'
            data-transition="slide" href='messages.jsp?member=<%= user %>'>Messages</a>
          <a data-role='button' data-inline='true' data-icon='edit'
            data-transition="slide" href='profile.jsp'>Edit Profile</a>
          <a data-role='button' data-inline='true' data-icon='action'
            data-transition="slide" href='logout.jsp'>Log out</a>
  		
  		 </div>
  		 
  		 <% } else { %>
  		
   			
  		  		<div class='center'>
          <a data-role='button' data-inline='true' data-icon='home'
            data-transition='slide' href='index.jsp'>Home</a>
          <a data-role='button' data-inline='true' data-icon='plus'
            data-transition="slide" href='signup.jsp'>Sign Up</a>
          <a data-role='button' data-inline='true' data-icon='check'
            data-transition="slide" href='login.jsp'>Log In</a>
            
        </div>
        
        <p class='info'>(You must be logged in to use this app)</p>
 
  		 <% } %>
		
         
   </body>
   </html>
      
