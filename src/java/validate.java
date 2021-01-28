/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 /*
        Name : Ahmad Gomma Farouk Mahmoud
        
        Id : 20170014
   
        Group : S1
   
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ahmad
 */
@WebServlet(urlPatterns = {"/validate"})
public class validate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request validate request
     * @param response validate response
     * @throws ServletException if a validate-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/mydb";
                String user = "root";
                String password = "root";
                Connection Con = null;
                Statement Stmt = null;

                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();

                String customer_id = request.getParameter("customer_id");

                String pass = request.getParameter("pass");

                Stmt.executeQuery("select customer_id , pass from customer where customer_id ='" + customer_id + "' And pass = '" + pass + "'");
                ResultSet rs = Stmt.getResultSet();

                if (!rs.isBeforeFirst()) {
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('This Account Not Valid Back To Login Page Again');");
                    out.println("location='index.html';");
                    out.println("</script>");

                } else {
                    HttpSession session;
                    session = request.getSession(true);
                    session.setAttribute("customer_id", customer_id);
                    
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('This Account Is Valid Login To System Go To Cusomer Home Page');");
                    out.println("location='customerhome.jsp';");
                    out.println("</script>");
                }
            } catch (ClassNotFoundException | SQLException ex) {
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request validate request
     * @param response validate response
     * @throws ServletException if a validate-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request validate request
     * @param response validate response
     * @throws ServletException if a validate-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the validate.
     *
     * @return a String containing validate description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
