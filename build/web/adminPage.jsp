<%-- 
    Document   : admin
    Created on : Jul 8, 2023, 2:53:29 AM
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
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <title>Admin</title>
        <!-- Bootstrap core CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <!-- Additional CSS Files -->
        <link rel="stylesheet" href="assets/css/fontawesome.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/owl.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />

        <style>
            html, body{
                background-color: #ffffff;
                height: 100vh;
            }
            

        </style>
    </head>

    <body>

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

                <!-- ***** Menu Start ***** -->
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
                    <li class="effect"><a href="./post">Post</a></li>
                    <li class="effect"><a href="./admin">Admin</a></li> <!-- Add Admin page link -->
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


        <div class="container-fluid background-light" style="margin-top: 70px; margin-bottom: 40px; background-color: #fff; padding: 20px;">

            <ul class="nav nav-tabs mt-5">
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="#posts">Posts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#users">Users</a>
                </li>
            </ul>

            <div class="tab-content mt-3">
                <div class="tab-pane fade show active" id="posts">
                    <h2 class="text-center text-primary">Posts</h2>
                    <!-- Table for displaying list of posts -->
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Post ID</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Address</th>
                                <th>Phone</th>
                                <th>Area</th>
                                <th>N-Room</th>
                                <th>A-Room</th>
                                <th>Price</th>
                                <th>Date</th>
                                <!--<th>Post Date</th>-->
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="postsTableBody">
                            <!-- Search Bar -->
                        <div class="search-bar">
                            <input type="text" id="postSearchQuery" placeholder="Search by title or address">
                            <button type="button" onclick="searchPosts()"><i class="bi bi-search"></i></button>
                        </div>

                        <%-- Iterate over the list of posts and display the information --%>
                        <% 
                           ArrayList<Post> postsList = (ArrayList<Post>) session.getAttribute("postsList");
                           if (postsList != null) {
                                for (Post post : postsList) { 
                        %>
                        <tr>
                            <td><%= post.getPostID() %></td>
                            <td><%= post.getTitle() %></td>
                            <td>
                                <% 
                                    String description = post.getDescription();
                                    int maxLength = 50; // Maximum length of the description

                                    if (description.length() > maxLength) {
                                        String truncatedDescription = description.substring(0, maxLength) + "...";
                                        String fullDescription = description;
                                %>
                                <div class="item-description"> <!-- Add the item-description class here -->
                                    <span class="truncated-description"><%= truncatedDescription %></span>
                                    <span class="full-description" style="display: none;"><%= fullDescription %></span>
                                    <a href="#" class="read-more-link">Read More</a>
                                    <a href="#" class="collapse-link" style="display: none;">Show less</a> <!-- Add the collapse-link with the initial display set to none -->
                                </div>
                                <%
                                    } else {
                                        out.println(description);
                                    }
                                %>
                            </td>

                            <td><%= post.getAddress() %></td>
                            <td><%= post.getPhoneNumber() %></td>
                            <td><%= post.getArea() %></td>
                            <td><%= post.getNumberOfRoom() %></td>
                            <td><%= post.getAvailableRoom() %></td>
                            <td><%= formatCurrency(post.getPrice()) %></td>
                            <td><%= post.getDateString() %></td>
                            <td>
                                <!-- Add action buttons for managing posts (e.g., update, delete) -->
                                <button class="btn btn-primary" onclick="updatePost(<%= post.getPostID() %>)">Update</button>
                                <button class="btn btn-danger" onclick="deletePost(<%= post.getPostID() %>)">Delete</button>
                            </td>
                        </tr>
                        <% }
                            } %>
                        </tbody>
                    </table>

                </div>
                <div class="tab-pane fade" id="users">
                    <h2 class="text-center text-primary">Users</h2>
                    <!-- Table for displaying list of users -->
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Full name</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Phone Number</th>
                                <th>User Type</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="usersTableBody">
                        <div class="search-bar">
                            <input type="text" id="userSearchQuery" placeholder="Search by username or full name">
                            <button type="button" onclick="searchUsers()"><i class="bi bi-search"></i></button>
                        </div>
                        <%-- Iterate over the list of users and display the information --%>
                        <% ArrayList<User> usersList = (ArrayList<User>) session.getAttribute("usersList");
                           if (usersList != null) {
                                for (User u : usersList) { 
                        %>

                        <tr>
                            <td><%= u.getUserId() %></td>
                            <td><%= u.getFullName() %></td>
                            <td><%= u.getUserName() %></td>
                            <td><%= u.getEmail() %></td>
                            <td><%= u.getPhoneNumber() %></td>
                            <td><%= u.getUserType() %></td>
                            <td>
                                <!-- Add action buttons for managing posts (e.g., update, delete) -->
                                <button class="btn btn-primary" onclick="updateUser(<%= u.getUserId() %>)">Update</button>
                                <button class="btn btn-danger" onclick="deleteUser(<%= u.getUserId() %>)">Delete</button>
                            </td>
                        </tr>
                        <% }
                                }
                        %>
                        </tbody>
                    </table>

                </div>
            </div>


        </div>   
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-4 right-logo">
                                <a href="index.html"><img style="object-fit: contain;" src="assets/images/logo3.png" alt="" class="footer-logo" /></a>
                            </div>

                            <div class="col-lg-4 center-info">
                                <h2>Kết nối với chúng tôi</h2>
                                <ul>
                                    <li>Hotline: <a href="tel:0987654321">098.765.4321</a></li>

                                    <li>Email: <a href="mailto:group1@gmail.com" target="_blank">group1@gmail.com</a></li>
                                    <li class="social">
                                        <a href="https://www.facebook.com/" target="_blank">
                                            <i class="bi bi-facebook" style="color: #ffffff; font-size: 20px;" ></i>
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

        <!-- Scripts -->
        <!-- Bootstrap core JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

        <script src="assets/js/isotope.js"></script>
        <script src="assets/js/owl-carousel.js"></script>
        <script src="assets/js/tabs.js"></script>
        <script src="assets/js/popup.js"></script>
        <script src="assets/js/custom.js"></script>
        <script src="assets/js/admin.js"></script>
        <script>
                                    $(document).ready(function () {
                                        $('.dropdown').on('focusin mouseenter', function () {
                                            $(this).addClass('show').find('.dropdown-menu').addClass('show');
                                        }).on('focusout mouseleave', function () {
                                            $(this).removeClass('show').find('.dropdown-menu').removeClass('show');
                                        });

                                        $(document).on("click", ".read-more-link", function (e) {
                                            e.preventDefault();
                                            var container = $(this).closest('.item-description');
                                            container.find(".truncated-description").hide();
                                            container.find(".full-description").show();
                                            $(this).hide(); // Hide the "Read More" link
                                            container.find(".collapse-link").show(); // Show the "Tóm gọn" link
                                        });

                                        $(document).on("click", ".collapse-link", function (e) {
                                            e.preventDefault();
                                            var container = $(this).closest('.item-description');
                                            container.find(".full-description").hide();
                                            container.find(".truncated-description").show();
                                            $(this).hide(); // Hide the "Tóm gọn" link
                                            container.find(".read-more-link").show(); // Show the "Read More" link
                                        });
                                    });



        </script>
    </body>

</html>
