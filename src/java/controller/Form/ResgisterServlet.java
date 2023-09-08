/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Form;

import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.User;

/**
 *
 * @author Quoc Anh
 */
public class ResgisterServlet extends HttpServlet {

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
            session.removeAttribute("username");
        request.getRequestDispatcher("/register.jsp").forward(request, response);
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
        String password = request.getParameter("password");
        String usertype = "normal";
        UserDAO udb = new UserDAO();
        HttpSession session = request.getSession();
        try {
            if (udb.getUserByUsername(username) == null){
                RequestDispatcher dispatcher = null;
                    int otpvalue = 0;

                    if (email != null && !email.equals("")) {
                        // Sending OTP
                        Random rand = new Random();
                        otpvalue = rand.nextInt(1255650);

                        String to = email; // Change accordingly

                        // Get the session object
                        Properties props = new Properties();
                        props.put("mail.smtp.host", "smtp.gmail.com");
                        props.put("mail.smtp.socketFactory.port", "465");
                        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                        props.put("mail.smtp.auth", "true");
                        props.put("mail.smtp.port", "465");
                        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication("anhnq1130@gmail.com", "syjaegemrckbnxgt"); // Put your email ID and password here
                            }
                        });

                        // Compose message
                        try {
                            MimeMessage message = new MimeMessage(mailSession);
                            message.setFrom(new InternetAddress("your-email@example.com")); // Change accordingly
                            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                            message.setSubject("Hello");
                            message.setText("Your OTP is: " + otpvalue);

                            // Send message
                            Transport.send(message);
                            System.out.println("Message sent successfully");
                        } catch (MessagingException e) {
                            throw new RuntimeException(e);
                        }

                        User uNew = new User(0, fullname, username, password, usertype, phonenumber, email);
                        request.setAttribute("message", "OTP is sent to your email ID");
                        session.setAttribute("otp", otpvalue);
                        session.setAttribute("email", email);
                        
                        
                        
                        session.setAttribute("registerUser", uNew);
                        session.setAttribute("username", username);
                        
                        
                        response.sendRedirect(request.getContextPath() + "/emailverify");
                    }
                
            } else {
                System.out.println("Could not send user register");
                request.setAttribute("registrationStatus", "success");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } catch (IOException e) {
            System.out.println("Could not send user register");
            request.setAttribute("registrationStatus", "failure");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

}
