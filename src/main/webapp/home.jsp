
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*,com.IMAP.DAO.DbConnection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%!
   String role;
   String sql;
   String user;
   int dept;
   String year;
   int user_id;
   String sp="super-admin";
   String ad="admin";
   String te="teacher";
%>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{	
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
			dept = rs2.getInt("dept_id");
			year = rs2.getString("class");
			user_id=rs2.getInt("id");
		}
		rs2.close();
   		st2.close();
   		con2.close();
   		}catch(Exception e){
   			e.printStackTrace();
   		}
		session.setAttribute("user_id", user_id);
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date d = new java.sql.Date(utilDate.getTime());
		java.sql.Time t = new java.sql.Time(utilDate.getTime());
	if(!role.equals("student"))	{
%>

<jsp:forward page="user"></jsp:forward>
<%} %>
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
          <li class="breadcrumb-item"><a href="#"><%=role%></a></li>
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
        
		<div class="card">
		  <div class="card-header">
		    Instructions
		  </div>
		  <div class="card-body">
		    
		  </div>
		</div>
       <div class="card">
	  <div class="card-header">
	    List Of Subject Available For Examination Now
	  </div>
	  <div class="card-body">
	   <%
              sql="select * from examination as e inner join subjects as s on e.sub_id=s.id  where e.dept_id=? and e.year=? and e.date=? order by e.id desc";
              
				//out.println(sql);
				try{
				DbConnection dbcon = new DbConnection();
				Connection con = dbcon.getConnection();
				PreparedStatement st= con.prepareStatement(sql);
				st.setInt(1,dept);
				st.setString(2, year);
				st.setDate(3, d);
				//st.setTime(4, t);
				
				ResultSet rs= st.executeQuery();
			  	int i=1;
			  	if(!rs.isBeforeFirst()){
			  		out.println(" ");
			  	}
			  	if(rs.next())		
				{	
			  		session.setAttribute("sub", rs.getString("s.name"));
			  %>
	  
	   <a href="<%=request.getContextPath()%>/instruction?qsn_id=<%=rs.getInt("e.id")%>">
	   
	  <div class="card" style="background-color:#EFEBEB">
		  <div class="card-body ">
		    <%=rs.getString("s.name") %>
		  </div>
	  </div>
	  
	   </a> 
	   
	    <%
			  	i++;
			  	}
			  	rs.close();
				st.close();
				con.close();
				}catch(Exception e){
						e.printStackTrace();
					}
				%>
	  </div>
	</div>
	<!-- list of subjects -->
	<div class="card">
	 <%
              sql="select * from subjects where dept_id=? and year=? order by id desc";
              
				//out.println(sql);
				try{
				DbConnection dbcon = new DbConnection();
				Connection con = dbcon.getConnection();
				PreparedStatement st= con.prepareStatement(sql);
				st.setInt(1,dept);
				st.setString(2, year);
				
				ResultSet rs= st.executeQuery();
			  	int i=1;
			  	if(!rs.isBeforeFirst()){
			  		out.println(" ");
			  	}
			  	%>
	  <div class="card-header">
	    List Of All Subjects
	  </div>
	  <%
	  while(rs.next())		
		{	
	  		
	  %>
	 
	  <div class="card-body">
	    <%=rs.getString("name") %>
	  </div>
	   <%
			  	i++;
			  	}
			  	rs.close();
				st.close();
				con.close();
				}catch(Exception e){
						e.printStackTrace();
					}
				%>
	</div>
	
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
<script type="text/javascript">
    $(function () {
      $("#example1").DataTable({
        "responsive": true, "lengthChange": false, "autoWidth": false,
        "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
      }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    });
  </script>
 </body>
</html>
<%}%>