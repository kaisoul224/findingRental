package controller.User;

import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import model.User;
import model.Post;

public class ForgotServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/forgot.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        UserDAO udb = new UserDAO();
        User u = udb.getUserByUsername(username);
        HttpSession session = request.getSession();
        try {
            if (u != null) {
                if (u.getEmail().equals(email)) {
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

                        
                        request.setAttribute("message", "OTP is sent to your email ID");
                        session.setAttribute("otp", otpvalue);
                        session.setAttribute("email", email);
                        session.setAttribute("username", username);
                        response.sendRedirect(request.getContextPath() + "/EnterOTP");
                    }
                    
                } else {
                    request.setAttribute("forgetStatus", "warning");
                    request.getRequestDispatcher("forget.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("forgetStatus", "failure");
                request.getRequestDispatcher("forget.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            System.out.println("Could not forget this username");
            e.printStackTrace();
        }
    }
}
