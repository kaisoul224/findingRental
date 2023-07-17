/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.User;

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
 * @author QuocAnh
 */
public class ChangeInfoServlet extends HttpServlet {

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
        UserDAO udb = new UserDAO();
        HttpSession session = request.getSession();
        Cookie[] cookies = request.getCookies();

        if (cookies != null && request.getSession().getAttribute("username") == null && request.getSession().getAttribute("login") == null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("accountt")) {
                    // Read the value of the "account" cookie
                    String accountCookieValue = cookie.getValue();

                    // Process the cookie value as needed
                    // For example, split the value into username and password
                    String[] accountInfo = accountCookieValue.split(":");
                    String username = accountInfo[0];
                    String password = accountInfo[1];
                    System.out.println("username: " + username);
                    System.out.println("password: " + password);
                    User u = udb.check(username, password);
                    if (u != null) {
                        
                        session.setMaxInactiveInterval(Integer.MAX_VALUE);
                        session.setAttribute("username", username);
                        session.setAttribute("login", "true");
                        User user = udb.getUserByUsername(username);
                        request.setAttribute("data", user);
                        response.sendRedirect(request.getContextPath() + "/changeInfo");
                        break;
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                    break; // Exit the loop since we found the desired cookie
                }
            }
        } else {
            if (request.getSession().getAttribute("username") != null) {
                String username = (String) request.getSession().getAttribute("username");
                User user = udb.getUserByUsername(username);
                request.setAttribute("data", user);
                session.setMaxInactiveInterval(Integer.MAX_VALUE);
                session.setAttribute("username", username);
                request.getRequestDispatcher("/changeInfo.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        }

        
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

        UserDAO udb = new UserDAO();
        try {
            if (udb.getUserByUsername(username) == null) {
                String oldUsername = (String) request.getSession().getAttribute("username");
                int id = udb.getUserByUsername(oldUsername).getUserId();

                if (!oldUsername.equals(username)) {
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if (cookie.getName().equals("account")) {
                                cookie.setMaxAge(0); // Set maximum age to 0 to remove the cookie
                                cookie.setPath("/"); // Make sure to set the same path used when creating the cookie
                                response.addCookie(cookie); // Update the cookie in the response to remove it
                                break; // Exit the loop since the cookie has been found and removed
                            }
                        }
                    }
                }

                User uNew = new User(id, fullname, username, "", "normal", phonenumber, email);
                udb.update_forUser(uNew);
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("login", "true");
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                System.out.println("Could not send user register");
                request.setAttribute("changeInfoStatus", "failure");
                request.getRequestDispatcher("/changeInfo.jsp").forward(request, response);
            }
        } catch (IOException e) {
            System.out.println("Could not send user register");
            request.setAttribute("changeInfoStatus", "failure");
            request.getRequestDispatcher("/changeInfo.jsp").forward(request, response);
        }
    }

}
