/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.User;

import dal.PostDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class ChangePasswordServlet extends HttpServlet {
   
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
        HttpSession session = request.getSession();
        PostDAO pdb = new PostDAO();
        UserDAO udb = new UserDAO();
        // Get all the cookies from the request
        Cookie[] cookies = request.getCookies();

        if (cookies != null && request.getSession().getAttribute("username") == null && request.getSession().getAttribute("login") == null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("account")) {
                    // Read the value of the "account" cookie
                    String accountCookieValue = cookie.getValue();

                    // Process the cookie value as needed
                    // For example, split the value into username and password
                    String[] accountInfo = accountCookieValue.split(":");
                    String username = accountInfo[0];
                    String password = accountInfo[1];
                    
                    User u = udb.check(username, password);
                    if (u != null) {
                        session.setMaxInactiveInterval(Integer.MAX_VALUE);
                        session.setAttribute("username", username);
                        session.setAttribute("usertype", u.getUserType());
                        session.setAttribute("login", "true");
                        response.sendRedirect(request.getContextPath() + "./changePassword");
                        break;
                    } else {
                        if (request.getSession().getAttribute("username") != null) {
                            session.setMaxInactiveInterval(Integer.MAX_VALUE);
                            session.setAttribute("username", request.getSession().getAttribute("username"));
                            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/index.jsp").forward(request, response);
                        }
                    }
                    break; // Exit the loop since we found the desired cookie
                }
            }
        } else {
            if (request.getSession().getAttribute("username") != null) {
                User u = udb.getUserByUsername((String) request.getSession().getAttribute("username"));
                session.setMaxInactiveInterval(Integer.MAX_VALUE);
                session.setAttribute("username", request.getSession().getAttribute("username"));
                session.setAttribute("usertype", u.getUserType());
                request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        }
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
        String password = request.getParameter("password");
        UserDAO udb = new UserDAO();
        HttpSession session = request.getSession();

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("account")) {
                    Cookie cookie_ = new Cookie("account", username + ":" + password);
                    cookie.setMaxAge(3600 * 24 * 365); // Cookie expires in 1 year
                    cookie.setPath("/");    // Cookie is valid for the entire website
                    response.addCookie(cookie_); // Set the cookie in the response
                    System.out.println("Have to update cookie");
                    break; // Exit the loop since the cookie has been found and removed
                }
            }
        }
        
        
        udb.changePassWord(username, password);
        session.setAttribute("username", username);
        session.setAttribute("login", "true");
        response.sendRedirect(request.getContextPath() + "/home");
        
    }

}
