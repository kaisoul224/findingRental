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
import java.text.Normalizer;
import java.util.ArrayList;
import model.Post;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class HomeServlet extends HttpServlet {

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
        PostDAO pdb = new PostDAO();
        UserDAO udb = new UserDAO();
        ArrayList<Post> newestPost = new ArrayList<>();
        ArrayList<Post> priciestPost = new ArrayList<>();
        priciestPost = pdb.getPriciestPosts(5);
        newestPost = pdb.getNewestPosts(4);
        
        session.setAttribute("newestPost", newestPost);
        session.setAttribute("priciestPost", priciestPost);

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
                        //            Create cookie to still login
                        Cookie loginCokie = new Cookie("login", username);
                        loginCokie.setMaxAge(3600); // Cookie expires in 1 year
                        loginCokie.setPath("/");    // Cookie is valid for the entire website
                        response.addCookie(loginCokie); // Set the cookie in the response
                        response.sendRedirect(request.getContextPath() + "/home");
                        break;
                    } else {
                        if (request.getSession().getAttribute("username") != null) {
                            session.setMaxInactiveInterval(Integer.MAX_VALUE);
                            session.setAttribute("username", request.getSession().getAttribute("username"));
                            request.getRequestDispatcher("/home.jsp").forward(request, response);
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
                request.getRequestDispatcher("/home.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        }
    }

    // Method to remove diacritics from a Vietnamese string
    public String removeDiacritics(String vietnameseString) {
        String normalizedString = Normalizer.normalize(vietnameseString, Normalizer.Form.NFD);
        return normalizedString.replaceAll("\\p{M}", "");
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

            String searchValue = request.getParameter("search_home");
            String searchCity = request.getParameter("search_city");
            String searchPrice = request.getParameter("search_price");

            if (searchValue != null && !searchValue.isEmpty()) {
//                searchValue = removeDiacritics(searchValue);
                // Encode search value with proper encoding
                String encodedSearchValue = java.net.URLEncoder.encode(searchValue, "UTF-8");

                response.sendRedirect(request.getContextPath() + "/find?query=" + encodedSearchValue);
            } else {
                // Check if searchCity and searchPrice are not empty
                if (!"Select City".equals(searchCity) && !searchCity.isEmpty() || !"Select Rental Price".equals(searchPrice) && !searchPrice.isEmpty()) {
                    searchCity = removeDiacritics(searchCity);
                    searchPrice = removeDiacritics(searchPrice);

                    switch (searchPrice) {
                        case "Duoi 1 trieu":
                            searchPrice = "0-1000000";
                            break;
                        case "1 trieu - 2 trieu":
                            searchPrice = "1000000-2000000";
                            break;
                        case "2 trieu - 3 trieu":
                            searchPrice = "2000000-3000000";
                            break;
                        case "3 trieu - 5 trieu":
                            searchPrice = "3000000-5000000";
                            break;
                        case "5 trieu - 10 trieu":
                            searchPrice = "5000000-10000000";
                            break;
                        case "Tat ca":
                            searchPrice = "all";
                            break;
                        // Add more cases for other price ranges if needed
                    }

                    if ("Select City".equals(searchCity) && !searchCity.isEmpty() ){
                        searchCity = "none";
                    }
                    if ("Select Rental Price".equals(searchPrice) && !searchPrice.isEmpty()){
                        searchPrice = "all";
                    }

                    // Encode searchCity and searchPrice with proper encoding
                    String encodedSearchCity = java.net.URLEncoder.encode(searchCity, "UTF-8");
                    String encodedSearchPrice = java.net.URLEncoder.encode(searchPrice, "UTF-8");
                    
                    response.sendRedirect(request.getContextPath() + "/find?city=" + encodedSearchCity + "&price=" + encodedSearchPrice);
                } else {
                    response.sendRedirect(request.getContextPath() + "/rental");
                }
            }
        } catch (IOException e) { // Handle encoding exception
            // Handle encoding exception
            response.sendRedirect(request.getContextPath() + "/rental");
        }

    }
}
