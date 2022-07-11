<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*,com.IMAP.DAO.DbConnection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="com.google.gson.Gson"%>

<%!
   String role;
   String sql,sql4,sql3;
   String user;
   String sp="super-admin";
   String ad="admin";
   String te="teacher";
   int dept;
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
			uid= rs2.getInt("id");
			dept=rs2.getInt("dept_id");
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
      <%//if(role.equals("admin")||role.equals("super-admin")){ %>
     	<div class="card">
          <div class="card-header">
            <h3 class="card-title mt-2 font-weight-bold">Answer</h3>
            
             <a class="btn btn-outline-primary float-right" data-toggle="modal" data-target="#addmodal">
              <span class="fa fa-plus mr-1" aria-hidden="true"></span> <span> Add</span>
             </a>
            	 <!-- Modal -->
			    <div class="modal fade" id="addmodal" tabindex="-1" role="dialog" aria-labelledby="addmodalTitle1" aria-hidden="true">
			      <div class="modal-dialog modal-dialog-centered" role="document">
			        <div class="modal-content">
			        	  <form action="AnswerController" method="post" enctype="multipart/form-data">
					        <div class="modal-header">
					          <h5 class="modal-title" id="exampleModalCenterTitle">Subject</h5>
					          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					          </button>
					        </div>
					        <div class="modal-body">
					        <%
							if(!role.equals("teacher")){
							sql="SELECT * FROM users where role='student' order by id desc";
							}
							else{
								sql="SELECT * FROM users where role='student' and dept_id=? order by id desc";
							}
							//out.println(sql);
							try{
							DbConnection dbcon2 = new DbConnection();
							Connection con2 = dbcon2.getConnection();
							PreparedStatement st2= con2.prepareStatement(sql);
							if(role.equals("teacher")){
								st2.setInt(1, dept);
							}
							ResultSet rs2= st2.executeQuery();
						  	//int i=1;
						  	if(rs2.isBeforeFirst()){
						  		out.println(" ");
						  	}
						  		
						  %>
		                      
						  <div class="form-group row">
		                  <label for="staticEmail" class="col-sm-2 col-form-label">Student Name</label>
		                  <div class="col-sm-10">
		            		<select class="form-control" name="user_id">
		                      	<%while(rs2.next())		
								{	
		                      	%>
		                          <option value="<%=rs2.getInt("id")%>"><%=rs2.getString("name")%></option>
		                          
		                       <%} %>
		                      </select>		
		                  </div>
		                  </div>
		                  <%
							  	rs2.close();
								st2.close();
								con2.close();
								}catch(Exception e){
										e.printStackTrace();
								}
							%>
		               <!-- /.subjects -->
					           
					      <%
					      if(!role.equals("teacher")){
					      sql="SELECT * FROM examination order by id desc";
					      }
					      else{
					    	  sql="SELECT * FROM examination where user_id=? order by id desc";
					      }
					      //out.println(sql);
					      try{
					      DbConnection dbcon3 = new DbConnection();
					      Connection con3 = dbcon3.getConnection();
					      PreparedStatement st3= con3.prepareStatement(sql);
					      if(role.equals("teacher")){
								st3.setInt(1, uid);
							}
					      ResultSet rs3= st3.executeQuery();
					        //int i=1;
					        if(rs3.isBeforeFirst()){
					          out.println(" ");
					        }
					          
					      %>
					                  
					      <div class="form-group row">
					              <label for="staticEmail" class="col-sm-2 col-form-label">Question</label>
					              <div class="col-sm-10">
					            <select class="form-control" name="file_id">
					                    <%while(rs3.next())		
					        {	
					                    %>
					                      <option value="<%=rs3.getInt("id")%>"><%= new Gson().fromJson(rs3.getString("qsn_name"), String[].class)[0].split("_1")[0]%></option>
					                      
					                   <%} %>
					                  </select>		
					              </div>
					              </div>
					              <%
					          rs3.close();
					        st3.close();
					        con3.close();
					        }catch(Exception e){
					            e.printStackTrace();
					        }
					      %>
					      
					       
					      <input type="file" name="ans">
					        </div>
					        <div class="modal-footer">
					          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					          <!--<button type="button" class="btn btn-primary">Save changes</button>  -->
					        <input type="submit" class="btn btn-info" value="Update">
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
                  <th>Sl No.</th>
			      <th>Student</th>
			      <th>Department</th>
			      <th>Class</th>
			      <th>Subject</th>
			      <th>Question</th>
			      <th>Answer</th>
			      <th>Action</th>
              </tr>
              </thead>
              <tbody>
              <%
              if(!role.equals("teacher")){
              sql="select eid,aid,qsn_name,ans_name,yr,st,d.name as de,s.name as su from (select a.id as aid,e.id as eid,qsn_name,ans_name,year as yr,name as st,sub_id,e.dept_id from answer as a inner join examination as e on a.qsn_id=e.id inner join users as u on a.user_id=u.id) as t inner join department as d on t.dept_id=d.id inner join subjects as s on t.sub_id=s.id order by eid desc";
              }
              else{
            	  sql="select teacher,uid,eid,aid,qsn_name,ans_name,yr,st,d.name as de,s.name as su from (select e.user_id as teacher,u.id as uid,a.id as aid,e.id as eid,qsn_name,ans_name,year as yr,name as st,sub_id,e.dept_id from answer as a inner join examination as e on a.qsn_id=e.id inner join users as u on a.user_id=u.id) as t inner join department as d on t.dept_id=d.id inner join subjects as s on t.sub_id=s.id  where teacher=? order by eid desc";
              }
				//out.println(sql);
				try{
				DbConnection dbcon = new DbConnection();
				Connection con = dbcon.getConnection();
				PreparedStatement st= con.prepareStatement(sql);
				 if(role.equals("teacher")){
					 st.setInt(1,uid);
				 }
				ResultSet rs= st.executeQuery();
			  	int i=1;
			  	if(!rs.isBeforeFirst()){
			  		out.println(" ");
			  	}
			  	while(rs.next())		
				{		
			  %>
			    <tr>
			      <td><%=i%></td>
			      <td><%=rs.getString("st")%></td>
			      <td><%=rs.getString("de")%></td>
			      <td><%=rs.getString("yr")%></td>
			      <td><%=rs.getString("su")%></td>
			      <td class="text-truncate"><%= new Gson().fromJson(rs.getString("qsn_name"), String[].class)[0].split("_1")[0]%></td>
			       <td class="text-truncate"><%= new Gson().fromJson(rs.getString("ans_name"), String[].class)[0].split("_1")[0]%></td>
			      
			      <td>
			      
			      <div class="row">
			      <!-- Button trigger modal -->
			      <div class="col-1">
					<a class="actionCust" data-toggle="modal" data-target="#editmodal<%=rs.getInt("eid")%>" style="cursor:pointer;">
					  <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
					</a>
					<!-- Modal -->
					<div class="modal fade" id="editmodal<%=rs.getInt("eid")%>" tabindex="-1" role="dialog" aria-labelledby="editmodal<%=rs.getInt("eid")%>" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					     <%
					     String sql1="select eid,aid,qsn_name,ans_name,yr,st,d.name as de,s.name as su from (select a.id as aid,e.id as eid,qsn_name,ans_name,year as yr,name as st,sub_id,e.dept_id from answer as a inner join examination as e on a.qsn_id=e.id inner join users as u on a.user_id=u.id) as t inner join department as d on t.dept_id=d.id inner join subjects as s on t.sub_id=s.id where eid= ? order by eid desc ";
					      
						  	try{
						  	DbConnection dbcon1 = new DbConnection();
						  	Connection con1 = dbcon1.getConnection();
						  	PreparedStatement st1= con1.prepareStatement(sql1);
						  	st1.setInt(1, rs.getInt("eid"));
						  	ResultSet rs1= st1.executeQuery();
					      	if(rs1.next())
					      	{  		
					    %>
					     <form action="EditAnswerController" method="post" enctype="multipart/form-data">
					        <div class="modal-header">
					          <h5 class="modal-title" id="exampleModalCenterTitle">Answer</h5>
					          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					            <span aria-hidden="true">&times;</span>
					          </button>
					        </div>
					           <div class="modal-body">
					        <%
				
							sql="SELECT * FROM users where role='student' order by id desc";
							
							//out.println(sql);
							try{
							DbConnection dbcon2 = new DbConnection();
							Connection con2 = dbcon2.getConnection();
							PreparedStatement st2= con2.prepareStatement(sql);
							ResultSet rs2= st2.executeQuery();
						  	//int i=1;
						  	if(rs2.isBeforeFirst()){
						  		out.println(" ");
						  	}
						  		
						  %>
		                      
						  <div class="form-group row">
		                  <label for="staticEmail" class="col-sm-2 col-form-label">Student Name</label>
		                  <div class="col-sm-10">
		            		<select class="form-control" name="user_id">
		                      	<%while(rs2.next())		
								{	
		                      	%>
		                          <option value="<%=rs2.getInt("id")%>"><%=rs2.getString("name")%></option>
		                          
		                       <%} %>
		                      </select>		
		                  </div>
		                  </div>
		                  <%
							  	rs2.close();
								st2.close();
								con2.close();
								}catch(Exception e){
										e.printStackTrace();
								}
							%>
		               <!-- /.subjects -->
					           
					      <%
					
					      sql="SELECT * FROM examination order by id desc";
					      
					      //out.println(sql);
					      try{
					      DbConnection dbcon3 = new DbConnection();
					      Connection con3 = dbcon3.getConnection();
					      PreparedStatement st3= con3.prepareStatement(sql);
					      ResultSet rs3= st3.executeQuery();
					        //int i=1;
					        if(rs3.isBeforeFirst()){
					          out.println(" ");
					        }
					          
					      %>
					                  
					      <div class="form-group row">
					              <label for="staticEmail" class="col-sm-2 col-form-label">Question</label>
					              <div class="col-sm-10">
					            <select class="form-control" name="file_id">
					                    <%while(rs3.next())		
					        {	
					                    %>
					                      <option value="<%=rs3.getInt("id")%>"><%=rs3.getString("qsn_name")%></option>
					                      
					                   <%} %>
					                  </select>		
					              </div>
					              </div>
					              <%
					          rs3.close();
					        st3.close();
					        con3.close();
					        }catch(Exception e){
					            e.printStackTrace();
					        }
					      %>
					      
					       
					      <input type="file" name="ans">
					       <input type="hidden" name="id" value='<%=rs.getInt("eid")%>'>
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
				</div>
				<div class="col-1">
			   		<span class="actionCust ml-3 ">
			   			<a href="<%=request.getContextPath()%>/DeleteAnswerController?id=<%=rs.getInt("eid")%>" style="cursor:pointer;">
			   				<i class="fa fa-trash-o" aria-hidden="true"></i>
			   			</a>
			   		</span>
			   	</div>
			    <div class="col-2">
			   		<span class="actionCust float-right">
			   			<a href="<%=request.getContextPath()%>/ReadFileController?qid=<%=rs.getInt("eid")%>" style="cursor:pointer;">
			   				Question <i class="fa fa-eye" aria-hidden="true"></i>
			   			</a>
			   		</span>
			   	</div>
			   	<div class="col-2">
			   		<span class="actionCust float-right">
			   			<a href="<%=request.getContextPath()%>/ReadFileController?aid=<%=rs.getInt("aid")%>" style="cursor:pointer;">
			   				Answer <i class="fa fa-eye" aria-hidden="true"></i>
			   			</a>
			   		</span>
			   	</div>
			   		</div>
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
      </div> 
      <%//} %>
      

      
      
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
  <small>Copyright &copy; 2021-<%
      GregorianCalendar cal = new GregorianCalendar();
      out.print(cal.get(Calendar.YEAR));
    %> <a href="<%=request.getContextPath()%>/login">DigiXam</a>.</small> All rights reserved.
</footer>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript">
$(function () {
    $("#example1").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false,"pageLength": 5,
      "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
  });
  </script>
 </body>
</html>
<%}%>