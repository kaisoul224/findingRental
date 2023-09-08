/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Post;

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
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import model.City;
import model.Post;
import model.PostComparator;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class FindRentalServlet extends HttpServlet {
    
    // Method to remove diacritics from a Vietnamese string
    public String removeDiacritics(String vietnameseString) {
        String normalizedString = Normalizer.normalize(vietnameseString, Normalizer.Form.NFD);
        return normalizedString.replaceAll("\\p{M}", "");
    }

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

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String searchValue1 = request.getParameter("query");
        String searchValue2 = request.getParameter("city");
        String searchValue3 = request.getParameter("price");
        HttpSession session = request.getSession();
        City c = new City();
        PostDAO pdb = new PostDAO();
        PostComparator comparator = new PostComparator();


        if (searchValue1 != null) {
            session.removeAttribute("postList_raw");
            searchValue1 = searchValue1.toLowerCase();
            ArrayList<Post> postList1 = pdb.getListPostByAddress(searchValue1);
            ArrayList<Post> postList2 = pdb.getListPostByTitle(searchValue1);
            System.out.println("postList1 " + postList1.size());
            System.out.println("postList2 " + postList2.size());
            if (postList1 != null && postList2 != null) {
                if (postList1.size() > postList2.size()) {
                    Collections.sort(postList1, comparator);
                    session.setAttribute("postList", postList1);
                } else {
                    Collections.sort(postList2, comparator);
                    session.setAttribute("postList", postList2);
                }
            } else if (postList1 != null) {
                Collections.sort(postList1, comparator);
                session.setAttribute("postList", postList1);
            } else if (postList2 != null) {
                Collections.sort(postList2, comparator);
                session.setAttribute("postList", postList2);
            }
        } else if (searchValue2 != null && searchValue3 != null) {
            session.removeAttribute("postList_raw");
            // Handle search by city and price
            ArrayList<Post> postList = pdb.getListPostByCityAndPrice(c.getID(searchValue2), searchValue3);
            if (!postList.isEmpty()) {
                Collections.sort(postList, comparator);
                session.setAttribute("postList", postList);
            } else {
                session.removeAttribute("postList");
                System.out.println("No posts found.");
            }
        } else if (searchValue2 != null) {
            
            session.removeAttribute("postList_raw");
            session.removeAttribute("postList");
            searchValue2= removeDiacritics(searchValue2);
            ArrayList<Post> postList = pdb.getListPostByCityAndPrice(c.getID(searchValue2),"all");
            Collections.sort(postList, comparator);
            session.setAttribute("postList", postList);
            
        } else if (searchValue3 != null) {
            ArrayList<Post> postList_raw;
            if (session.getAttribute("postList_raw") != null && session.getAttribute("postList") != null) {
                postList_raw = (ArrayList<Post>) session.getAttribute("postList_raw");
            } else if (session.getAttribute("postList") != null ) {
                postList_raw = (ArrayList<Post>) session.getAttribute("postList");
            } else if (session.getAttribute("postList_raw") != null) {
                 postList_raw = (ArrayList<Post>) session.getAttribute("postList_raw");
            } else {
                postList_raw = pdb.getAllListPost();
            }

            ArrayList<Post> postList_all = pdb.getAllListPost();
            ArrayList<Post> postList = new ArrayList<>();
            // Prepare the price range variables
            int minPrice = 0;
            int maxPrice = Integer.MAX_VALUE;

            if (searchValue3 != null && !searchValue3.equals("all")) {
                String[] priceRange = searchValue3.split("-");
                if (priceRange.length == 2) {
                    minPrice = Integer.parseInt(priceRange[0]);
                    maxPrice = Integer.parseInt(priceRange[1]);
                }
            }
            for (Post p : postList_all) {
                if (postList_raw.contains(p)) {
                    postList.add(p);
                }
            }
            Iterator<Post> iterator = postList.iterator();
            while (iterator.hasNext()) {
                Post p = iterator.next();
                if (p.getPrice() < minPrice || p.getPrice() > maxPrice) {
                    iterator.remove();
                }
            }
            Collections.sort(postList_raw, comparator);
            Collections.sort(postList, comparator);
            session.setAttribute("postList_raw", postList_raw);
            session.setAttribute("postList", postList);
        }

        // Get all the cookies from the request
        Cookie[] cookies = request.getCookies();
        UserDAO udb = new UserDAO();

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
                        response.sendRedirect(request.getContextPath() + "/home");
                        break;
                    } else {
                        if (request.getSession().getAttribute("username") != null) {
                            session.setMaxInactiveInterval(Integer.MAX_VALUE);
                            session.setAttribute("usertype", u.getUserType());
                            session.setAttribute("username", request.getSession().getAttribute("username"));
                            request.getRequestDispatcher("/findRental.jsp").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/rental.jsp").forward(request, response);
                        }
                    }
                    break; // Exit the loop since we found the desired cookie
                }
            }
            System.out.println("Not found");
            session.removeAttribute("postList_raw");
            session.removeAttribute("postList");
        } else {
            if (request.getSession().getAttribute("username") != null) {
                User u = udb.getUserByUsername((String) request.getSession().getAttribute("username"));
                session.setMaxInactiveInterval(Integer.MAX_VALUE);
                session.setAttribute("username", request.getSession().getAttribute("username"));
                session.setAttribute("usertype", u.getUserType());
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

    }

}
