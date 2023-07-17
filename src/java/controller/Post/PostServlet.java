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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.text.Normalizer;
import java.time.LocalDate;
import model.City;
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
                    UserDAO udb = new UserDAO();
                    User u = udb.check(username, password);
                    if (u != null) {
                        HttpSession session = request.getSession();
                        session.setMaxInactiveInterval(Integer.MAX_VALUE);
                        session.setAttribute("username", username);
                        session.setAttribute("login", "true");
                        response.sendRedirect(request.getContextPath() + "/post");
                        break;
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
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
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String address = request.getParameter("address");
        String cityID_raw = request.getParameter("city");
        String phoneNumber = request.getParameter("phoneNumber");
        String area_raw = request.getParameter("area");
        String numberOfRoom_raw = request.getParameter("numberOfRoom");
        String availableRoom_raw = request.getParameter("availableRoom");
        String price_raw = request.getParameter("price");
        
        Part part = request.getPart("image");
        PostDAO pdb = new PostDAO();
        UserDAO udb = new UserDAO();
        City c = new City();
        if (part != null) {
            try {
                double area = Double.parseDouble(area_raw);
                int cityID = c.getID(removeDiacritics(cityID_raw));
                int numberOfRoom = Integer.parseInt(numberOfRoom_raw);
                int availableRoom = Integer.parseInt(availableRoom_raw);
                int price = Integer.parseInt(price_raw);
                InputStream is = part.getInputStream();
                LocalDate localDate = LocalDate.now();
                Cookie[] cookies = request.getCookies();
                if (cookies != null && request.getSession().getAttribute("login") != null) {
                    System.out.println("CCCCCC");
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("login")) {
                            // Read the value of the "account" cookie
                            String username = cookie.getValue();
                            System.out.println("Username: " + username);
                            int userid = udb.getUserByUsername(username).getUserId();
                            Post newP = new Post(0, title, description, address, phoneNumber, area, numberOfRoom, availableRoom, price, localDate, userid, cityID, is);
                            pdb.insertPost_forUser(newP);
                            pdb.insertImage_forUser(newP);
                            response.sendRedirect(request.getContextPath() + "/postDetail?id="+pdb.getNewestID());
                            break; // Exit the loop since we found the desired cookie
                        }
                    }
                }
            } catch (IOException | NumberFormatException e) {
                System.out.println("Could not save this post");
                System.out.println(e);
                request.setAttribute("postStatus", "failure");
                request.getRequestDispatcher("/post.jsp").forward(request, response);
            }
        }
    }

}
