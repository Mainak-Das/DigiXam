<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*,com.IMAP.DAO.DbConnection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%!
   String role;
   String sql;
   String user;
   String id;
   String email;
%>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{	
		id=request.getParameter("id");
		String sql2="SELECT * FROM users where id=?";
		try{
		DbConnection dbcon2 = new DbConnection();
		Connection con2 = dbcon2.getConnection();
		PreparedStatement st2= con2.prepareStatement(sql2);
		st2.setString(1, id);
		
		ResultSet rs2= st2.executeQuery();
		if(rs2.next())
		{
			role = rs2.getString("role");
			user = rs2.getString("name");
			email=rs2.getString("email");
		}
		rs2.close();
   		st2.close();
   		con2.close();
   		}catch(Exception e){
   			e.printStackTrace();
   		}
%>
<jsp:include page="header.jsp"></jsp:include>
<!-- CSS for Navbar & Sidebar -->
<style>
/* Googlefont Poppins CDN Link */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
.sidebar-dark-primary{
          background-color: #ec2829;
}

</style>
<div class="wrapper">
<jsp:include page="dashboard_navbar.jsp"></jsp:include>
<jsp:include page="dashboard_sidebar.jsp"></jsp:include>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
<section class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <!-- <div class="col-sm-6">
        <h1>Users</h1>
      </div> -->
      <div class="col-sm-6 offset-sm-6">
      
        <ol class="breadcrumb float-sm-right">
          <li class="breadcrumb-item"><a href="#"><%=role %></a></li>
          <li class="breadcrumb-item active"><%=user %></li>
        </ol>
      </div>
    </div>
  </div><!-- /.container-fluid -->
</section>
<!-- Main content -->
<section class="content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-12">
 				<form action="EditController" method="post" enctype="multipart/form-data">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalCenterTitle">Users</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
		      		<input type="hidden" name="id" value="<%=id%>">
		      			<%if(!role.equals("student")){ %>
		      		  <div class="form-group row">
					    <label for="inputPassword" class="col-sm-2 col-form-label">Email</label>
					    <div class="col-sm-10">
					    	<input type="text" class="form-control-plaintext" id="staticEmail" value='<%=email%>' name = "email" placeholder="email@example.com">
					    </div>
					  </div>
					  
	      			  <div class="form-group row">
				      <label for="staticEmail" class="col-sm-2 col-form-label">Name</label>
				      <div class="col-sm-10">
				      	<input type="text" class="form-control" id="inputPassword" value='<%=user%>' name= "name" placeholder="Name">
				      </div>
					 </div>	
					 
					 <!-- department -->	
		                 <%
				
							sql="SELECT * FROM department order by id desc";
							
							//out.println(sql);
							try{
							DbConnection dbcon = new DbConnection();
							Connection con = dbcon.getConnection();
							PreparedStatement st= con.prepareStatement(sql);
							ResultSet rs= st.executeQuery();
						  	int i=1;
						  	if(rs.isBeforeFirst()){
						  		out.println(" ");
						  	}
						  		
						  %>
		                      
						  <div class="form-group row">
		                  <label for="staticEmail" class="col-sm-2 col-form-label">Departments</label>
		                  <div class="col-sm-10">
		            		<select class="form-control" name="dept">
		                      	<%while(rs.next())		
								{	
		                      	%>
		                          <option value="<%=rs.getInt("id")%>"><%=rs.getString("name")%></option>
		                          
		                       <%} %>
		                      </select>		
		                  </div>
		                  </div>
		                  <%
							  	rs.close();
								st.close();
								con.close();
								}catch(Exception e){
										e.printStackTrace();
								}
							%>
							<!-- /.department -->
							
							<!-- class
							    <div class="form-group row">
					                  <label for="staticEmail" class="col-sm-2 col-form-label">Class</label>
					                  <div class="col-sm-10">
					            		<select class="form-control" name="year">
												<option selected disabled>----Choose Option----</option>
					                          <option value="1st">1st Year</option>
					                          <option value="2nd">2nd Year</option>
					                      		<option value="3rd">3rd Year</option>
					                      		<option value="4rth">4rth Year</option>
					                      </select>		
				                  </div>
				                  </div>
							./class -->
					 <%} %>
					 <input type="file" name="profile">  
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <!--<button type="button" class="btn btn-primary">Save changes</button>  -->
			      <input type="submit" class="btn btn-info" value="Update">
			      </div>
</form>
  </div>
      <!-- /.col -->
    </div>
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
</section>
<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<footer class="main-footer">
  <div class="float-right d-none d-sm-block">
    <b>Version</b> 3.2.0
  </div>
  <strong>Copyright &copy; 2021-<%
      GregorianCalendar cal = new GregorianCalendar();
      out.print(cal.get(Calendar.YEAR));
    %> <a href="<%=request.getContextPath()%>/login">DigiXam</a>.</strong> All rights reserved.
</footer>
</div>
<jsp:include page="footer.jsp"></jsp:include>

 </body>
</html>
<%}%>