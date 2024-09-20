package admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tools.EncryptDecrypt;

import java.io.IOException;
import java.sql.SQLException;

import auth.UserService;


public class deleteUser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
  
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	HttpSession session = request.getSession();
        String email = EncryptDecrypt.decodeBase64((String)request.getParameter("id"));
        System.out.println(email);
        
        if (email == null || email.trim().isEmpty()) {
        	session.setAttribute("state", "error");
        	session.setAttribute("message","Account Delete Failed Invalid Email");
            response.sendRedirect("Admin/UserManagement/UserManagement.jsp");
            return;
        }

        UserService userService = new UserService();
        try {
            boolean success = userService.deleteUser(email);
            if (success) {
            	session.setAttribute("state", "success");
            	session.setAttribute("message","Account Delete Successful");
            	response.sendRedirect("Admin/UserManagement/UserManagement.jsp");
            } else {
            	session.setAttribute("state", "error");
            	session.setAttribute("message","Account Delete Failed");
               response.sendRedirect("Admin/UserManagement/UserManagement.jsp?message=User deletion failed");
            }
        } catch (SQLException | ClassNotFoundException e) {
        	session.setAttribute("state", "error");
        	session.setAttribute("message","Account Delete Failed, Error Occured while Deleting ");
            response.sendRedirect("Admin/UserManagement/UserManagement.jsp");
        }
    }
}
