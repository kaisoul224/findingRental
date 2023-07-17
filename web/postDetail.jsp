<%-- 
    Document   : postDetail
    Created on : Jul 16, 2023, 7:36:09 PM
    Author     : Quoc Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.text.DecimalFormat, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Base64" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="model.Post" %>
<%@ page import="model.User" %>
<%@ page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
        <title>Information</title>
        <!-- Bootstrap core CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">


        <!-- Additional CSS Files -->
        <link rel="stylesheet" href="assets/css/fontawesome.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/owl.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />

        <style>
            .footer {
                margin-top: 70px;
            }
        </style>

    </head>

    <body  onload="initMap()">

        <%! 
            public String inputStreamToBase64(InputStream inputStream) throws IOException {
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                byte[] imageBytes = outputStream.toByteArray();
                return Base64.getEncoder().encodeToString(imageBytes);
            }

            public String formatCurrency(double price) {
                NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);
                DecimalFormat decimalFormat = (DecimalFormat) formatter;
                decimalFormat.applyPattern("#,### VNĐ");
                return decimalFormat.format(price);
            }
        %>

        <!-- ***** Preloader Start ***** -->
        <div id="js-preloader" class="js-preloader">
            <div class="preloader-inner">
                <span class="dot"></span>
                <div class="dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </div>
        <!-- ***** Preloader End ***** -->

        <!-- ***** Header Area Start ***** -->
        <header class="header-area">
            <nav class="container main-nav">
                <!-- ***** Logo Start ***** -->
                <a href="./home" class="logo">
                    <!--<img src="../src/java/imgs/logo2.jpg" alt="">-->
                    <img style="object-fit: contain;" src="./assets/images/logo3.png" alt="">
                </a>
                <!-- ***** Logo End ***** -->

                <% 
                    String user = null;
                    HttpSession section = request.getSession(false);
                    if (session != null) {
                        user = (String) session.getAttribute("username");
                    } 
                %>

                <!-- ***** Menu Start ***** -->
                <ul class="nav" style="display: flex; align-items: center;">
                    <li class="effect"><a href="./home" class="active">Home</a></li>
                    <li class="effect"><a href="./rental">Rental</a></li>
                    <li class="effect"><a href="./instruction">Instruction</a></li>
                    <li class="effect"><a href="./post">Post</a></li>
                        <% 
                            if ("admin".equals(session.getAttribute("usertype"))) {
                        %>
                    <li class="effect"><a href="./admin">Admin</a></li>
                        <%
                            }
                        %>
                    <li class="dropdown">
                        <a class="nav-link dropdown-toggle" href="" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-user"></i> <%= user %>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="./profile">Profile</a>
                            <a class="dropdown-item" href="./post">Post</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="./login">Logout</a>
                        </div>
                    </li>
                </ul>

                <a class='menu-trigger'>
                    <span>Menu</span>
                </a>
                <!-- ***** Menu End ***** -->
            </nav>
        </header>
        <!-- ***** Header Area End ***** -->
        <% 
            Post post = (Post) request.getAttribute("post"); 
            User userOfPost = (User) request.getAttribute("userOfPost"); 
        %>
        <!-- ***** BODY Area Start ***** -->
        <div class="container" style="background-color: white; padding: 20px; margin-top: 70px;">
            <div class="row">
                <div class="col-lg-12">
                    <img style="height: 70vh; object-fit: cover; border-radius: 10px;" src="data:image/png;base64,<%= inputStreamToBase64(post.getUrl()) %>" alt="Post Image" class="img-fluid">
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-12">
                    <h2 class="text-primary"><%= post.getTitle()%></h2>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-12">
                    <p><%= post.getDescription()%></p>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-6">
                    <table class="table">
                        <tbody>
                            <tr>
                                <th scope="row">Address</th>
                                <td><%= post.getAddress() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Price</th>
                                <td><%= formatCurrency(post.getPrice()) %> /1 Tháng</td>
                            </tr>
                            <tr>
                                <th scope="row">Area</th>
                                <td><%= post.getArea() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Number of Rooms</th>
                                <td><%= post.getNumberOfRoom() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Available Rooms</th>
                                <td><%= post.getAvailableRoom() %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-lg-6">
                    <table class="table">
                        <tbody>
                            <tr>
                                <th scope="row">Name</th>
                                <td><%= userOfPost.getFullName() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Phone Number</th>
                                <td><%= userOfPost.getPhoneNumber() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Email</th>
                                <td><%= userOfPost.getEmail() %></td>
                            </tr>
                            <tr>
                                <th scope="row">Date</th>
                                <td><%= post.getDate() %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-12">
                    <h4 class="text-primary mb-4">Contact the Host</h4>
                    <ul class="list-unstyled contact-options" style="display: flex; justify-content: space-around;">
                        <li>
                            <i class="bi bi-envelope"></i>
                            <a href="mailto:<%= userOfPost.getEmail() %>" class="contact-link">Contact via Email</a>
                        </li>
                        <li>
                            <i class="bi bi-telephone"></i>
                            <a href="tel:<%= userOfPost.getPhoneNumber() %>" class="contact-link">Contact via Phone</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="map" style="z-index: 100000000;"></div>   
            <div class="row mt-3">
                <div class="col-lg-12">
                    <h4 class="text-primary mb-4">Search Location</h4>
                    <div class="input-group">
                        <input id="search-location" type="text" class="form-control" placeholder="Enter a location" value="<%= post.getAddress() %>">
                        <button class="btn btn-primary" type="button" onclick="searchLocation()">Search</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ***** BODY Area End ***** -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-4 right-logo">
                                <a href="index.html"><img style="object-fit: contain;" src="assets/images/logo3.png"
                                                          alt="" class="footer-logo" /></a>
                            </div>

                            <div class="col-lg-4 center-info">
                                <h2>Kết nối với chúng tôi</h2>
                                <ul>
                                    <li>Hotline: <a href="tel:0987654321">098.765.4321</a></li>

                                    <li>Email: <a href="mailto:group1@gmail.com"
                                                  target="_blank">group1@gmail.com</a></li>
                                    <li class="social">
                                        <a href="https://www.facebook.com/" target="_blank">
                                            <i class="bi bi-facebook" style="color: #ffffff; font-size: 20px;"></i>
                                        </a>
                                        <a href="https://www.youtube.com/" target="_blank">
                                            <i class="bi bi-youtube" style="color: #ffffff; font-size: 20px;"></i>
                                        </a>
                                        <a href="https://www.instagram.com" target="_blank">
                                            <i class="bi bi-instagram" style="color: #ffffff; font-size: 20px;"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <div class="col-lg-4 left-contact">
                                <p>Copyright © 2023 <a href="#">Group 1</a> Company. <br>All rights reserved.</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>


        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAVUwRXJYeKMiRdG6zZ1GQFiSGuWGOgU"></script>

        <!-- Scripts -->
        <!-- Bootstrap core JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

        <!--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAVUwRXJYeKMiRdG6zZ1GQFiSGuWGOgU&libraries=places&callback=initMap" async defer></script>-->
        <!--        <script async
                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAVUwRXJYeKMiRdG6zZ1GQFiSGuWGOgU&callback=initMap">
                </script>-->
        <script>
            // Create a map
            var map = new google.maps.Map(document.getElementById("map"), {
                center: new google.maps.LatLng(40.748437, -73.985669),
                zoom: 15
            });

            // Create a marker
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(40.748437, -73.985669),
                map: map
            });
        </script>
        <script src="assets/js/isotope.js"></script>
        <script src="assets/js/owl-carousel.js"></script>
        <script src="assets/js/tabs.js"></script>
        <script src="assets/js/popup.js"></script>
        <script src="assets/js/custom.js"></script>
        <script src="assets/js/postDetail.js"></script>
    </body>
</html>
