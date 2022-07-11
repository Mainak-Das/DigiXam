<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*, com.IMAP.DAO.DbConnection,java.io.File"%>
<%!
   String role;
   String sql;
   String user;
   int id;
   String email;
   String profile_name;
   String path;
%>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{	
		email = (String)session.getAttribute("email");
		String sql2="SELECT * FROM users where email = ? OR username = ?";
		try{
		DbConnection dbcon2 = new DbConnection();
		Connection con2 = dbcon2.getConnection();
		PreparedStatement st2= con2.prepareStatement(sql2);
		st2.setString(1, (String)session.getAttribute("email"));
		st2.setString(2, (String)session.getAttribute("username"));
		ResultSet rs2= st2.executeQuery();
		if(rs2.next())
		{
			role = rs2.getString("role");
			user = rs2.getString("name");
			profile_name=rs2.getString("profile_img");
			path=rs2.getString("profile_path");
			id=rs2.getInt("id");
		}
		rs2.close();
   		st2.close();
   		con2.close();
   		}catch(Exception e){
   			e.printStackTrace();
   		}
		

%>
<style>
nav .profile-details{
  display: flex;
  align-items: center;
  background: #F5F6FA;
  border: 2px solid #EFEEF1;
  border-radius: 6px;
  height: 50px;
  min-width: 190px;
  
}
nav .profile-details li img{
  height: 41px;
  width: 41px;
  border-radius: 6px;
  object-fit: cover;
}
nav .profile-details li .admin_name{
  font-size: 17px;
  font-weight: 500;
  color: #333;
  margin: 0 10px;
  white-space: nowrap;
}

</style>
 <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light sticky-top home-section">
      <!-- Left navbar links -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" id="bars" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
          <h4 class="mt-1"><%=request.getRequestURI().split("/")[request.getRequestURI().split("/").length-1].substring(0, 1).toUpperCase()+request.getRequestURI().split("/")[request.getRequestURI().split("/").length-1].substring(1)%></h4>
        </li>
       
      </ul >
		<!-- <ul class="navbar-nav ml-2">
			<li id="timer1" class="nav-item">
			00:00
			</li>
		</ul> -->
     <ul class="navbar-nav ml-auto profile-details ">
      <li class="nav-item dropdown mb-2">
      	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-expanded="false">
         <%if(profile_name == null){ %>
         <img src="Assets/img/user.jpg" alt="user">
         <%}else{ %>
          <img src="files/<%=profile_name%>" alt="user">
          <%} %>
	     <span class="admin_name"><%=user %></span>
        </a>
        <div class="dropdown-menu mt-2 ml-3" aria-labelledby="navbarDropdown">
          <a class="dropdown-item actionCust"  href="edit-profile?id=<%=id%>"  style="cursor:pointer;">Edit Profile</a>
          <a class="dropdown-item" href="<%=request.getContextPath()%>/Logout">Logout</a>


        </div> 
       
	   </li>
      </ul>
    
     
    </nav>
    <!-- /.navbar -->
   
 <%
}
 %>