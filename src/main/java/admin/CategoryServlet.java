package admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import auth.DbConn;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDao categoryDao;

    @Override
    public void init() {
        Connection connection = null;
        try {
            connection = DbConn.getConnection();
            categoryDao = new CategoryDao(connection);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 String action = request.getParameter("action");
         if ("add".equals(action)) {
             addCategory(request, response);
         } else if ("delete".equals(action)) {
             deleteCategory(request, response);
         } else if ("update".equals(action)) {
             updateCategory(request, response);
         }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 String action = request.getParameter("action");
         if ("add".equals(action)) {
             addCategory(request, response);
         } else if ("delete".equals(action)) {
             deleteCategory(request, response);
         } else if ("update".equals(action)) {
             updateCategory(request, response);
         }
    }

    //Delete category by ID-Usage checked 2024/09/17 called by category.jsp
    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("categorie-name");

        Category category = new Category();
        category.setName(name);
        System.out.println("catergoery invoked");

        try {
        	HttpSession session = request.getSession();
            if(categoryDao.addCategory(category)) {
              	 session.setAttribute("state", "success");
              	 session.setAttribute("message","Category Added Succefully");
              	 response.sendRedirect("Admin/Category/category.jsp");
              }
              else {
              	 session.setAttribute("state", "error");
              	 session.setAttribute("message","Category Adding Failed !");
              	 response.sendRedirect("Admin/Category/category.jsp");
              }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Delete category by ID-Usage checked 2024/09/17 called by category.jsp
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("categoryId"));
        try {
        	HttpSession session = request.getSession();
            if(categoryDao.deleteCategory(id)) {
           	 session.setAttribute("state", "success");
           	 session.setAttribute("message","Category Deleted Succesfully ");
           	 response.sendRedirect("Admin/Category/category.jsp");
           }
           else {
           	 session.setAttribute("state", "error");
           	 session.setAttribute("message","Category Delete Failed !");
           	 response.sendRedirect("Admin/Category/category.jsp");
           }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("category-id"));
        String name = request.getParameter("category-name");

        Category category = new Category(id, name);

        try {
            
            HttpSession session = request.getSession();
            if(categoryDao.updateCategory(category)) {
           	 session.setAttribute("state", "success");
           	 session.setAttribute("message","Category Update Successful");
           	 response.sendRedirect("Admin/Category/category.jsp");
           }
           else {
           	 session.setAttribute("state", "error");
           	 session.setAttribute("message","Category Update Failed !");
           	 response.sendRedirect("Admin/Category/category.jsp");
           }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
