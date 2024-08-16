<%@page import="jakarta.servlet.http.HttpSession"%>

<%   HttpSession se1 = request.getSession();
	 String username = (String) se1.getAttribute("username");
%>

<html>
<head>
    <meta charset="UTF-8">
    
       <link rel="icon" type="image/x-icon" href="../../src/icon.png">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css">
    <style>
    body{
  font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
  font-weight: 400;
  overflow-x: hidden;
  overflow-y: auto;
  background: #f1f2f7;
  height: 100%;
  width: 100%;
}a{
  color #777;
  text-decoration: none;
}.padding-top{
  padding-top: 20px;
}.login-page{
  width: 350px;
  margin: 5% 40% 6% auto;
  padding: 0 20px;
  background-color: #f9f9f9;
  border: 1px solid #f2f2f2;
}.login-page .text-center{
  margin-bottom: 10px;
}.box{
  padding: 20px;
  background-color: #f9f9f9;
  border: 1px solid #f2f2f2;
}.page{
  position: relative;
  display: block;
  top: 50px;
  left: 0;
  padding: 35px 15px 20px 270px;
}

.page-lgn{
  position: relative;
  display: block;
  top: 50px;
  left: 0;
  padding: 35px 15px 20px 270px;
}

.bg-green{
  background-color: #A3C86D;
}
.bg-blue{
  background-color: #7ACBEE;
}
.bg-yellow{
  background-color: #FDD761;
}
.bg-red{
  background-color: #FF7857;
}

.bg-secondary1{
	background-color: #b17897;
}

.bg-blue2{
	background-color: #7a83ee;
}
.panel-default >.panel-heading{
  background-color: #f5f5f5;
  border-bottom: 2px solid #3498DB;
  font-size: 15px;
  text-transform: uppercase;
  letter-spacing: .5px;
  padding: 15px;
}.panel-box{
  width: 100%;
  height: 100%;
  text-align: center;
  border: none;
}.panel-value{
  width: 60%;
}.panel-icon{
  padding: 30px;
  width: 40%;
  border-radius: 0;
}.panel-icon{
  -webkit-border-radius: 3px 0 0 3px;
  -moz-border-radius: 3px 0 0 3px;
  border-radius: 3px 0 0 3px;
}.panel-value{
  -webkit-border-radius: 0 3px 3px 0;
  -moz-border-radius: 0 3px 3px 0;
  border-radius: 0 3px 3px 0;
}.panel-value h2{
  margin-top: 30px;
}
.panel-icon i{
  line-height:65px;
  font-size: 40px;
  color: #fff;
}
#header {
  position: fixed;
  z-index: 99;
  top: 0;
  left: 0;
  background-color: #fff;
  width: 100%;
  height: 65px;
  line-height: 65px;
  -moz-box-shadow: 0 1px 2px rgba(0,0,0,0.1);
  -webkit-box-shadow: 0 1px 2px rgba(0,0,0,0.1);
   box-shadow: 0 1px 2px rgba(0,0,0,0.1);
} header > .logo {
    color: #fff;
    text-align: center;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    display: inline-block;
    width: 250px;
    background-color: #db3434;
}.header-date{
  color: #9b9b9b;
  margin-left: 20px;
}
.info-menu{
  height: 60px;
  margin: 0;
  line-height: 60px;
  padding: 0 15px;
}.info-menu li.profile {
  position: relative;
}.profile a.toggle{
  text-decoration: none;
  text-align: center;
  font-size: 14px;
  color: rgba(150, 150, 158, 1.0);
  position: relative;
  padding: 10px 10px 10px 0;
  margin: 0;
  background: #f9f9f9;
  border-radius: 30px;
}.info-menu li.profile a img{
  width: 30px;
  height: 30px;
}.dropdown-menu{
  margin-top: 4px;
  border-color: #fefefe;
  border-radius: 0;
   box-shadow: 0px 0px 5px rgba(86, 96, 117, 0.15);
  -moz-box-shadow: 0px 0px 5px rgba(86, 96, 117, 0.15);
  -webkit-box-shadow: 0px 0px 5px rgba(86, 96, 117, 0.15);
  }.dropdown-menu li{
    margin: 0;
    padding: 0;
    display: block;
    line-height: 35px;
 }.dropdown-menu li a{
  text-decoration: none;
  display: block;
  font-size: 14px;
  position: relative;
  line-height: 30px;
  width: 100%;
  border-bottom: 1px solid #f4faf9;
}.dropdown-menu li a i{
  margin-right: 5px;
}.dropdown-menu li.last a{
  border-bottom: 0;
}.datepicker{
  text-align: center;
}
.sidebar {
  position: fixed;
  z-index: 10;
  left: 0;
  top: 0;
  padding: 65px 0 0;
  height: 100%;
  width: 250px;
  background: #272727;
  border-right: 1px solid #ddd;
  text-align: center;
}.sidebar ul li:hover,.submenu ul li:hover{
  -webkit-transition: all .2s ease-in-out;
  transition: all .2s ease-in-out;
}.sidebar ul{
  list-style: none;
  margin: 0;
  padding: 0;
}.sidebar ul li {
  display: block;
}.sidebar ul li:hover,ul.submenu{
  background-color:#35404d;
}.sidebar ul li a:hover {
  color: white;
}.sidebar ul li a,ul.submenu li a {
  color: #aeb2b7;
  display: block;
  overflow: hidden;
  position: relative;
  white-space: nowrap;
  text-decoration: none;
  text-align: left;
}.sidebar ul li a span,.sidebar ul li i{
  font-size: 14px;
  font-weight: 300;
  letter-spacing: 1.5px;
  text-shadow: 0 1px rgba(0,0,0, 1);
}.sidebar ul li a i{
  color: #aeb2b7;
  padding: 15px 22px;
  text-align: center;
}ul.submenu{
  display: none;
  position: relative;
}ul.submenu li a:hover{
  background-color:#35404d;
}ul.submenu li a {
  padding-left: 45px;
}ul.submenu li:before{
  content: "";
  display: block;
  position: absolute;
  z-index: 1;
  left: 25px;
  top: 0;
  bottom: 0;
  border: 1px dotted #d7d7d7;
  border-width: 0 0 0 1px;
}ul.submenu li a:before{
  content: "";
  display: inline-block;
  position: absolute;
  width: 7px;
  left: 25px;
  top: 18px;
  border-top: 1px dotted #d7d7d7;
}

.sale_report_header{
  padding: 15px 0;
}
table td h6{
  margin: 0 0 0.2em 0;
}
table tfoot tr td:first-child{
  border: 0;
}table tfoot tr td:last-child{
  border-top: 1px solid #ccc;
}table td h6,table tfoot tr td:last-child{
  color: #000;
  _font-size: 1.2em;
  font-weight: normal;
}
.form-control{
  color: #646464;
  border: 1px solid #e6e6e6;
  border-radius: 3px;
  -webkit-box-shadow: none;
  -moz-box-shadow: none;
  box-shadow: none;
  -moz-transition: all .15s ease-out;
  -webkit-transition: all .15s ease-out;
  transition: all .15s ease-out;
}.form-control:focus{
  background: #f8f8f8;
  border-color: #3498DB;
  outline: 0;
  -webkit-box-shadow: none;
  -moz-box-shadow: none;
  box-shadow: none;
}
.btn{
  border-radius: 3px;
  -webkit-transition: all 300ms ease-in-out;
  -moz-transition: all 300ms ease-in-out;
   transition: all 300ms ease-in-out;
}.btn-primary {
    color: #fff;
    background-color: #51aded;
    border-color: #3d8fd8
}.btn-primary:hover, .btn-primary:focus, .btn-primary.focus, .btn-primary:active, .btn-primary.active{
    color: #fff;
    background-color: #3175b8;
    border-color: #3d8fd8
}.btn-success{
   background-color:#2ecc71
}.btn-success:hover, .btn-success:focus, .btn-success.focus, .btn-success:active, .btn-success.active{
  background-color:#27ae60
}.btn-warning{
  background-color: #e7c13e;
  border-color: #dfba3c;
}.btn-warning:hover, .btn-warning:focus, .btn-warning.focus, .btn-warning:active, .btn-warning.active{
  background-color:#d0ac2c;
  border-color: #dfba3c;
}.btn-danger{
  background-color: #ed5153
}.btn-danger:hover, .btn-danger:focus, .btn-danger.focus, .btn-danger:active, .btn-danger.active{
  background-color:#bb282a
}.input-group-addon{
  background-color: #fcfcfc;
  border: 1px solid #dbdbdb;
  border-radius: 0;
}
input[type=file]{
  text-indent: -99999px;
}td img.img-thumbnail{
  width: 125px;
  height: 125px;
  vertical-align: top;
}.img-avatar{
  width: 50px;
  height: 50px;
}
.jumbotron{
  margin-bottom: 0;
}.list-group-item:first-child,.list-group-item:last-child{
  border-radius: 0;
}.profile .jumbotron{
  border-radius: 3px 3px 0 0;
}.profile .jumbotron h3{
  color: white;
}img.img-size-2{
  width: 125px;
  height: 125px;
}
#profile{
object-fit:cover;
}
    
    </style>
  </head>
<header id="header">
      <div class="logo pull-left"><img height=40px width =40px style="object-fit:cover;transform:translateX(-30px);"src="../../src/icon.png">Track-Stock</div>
      <div class="header-content">
      <div class="header-date pull-left">
       <strong id="current-date-time"></strong>
      </div>
      <div class="pull-right clearfix">
        <ul class="info-menu list-inline list-unstyled">
          <li class="profile">
            <a href="#" data-toggle="dropdown" class="toggle" aria-expanded="false">
              <img src="../../src/profile.png" alt="user-image" class="img-circle img-inline">
              <span>Venura jayasingha <i class="caret"></i></span>
            </a>
            <ul class="dropdown-menu">
              <li>
                  <a href="profile.php?id=1">
                      <i class="glyphicon glyphicon-user"></i>
                      Profile
                  </a>
              </li>
             <li>
                 <a href="edit_account.php" title="edit account">
                     <i class="glyphicon glyphicon-cog"></i>
                     Settings
                 </a>
             </li>
             <li class="last">
                 <a href="../../logout">
                     <i class="glyphicon glyphicon-off"></i>
                     Logout
                 </a>
             </li>
           </ul>
          </li>
        </ul>
      </div>
     </div>
    </header>
    <div class="sidebar">
              <!-- admin menu -->
      <ul>
  <li>
    <a href="admin.jsp">
      <i class="glyphicon glyphicon-home"></i>
      <span>Dashboard</span>
    </a>
  </li>
  <li>
    <a href="#" class="submenu-toggle">
      <i class="glyphicon glyphicon-user"></i>
      <span>User Management</span>
    </a>
    <ul class="nav submenu" style="display: none;">
      <li><a href="group.php">Manage Groups</a> </li>
      <li><a href="users.php">Manage Users</a> </li>
   </ul>
  </li>
  <li>
    <a href="categorie.php">
      <i class="glyphicon glyphicon-indent-left"></i>
      <span>Categories</span>
    </a>
  </li>
  <li>
    <a href="#" class="submenu-toggle">
      <i class="glyphicon glyphicon-th-large"></i>
      <span>Products</span>
    </a>
    <ul class="nav submenu" style="display: none;">
       <li><a href="product.php">Manage Products</a> </li>
       <li><a href="add_product.php">Add Products</a> </li>
   </ul>
  </li>
  <li>
    <a href="media.php">
      <i class="glyphicon glyphicon-picture"></i>
      <span>Media Files</span>
    </a>
  </li>
  <li>
    <a href="#" class="submenu-toggle">
      <i class="glyphicon glyphicon-credit-card"></i>
       <span>Sales</span>
      </a>
      <ul class="nav submenu" style="display: none;">
         <li><a href="sales.php">Manage Sales</a> </li>
         <li><a href="add_sale.php">Add Sale</a> </li>
     </ul>
  </li>
  <li>
    <a href="#" class="submenu-toggle">
      <i class="glyphicon glyphicon-duplicate"></i>
       <span>Sales Report</span>
      </a>
      <ul class="nav submenu" style="display:none;">
        <li><a href="sales_report.php">Sales by dates </a></li>
        <li><a href="monthly_sales.php">Monthly sales</a></li>
        <li><a href="daily_sales.php">Daily sales</a> </li>
      </ul>
  </li>
</ul>

      
   </div>

    
    </body>
    
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>
  <script>

  function suggetion() {

       $('#sug_input').keyup(function(e) {

           var formData = {
               'product_name' : $('input[name=title]').val()
           };

           if(formData['product_name'].length >= 1){

             // process the form
             $.ajax({
                 type        : 'POST',
                 url         : 'ajax.php',
                 data        : formData,
                 dataType    : 'json',
                 encode      : true
             })
                 .done(function(data) {
                     //console.log(data);
                     $('#result').html(data).fadeIn();
                     $('#result li').click(function() {

                       $('#sug_input').val($(this).text());
                       $('#result').fadeOut(500);

                     });

                     $("#sug_input").blur(function(){
                       $("#result").fadeOut(500);
                     });

                 });

           } else {

             $("#result").hide();

           };

           e.preventDefault();
       });

   }
    $('#sug-form').submit(function(e) {
        var formData = {
            'p_name' : $('input[name=title]').val()
        };
          // process the form
          $.ajax({
              type        : 'POST',
              url         : 'ajax.php',
              data        : formData,
              dataType    : 'json',
              encode      : true
          })
              .done(function(data) {
                  //console.log(data);
                  $('#product_info').html(data).show();
                  total();
                  $('.datePicker').datepicker('update', new Date());

              }).fail(function() {
                  $('#product_info').html(data).show();
              });
        e.preventDefault();
    });
    function total(){
      $('#product_info input').change(function(e)  {
              var price = +$('input[name=price]').val() || 0;
              var qty   = +$('input[name=quantity]').val() || 0;
              var total = qty * price ;
                  $('input[name=total]').val(total.toFixed(2));
      });
    }

    $(document).ready(function() {

      //tooltip
      $('[data-toggle="tooltip"]').tooltip();

      $('.submenu-toggle').click(function () {
         $(this).parent().children('ul.submenu').toggle(200);
      });
      //suggetion for finding product names
      suggetion();
      // Callculate total ammont
      total();

      $('.datepicker')
          .datepicker({
              format: 'yyyy-mm-dd',
              todayHighlight: true,
              autoclose: true
          });
    });
    
  </script>
  
  <!--This Displays the Time and Date Dynamically-->
  <script>
  function updateDateTime() {
	    const dateElement = document.querySelector('.header-date strong');
	    const now = new Date();
	    const options = { year: 'numeric', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric' };
	    const formattedDate = now.toLocaleDateString('en-US', options);
	    dateElement.textContent = formattedDate;
	}
	setInterval(updateDateTime, 1000);
	updateDateTime();
  </script>
  
  
  </html>    