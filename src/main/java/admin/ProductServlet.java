package admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import auth.DbConn;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@MultipartConfig
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDao productDao;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DbConn.getConnection();
            productDao = new ProductDao(connection);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database connection error", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("product-title");
        String category = request.getParameter("product-categorie");
        String qty = request.getParameter("product-quantity");
        String price = request.getParameter("Price");
       
        Product product = new Product(name, category, qty, price);

        HttpSession session = request.getSession();
        
        
        try {
           
            if (productDao.addProduct(product)) {
                session.setAttribute("state", "success");
                session.setAttribute("message", "Product Added Successfully");
            } else {
                session.setAttribute("state", "error");
                session.setAttribute("message", "Product Adding Failed!");
            }
            response.sendRedirect("Admin/Products/Addproduct.jsp");
        } catch (SQLException e) {
            
            session.setAttribute("state", "error");
            session.setAttribute("message", "Product Adding Failed!");
            response.sendRedirect("Admin/Products/Addproduct.jsp");
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        HttpSession session = request.getSession();
        
        try {
           
            if (productDao.deleteProduct(id)) {
                session.setAttribute("state", "success");
                session.setAttribute("message", "Product Deleted Successfully");
            } else {
                session.setAttribute("state", "error");
                session.setAttribute("message", "Product Deletion Failed!");
            }
            response.sendRedirect("Admin/Products/Manageproducts.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("state", "success");
            session.setAttribute("message", "Product Deleted Successfully");
            response.sendRedirect("Admin/Products/Manageproducts.jsp");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	int prodId = Integer.parseInt(request.getParameter("id"));
    	String name = request.getParameter("product-title");
        String category = request.getParameter("product-categorie");
        String qty = request.getParameter("product-quantity");
        String price = request.getParameter("price");
        System.out.println(prodId);

        // public Product(int id,String name,String category,String qty,String price)
        Product product = new Product(prodId, name, category,qty,price);
        HttpSession session = request.getSession();

        try {
            
            if ( productDao.updateProduct(product)) {
                session.setAttribute("state", "success");
                session.setAttribute("message", "Product Updated Successfully");
            } else {
                session.setAttribute("state", "error");
                session.setAttribute("message", "Product Update Failed!");
            }
            response.sendRedirect("Admin/Products/Manageproducts.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e);
            session.setAttribute("state", "error");
            session.setAttribute("message", "Product Update Failed!");
            response.sendRedirect("Admin/Products/Manageproducts.jsp");
            
        }
    }
}
