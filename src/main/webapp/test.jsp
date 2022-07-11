<jsp:include page="header.jsp"></jsp:include>
<!-- CSS -->
<style>
body{
    font-family: 'Raleway', sans-serif;
    background: #f9f9f9;
}
.p-30{
    padding:30px;
}
.main-datatable {
    padding: 0px; 
    border: 1px solid #f3f2f2;
    border-bottom: 0;
    box-shadow: 0px 2px 10px rgba(0,0,0,.05);
}
.d-flex{
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.card_body{ 
    background-color: white;
    border: 1px solid transparent;
    border-radius: 2px;
    -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
}
.main-datatable .row {
    margin: 0;
} 
.searchInput {
    width: 50%;
    display: flex;
    align-items: center;
    position: relative;
    justify-content: flex-end;
    margin: 20px 0px;
    padding: 0px 4px;
}
.searchInput input {
    border: 1px solid #e5e5e5;
    border-radius: 50px;
    margin-left: 8px;
    height: 34px;
    width: 100%;
    padding: 0px 25px 0px 10px;
    transition: all .6s ease;
}
.searchInput label {
    color: #767676;
    font-weight: normal;
}
.searchInput input:placeholder-shown {
    width: 13%;
}
.searchInput:hover input:placeholder-shown {
    width: 100%;
    cursor: pointer;
}
.searchInput:after {
    font-family: 'FontAwesome';
    color: #d4d4d4;
    position: relative;
    content: "\f002";
    right: 25px;
}

.dim_button {
    display: inline-block;
    color: #fff;
    text-decoration: none;
    text-transform: uppercase;
    text-align: center;
    padding-top: 6px;
    background: rgb(57, 85, 136);
    margin-right: 10px;
    position: relative;
    cursor: pointer;
    font-weight: 600;
    margin-bottom: 20px;
} 
.createSegment a { 
    margin-bottom: 0px;
    border-radius: 50px;
    background: #ffffff;
    border: 1px solid #007bff;
    color: #007bff;
    transition: all .4s ease;
}
.createSegment a:hover, .createSegment a:focus {
    transition: all .4s ease;
    background: #007bff;
    color: #fff;
}
.add_flex{
    display: flex;
    justify-content: flex-end;
    padding-right:0px;
}
.main-datatable .dataTable.no-footer {
    border-bottom: 1px solid #eee;
}
.main-datatable .cust-datatable thead {
    background-color: #f9f9f9;
}
.main-datatable .cust-datatable>thead>tr>th {
    border-bottom-width: 0;
    color: #443f3f;
    font-weight: 600;
    padding: 16px 15px;
    vertical-align: middle;
    padding-left: 18px;
    text-align: center;
}
.main-datatable .cust-datatable>tbody td {
    padding: 10px 15px 10px 18px;
    color: #333232;
    font-size: 13px;
    font-weight: 500;
    word-break: break-word;
    border-color: #eee;
    text-align: center;
    vertical-align: middle;
}
.main-datatable .cust-datatable>tbody tr {
    border-top: none;
}
.main-datatable .table > tbody > tr:nth-child(even) {
    background: #f9f9f9;
}
.btn-group.open .dropdown-toggle {
    box-shadow: none;
}
.main-datatable .dropdown_icon {
    display: inline-block;
    color: #8a8a8a;
    font-size: 12px;
    border: 1px solid #d4d4d4;
    padding: 10px 11px;
    border-radius: 50%;
    cursor: pointer;
}
.btn-group i{
    color: #8e8e8e; 
    margin: 2px;
}
.main-datatable .actionCust a {
    display: inline-block;
    color: #8a8a8a;
    font-size: 12px;
    border: 1px solid #d4d4d4;
    padding: 10px 11px;
    margin: -9px 3px;
    border-radius: 50%;
    cursor: pointer;
}
.main-datatable .actionCust a i{
    color: #8e8e8e;
    margin: 2px;
}
.main-datatable .dropdown-menu {
    padding: 0;
    border-radius: 4px;
    box-shadow: 10px 10px 20px #c8c8c8;
    margin-top: 10px;
    left: -65px;
    top: 32px;
}
.main-datatable .dropdown-menu > li > a {
    display: block;
    padding: 12px 20px;
    clear: both;
    font-weight: normal;
    line-height: 1.42857;
    color: #333333;
    white-space: nowrap;
    border-bottom: 1px solid #d4d4d4;
}
.main-datatable .dropdown-menu > li > a:hover, 
.main-datatable .dropdown-menu > li > a:focus {
    color: #fff;
    background: #007bff;
}
.main-datatable .dropdown-menu > li > a:hover i{
    color: #fff; 
}
.main-datatable .dropdown-menu:before {
    position: absolute;
    top: -7px;
    left: 78px;
    display: inline-block;
    border-right: 7px solid transparent;
    border-bottom: 7px solid #d4d4d4;
    border-left: 7px solid transparent;
    border-bottom-color: #d4d4d4;
    content: '';
}
.main-datatable .dropdown-menu:after {
    position: absolute;
    top: -6px;
    left: 78px;
    display: inline-block;
    border-right: 6px solid transparent;
    border-bottom: 6px solid #ffffff;
    border-left: 6px solid transparent;
    content: '';
}
.dropdown-menu i {
    margin-right: 8px;
}
.main-datatable .dataTables_wrapper .dataTables_paginate .paginate_button {
    color: #999999 !important;
    background-color: #f6f6f6 !important;
    border-color: #d4d4d4 !important;
    border-radius: 40px;
    margin: 5px 3px;
}
.main-datatable .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
    color: #fff !important;
    border: 1px solid #3d96f5 !important;
    background: #4da3ff !important;
    box-shadow: none;
}
.main-datatable .dataTables_wrapper .dataTables_paginate .paginate_button.current, 
.main-datatable .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
    color: #fff !important;
    border-color: transparent !important;
    background: #007bff !important;
}
.main-datatable .dataTables_paginate {
    padding-top: 0 !important;
    margin: 15px 10px;
    float: right !important;
}
.mode{
    padding:4px 10px;
    line-height: 13px;
    color:#fff;
    font-weight: 400;
    border-radius: 1rem;
    -webkit-border-radius: 1rem;
    -moz-border-radius: 1rem;
    -ms-border-radius: 1rem;
    -o-border-radius: 1rem;
    font-size:11px;
    letter-spacing: 0.4px;
}
.mode_on{
    background-color: #09922d;
}
.mode_off{
    background-color: #8b9096;
}
.mode_process{
    background-color: #ff8000;
}
.mode_done{
    background-color: #03a9f3;
}
@media only screen and (max-width:1200px){
    .overflow-x{
        overflow-x:scroll;
    }
    .overflow-x::-webkit-scrollbar{
        width:5px;
        height:6px;
    }
    .overflow-x::-webkit-scrollbar-thumb{
        background-color: #888;
    }
    .overflow-x::-webkit-scrollbar-track{
         background-color: #f1f1f1;
    }
}

</style>
<!-- HTML -->
<div class="container p-30">
    <div class="row">
        <div class="col-md-12 main-datatable">
            <div class="card_body">
                <div class="row d-flex">
                    <div class="col-sm-4 createSegment"> 
                    <a class="btn dim_button create_new"> <span class="glyphicon glyphicon-plus"></span>Create New</a>
                    </div>
                    <div class="col-sm-8 add_flex">
                        <div class="form-group searchInput">
                            <label for="email">Search:</label>
                            <input type="search" class="form-control" id="filterbox" placeholder=" ">
                        </div>
                    </div> 
                </div>
                <div class="overflow-x">
                    <table style="width:100%;" id="filtertable" class="table cust-datatable dataTable no-footer">
                       <thead>
                           <tr>
                               <th style="min-width:50px;">ID</th>
                               <th style="min-width:150px;">Role</th>
                               <th style="min-width:150px;">Name</th>
                               <th style="min-width:100px;">User Name</th>
                               <th style="min-width:100px;">Email ID</th>
                               <th style="min-width:150px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Dummy</td>
                                <td><span class="mode mode_process">Processing</span></td>
                                <td>Journey</td>
                                <td>17-Apr-2020</td>
                                <td><span class="mode mode_on">Active</span></td>
                                <td>
                                	<span class="actionCust">
                                        <a href="#"><i class="fa fa-line-chart"></i></a>
                                    </span>
                              
                                    <span class="actionCust">
                                        <a href="#"><i class="fa fa-line-chart"></i></a>
                                    </span>
                          
                                </td>
                            </tr>
                         </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Js -->
<script src="https://cdn.datatables.net/1.10.14/js/jquery.dataTables.min.js"></script>
<script type=text/javascript>
$(document).ready(function() {
    var dataTable = $('#filtertable').DataTable({
        "pageLength":5,
        'aoColumnDefs':[{
            'bSortable':false,
            'aTargets':['nosort'],
        }],
        columnDefs:[
            {type:'date-dd-mm-yyyy',aTargets:[5]}
        ],
        "aoColumns":[
            null,
            null,
            null,
            null,
            null,
            null,
            null
        ],
        "order":false,
        "bLengthChange":false,
        "dom":'<"top">ct<"top"p><"clear">'
    });
    $("#filterbox").keyup(function(){
        dataTable.search(this.value).draw();
    });
} );
</script>
<jsp:include page="footer.jsp"></jsp:include>