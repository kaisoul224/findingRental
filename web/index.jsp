<%-- 
    Document   : index
    Created on : Jul 6, 2023, 2:31:47 AM
    Author     : Tan Phat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.text.DecimalFormat, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Base64" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="model.Post" %>
<%@ page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <title>Home</title>

        <!-- Bootstrap core CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">

        <!-- Additional CSS Files -->
        <link rel="stylesheet" href="./assets/css/fontawesome.css">
        <link rel="stylesheet" href="./assets/css/style.css">
        <link rel="stylesheet" href="./assets/css/owl.css">
        <link rel="stylesheet" href="./assets/css/animate.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />
        <style>
            .logo img {
                width: 100%;
                height: auto;
                max-height: 100px; /* Adjust the maximum height as needed */
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
                    <img style="object-fit: contain;" src="./assets/images/logo3.png" alt="">
                </a>
                <!-- ***** Logo End ***** -->

                <!-- ***** Menu Start ***** -->
                <ul class="nav" style=" align-items: center;">
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

        <div class="container">
            <div id="toast" style="z-index: 1000000;"></div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="page-content">

                        <!-- ***** Banner Start ***** -->
                        <div class="main-banner">
                            <div class="row">
                                <div class="col-lg-7">

                                    <div class="header-text">
                                        <h6>Better Call Saul</h6>
                                        <h4>Everything You Need<br><em> All Right Here</em></h4>
                                    </div>
                                </div>

                            </div>

                            <div class="search-area">

                                <div class="row contain" style="margin: 0;">
                                    <form class="col-sm-12" style="width: 100%;" method="POST" action="home" onsubmit="return validateForm()">
                                        <div class="search-bar" style="height: 40px;">
                                            <input name="search_home" id="search_home" class="input-content" type="text" placeholder="Search">
                                            <button style="border: none; outline: none; background: none; padding: 0;" type="submit">
                                                <i class="fa fa-search" style="color: #000000;"></i>
                                            </button>
                                        </div>
                                    </form>


                                    <div class="row">
                                        <div class="col">
                                            <div class="search-button">
                                                <form method="POST" action="home">
                                                    <div class="row">
                                                        <div class="col-lg-5 col-sm-12"">
                                                            <div class="wrapper">
                                                                <div class="select-btn">
                                                                    <input type="text" name="search_city" id="search_city" value="Select City"
                                                                           style="padding-left: 25px; outline: none; border: none; background: transparent;"
                                                                           readonly>
                                                                    <span class="arrow-dwn">
                                                                        <i class="fa fa-angle-down"></i>
                                                                    </span>
                                                                </div>
                                                                <div class="content">
                                                                    <div class="search">
                                                                        <i class="uil uil-search"></i>
                                                                        <input spellcheck="false" type="text" placeholder="Search">
                                                                    </div>
                                                                    <ul style="max-height: 110px;" class="options"></ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-5 col-sm-12">
                                                            <div class="container-holder">
                                                                <div class="select-button">
                                                                    <input type="text" name="search_price" id="search_price" class="btn-text"
                                                                           value="Select Rental Price"
                                                                           style="padding-left: 25px; outline: none; border: none; background: transparent;"
                                                                           readonly>
                                                                    <span class="arrow-dwn">
                                                                        <i class="fa fa-angle-down"></i>
                                                                    </span>
                                                                </div>
                                                                <div class="list-items" style="max-height: 210px; overflow-y: scroll;">
                                                                    <ul>
                                                                        <li class="item">
                                                                            <input type="radio" name="price" value="all" id="tat-ca">
                                                                            <label for="tat-ca">Tất cả</label>
                                                                        </li>
                                                                        <li class="item">
                                                                            <input type="radio" name="price" value="0-1000000" id="duoi1trieu">
                                                                            <label for="duoi1trieu">Dưới 1 triệu</label>
                                                                        </li>
                                                                        <li class="item">
                                                                            <input type="radio" name="price" value="1000000-2000000" id="1-2trieu">
                                                                            <label for="1-2trieu">1 triệu - 2 triệu</label>
                                                                        </li>
                                                                        <li class="item">
                                                                            <input type="radio" name="price" value="2000000-3000000" id="2-3trieu">
                                                                            <label for="2-3trieu">2 triệu - 3 triệu</label>
                                                                        </li>
                                                                        <li class="item">
                                                                            <input type="radio" name="price" value="3000000-5000000" id="3-5trieu">
                                                                            <label for="3-5trieu">3 triệu - 5 triệu</label>
                                                                        </li>
                                                                        <li class="item">
                                                                            <input type="radio" name="price" value="5000000-10000000" id="5-10trieu">
                                                                            <label for="5-10trieu">5 triệu - 10 triệu</label>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-2 col-sm-12">
                                                            <div class="apply-box-container">
                                                                <div class="apply-button">
                                                                    <button type="submit" class="btn">Search</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>

                    </div>
                    <!-- ***** Banner End ***** -->
                    <!-- Search box End -->

                    <!-- ***** Most Popular Start ***** -->
                    <div class="most-popular">
                        <div class="row">
                            <div class="col-lg-12">

                                <div class="heading-section">
                                    <h4>MOST POPULAR</h4>
                                </div>


                                <div class="row">
                                    <%
                                        ArrayList<Post> newestPost = (ArrayList<Post>) session.getAttribute("newestPost");

                                        if (newestPost != null) {
                                            for (Post post : newestPost) {
                                    %>
                                    <div class="col-lg-6">
                                        <div class="item" style="font-family: 'Arial', sans-serif;">
                                            <div class="row">
                                                <div class="col-md-5 popular-img">
                                                    <img src="data:image/png;base64,<%= inputStreamToBase64(post.getUrl()) %>" alt="" class="img-popular">
                                                </div>
                                                <%
                                                    String postId = String.valueOf(post.getPostID());
                                                    String encodedId = java.util.Base64.getEncoder().encodeToString(postId.getBytes());
                                                %>
                                                <div class="col-md-7 popular-des" style="display: flex; flex-wrap: wrap; align-items: flex-start;">
                                                    <h4 class="title" style="font-size: 18px;">
                                                        <a href="./postDetail?id=<%=encodedId%>"><%= post.getTitle() %></a>
                                                    </h4>
                                                    <div class="location">
                                                        <dl class="address">
                                                            <dt>Address: <%= post.getAddress() %></dt>
                                                        </dl>
                                                    </div>
                                                    <div class="contact">
                                                        <dl class="price">
                                                            <dt>Price: <%= formatCurrency(post.getPrice()) %></dt>
                                                        </dl>
                                                    </div>
                                                        <div class="post-date" style="margin-top: 10px; margin-left: 5px;">
                                                        <p>Post Date: <%= post.getDate() %></p>
                                                    </div>
                                                    <% 
                                                        if ("admin".equals(session.getAttribute("usertype"))) {
                                                        
                                                    %>
                                                    <div class="button-group">
                                                        <button class="btn btn-primary" onclick="updatePost(<%= post.getPostID() %>)">Update</button>
                                                        <button class="btn btn-danger" onclick="deletePost(<%= post.getPostID() %>)">Delete</button>
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
                                <div class="col-lg-12">
                                    <div class="main-button">
                                        <a href="./rental">MORE</a>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- ***** Most Popular End ***** -->

                    <!-- ***** Hot Recommended Start *****-->
                    <div class="hot-search">
                        <div class="col-lg-12">
                            <div class="heading-section">
                                <h4>HOT RECOMMENDED</h4>
                            </div>
                            <%
                                ArrayList<Post> priciestPost = (ArrayList<Post>) session.getAttribute("priciestPost");

                                if (priciestPost != null) {
                                    for (Post post : priciestPost) {
                            %>
                            <div class="item" style="font-family: 'Arial', sans-serif;">
                                <div class="row" style="border-radius: 10px;">
                                    <div class="col-md-5 picture" style="object-fit: contain;">
                                        <img src="data:image/png;base64,<%= inputStreamToBase64(post.getUrl()) %>" alt="" class="img-hot">
                                    </div>
                                    <%
                                        String postId = String.valueOf(post.getPostID());
                                        String encodedId = java.util.Base64.getEncoder().encodeToString(postId.getBytes());
                                    %>
                                    <div class="col-md-7 describe">
                                        <h4 class="title">
                                            <a href="./postDetail?id=<%=encodedId%>" style="font-size: 22px;" href="rental.html"><%= post.getTitle() %></a>
                                        </h4>
                                        <div class="location">
                                            <dl  class="address">
                                                <dt>Address: <%= post.getAddress() %></dt>
                                            </dl>
                                        </div>

                                        <div class="contact">
                                            <dl class="price">
                                                <dt>Price: <%= formatCurrency(post.getPrice()) %></dt>
                                            </dl>
                                        </div>
                                        <div class="post-date">
                                            <p>Post Date: <%= post.getDate() %></p>
                                        </div>
                                        <% 
                                        if ("admin".equals(session.getAttribute("usertype"))) {
                                        %>
                                        <div class="button-group">
                                            <button class="btn btn-primary" onclick="updatePost(<%= post.getPostID() %>)">Update</button>
                                            <button class="btn btn-danger" onclick="deletePost(<%= post.getPostID() %>)">Delete</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>

                            <div class="col-lg-12">
                                <div class="main-button">
                                    <a href="./rental">MORE</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ***** Hot Recommended End ***** -->
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
        <!--<script src="./vendor/jquery/jquery.min.js"></script>-->
        <!--<script src="./vendor/bootstrap/js/bootstrap.min.js"></script>-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"></script>
        <script src="./assets/js/isotope.js"></script>
        <script src="./assets/js/owl-carousel.js"></script>
        <script src="./assets/js/tabs.js"></script>
        <script src="./assets/js/popup.js"></script>
        <script src="./assets/js/custom.js"></script>
        <script src="./assets/js/selectBox.js"></script>
        <script src="./assets/js/checkBox.js"></script>
        <script src="./assets/js/home.js"></script>
        <script src="./assets/js/toast.js"></script>

        <script>
                                                if ("${requestScope.deleteStatus}" === "failure") {
                                                    showErrorDelete();
            <%
                request.setAttribute("deleteStatus", null);
            %>
                                                } else if ("${requestScope.deleteStatus}" === "success") {
                                                    showSuccessDelete();
            <%
                request.setAttribute("deleteStatus", null);
            %>
                                                }

                                                $(document).ready(function () {
                                                    $('.dropdown').on('focusin mouseenter', function () {
                                                        $(this).addClass('show').find('.dropdown-menu').addClass('show');
                                                    }).on('focusout mouseleave', function () {
                                                        $(this).removeClass('show').find('.dropdown-menu').removeClass('show');
                                                    });
                                                });
        </script>
    </body>

</html>
