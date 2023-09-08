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
import java.util.Base64;
import model.City;
import model.Post;
import model.User;

/**
 *
 * @author Quoc Anh
 */
@MultipartConfig(maxFileSize = 16177216) // up to 16mb
public class UpdatePostServlet extends HttpServlet {

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
        String id_raw = request.getParameter("id");
        int id = Integer.parseInt(new String(Base64.getDecoder().decode(id_raw)));
        Post post = new Post();
        PostDAO pdb = new PostDAO();
        post = pdb.getPostByID(id);
        HttpSession session = request.getSession();
        session.setAttribute("post", post);

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
                    System.out.println("username " + username);
                    System.out.println("password " + password);
                    UserDAO udb = new UserDAO();
                    User u = udb.check(username, password);
                    if (u != null) {
                        session.setMaxInactiveInterval(Integer.MAX_VALUE);
                        session.setAttribute("username", username);
                        session.setAttribute("login", "true");
                        request.getRequestDispatcher("/updatePost.jsp").forward(request, response);
                        break;
                    } else {
                        System.out.println("CCCCC");
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                    break; // Exit the loop since we found the desired cookie
                }
            }
        } else {
            if (request.getSession().getAttribute("username") != null) {
                UserDAO udb = new UserDAO();
                String username = (String) request.getSession().getAttribute("username");
                User u = udb.getUserByUsername(username);
                request.setAttribute("data", u);
                session.setMaxInactiveInterval(Integer.MAX_VALUE);
                session.setAttribute("username", username);
                request.getRequestDispatcher("/updatePost.jsp").forward(request, response);
            } else {
                System.out.println("YYYYYYYY");
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
        boolean hasImage = part != null && part.getSize() > 0;
        
        PostDAO pdb = new PostDAO();
        UserDAO udb = new UserDAO();
        City c = new City();

        try {
            double area = Double.parseDouble(area_raw);
            int cityID;
            Post post = new Post();
            post = (Post) request.getSession().getAttribute("post");
            if (cityID_raw != null) {
                cityID = c.getID(removeDiacritics(cityID_raw));
            } else {
                cityID = post.getCityID();
                System.out.println("cityID " + cityID);
            }
            InputStream is = null;
            if (hasImage) {
                is = part.getInputStream();
            } 

            int numberOfRoom = Integer.parseInt(numberOfRoom_raw);
            int availableRoom = Integer.parseInt(availableRoom_raw);
            int price = Integer.parseInt(price_raw);
            
            LocalDate localDate = LocalDate.now();
            Cookie[] cookies = request.getCookies();
            if (cookies != null && request.getSession().getAttribute("login") != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("login")) {
                        // Read the value of the "account" cookie
                        String username = cookie.getValue();
                        System.out.println("Username: " + username);
                        int userid = udb.getUserByUsername(username).getUserId();
                        Post newP = new Post(post.getPostID(), title, description, address, phoneNumber, area, numberOfRoom, availableRoom, price, localDate, userid, cityID, is);
                        pdb.updatePost_forUser(newP);
                        if (is != null) {
                            System.out.println("image " + is.toString());
                            pdb.updateImage_forUser(newP);
                        }
                        String encodedId = Base64.getEncoder().encodeToString(String.valueOf(newP.getPostID()).getBytes());
                        request.setAttribute("updateStatus", "success");
                        response.sendRedirect(request.getContextPath() + "/postDetail?id=" + encodedId);
                        break; // Exit the loop since we found the desired cookie
                    }
                }
            }
        } catch (IOException | NumberFormatException e) {
            System.out.println("Could not save this post");
            System.out.println(e);
            request.setAttribute("updateStatus", "failure");
            request.getRequestDispatcher("/post.jsp").forward(request, response);
        }

    }

}
