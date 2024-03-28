<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.sql.* "
    import="java.util.Date "
    import="java.text.* "%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>



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
Date msg_date ;
//DateFormat df = new SimpleDateFormat("dd:MM:yy:HH:mm:ss");
DateFormat df = new SimpleDateFormat("MMM d yy h:mm a ");

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

String query = "select * from messages where recip='" + profile + "'" + "order by time desc " ;
String query_1 = "select user,text from profiles where user='" + member + "'" ;



Connection cn ;
cn = (Connection)getServletContext().getAttribute("DBCon");
int i = 0;   	

try
{
	
	PreparedStatement st1 = cn.prepareStatement(query_1);
	ResultSet rs1 = st1.executeQuery();
	
		
			
		if (rs1.next())
		{
			text = rs1.getString("text") ;
		} 
	
	
}
catch (Exception ex)
{
	//log it
	ex.printStackTrace();
}

%>

 <h3> <%= name %>  Messages</h3>
 <img src="images?profile=<%= profile%>" style='float:left;'>
<%= text %> <br style='clear:left;'><br>

<form method='post' action='messages?member=<%= member %>'>
        <fieldset data-role="controlgroup" data-type="horizontal">
          <legend>Type here to leave a message</legend>
          <input type='radio' name='pm' id='public' value='0' checked='checked'>
          <label for="public">Public</label>
          <input type='radio' name='pm' id='private' value='1'>
          <label for="private">Private</label>
        </fieldset>
      <textarea name='text'></textarea>
      <input data-transition='slide' type='submit' value='Post Message'>
    </form><br>
    
 <% 
 
 try
 {
 	PreparedStatement st = cn.prepareStatement(query);
 	ResultSet rs = st.executeQuery();
 	
 	while(rs.next()){
 		//System.out.println(rs.getString("pm"));
 		
 		i++;
 		if((rs.getString("pm").equals("0")) || (rs.getString("auth").equals(user)) || (rs.getString("recip").equals(user)) ) { 
 		    

 			//msg_date =Long.parseLong(rs.getString("time")); 
 		   //msg_date = rs.getLong("time");
 		   //Calendar cal = Calendar.getInstance();
 	       //cal.setTimeInMillis(msg_date);
 	       msg_date = new Date(rs.getLong("time")*1000);
 	       
 			
 			%>
 			
 			<%= df.format(msg_date) %>:
 			<a href = 'messages.jsp?member=<%= rs.getString("auth") %>'> <%= rs.getString("auth") %> </a>
 			 <% if(rs.getString("pm").equals("0")) {%> wrote <% }
 			 else { %> whispered
 			 <%} %>
 			 : "<%= rs.getString("message") %>"
 			 <% if (rs.getString("recip").equals(user)) {%>
 			 	[ <a href='messages?erase=<%= rs.getInt("Id") %>&member=<%= rs.getString("recip") %>'>erase</a>]
 			 
 			<%} %>
 			<br>
 			
 		<% }
 		
 	}
 	
 	
 }
 catch (Exception ex)
 {
 	//log it
 	ex.printStackTrace();
 }
 
 
 %>
 
 <% if(i==0){ %>
 
 <br><span class='info'>No messages yet</span><br><br>
 
 <%} %>
 
<br><a data-role='button' href='messages?member=<%= member %>'>Refresh messages</a>



</body>
</html>