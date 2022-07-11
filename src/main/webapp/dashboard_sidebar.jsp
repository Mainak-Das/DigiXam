<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*, com.IMAP.DAO.DbConnection,com.IMAP.required.UserRole"%>
<%!
       String role;
       String sql;
       String user;
%>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{
		role=new UserRole().getRole((String)session.getAttribute("email"),(String)session.getAttribute("username"))[0];
		user=new UserRole().getRole((String)session.getAttribute("email"),(String)session.getAttribute("username"))[1];
%>

<style>

[class*=sidebar-dark] .brand-link {
    border-bottom: none;
}
</style>
<script src="https://your-site-or-cdn.com/fontawesome/v6.1.1/js/all.js" ></script>

  <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4 position-fixed">
      <!-- Brand Logo -->
      <a href="<%=request.getContextPath()%>/login" class="brand-link">
        <img src="Assets/dist/img/Sidebar_logo.png"  alt="DigiXam" class="brand-image" style="max-height: 53px; margin-left: 0px; margin-right: 0px; padding-left: 7px;" > <!-- class="brand-image img-circle elevation-3" style="opacity: .8" -->
        <span class="brand-text text-light" style="font-size:130%;">DigiXam</span>
      </a>
  
      <!-- Sidebar -->
      <div class="sidebar">
        <!-- Sidebar user (optional) 
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
          <div class="image">
            <img src="Assets/dist/img/profile.jpg" class="img-circle elevation-2" alt="User Image">
          </div>
          <div class="info">
            <a href="#" class="d-block text-light">  </a>
          </div>
        </div>
  -->
  
        <!-- Sidebar Menu -->
        <nav class="mt-2">
          <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <!-- Add icons to the links using the .nav-icon class
                 with font-awesome or any other icon font library -->
            <%if(role.equals("student")) {%>
            <li class="nav-item ">
              <a href="<%=request.getContextPath()%>/home" class="nav-link text-light">
                <i class="nav-icon fa-solid fa-house-user"></i>
                <p>
                  Dashboard
                </p>
              </a>
            </li>
            
             <div class="datetime" id="datetime" style="color: white; padding-left: 10px; font-size:130%;">			  
		      <div class="date"> 
		        <span id="dayname">Day</span>,
		        <span id="month">Month</span>
		        <span id="daynum">00</span>,
		        <span id="year">Year</span>
		      </div>
		      <div class="time">
		        <span id="hour">00</span>:
		        <span id="minutes">00</span>:
		        <span id="seconds">00</span>
		        <span id="period">AM</span>
		      </div>
		    </div>
            <%} %>
            <%if(role.equals("super-admin")) {%>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/admin" class="nav-link text-light">
                <!--<i class="nav-icon fa-solid fa-screen-users"></i>">-->
                <i class="nav-icon fa-solid fa-building-columns"></i>
                <p>
                  Admins
                </p>
              </a>
            </li>
            <%} %>
            <%if(role.equals("super-admin") || role.equals("admin")) {%>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/user" class="nav-link text-light">
                <!-- <i class="nav-icon fas fa-user"></i> -->
                <i class="nav-icon fa-solid fa-chalkboard-user"></i>
                <p>
                  Teachers
                </p>
              </a>
            </li>
            <%} %>
            <%if(!role.equals("student")) {%>
             <li class="nav-item">
              <a href="<%=request.getContextPath()%>/student" class="nav-link text-light">
                <!--<i class="fa-solid fa-screen-users"></i>-->
                <i class="nav-icon fa-solid fa-graduation-cap"></i>
                <p>
                  Students
                </p>
              </a>
            </li>
             <%if(role.equals("super-admin") || role.equals("admin")) {%>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/department" class="nav-link text-light">
                <i class="nav-icon fa-solid fa-users-viewfinder"></i>
                <p>
                  Departments
                </p>
              </a>
            </li>
            <%} %>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/subject" class="nav-link text-light">
               <i class="nav-icon fa-solid fa-book-open"></i>
                <p>
                  Subjects
                </p>
              </a>
            </li>
             <%if(role.equals("super-admin") || role.equals("admin")) {%>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/assign" class="nav-link text-light">
                <i class="nav-icon fa-solid fa-person-chalkboard"></i>
                <p>
                  Subject Assigned
                </p>
              </a>
            </li>
            <%} %>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/examination" class="nav-link text-light">
                <i class="nav-icon fa-solid fa-file-circle-question"></i>
                <p>
                  Examination
                </p>
              </a>
            </li>
             <li class="nav-item">
              <a href="<%=request.getContextPath()%>/answers" class="nav-link text-light">
                <i class="nav-icon fa-regular fa-pen-to-square"></i>
                <p>
                  Answers
                </p>
              </a>
            </li>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/result" class="nav-link text-light">
                <i class="nav-icon fa-solid fa-ranking-star"></i>
                <p>
                  Result
                </p>
              </a>
            </li>
           <%} %>
          </ul>
        </nav>
        <!-- /.sidebar-menu -->
      </div>
      <!-- /.sidebar -->
    </aside>
    <script type="text/javascript">

function updateClock(){
    var now = new Date();
    var dname = now.getDay(),
        mo = now.getMonth(),
        dnum = now.getDate(),
        yr = now.getFullYear(),
        hou = now.getHours(),
        min = now.getMinutes(),
        sec = now.getSeconds(),
        pe = "AM";

        if(hou >= 12){
          pe = "PM";
        }
        if(hou == 0){
          hou = 12;
        }
        if(hou > 12){
          hou = hou - 12;
        }

        Number.prototype.pad = function(digits){
          for(var n = this.toString(); n.length < digits; n = 0 + n);
          return n;
        }

        var months = ["January", "February", "March", "April", "May", "June", "July", "Augest", "September", "October", "November", "December"];
        var week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        var ids = ["dayname", "month", "daynum", "year", "hour", "minutes", "seconds", "period"];
        var values = [week[dname], months[mo], dnum.pad(2), yr, hou.pad(2), min.pad(2), sec.pad(2), pe];
        for(var i = 0; i < ids.length; i++)
        document.getElementById(ids[i]).firstChild.nodeValue = values[i];
  }

    updateClock();
    window.setInterval("updateClock()", 1);
 
		


</script>
<% }%>
  