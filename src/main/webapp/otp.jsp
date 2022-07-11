<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{	
%>
<jsp:include page="header.jsp"></jsp:include>
<style>
	.form-control{
		height: 3rem;
	} 
	</style>
        <div class="container">
        <div class="row" style="margin-top:6rem;">
            <div class="col-lg-8 offset-lg-2 col-md-12">
                <div class="card shadow-lg bg-white" style="padding-top: 4rem; padding-bottom: 7rem; border-radius: 7%;outline:none;padding-left: 6rem;padding-right: 6rem;">
                    <div class="text-center">
                        <img src="Assets/img/forgotpassword/otp.png" class="card-img-top img-fluid" alt="..." style="width: 17rem; margin-left: 6rem;">
                      </div>
                    <div class="card-body">
                    <div class="text-center" style="margin-top:-2rem;">
                    <h4 class="font-weight-bold " >Check your inbox</h4>
                    <p class="text-muted " style="font-size:15px;font-weight:500;">We have sent a One Time Password to your Email-ID</p>
                    <!--<div class="form-group">                  
                            <input type="email" class="form-control" placeholder="Registered mail Id" name="email">    
                    </div>  -->
                    <form id="otp">
                    <div class="form-group">
                    	<div class= "row" style="margin-left: 7.5rem;"s>
                    			<div class= "col-md-2">
	                    			<input class= "form-control" type="text" id="txt1" name="txt1" maxlength="1" onkeyup="mover(event, '', 'txt1', 'txt2')" onclick="mover(event, '', 'txt1', 'txt2')">
	                    		</div>
	                    		<div class= "col-md-2">
	                    			<input class= "form-control" type="text" id="txt2" name="txt2" maxlength="1" onkeyup="mover(event, 'txt1', 'txt2', 'txt3')" onclick="mover(event, 'txt1', 'txt2', 'txt3')">
	                    		</div>
	                    		<div class= "col-md-2">
	                    			<input class= "form-control" type="text" id="txt3" name="txt3" maxlength="1" onkeyup="mover(event, 'txt2', 'txt3', 'txt4')" onclick="mover(event, 'txt2', 'txt3', 'txt4')">
	                    		</div>
	                    		<div class= "col-md-2">
	                    			<input class= "form-control" type="text" id="txt4" name="txt4" maxlength="1" onkeyup="mover(event, 'txt3', 'txt4', call())" onclick="mover(event, 'txt3', 'txt4', call())">
	                    		</div>
	                    		<div style="margin-left: 1.9rem">
	                    		<strong class= "text-danger" id= "error"></strong>
	                    		</div>
	                    	</div>	
                    		</div>
                    		</form>
		                   </div>     
		                  	              
                    <!--<button type="submit" class="btn btn-danger">Create new Password</button>-->
                  </div>
            </div>
        </div>
    </div> 
    </div> 
<script type="text/javascript">
	function mover(e, prev, current, next){
		console.log(e);
		var length= document.getElementById(current).value.length; 
		var maxlength= document.getElementById(current).getAttribute("maxlength");
		if (length == maxlength)
		{
			if(next !== "")
			{
				document.getElementById(next).focus();
			}		
		}
		if(e.key === "Backspace")
		{
			alert();
			if(prev !== "")
			{
				document.getElementById(prev).focus();
			}
		}
	}
	
	function call()
	{
		var txt1 = document.getElementById("txt1").value;
		var txt2 = document.getElementById("txt2").value;
		var txt3 = document.getElementById("txt3").value;
		var txt4 = document.getElementById("txt4").value;
		const err = document.getElementById("error");
		if(txt1 === "" && txt2 === "" && txt3 === "")
		{
			txt4.value="";
			err.innerHTML= "Previous fields must be fill!";
			
		}
		else 
		{
			err.innerHTML= "";
			document.getElementById("otp").action="OTPVerification";
			document.getElementById("otp").method='post';
			document.getElementById("otp").submit();
		}
	}
</script>
<jsp:include page="footer.jsp"></jsp:include>
<%
}
%>