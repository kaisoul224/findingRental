/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Page;

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
import java.util.ArrayList;
import model.Post;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class AdminPageServlet extends HttpServlet {

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
        ArrayList<Post> postsList = new ArrayList<>();
        ArrayList<User> usersList = new ArrayList<>();
        postsList = pdb.getAllListPost();
        usersList = udb.getAllList();
        
        session.setAttribute("postsList", postsList);
        session.setAttribute("usersList", usersList);
        
        Cookie[] cookies = request.getCookies();
        
        if (cookies != null && request.getSession().getAttribute("username") == null && request.getSession().getAttribute("login") == null ) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("account")) {
                    // Read the value of the "account" cookie
                    String accountCookieValue = cookie.getValue();

                    // Process the cookie value as needed
                    // For example, split the value into username and password
                    String[] accountInfo = accountCookieValue.split(":");
                    String username = accountInfo[0];
                    String password = accountInfo[1];
                    System.out.println("username: " + username);
                    System.out.println("password: "+ password);
                    User u = udb.check(username, password);
                    if (u != null) {
                        session.setAttribute("username", username);
                        session.setAttribute("usertype", u.getUserType());
                        session.setAttribute("login", "true");
                        response.sendRedirect(request.getContextPath() + "/admin");
                        break;
                    } else {
                        if (request.getSession().getAttribute("username") != null) {
                            
                        session.setAttribute("username", request.getSession().getAttribute("username"));
                        request.getRequestDispatcher("/adminPage.jsp").forward(request, response);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/home");
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
            request.getRequestDispatcher("/adminPage.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
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
    }

}
