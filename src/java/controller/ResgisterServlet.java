/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
 * @author Quoc Anh
 */
public class ResgisterServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
            session.removeAttribute("username");
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String phonenumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String usertype = "normal";
        UserDAO udb = new UserDAO();
        try {
            if (udb.getUserByUsername(username) == null){
                User uNew = new User(0, fullname, username, password, usertype, phonenumber, email);
                udb.insert_forUser(uNew);
                request.getSession().setAttribute("username", username);
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                System.out.println("Could not send user register");
                request.setAttribute("registrationStatus", "failure");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (IOException e) {
            System.out.println("Could not send user register");
            request.setAttribute("registrationStatus", "failure");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

}
