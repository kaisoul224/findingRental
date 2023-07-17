/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.User;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author kaiso
 */
public class ForgotServlet extends HttpServlet {
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/forgot.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("username");
        String phoneNumber = request.getParameter("phoneNumber");
        UserDAO udb = new UserDAO();
        User u = udb.getUserByUsername(username);
        HttpSession session = request.getSession();
        try {
            if (u != null) {
                if (u.getPhoneNumber().equals(phoneNumber)) {
                    session.setAttribute("username", username);
                    request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                } else {
                    request.setAttribute("forgetStatus", "warning");
                    request.getRequestDispatcher("forget.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("forgetStatus", "failure");
                request.getRequestDispatcher("forget.jsp").forward(request, response);
            }

        } catch (ServletException | IOException e) {
            System.out.println("Could not forget this username");
            System.out.println(e);
        }
    }
}
