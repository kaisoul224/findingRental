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
import java.util.ArrayList;
import model.Post;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class YourPostServlet extends HttpServlet {
  

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
        Cookie[] cookies = request.getCookies();
        
        PostDAO pdb = new PostDAO();
        UserDAO udb = new UserDAO();
        HttpSession session = request.getSession();
        session.removeAttribute("postList_raw");
       
        if (cookies != null && request.getSession().getAttribute("username") == null && request.getSession().getAttribute("login") == null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("accountt")) {
                    // Read the value of the "account" cookie
                    String accountCookieValue = cookie.getValue();
                    String[] accountInfo = accountCookieValue.split(":");
                    String username = accountInfo[0];
                    String password = accountInfo[1];
                    
                    User u = udb.check(username, password);
                    if (u != null) {
                        ArrayList<Post> yourList = new ArrayList<>();
                        yourList = pdb.getListPostByUserID(u.getUserId());
                        session.setAttribute("yourList", yourList);
                        session.setAttribute("username", username);
                        session.setAttribute("login", "true");
//                        response.sendRedirect(request.getContextPath() + "/rental");
                        request.getRequestDispatcher("/yourPost.jsp").forward(request, response);
                        break;
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                    break; // Exit the loop since we found the desired cookie
                }
            }
        } else {
            if (request.getSession().getAttribute("username") != null) {
                ArrayList<Post> yourList = new ArrayList<>();
                
                String username = (String) request.getSession().getAttribute("username");
                User user = udb.getUserByUsername(username);
                yourList = pdb.getListPostByUserID(user.getUserId());
                session.setAttribute("yourList", yourList);
                session.setAttribute("username", username);
                request.getRequestDispatcher("/yourPost.jsp").forward(request, response);
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
