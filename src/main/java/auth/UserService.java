package auth;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class UserService {

    // Retrieve user by email or username
    public User getUserByEmailOrUsername(String emailOrUsername) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM registered_user WHERE username=? OR email=?";
        try (Connection con = DbConn.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapUserFromResultSet(rs); 
            }
        }
        return null;
    }

    // Admin check
    public User findAdminByEmailOrUsername(String emailOrUsername) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM admin WHERE email=? OR name=?";
        try (Connection con = DbConn.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapUserFromResultSet(rs); 
            }
        }
        return null;
    }

   
    public boolean isAdmin(String email) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM admin WHERE email=?";
        try (Connection con = DbConn.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            return rs.next(); 
        }
    }

   
    public boolean registerUser(User user) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO registered_user (username, email, password, Access_level) VALUES (?, ?, ?, ?)";
        try (Connection con = DbConn.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, "3");

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Generate OTP
    public String generateOTP() {
        Random random = new Random();
        StringBuilder otp = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            otp.append(random.nextInt(10)); // Generate random digits
        }
        return otp.toString();
    }

    // Update password
    public boolean updatePassword(String email, String newPassword) throws SQLException, ClassNotFoundException {
        String query = "UPDATE registered_user SET password=? WHERE email=?";
        try (Connection con = DbConn.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }



    // Utility method for mapping a ResultSet to a User object
    private User mapUserFromResultSet(ResultSet rs) throws SQLException {
        String username = rs.getString("username");
        String email = rs.getString("email");
        String password = rs.getString("password");
        String accessStatus = rs.getString("Access_state");
        String accessLevel = rs.getString("Access_level");
        return new User(username, email, password, accessStatus, accessLevel);
    }
    
    public boolean updateUserAccess(User user) throws SQLException, ClassNotFoundException {
        String queryUpdateUser = "UPDATE registered_user SET Access_level = ?, Access_state = ? WHERE email = ?";
        String queryInsertAdmin = "INSERT INTO admin (email) VALUES (?)";
        String queryDeleteAdmin = "DELETE FROM admin WHERE email = ?";
        
        boolean isUpdated = false;

        try (Connection con = DbConn.getConnection()) {
           
            String currentAccessLevelQuery = "SELECT Access_level FROM registered_user WHERE email = ?";
            try (PreparedStatement ps = con.prepareStatement(currentAccessLevelQuery)) {
                ps.setString(1, user.getEmail());
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String currentAccessLevel = rs.getString("Access_level");

                  
                    try (PreparedStatement psUpdate = con.prepareStatement(queryUpdateUser)) {
                        psUpdate.setString(1, user.getAccessLevel());
                        psUpdate.setString(2, user.getStatus());
                        psUpdate.setString(3, user.getEmail());
                        isUpdated = psUpdate.executeUpdate() > 0;
                    }

                  
                    if ("1".equals(user.getAccessLevel()) && !currentAccessLevel.equals("1")) {
                       
                        try (PreparedStatement psInsert = con.prepareStatement(queryInsertAdmin)) {
                            psInsert.setString(1, user.getEmail());
                            psInsert.executeUpdate();
                        }
                    } else if (!"1".equals(user.getAccessLevel()) && currentAccessLevel.equals("1")) {
                       
                        try (PreparedStatement psDelete = con.prepareStatement(queryDeleteAdmin)) {
                            psDelete.setString(1, user.getEmail());
                            psDelete.executeUpdate();
                        }
                    }
                }
            }
        }

        return isUpdated;
    }
    
    public boolean deleteUser(String email) throws SQLException, ClassNotFoundException {
        boolean userDeleted = false;
        boolean adminDeleted = false;

        // Check if user exists in the admin table
        if (isAdmin(email)) {
            // Delete user from admin table
            String deleteAdminQuery = "DELETE FROM admin WHERE email=?";
            try (Connection con = DbConn.getConnection();
                 PreparedStatement ps = con.prepareStatement(deleteAdminQuery)) {
                ps.setString(1, email);
                adminDeleted = ps.executeUpdate() > 0;
            }
        }

        // Delete user from registered_user table
        String deleteUserQuery = "DELETE FROM registered_user WHERE email=?";
        try (Connection con = DbConn.getConnection();
             PreparedStatement ps = con.prepareStatement(deleteUserQuery)) {
            ps.setString(1, email);
            userDeleted = ps.executeUpdate() > 0;
        }

      
        return userDeleted && (adminDeleted || !isAdmin(email));
    }
    

    public void updateLastLogin(String string) {
        String query = "UPDATE registered_user SET last_login = NOW() WHERE email = ?";
        try (Connection conn = DbConn.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, string);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
    }

  
   

    
}
