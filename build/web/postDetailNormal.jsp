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
            .modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .modal-image {
                max-width: 90%;
                max-height: 90%;
            }
        </style>


    </head>

    <body >

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
                <ul class="nav" style="align-items: center;">
                    <li class="effect"><a href="./home" class="active">Home</a></li>
                    <li class="effect"><a href="./rental">Rental</a></li>
                    <li class="effect"><a href="./instruction">Instruction</a></li>
                    <li class="effect"><a href="./register">Register</a></li>
                    <li class="effect"><a href="./login">Login</a></li>
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
        <div class="container" style="background-color: #eee; padding: 20px; margin-top: 70px;">
            <div class="row">
                <div class="col-lg-12">
                    <img style="height: 70vh; object-fit: cover; border-radius: 10px; cursor: pointer;" src="data:image/png;base64,<%= inputStreamToBase64(post.getUrl()) %>" alt="Post Image" class="img-fluid" onclick="showFullImage(this)">
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

            <% 
                if ("admin".equals(session.getAttribute("usertype"))) {
                                                        
            %>
            <div class="row button-group">
                <button class="btn btn-primary" onclick="updatePost(<%= post.getPostID() %>)">Update</button>
                <button class="btn btn-danger" onclick="deletePost(<%= post.getPostID() %>)">Delete</button>
            </div>
            <%
                }
            %>
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
            <div class="row mt-3">
                <div class="col-lg-12">
                    <h4 class="text-primary mb-4">Search the location</h4>
                    <div style="height: 400px;" id="map"></div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-lg-12">
                    <h4 class="text-primary mb-4">Near Rental</h4>
                    <%
                        ArrayList<Post> nearPost = (ArrayList<Post>) session.getAttribute("nearPost");

                        if (nearPost != null) {
                            for (Post npost : nearPost) {
                    %>
                    <div class="col-lg-8" style="margin-bottom: 20px; border-bottom: 1px solid #ccc; padding-bottom: 10px;">
                        <div class="item" style="font-family: 'Arial', sans-serif;">
                            <div class="row">
                                <div class="col-md-4 popular-img">
                                    <img style=" object-fit: cover; border-radius: 10px; width: 100%; height: 150px;" src="data:image/png;base64,<%= inputStreamToBase64(npost.getUrl()) %>" alt="" class="img-popular">
                                </div>
                                <%
                                    String postId = String.valueOf(npost.getPostID());
                                    String encodedId = java.util.Base64.getEncoder().encodeToString(postId.getBytes());
                                %>
                                <div class="col-md-8 popular-des" style="display: flex; flex-wrap: wrap; align-items: flex-start;">
                                    <h4 class="title" style="font-size: 18px;">
                                        <a href="./postDetail?id=<%=encodedId%>"><%= npost.getTitle() %></a>
                                    </h4>
                                    <div class="location">
                                        <dl class="address">
                                            <dt>Address: <%= npost.getAddress() %></dt>
                                        </dl>
                                    </div>
                                    <div class="contact">
                                        <dl class="price">
                                            <dt style="font-size: 15px; color: #666666; font-weight: 400; margin-right: 10px;">Price: <%= formatCurrency(npost.getPrice()) %></dt>
                                        </dl>
                                    </div>
                                    <div class="post-date">
                                        <dl class="date">
                                            <dt style="font-size: 15px; color: #666666; font-weight: 400;">Post Date: <%= npost.getDate() %></dt>
                                        </dl>
                                    </div>
                                    <% 
                                        if ("admin".equals(session.getAttribute("usertype"))) {      
                                    %>
                                    <div class="button-group">
                                        <button class="btn btn-primary" onclick="updatePost(<%= npost.getPostID() %>)">Update</button>
                                        <button class="btn btn-danger" onclick="deletePost(<%= npost.getPostID() %>)">Delete</button>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%
                            }
                        }
                    %>
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



        <script src="assets/js/isotope.js"></script>
        <script src="assets/js/owl-carousel.js"></script>
        <script src="assets/js/tabs.js"></script>
        <script src="assets/js/popup.js"></script>
        <script src="assets/js/custom.js"></script>
        <script src="assets/js/postDetail.js"></script>

        <script>
            var address = '<%= post.getAddress().replaceAll("'", "\\\\'") %>';

            fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(address))
                    .then(response => response.json())
                    .then(data => {
                        if (data.length > 0) {
                            var latitude = parseFloat(data[0].lat);
                            var longitude = parseFloat(data[0].lon);

                            var map = L.map('map').setView([latitude, longitude], 14);

                            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                attribution: '&copy; OpenStreetMap contributors'
                            }).addTo(map);

                            L.marker([latitude, longitude]).addTo(map)
                                    .bindPopup('Your address')
                                    .openPopup();
                        } else {
                            // Default location if address not found
                            var defaultLatitude = 10.8231;
                                var defaultLongitude =  106.6297;

                            var map = L.map('map').setView([defaultLatitude, defaultLongitude], 14);

                            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                attribution: '&copy; OpenStreetMap contributors'
                            }).addTo(map);

                            console.log('No results found');
                        }
                    })
                    .catch(error => {
                        console.log('Error:', error);
                    });
        </script>
    </body>
</html>
