package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import auth.User;
import auth.UserService;


public class adduserManual extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieving form parameters
    	HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); 
        String access_state = "Active";
        String access_level = "3";

        // Create User object using the User class
        User user = new User(username, email, password, access_state, access_level);
        UserService userService = new UserService();
        

        try {
            
            if (userService.getUserByEmailOrUsername(email) != null) {
                session.setAttribute("state", "error");
                session.setAttribute("message", "User Already Exists");
                response.sendRedirect("Admin/UserManagement/Userdetails.jsp");  
            } else {
               
                boolean success = userService.registerUser(user);
                if (success) {
                    session.setAttribute("state", "success");
                    session.setAttribute("message", "User Added Successfully");
                    response.sendRedirect("Admin/UserManagement/Userdetails.jsp");  
                } else {
                	session.setAttribute("state", "error");
                    session.setAttribute("message", "User Adding Failed");
                    response.sendRedirect("Admin/UserManagement/Userdetails.jsp");  
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
           
            response.getWriter().println("Database connection problem: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
