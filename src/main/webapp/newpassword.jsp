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
         @media screen and (max-width: 1920px) { 
         div.row{
          margin-top:6rem;
         }
         div.card{
          border-radius: 7%;
          outline:none;
          padding-left: 6rem;
          padding-right: 6rem;
         }
        div.img1 img{
         
          width: 17rem;
          margin-left: 11.5rem;
        }
        div.txt1{
          text-align:center;
          margin-top:-2rem;
        }
        div.txt1 p{
          font-size:15px;
          font-weight:500;
        }
        
      }
      @media screen and (max-width: 770px) {
        div.card{
          border-radius: 5%;
          outline:none;
          padding-left: 3rem;
          padding-right: 3rem;
         }
        div.img1 img{
          margin-left: 6rem;
          width: 13rem; 
        }
        div.txt1{
          text-align:center;
          margin-top:-2rem;
        }
        div.txt1 h4{
          font-size: 20px;
          font-weight: 500;
        }

        div.txt1 p{
          font-size:11px;
          font-weight:500;
        }
      }
      @media screen and (max-width: 430px) {
        div.row{
          margin-top:9rem;
         }
        div.card{
          border-radius: 9%;
          outline: none;
          padding-left: 0rem;
          padding-right: 0rem;
         }
        div.img1 img{
          margin-left: 8rem;
          width: 10rem; 
        }
        div.txt1{
          margin-top:-2rem;
        }
        div.txt1 h4{
          font-size: 20px;
          font-weight: 500;
        }

        div.txt1 p{
          font-size:11px;
          font-weight:500;
        }
      }


      @media screen and (max-width: 380px) {
        div.row{
          margin-top:9rem;
         }
        div.card{
          border-radius: 9%;
          outline: none;
          padding-left: 0rem;
          padding-right: 0rem;
         }
        div.img1 img{
          margin-left: 6rem;
          width: 10rem; 
        }
        div.txt1{
          margin-top:-2rem;
        }
        div.txt1 h4{
          font-size: 20px;
          font-weight: 500;
        }

        div.txt1 p{
          font-size:11px;
          font-weight:500;
        }
      }
      @media screen and (max-width: 330px) {
        div.row{
          margin-top:9rem;
         }
        div.card{
          border-radius: 9%;
          outline: none;
          padding-left: 0rem;
          padding-right: 0rem;
         }
        div.img1 img{
          margin-left: 5rem;
          width: 10rem; 
        }
        div.txt1{
          margin-top:-2rem;
        }
        div.txt1 h4{
          font-size: 20px;
          font-weight: 500;
        }

        div.txt1 p{
          font-size:11px;
          font-weight:500;
        }
      }
    </style>
    <div class="container">
        <div class="row" >
            <div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-12 offset-0">
                <div class="card shadow-lg pt-3 pb-3 pt bg-white" >
                    <div class="img1">
                        <img src="Assets/img/forgotpassword/newpassword.png" class="card-img-top img-fluid" alt="..." >
                      </div>
                    
                    <div class="card-body">
                      <div class="txt1" >
                        <h4 class=" col-12 " >Create new password</h4>
                        <p class="text-muted col-12 ">Your new password must be different from the previous one</p>
                       	<form id="np" onsubmit="return clk()">
                        <div class="form-group"> 
                          <input id="p" style="border-radius: 50px 50px; border-box:none; box-shadow:none;" type="password" class="form-control" placeholder="New Password" name="password">
                       	  <input id= "cp" style="border-radius: 50px 50px; border-box:none; box-shadow:none;" type="password" class="form-control mt-3" placeholder="Confirm Password" name="confirmpassword">
                       	  
                       	  <strong id="err" class= "text-danger"><%
                       	  		if(session.getAttribute("err")!=null)
                       	  		{
                       	  			out.println(session.getAttribute("err"));
                       	  		}
                       	  		else
                       	  		{
                       	  			out.println(" ");
                       	  		}
                       	  %></strong>
                        </div>
                        <button style="border-radius: 25px 25px;" type="submit" class="btn btn-danger">Create</button>
                      </form>
                      </div>
                    </div>
                  </div>
            </div>
        </div>
    </div>
    
<script type= "text/javascript">
	function clk(){
		document.getElementById("np").method='post';
		const p= document.getElementById("p").value;
		const cp= document.getElementById("cp").value;
		if(p!="" || cp!="")
		{
			if(p===cp)
			{
				document.getElementById("np").action="NewPasswordController";
				document.getElementById("np").submit();
				return true;
			}
			else
			{
				document.getElementById("err").innerHTML="Password doesn't match!";
				return false;
			}
			return true;
		}
		else
		{
			document.getElementById("err").innerHTML="This field must be fill!";
			return false;
		}
	}
</script>
<jsp:include page="footer.jsp"></jsp:include>
<%
}
%>