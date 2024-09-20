<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../Dashboard/headeradmin.jsp" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="auth.DbConn,tools.EncryptDecrypt" %>
<%
    HttpServletRequest httpRequest = (HttpServletRequest) pageContext.getRequest();
    String contextPath = httpRequest.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Track-Stock - User Management</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="path/to/bootstrap.css">
</head>
<body>
<div class="page">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12"></div>
            <% 
// Retrieve the session attributes


String msgs = (String) session.getAttribute("message");
String messageType = (String) session.getAttribute("state");
String displayMessage = "";

System.out.println(msgs);
System.out.println(messageType);


if (msgs != null && !msgs.isEmpty()) {
    if ("success".equalsIgnoreCase(messageType)) {
        displayMessage = "<div id='alert-message' class='alert alert-success'><a href='#' class='close' data-dismiss='alert'>×</a>" + msgs + "</div>";
    } else if ("error".equalsIgnoreCase(messageType)) {
        displayMessage = "<div id='alert-message' class='alert alert-danger'><a href='#' class='close' data-dismiss='alert'>×</a>" + msgs + "</div>";
    } else {
        displayMessage = "<div id='alert-message' class='alert alert-info'><a href='#' class='close' data-dismiss='alert'>×</a>" + msgs + "</div>";
    }

    // Clear the session attributes after displaying the message
    session.removeAttribute("message");
    session.removeAttribute("state");
}
%>

<%= displayMessage %>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <strong>
                            <span class="glyphicon glyphicon-th"></span>
                            <span>User Access Roles</span>
                        </strong>
                        <!-- Button to trigger the modal for filtering -->
                        <button type="button" class="btn btn-info pull-right btn-sm" data-toggle="modal" data-target="#filterModal">
                            Filter
                        </button>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th class="text-center" style="width: 50px;">#</th>
                                    <th>Name</th>
                                    <th class="text-center" style="width: 20%;">Access Level</th>
                                    <th class="text-center" style="width: 15%;">Status</th>
                                    <th class="text-center" style="width: 100px;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>

                                <!-- Dynamically Loaded Groups -->
                                <%
                                String filter = request.getParameter("userFilter");  // Get filter from request parameter
                                String filterCondition = "";
                                
                                if (filter != null && !filter.isEmpty()) {
                                    // Apply filter based on user type
                                    switch (filter) {
                                        case "admin":
                                            filterCondition = " WHERE Access_level = 1";  // Admin filter
                                            break;
                                        case "special":
                                            filterCondition = " WHERE Access_level = 2";  // Special User filter
                                            break;
                                        case "user":
                                            filterCondition = " WHERE Access_level = 3";  // Regular User filter
                                            break;
                                        case "all":
                                        	filterCondition = "";
                                        	break;
                                    }
                                }

                                try (Connection conn = DbConn.getConnection();
                                     PreparedStatement pstmt = conn.prepareStatement("SELECT User_ID,email, Access_level, Access_state FROM registered_user" + filterCondition);
                                     ResultSet rs = pstmt.executeQuery()) {
                                    
                                    int counter = 1;  // Row counter for dynamically generated rows
                                    String access = "";
                                    while (rs.next()) {
                                        String email = rs.getString("email");
                                        String encryptedEmail = EncryptDecrypt.encodeBase64(email);
                                        int accessLevel = rs.getInt("Access_level");
                                        String userid = rs.getString("User_ID");
                                        switch (accessLevel) {
                                            case 1:
                                                access = "Admin";
                                                break;
                                            case 2:
                                                access = "Special";
                                                break;
                                            case 3:
                                                access = "User";
                                                break;
                                            default:
                                                access = "Undefined";
                                                break;
                                        }
                                        String status = rs.getString("Access_state").equals("Active") ? "Active" : "Deactive";
                                        String labelClass = status.equals("Active") ? "label-success" : "label-danger";
                                %>
                                <tr>
                                    <td class="text-center"><%= counter %></td>
                                    <td><%= email %></td>
                                    <td class="text-center"><%= access %></td>
                                    <td class="text-center"><span class="label <%= labelClass %>"><%= status %></span></td>
                                    <td class="text-center">
                                        <div class="btn-group">
                                            <a href="editaccess.jsp?id=<%= userid %>" class="btn btn-xs btn-warning" data-toggle="tooltip" title="Edit">
                                                <i class="glyphicon glyphicon-pencil"></i>
                                            </a>
                                            <a href="../../deleteUser?id=<%= encryptedEmail %>" class="btn btn-xs btn-danger" data-toggle="tooltip" title="Remove">
                                                <i class="glyphicon glyphicon-remove"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        counter++;  // Increment row counter for next iteration
                                    }

                                } catch (SQLException | ClassNotFoundException e) {
                                    e.printStackTrace();
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Filter -->
<div id="filterModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Filter Users</h4>
            </div>
            <div class="modal-body">
                <form method="GET" action="UserManagement.jsp">
                    <div class="form-group">
                        <label>Select User Type to Filter:</label><br>
                        <input type="radio" name="userFilter" value="admin"> Admin<br>
                        <input type="radio" name="userFilter" value="special"> Special User<br>
                        <input type="radio" name="userFilter" value="user"> User<br>
                        <input type="radio" name="userFilter" value="all"> All<br>
                    </div>
                    <button type="submit" class="btn btn-success">Apply Filter</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Tooltip and Modal Script -->
<script src="path/to/jquery.js"></script>
<script src="path/to/bootstrap.js"></script>
<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>
 <!-- This part clear out the message after the set time -->
  <script>
  	const time_duration = 20000;
  
    var alertMessage = document.getElementById('alert-message');
    if (alertMessage) {
       
        setTimeout(function() {
          
            alertMessage.style.display = 'none';
        }, time_duration);
    } 
</script>
  

</body>
</html>
