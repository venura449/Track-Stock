<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*,auth.DbConn" %>
<%@page import="jakarta.servlet.http.HttpSession"%>   
<%@ include file="../Header/header.jsp" %>

<% 
    HttpSession session1 = request.getSession(); 
    if(session1.getAttribute("login_state") == null){
        response.sendRedirect("../Login/Login.jsp");
    }
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Track-Stock - Add New Sale</title>

<script>
$(document).ready(function() {
    $('#sug_input').on('input', function() {
        var query = $(this).val();
        
        if (query.length > 2) {
            $.ajax({
                url: '../ProductSearch',
                method: 'POST',
                data: {search: query},
                success: function(data) {
                    $('#result').html(data);
                    $('#result').show();
                }
            });
        } else {
            $('#result').hide();
        }
    });
    
    $(document).on('click', '.list-group-item', function() {
        var selectedProdName = $(this).text();
        var selectedProdId = $(this).data('prodid');

        $('#sug_input').val(selectedProdName);
        $('#selected_prod_id').val(selectedProdId);
        $('#result').hide();
    });
});
</script>
</head>
<body>
<div class="page">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <form method="post" action="" autocomplete="off" id="sug-form">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-btn">
                                <button type="submit" class="btn btn-primary">Find It</button>
                            </span>
                            <input type="text" id="sug_input" class="form-control" name="title" placeholder="Search for product name">
                        </div>
                    </div>
                    <input type="hidden" id="selected_prod_id" name="prodId">
                    <div id="result" class="list-group" style="display:block;"></div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading clearfix">
                        <strong>
                            <span class="glyphicon glyphicon-th"></span>
                            <span>Sale Edit</span>
                        </strong>
                    </div>
                    <div class="panel-body">
                    <%String prodId = request.getParameter("prodId"); %>
                        <form method="post" action="../SalesDelete?id=<%=prodId%>&action=add">
                        
                            <% 
                                
                                if (prodId != null && !prodId.isEmpty()) {
                                    Connection conn = null;
                                    PreparedStatement pstmt = null;
                                    ResultSet rs = null;
                                    
                                    try {
                                        conn = DbConn.getConnection();
                                        String query = "SELECT * FROM `products` WHERE `prodId` = ?";
                                        pstmt = conn.prepareStatement(query);
                                        pstmt.setString(1, prodId);
                                        rs = pstmt.executeQuery();
                                        
                                        if (rs.next()) {
                                            String prodName = rs.getString("prodName");
                                            String price = rs.getString("price");
                                           	String cat = rs.getString("ProductCategory");
                                           	String qty = rs.getString("Quantity");
                                        
                            %>
                            <input type="text" style="display:none" name="prodId" value=<%=prodId %>>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Item</th>
                                        <th>Ordering Qty</th>
                                        <th>Avalible Qty</th>
                                        <th>Price Per Item</th>
                                        <th>Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="product_info">
                                    <tr>
                                    	
                                        <td><input type="text" style="outline:none;pointer-events:none;border:none" name="prodName" value="<%= prodName %>"></td>
                                        <td><input type="text" style="outline:none;border:none" name="quantity" min="1" value="1"></td>
                                         <td><input type="text" style="outline:none;pointer-events:none;border:none" name="qty" value="<%= qty %> "></td>
                                        <td><input type="text" style="outline:none;border:none" name="price" value="<%= price %> "></td>
                                        <td><input type="date" style="outline:none;border:none" name="sale_date"></td>
                                        <td><button type="submit" name="add_sale" class="btn btn-primary">Add sale</button></td>
                                    </tr>
                                </tbody>
                            </table>
                            <% 
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                                        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                                    }
                                }
                            %>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

</html>
