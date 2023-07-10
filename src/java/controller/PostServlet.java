/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.time.LocalDate;
import model.Post;
import model.User;

/**
 *
 * @author Quoc Anh
 */
@MultipartConfig(maxFileSize = 16177216) // up to 16mb
public class PostServlet extends HttpServlet {

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
                    UserDAO udb = new UserDAO();
                    User u = udb.check(username, password);
                    if (u != null) {
                        HttpSession session = request.getSession();
                        session.setMaxInactiveInterval(Integer.MAX_VALUE);
                        session.setAttribute("username", username);
                        session.setAttribute("login", "true");
                        response.sendRedirect(request.getContextPath() + "/post");
                        break;
                    }
                    break; // Exit the loop since we found the desired cookie
                }
            }
        } else {
            if (request.getSession().getAttribute("username") != null) {
                request.getRequestDispatcher("/post.jsp").forward(request, response);
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
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String area_raw = request.getParameter("area");
        String numberOfRoom_raw = request.getParameter("numberOfRoom");
        String availableRoom_raw = request.getParameter("availableRoom");
        Part part = request.getPart("image");
        PostDAO pdb = new PostDAO();
        UserDAO udb = new UserDAO();
        if (part != null) {
            try {
                double area = Double.parseDouble(area_raw);
                int numberOfRoom = Integer.parseInt(numberOfRoom_raw);
                int availableRoom = Integer.parseInt(availableRoom_raw);
                InputStream is = part.getInputStream();
                LocalDate localDate = LocalDate.now();
                String username = (String) request.getSession().getAttribute("username");
                if (username == null) {
                    response.sendRedirect(request.getContextPath() + "/home");

                }
                
                int userid = udb.getUserByUsername(username).getUserId();
                Post newP = new Post(0, title, description, address, phoneNumber, area, numberOfRoom, availableRoom, localDate, userid, is);
                pdb.insertPost_forUser(newP);
                pdb.insertImage_forUser(newP);
                response.sendRedirect(request.getContextPath() + "/home");
            } catch (IOException | NumberFormatException e) {
                System.out.println("Could not save this post");
                System.out.println(e);
                request.setAttribute("registrationStatus", "failure");
                request.getRequestDispatcher("/post.jsp").forward(request, response);
            }
        }
    }

}
