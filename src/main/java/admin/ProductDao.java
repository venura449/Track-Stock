package admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    private Connection connection;

    public ProductDao(Connection connection) {
        this.connection = connection;
    }

    
    public boolean addProduct(Product product) throws SQLException {
        String query = "INSERT INTO `products`(`prodName`, `Quantity`, `ProductCategory`, `Price`) VALUES (?, ?, ? , ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getQty());
            pstmt.setString(3, product.getCategory());
            pstmt.setString(4, product.getPrice());
            return pstmt.executeUpdate() > 0;
        }
    }

   

   
    public boolean deleteProduct(int id) throws SQLException {
        String query = "DELETE FROM products WHERE prodId = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        }
    }

    // Update product by ID
    public boolean updateProduct(Product product) throws SQLException {
        String query = "UPDATE `products` SET `prodName`= ? ,`Quantity`= ?,`ProductCategory`= ?,`Price`= ?  WHERE prodId = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getQty());
            pstmt.setString(3, product.getCategory());
            pstmt.setString(4, product.getPrice());
            pstmt.setInt(5, product.getId());
            return pstmt.executeUpdate() > 0;
        }
    }
}
