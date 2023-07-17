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
public class RentalServlet extends HttpServlet {

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
        ArrayList<Post> postList = new ArrayList<>();
        PostDAO pdb = new PostDAO();
        postList = pdb.getAllListPost();
        HttpSession session = request.getSession();
        session.removeAttribute("postList_raw");
        session.setAttribute("postList", postList);
        if (cookies != null && request.getSession().getAttribute("username") == null && request.getSession().getAttribute("login") == null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("account")) {
                    // Read the value of the "account" cookie
                    String accountCookieValue = cookie.getValue();
                    String[] accountInfo = accountCookieValue.split(":");
                    String username = accountInfo[0];
                    String password = accountInfo[1];
                    UserDAO udb = new UserDAO();
                    User u = udb.check(username, password);
                    if (u != null) {
                        session.setAttribute("username", username);
                        session.setAttribute("login", "true");
                        response.sendRedirect(request.getContextPath() + "/rental");
                        break;
                    } else {
                        if (request.getSession().getAttribute("username") != null) {
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
                session.setAttribute("username", request.getSession().getAttribute("username"));
                request.getRequestDispatcher("/findRental.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/rental.jsp").forward(request, response);
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
        try {
            // Set character encoding for request and response
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            String searchValue = request.getParameter("search_value");

            if (searchValue != null && !searchValue.isEmpty()) {
//                searchValue = removeDiacritics(searchValue);
                // Encode search value with proper encoding
                String encodedSearchValue = java.net.URLEncoder.encode(searchValue, "UTF-8");

                response.sendRedirect(request.getContextPath() + "/find?query=" + encodedSearchValue);
            } else {
                response.sendRedirect(request.getContextPath() + "/rental");
            }
        } catch (IOException e) { // Handle encoding exception
            // Handle encoding exception
            response.sendRedirect(request.getContextPath() + "/rental");
        }

    }

}
