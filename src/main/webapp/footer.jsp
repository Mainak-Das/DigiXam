<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>

 <!-- jQuery -->
<script src="Assets/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="Assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables & Plugins -->
<script src="Assets/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="Assets/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="Assets/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="Assets/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="Assets/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="Assets/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="Assets/plugins/jszip/jszip.min.js"></script>
<script src="Assets/plugins/pdfmake/pdfmake.min.js"></script>
<script src="Assets/plugins/pdfmake/vfs_fonts.js"></script>
<script src="Assets/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="Assets/plugins/datatables-buttons/js/buttons.print.min.js"></script>
<script src="Assets/plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
<!-- AdminLTE App -->
<script src="Assets/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="Assets/dist/js/demo.js"></script>
<!-- Page specific script -->
<script src="https://use.fontawesome.com/8587060daf.js"></script>
<!-- JavaScript Files -->
<script type="text/javascript" >
$(function () {
	
$("#bars").click(function(){
	if($('body').hasClass('sidebar-collapse')){
		$("#datetime").show();
	}
	else {
		$("#datetime").hide();
	} 
});

	$( "#timer" ).click(function() {
		
	 	
		  var path=document.getElementById("path").value;
		  var id=document.getElementById("jid").value;
			 //alert(id);
			
			 location.replace(path+"/StudentReadViewController?id="+id);
		});
		
		 
	$("#timer").click(function(){
	    var $this = $(this);
	    if($this.data('clicked')) {
	    	var timer;
		 	var ele=document.getElementById("timer1");
		 	var sec=0;
		 	timer=setInterval(()=>{
		 		ele.innerHTML='00:'+sec;
		 		sec++;
		 	},1000);
	    }
	   
	});

});

</script>

