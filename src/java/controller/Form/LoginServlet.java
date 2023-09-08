/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Form;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.Principal;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class LoginServlet extends HttpServlet {

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
        session.setMaxInactiveInterval(Integer.MAX_VALUE);
        session.setAttribute("login", "false");
        session.removeAttribute("usertype");
        Cookie cookie = new Cookie("login", null); // Đặt giá trị của cookie thành null
        cookie.setMaxAge(0); // Đặt thời gian sống của cookie thành 0 (xóa ngay lập tức)
        cookie.setPath("/"); // Đặt lại path của cookie để khớp với path ban đầu khi tạo cookie
        response.addCookie(cookie); // Gửi cookie xóa đến client
        request.getRequestDispatcher("/login.jsp").forward(request, response);
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        UserDAO udb = new UserDAO();
        User u = udb.check(username, password);
        if (u != null) {
            if (remember != null && remember.equals("on")) {
                Cookie cookie = new Cookie("accountt", username + ":" + password);
                cookie.setMaxAge(3600 * 24 * 365); // Cookie expires in 1 year
                cookie.setPath("/");    // Cookie is valid for the entire website
                response.addCookie(cookie); // Set the cookie in the response
                System.out.println("Have to save cookie");

            }
//            Create cookie to still login
            Cookie loginCokie = new Cookie("login", username);
            loginCokie.setMaxAge(3600); // Cookie expires in 1 year
            loginCokie.setPath("/");    // Cookie is valid for the entire website
            response.addCookie(loginCokie); // Set the cookie in the response
            
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(Integer.MAX_VALUE);
            session.setAttribute("username", username);
            session.setAttribute("usertype", u.getUserType());
            System.out.println("Usertype: " + u.getUserType());
            session.setAttribute("login", "true");
            response.sendRedirect(request.getContextPath() + "/home");

        } else {
            System.out.println("Could not login");
            request.setAttribute("loginStatus", "failure");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
