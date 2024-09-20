<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../Dashboard/headeradmin.jsp" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="auth.DbConn" %>
<%
    HttpServletRequest httpRequest = (HttpServletRequest) pageContext.getRequest();
    String contextPath = httpRequest.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Track-Stock - Category</title>
<!-- Include Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- Custom CSS for modal -->
<style>
  .modal-content {
    border-radius: 10px;
  }
  .modal-header {
    background-color: #007bff;
    color: #fff;
  }
  .modal-footer {
    border-top: none;
  }
</style>
</head>
<body>
<div class="page">
  <div class="container-fluid">

    <div class="row">
      <div class="col-md-12">
        <% 
        // Retrieve session attributes
        String msgs = (String) session.getAttribute("message");
        String messageType = (String) session.getAttribute("state");
        String displayMessage = "";

        if (msgs != null && !msgs.isEmpty()) {
            if ("success".equalsIgnoreCase(messageType)) {
                displayMessage = "<div id='alert-message' class='alert alert-success'><a href='#' class='close' data-dismiss='alert'>×</a>" + msgs + "</div>";
            } else if ("error".equalsIgnoreCase(messageType)) {
                displayMessage = "<div id='alert-message' class='alert alert-danger'><a href='#' class='close' data-dismiss='alert'>×</a>" + msgs + "</div>";
            } else {
                displayMessage = "<div id='alert-message' class='alert alert-info'><a href='#' class='close' data-dismiss='alert'>×</a>" + msgs + "</div>";
            }

            // Clear the session attributes
            session.removeAttribute("message");
            session.removeAttribute("state");
        }
        %>  
        <%= displayMessage %>
      </div>
    </div>

    <div class="row">
      <div class="col-md-5">
        <div class="panel panel-default">
          <div class="panel-heading">
            <strong>
              <span class="glyphicon glyphicon-th"></span>
              <span>Add New Category</span>
            </strong>
          </div>
          <div class="panel-body">
            <form method="post" action="${pageContext.request.contextPath}/CategoryServlet?action=add">
              <div class="form-group">
                <input type="text" class="form-control" name="categorie-name" placeholder="Category Name">
              </div>
              <button type="submit" name="add_cat" class="btn btn-primary">Add Category</button>
            </form>
          </div>
        </div>
      </div>

      <div class="col-md-7">
        <div class="panel panel-default">
          <div class="panel-heading">
            <strong>
              <span class="glyphicon glyphicon-th"></span>
              <span>All Categories</span>
            </strong>
          </div>
          <div class="panel-body">
            <table class="table table-bordered table-striped table-hover">
              <thead>
                <tr>
                  <th class="text-center" style="width: 50px;">Id</th>
                  <th>Categories</th>
                  <th class="text-center" style="width: 100px;">Actions</th>
                </tr>
              </thead>
              <tbody>
              <% 
                try (Connection conn = DbConn.getConnection();
                     PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM product_category");
                     ResultSet rs = pstmt.executeQuery()) {

                  while (rs.next()) {
                      String cat_id = rs.getString("product_cat_Id");
                      String cat_name = rs.getString("product_category");
              %>
                <tr>
                  <td class="text-center"><%= cat_id %></td>
                  <td><%= cat_name %></td>
                  <td class="text-center">
                    <div class="btn-group">
                      <a href="javascript:void(0)" class="btn btn-xs btn-warning" data-toggle="modal" data-target="#editCategoryModal" onclick="setEditCategory('<%=cat_id %>', '<%=cat_name %>')" data-toggle="tooltip" title="Edit" data-original-title="Edit">
                        <span class="glyphicon glyphicon-edit"></span>
                      </a>
                      <a href="javascript:void(0)" class="btn btn-xs btn-danger" data-toggle="modal" data-target="#deleteCategoryModal" onclick="setDeleteLink('<%=cat_id %>')" data-toggle="tooltip" title="Remove" data-original-title="Remove">
                        <span class="glyphicon glyphicon-trash"></span>
                      </a>
                    </div>
                  </td>
                </tr>
              <% 
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

<!-- Modal for editing category name -->
<div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true" >
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #ffffff;">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="addUserModalLabel" style="color: #333;">
         Edit Category Name
        </h4>
      </div>
      <div class="modal-body">
        <!-- Form for editing category -->
        <form id="editCategoryForm" method="post" action="${pageContext.request.contextPath}/CategoryServlet?action=update">
          <div class="form-group">
            <input type="hidden" id="editCategoryId" name="category-id">
            <input type="text" class="form-control" id="editCategoryName" name="category-name" placeholder="Category Name">
          </div>

          <div class="alert alert-warning">
            <h4><i class="glyphicon glyphicon-info-sign"></i> Important Note:</h4>
            <p>Please select a short, meaningful category name. Deleting a category will result in the permanent removal of all products associated with it. Ensure you make the correct selection to avoid unintended data loss.</p>
          </div>

          <button type="submit" class="btn btn-primary">Change Category Name</button>
        </form>
      </div>
    </div>
  </div>
</div>



<!-- Delete Category Modal -->
<div class="modal fade" id="deleteCategoryModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content" style="border-radius: 15px;">
      <div class="modal-header" style="background-color: #ffffff; border-bottom: none;  padding: 20px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <h5 class="modal-title" id="deleteModalLabel" style="color: #000000;  font-size: 1.85rem;  margin: 0;">
          <b> Confirm Delete</b>
        </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="position: absolute; right: 20px; top: 30px; color: red; font-size: 1.9rem;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div>
      <h5 style="padding:20px;" >Are You really want to delete this Category ?</h5>
      </div>

      <div class="modal-body text-center">
        <div class="alert alert-danger" style="padding: 20px; text-align: center; border-radius: 10px; margin: 0;">
          <h4><i class="glyphicon glyphicon-info-sign"></i> Important Note:</h4>
          <p>
            Deleting this category will also remove all associated products. Please ensure you make the correct selection to avoid unintended data loss.
          </p>
        </div>
      </div>
      
      <div class="modal-footer justify-content-center" style="border-top: none;">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="border-radius: 5px; background-color: #e0e0e0; border: none; color: #333;">
          <i class="glyphicon glyphicon-remove"></i> Cancel
        </button>
        <a id="confirmDeleteBtn" href="#" class="btn btn-danger" style="border-radius: 5px; background-color: #ff1744; border: none; color: #ffffff;">
          <i class="glyphicon glyphicon-trash"></i> Delete
        </a>
      </div>
    </div>
  </div>
</div>


<script>
  function setEditCategory(categoryId, categoryName) {
    document.getElementById('editCategoryId').value = categoryId;
    document.getElementById('editCategoryName').value = categoryName;
  }

  function setDeleteLink(categoryId) {
    var deleteUrl = '${pageContext.request.contextPath}/CategoryServlet?categoryId=' + categoryId + '&action=delete';
    document.getElementById('confirmDeleteBtn').setAttribute('href', deleteUrl);
  }

  $(function () {
    $('[data-toggle="tooltip"]').tooltip();
  });

  const time_duration = 20000;
  var alertMessage = document.getElementById('alert-message');
  if (alertMessage) {
    setTimeout(function () {
      alertMessage.style.display = 'none';
    }, time_duration);
  }
</script>

<!-- Ensure Bootstrap JS is included for modals and tooltips -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</body>
</html>
