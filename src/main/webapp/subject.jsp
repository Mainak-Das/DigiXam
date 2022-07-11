<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*,com.IMAP.DAO.DbConnection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%!
   String role;
   String sql;
   String user;
   String sp="super-admin";
   String ad="admin";
   String te="teacher";
   int uid;
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
			uid=rs2.getInt("id");
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
      
        <div class="card">
        <%if(!role.equals("teacher")) {%>
          <div class="card-header">
            <h3 class="card-title mt-2 font-weight-bold">Subjects</h3>
            
             <a class="btn btn-outline-primary float-right" data-toggle="modal" data-target="#addmodal">
              <span class="fa fa-plus mr-1" aria-hidden="true"></span> <span> Add</span>
             </a>
            	 <!-- Modal -->
			    <div class="modal fade" id="addmodal" tabindex="-1" role="dialog" aria-labelledby="addmodalTitle1" aria-hidden="true">
			      <div class="modal-dialog modal-dialog-centered" role="document">
			        <div class="modal-content">
			        <form action="AddSubjectController" method="post">
			          <div class="modal-header">
			            <h5 class="modal-title" id="addmodalTitle1">Subjects</h5>
			            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			              <span aria-hidden="true">&times;</span>
			            </button>
			          </div>
			          <div class="modal-body">
						<div class="form-group row">
		                  <div class="col-sm-12">
		                      <input type="text" class="form-control" id="name" placeholder="Subject Name" name= "name" >
		                  </div>
		                 </div>	
		                 	  <!-- department -->	
		                 <%
				
							sql="SELECT * FROM department order by id desc";
							
							//out.println(sql);
							try{
							DbConnection dbcon9 = new DbConnection();
							Connection con9 = dbcon9.getConnection();
							PreparedStatement st9= con9.prepareStatement(sql);
							ResultSet rs9= st9.executeQuery();
						  	int i9=1;
						  	if(rs9.isBeforeFirst()){
						  		out.println(" ");
						  	}
						  		
						  %>
		                      
						  <div class="form-group row">
		                  <label for="staticEmail" class="col-sm-2 col-form-label">Departments</label>
		                  <div class="col-sm-10">
		            		<select class="form-control" name="dept">
		                      	<%while(rs9.next())		
								{	
		                      	%>
		                          <option value="<%=rs9.getInt("id")%>"><%=rs9.getString("name")%></option>
		                          
		                       <%} %>
		                      </select>		
		                  </div>
		                  </div>
		                  <%
							  	rs9.close();
								st9.close();
								con9.close();
								}catch(Exception e){
										e.printStackTrace();
								}
							%>
							<!-- /.department -->	 

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
					                  
					                   <div class="form-group row">
					                  <label for="staticEmail" class="col-sm-2 col-form-label">Class</label>
					                  <div class="col-sm-10">
					            		<select class="form-control" name="sem">
												<option selected disabled>----Choose Option----</option>
					                          <option value="1st">1st Semester</option>
					                          <option value="2nd">2nd Semester</option>
					                      		<option value="3rd">3rd Semester</option>
					                      		<option value="4rth">4rth Semester</option>
					                      		<option value="5th">5th Semester</option>
					                          <option value="6th">6th Semester</option>
					                      		<option value="7th">7th Semester</option>
					                      		<option value="8th">8th Semester</option>
					                      </select>		
					                  </div>
					                  </div>
			          </div>
			          <div class="modal-footer">
			            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			          	<input type="submit" class="btn btn-info" value="Add">
			          </div>
			          </form>
			        </div>
			      </div>
			    </div>
            	<!-- /.modal -->
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <table id="example1" class="table table-bordered ">
              <thead>
              <tr>
                  <th>ID</th>
			      <th>Subject</th>
			      <th>Class</th>
			      <th>Semester</th>
			      <th>Action</th>
              </tr>
              </thead>
              <tbody>
              <%
				
				sql="SELECT * FROM subjects order by id desc";
				
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
			  	while(rs.next())		
				{		
			  %>
			    <tr>
			      <td><%=i%></td>
			      <td><%=rs.getString("name")%></td>
			      <td><%=rs.getString("year")%> Year</td>
			      <td><%=rs.getString("sem")%> Semester</td>
			      <td>
			      <!-- Button trigger modal -->
					<a class="actionCust" data-toggle="modal" data-target="#exampleModalCenter<%=rs.getInt("id")%>" style="cursor:pointer;">
					  <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
					</a>
					<!-- Modal -->
					<div class="modal fade" id="exampleModalCenter<%=rs.getInt("id")%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle<%=rs.getInt("id")%>" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					     <%
						    String sql1="SELECT * FROM subjects where id = ?";
						  	try{
						  	DbConnection dbcon1 = new DbConnection();
						  	Connection con1 = dbcon1.getConnection();
						  	PreparedStatement st1= con1.prepareStatement(sql1);
						  	st1.setInt(1, rs.getInt("id"));
						  	ResultSet rs1= st1.executeQuery();
					      	if(rs1.next())
					      	{  		
					    %>
					    <form action="EditSubjectController" method="post">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalCenterTitle">Subject</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					      		<input type="hidden" name="id" value='<%=rs.getInt("id")%>'>
				      			  <div class="form-group row">
							      <label for="staticEmail" class="col-sm-2 col-form-label">Name</label>
							      <div class="col-sm-10">
							      	<input type="text" class="form-control" id="inputPassword1" value='<%=rs1.getString("name")%>' name= "name" placeholder="Name">
							      </div>
								  </div>	
								  	  <!-- department -->	
		                 <%
				
							sql="SELECT * FROM department order by id desc";
							
							//out.println(sql);
							try{
							DbConnection dbcon9 = new DbConnection();
							Connection con9 = dbcon9.getConnection();
							PreparedStatement st9= con9.prepareStatement(sql);
							ResultSet rs9= st9.executeQuery();
						  	int i9=1;
						  	if(rs9.isBeforeFirst()){
						  		out.println(" ");
						  	}
						  		
						  %>
		                      
						  <div class="form-group row">
		                  <label for="staticEmail" class="col-sm-2 col-form-label">Departments</label>
		                  <div class="col-sm-10">
		            		<select class="form-control" name="dept">
		                      	<%while(rs9.next())		
								{	
		                      	%>
		                          <option value="<%=rs9.getInt("id")%>"><%=rs9.getString("name")%></option>
		                          
		                       <%} %>
		                      </select>		
		                  </div>
		                  </div>
		                  <%
							  	rs9.close();
								st9.close();
								con9.close();
								}catch(Exception e){
										e.printStackTrace();
								}
							%>
							<!-- /.department -->	 
								  
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
					                  
					                   <div class="form-group row">
					                  <label for="staticEmail" class="col-sm-2 col-form-label">Semester</label>
					                  <div class="col-sm-10">
					            		<select class="form-control" name="sem">
												<option selected disabled>----Choose Option----</option>
					                          <option value="1st">1st Semester</option>
					                          <option value="2nd">2nd Semester</option>
					                      		<option value="3rd">3rd Semester</option>
					                      		<option value="4rth">4rth Semester</option>
					                      		<option value="5th">5th Semester</option>
					                          <option value="6th">6th Semester</option>
					                      		<option value="7th">7th Semester</option>
					                      		<option value="8th">8th Semester</option>
					                      </select>		
					                  </div>
					                  </div>
								  
								 	  
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					        <!--<button type="button" class="btn btn-primary">Save changes</button>  -->
					      <input type="submit" class="btn btn-info" value="Update">
					      </div>
					      </form>
					      <%}%>
					    </div>
					  </div>
					</div>
				<%
					rs1.close();
			   		st1.close();
			   		con1.close();
			   		}catch(Exception e){
			   			e.printStackTrace();
			   		}
				%>  
			   		<span class="actionCust float-right">
			   			<a href="<%=request.getContextPath()%>/DeleteSubjectController?id=<%=rs.getInt("id")%>" style="cursor:pointer;">
			   				<i class="fa fa-trash-o" aria-hidden="true"></i>
			   			</a>
			   		</span>
			     </td>
			    </tr>
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
			  </tbody>
            </table>
          </div>
          <!-- /.card-body -->
          <%}else{ %>
          
          <div class="card-header">
		     <h3 class="card-title mt-2 font-weight-bold">Assigned Subjects</h3>
		  </div>
		   <%
				
			sql="select u.id,u.name,t.id,t.dept_id,t.name from (select s.id,s.dept_id,s.name from subjects as s inner join department as d on s.dept_id=d.id) as t inner join users as u on t.dept_id=u.dept_id where u.id=?";
			
			//out.println(sql);
			try{
			DbConnection dbcon9 = new DbConnection();
			Connection con9 = dbcon9.getConnection();
			PreparedStatement st9= con9.prepareStatement(sql);
			st9.setInt(1, uid);
			ResultSet rs9= st9.executeQuery();
		  	int i9=1;
		  	if(rs9.isBeforeFirst()){
		  		out.println(" ");
		  	}
		  		
		  %>
		   <%while(rs9.next())		
			{	
	       %>
		  
		  <div class="card-body">
		    <h5 class="card-title"><%=i9%>. <%=rs9.getString("t.name") %></h5>
		    
		  </div>
		                          
           <%i9++;} %>
						  
		   <%
		  	rs9.close();
			st9.close();
			con9.close();
			}catch(Exception e){
					e.printStackTrace();
			}
		%>
		  <!--  <div class="card-footer text-muted">
		    2 days ago
		  </div>-->
          <%} %>
          
        </div>
        <!-- /.card -->

       
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