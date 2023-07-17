/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Post;

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
import model.Post;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class PostDetailServlet extends HttpServlet {
   
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
        UserDAO udb = new UserDAO();
        PostDAO pdb = new PostDAO();
        HttpSession session = request.getSession();
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
                        String id_raw = request.getParameter("id");
                        int id = Integer.parseInt(id_raw);
                        Post post = pdb.getPostByID(id);
                        User user = udb.getUserById(post.getUserID());
                        request.setAttribute("post", post);
                        request.setAttribute("userOfPost", user);
                        session.setMaxInactiveInterval(Integer.MAX_VALUE);
                        session.setAttribute("username", username);
                        session.setAttribute("login", "true");
                        System.out.println("CCCCCCCCCCCCC");
                        request.getRequestDispatcher("/postDetail.jsp").forward(request, response);
                        break;
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                    break; // Exit the loop since we found the desired cookie
                }
            }
        } else {
            if (request.getSession().getAttribute("username") != null) {
                String id_raw = request.getParameter("id");
                int id = Integer.parseInt(id_raw);
                Post post = pdb.getPostByID(id);
                User user = udb.getUserById(post.getUserID());
                request.setAttribute("post", post);
                request.setAttribute("userOfPost", user);
                String username = (String) request.getSession().getAttribute("username");
                session.setMaxInactiveInterval(Integer.MAX_VALUE);
                session.setAttribute("username", username);
                System.out.println("hihi");
                request.getRequestDispatcher("/postDetail.jsp").forward(request, response);
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
        
    }


}
