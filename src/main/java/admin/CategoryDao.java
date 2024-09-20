package admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    private Connection connection;

    public CategoryDao(Connection connection) {
        this.connection = connection;
    }

    // Add a new category
    public boolean addCategory(Category category) throws SQLException {
        String query = "INSERT INTO product_category (product_category) VALUES (?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, category.getName());
            return pstmt.executeUpdate() > 0;
        }
    }

   
    // Delete product by ID-Usage checked 2024/09/17 called by product Servlet
    public boolean deleteCategory(int id) throws SQLException {
        String deleteProductsQuery = "DELETE FROM products WHERE ProductCategory = ?";
        String deleteCategoryQuery = "DELETE FROM product_category WHERE product_cat_id = ?";
        
        try (PreparedStatement deleteProductsStmt = connection.prepareStatement(deleteProductsQuery);
             PreparedStatement deleteCategoryStmt = connection.prepareStatement(deleteCategoryQuery)) {
            
            // Delete all products in the category
            deleteProductsStmt.setInt(1, id);
            deleteProductsStmt.executeUpdate();
            
            // Now delete the category itself
            deleteCategoryStmt.setInt(1, id);
            return deleteCategoryStmt.executeUpdate() > 0;
        }
    }


    // Update category by ID
    public boolean updateCategory(Category category) throws SQLException {
        String query = "UPDATE product_category SET product_category = ? WHERE product_cat_id = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, category.getName());
            pstmt.setInt(2, category.getId());
            return pstmt.executeUpdate() > 0;
        }
    }
}
