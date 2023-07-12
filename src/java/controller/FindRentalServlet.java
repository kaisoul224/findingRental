/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.PostDAO;
import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import model.Post;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class FindRentalServlet extends HttpServlet {
   

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
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String searchValue1 = request.getParameter("query");
        String searchValue2 = request.getParameter("city");
        String searchValue3 = request.getParameter("price");
        HttpSession session = request.getSession();
        PostDAO pdb = new PostDAO();
        
        session.removeAttribute("postList");
        
        if (searchValue1 != null) {
            ArrayList<Post> postList1 = pdb.getListPostByAddress(searchValue1);
            ArrayList<Post> postList2 = pdb.getListPostByTitle(searchValue1);
            if (postList1 != null && postList2 != null) {
                if (postList1.size() > postList2.size()) {
                    session.setAttribute("postList", postList1);
                } else {
                    session.setAttribute("postList", postList2);
                }
            } else if (postList1 != null) {
                session.setAttribute("postList", postList1);
            } else if (postList2 != null) {
                session.setAttribute("postList", postList2);
            }            
        } else if (searchValue2 != null && searchValue3 != null) {
            // Handle search by city and price
            ArrayList<Post> postList = pdb.getListPostByCityAndPrice(searchValue2, searchValue3);
            if (!postList.isEmpty()) {
                session.setAttribute("postList", postList);
            } else {
                System.out.println("No posts found.");
            }
        } else if (searchValue2 != null) {
            ArrayList<Post> postList1 = pdb.getListPostByAddress(searchValue3);
            ArrayList<Post> postList2 = pdb.getListPostByTitle(searchValue3);
            if (postList1 != null && postList2 != null) {
                if (postList1.size() > postList2.size()) {
                    session.setAttribute("postList", postList1);
                } else {
                    session.setAttribute("postList", postList2);
                }
            } else if (postList1 != null) {
                session.setAttribute("postList", postList1);
            } else if (postList2 != null) {
                session.setAttribute("postList", postList2);
            } 
        }
    
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
                    UserDAO udb = new UserDAO();
                    User u = udb.check(username, password);
                    if (u != null) {
                        session.setMaxInactiveInterval(Integer.MAX_VALUE);
                        session.setAttribute("username", username);
                        session.setAttribute("login", "true");
                        response.sendRedirect(request.getContextPath() + "/home");
                        break;
                    } else {
                        if (request.getSession().getAttribute("username") != null) {
                            session.setMaxInactiveInterval(Integer.MAX_VALUE);
                            session.setAttribute("username", request.getSession().getAttribute("username"));
                            request.getRequestDispatcher("/findRental.jsp").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/rental.jsp").forward(request, response);
                        }
                    }
                    break; // Exit the loop since we found the desired cookie
                }
            }
        } else {
            if (request.getSession().getAttribute("username") != null) {
                session.setMaxInactiveInterval(Integer.MAX_VALUE);
                session.setAttribute("username", request.getSession().getAttribute("username"));
                request.getRequestDispatcher("/findRental.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/rental.jsp").forward(request, response);
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