<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="UTF-8"%>
<%@page import= "java.sql.*,com.IMAP.DAO.*"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.*"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>

<%!
   String role;
   String sql;
   String user;
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
		session.setAttribute("file_id", session.getAttribute("id"));
		session.setAttribute("user_id", session.getAttribute("user_id"));
		String sql2="SELECT role, name FROM users where email = ? OR username = ?";
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
<section class="content-header ">
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
		
			<div class="card ">
		  <div class="card-header"  style="text-align:left;">
		    <h4>Screen. 2</h4>
		  </div>
		  <div class="card-body">
		  	<div class="row">
		  		<div class="col-12">
		  			
		  				<p style="text-align:left;">
		  					Please Upload <b>ALL</b> your hand written answer sheet images for this paper as <b>ONE Single PDF</b> File. First page of the PDF should be the <b>Filled Cover Sheet</b> prescribed by the University. 
							<b>Note :</b> Please make sure you upload the right PDF file and do not miss any of your answers / pages or the Filled Cover Sheet
							<b>No changes will be entertained after the Exam has ended.</b>
		  				</p>
		  			
		  		</div>
		  	</div>
		  		<div class="row">
		  		<div class="col-2">
		  			<b>ans.</b>
		  		</div>
		  	</div>
		  		<div class="row mt-1">
		  		<div class="col-5  border p-1">
		  			   <form action="AnswerController" method="post" enctype="multipart/form-data">
					       	  
		              <input type="file" name="ans">
		                
		              <input type="hidden" name="file_id" value="<%=session.getAttribute("file_id")%>">
		              <input type="hidden" name="user_id" value="<%=session.getAttribute("user_id")%>">
		              <input type="submit" class="btn btn-sm btn-secondary" value="Upload">
                                   
              		</form>
		  		</div>
		  	</div>
		  		<div class="row mt-1">
		  		<div class="col-5">
		  			<p style="text-align:left;">
		  			<b>
		  			Please upload ONE single PDF FILE of your answer TO this
					question. Image upload IS NOT allowed. Once FILE IS
					uploaded press "Save & continue" TO save. TO REPLACE FILE
					choose different FILE AND follow same PROCESS.
		  			
		  			</b>
		  			</p>
		  		</div>
		  	</div>
		  	
		 
		  </div>
		  <div class="card-footer text-muted">
		  	<div class="row">
		  		<div class="col-6" style="text-align:left;">
		  			<a href="<%=request.getContextPath()%>/StudentReadViewController?id=<%=request.getParameter("qsn_id")%>" class="btn btn-primary">Previous</a>
		  		</div>
		  		<div class="col-6" style="text-align:right;">
		  			<a href="<%=request.getContextPath()%>/screen3?qsn_id=<%=request.getParameter("qsn_id")%>" class="btn btn-primary">Next</a>
		  		</div>
		  	</div>
		  </div>
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

 
</script>
 </body>
</html>
<%}%>