<%@ include file="../Dashboard/headeradmin.jsp" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="auth.DbConn, tools.EncryptDecrypt" %>

<title>Track-Stock - User Details</title>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
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
        displayMessage = "<div id='alert-message' class='alert alert-success'><a href='#' class='close' data-dismiss='alert'>�</a>" + msgs + "</div>";
    } else if ("error".equalsIgnoreCase(messageType)) {
        displayMessage = "<div id='alert-message' class='alert alert-danger'><a href='#' class='close' data-dismiss='alert'>�</a>" + msgs + "</div>";
    } else {
        displayMessage = "<div id='alert-message' class='alert alert-info'><a href='#' class='close' data-dismiss='alert'>�</a>" + msgs + "</div>";
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
              <span>Users</span>
            </strong>
            <!-- Button to trigger the modal -->
            <button type="button" class="btn btn-info pull-right" data-toggle="modal" data-target="#addUserModal">
              Add New User
            </button>
          </div>
          <div class="panel-body">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th class="text-center" style="width: 50px;">#</th>
                  <th>Email</th>
                  <th class="text-center" style="width: 15%;">User Role</th>
                  <th class="text-center" style="width: 10%;">Status</th>
                  <th style="width: 20%;">Last Login</th>
                </tr>
              </thead>
              <tbody>
                <%
                    int count = 1;
                    String access = "";
                    String lastLogin = "";
                    String currentLoginUserEmail = (String) session.getAttribute("email");

                    try (Connection conn = DbConn.getConnection();
                         PreparedStatement pstmt = conn.prepareStatement(
                             "SELECT User_ID, email, Access_level, Access_state, last_login FROM registered_user");
                         ResultSet rs = pstmt.executeQuery()) {

                        while (rs.next()) {
                            String userId = rs.getString("User_ID");
                            String email = rs.getString("email");
                            String accessLevel = rs.getString("Access_level");
                            String encryptedEmail = EncryptDecrypt.encodeBase64(email);
                            String status = rs.getString("Access_state");

                            if (currentLoginUserEmail != null && currentLoginUserEmail.equals(email)) {
                                lastLogin = "Current User";
                            } else {
                                lastLogin = rs.getString("last_login") != null ? rs.getString("last_login") : "No login history";
                            }

                            String labelClass = status.equals("Active") ? "label-success" : "label-danger";
                            switch (accessLevel) {
                                case "1":
                                    access = "Admin";
                                    break;
                                case "2":
                                    access = "Special";
                                    break;
                                case "3":
                                    access = "User";
                                    break;
                                default:
                                    access = "Undefined";
                                    break;
                            }
                %>
                <tr>
                    <td class="text-center"><%= count %></td>
                    <td><%= email %></td>
                    <td class="text-center"><%= access %></td>
                    <td class="text-center"><span class="label <%= labelClass %>"><%= status %></span></td>
                    <td><%= lastLogin %></td>
                </tr>
                <%
                            count++;
                        }
                    } catch (SQLException e) {
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

<!-- Modal for adding a new user -->
<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"style="position: absolute; right: 20px; top: 20px; color: red; font-size: 1.9rem;">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="addUserModalLabel">
          Add New User
        </h4>
      </div>
      <div class="modal-body">
        <!-- Form for adding a new user -->
        <form action="${pageContext.request.contextPath}/adduserManual" method="post">
          <div class="form-group">
            <label for="username"> Username</label>
            <input type="text" class="form-control" id="username" name="username" required placeholder="Enter username">
          </div>
          <div class="form-group">
            <label for="email"> Email</label>
            <input type="email" class="form-control" id="email" name="email" required placeholder="Enter email">
          </div>
          <div class="form-group">
            <label for="password"> Password</label>
            <input type="password" class="form-control" id="password" name="password" required placeholder="Enter password">
          </div>
          <div class="alert alert-info">
            <h4><i class="glyphicon glyphicon-info-sign"></i> Important Note:</h4>
            <p>All users are initially granted <strong>standard user</strong> permissions. To request additional access (such as special user roles), please visit the <a href="UserManagement.jsp">User Management</a> page after account creation.</p>
          </div>
          <button type="submit" class="btn btn-primary"></i> Add User</button>
        </form>
      </div>
    </div>
  </div>
</div>


<!-- Include Bootstrap JS and jQuery -->
<script src="path/to/jquery.js"></script>
<script src="path/to/bootstrap.js"></script>
<script>
 

    // Clear message after set time
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
