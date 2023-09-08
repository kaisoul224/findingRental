<%-- 
    Document   : rentel.jsp
    Created on : Jul 6, 2023, 3:21:40 PM
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

        <title>Rental</title>

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
                <ul class="nav" style="align-items: center;">
                    <li class="effect"><a href="./home" >Home</a></li>
                    <li class="effect"><a href="./rental" class="active">Rental</a></li>
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
            <!-- ***** Page content Start ***** -->
            <div class="row page-content-find">
                <div class="col-sm-12 col-lg-3 side-content">
                    <form method="POST" action="rental" style="margin-bottom: 30px;">
                        <div class="filter-location">
                            <p>Find by Location</p>
                            <div class="filter-content">
                                <div class="wrapper">
                                    <div class="search-input">
                                        <a href="" target="_blank" hidden></a>
                                        <input id="search_value" name="search_value" type="text" placeholder="Search...">
                                        <div class="autocom-box"></div>
                                        <button class="icon btn btn-unstyled d-flex align-items-center" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="col-lg-12 col-sm-12 filter-price">
                        <p>Find by City</p>
                        <div class="filter-content">
                            <div class="select-btn" style="border-radius: 0 0 7px 7px;">
                                <select name="search_city" id="search_city" style="height: 60px; width: 100%; outline: none; border: none; background: transparent;">
                                    <option selected disabled>Select City</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 col-sm-12 filter-price">
                        <p>Find by Price</p>
                        <div class="filter-content">
                            <ul class="list-items-rental">
                                <li class="rental-item">
                                    <input type="radio" name="price" value="all" id="tat-ca">
                                    <label for="tat-ca">Tất cả</label>
                                </li>
                                <li class="rental-item">
                                    <input type="radio" name="price" value="0-1000000" id="duoi1trieu">
                                    <label for="duoi1trieu">Dưới 1 triệu</label>
                                </li>
                                <li class="rental-item">
                                    <input type="radio" name="price" value="1000000-2000000" id="1-2trieu">
                                    <label for="1-2trieu">1 triệu - 2 triệu</label>
                                </li>
                                <li class="rental-item">
                                    <input type="radio" name="price" value="2000000-3000000" id="2-3trieu">
                                    <label for="2-3trieu">2 triệu - 3 triệu</label>
                                </li>
                                <li class="rental-item">
                                    <input type="radio" name="price" value="3000000-5000000" id="3-5trieu">
                                    <label for="3-5trieu">3 triệu - 5 triệu</label>
                                </li>
                                <li class="rental-item">
                                    <input type="radio" name="price" value="5000000-10000000" id="5-10trieu">
                                    <label for="5-10trieu">5 triệu - 10 triệu</label>
                                </li>
                            </ul>
                        </div>
                    </div>



                </div>


                <div class="col-lg-9 col-sm-12 main-content">

                    <%
                        ArrayList<Post> postList = new ArrayList<Post>();
                        if (session.getAttribute("postList") != null) {
                            postList = (ArrayList<Post>) session.getAttribute("postList");
                        } else {
                            postList = new ArrayList<Post>(); // Initialize with an empty ArrayList
                        }

                        int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
                        int itemsPerPage = 10; // Number of items per page
                        int totalItems = postList.size(); // Total number of items from the database
                        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // Calculate total number of pages

                        int startIndex = (currentPage - 1) * itemsPerPage;
                        int endIndex = Math.min(startIndex + itemsPerPage, totalItems);
                    
                        if (startIndex >= totalItems) {
                    %>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-12 des text-center">
                                <div class="alert alert-danger text-center">
                                    <strong>Không tìm thấy kết quả.</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% 
                        } else {
                            for (int i = startIndex; i < endIndex; i++) {
                                Post post = postList.get(i);
                    %>
                    <div class="item-find">
                        <%
                            String postId = String.valueOf(post.getPostID());
                            String encodedId = java.util.Base64.getEncoder().encodeToString(postId.getBytes());
                        %>
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="./postDetail?id=<%=encodedId%>">
                                    <img src="data:image/png;base64,<%= inputStreamToBase64(post.getUrl()) %>" alt="" class="img-item">
                                </a>
                            </div>
                            <div class="col-md-7 des">
                                <h4 class="title">
                                    <a href="./postDetail?id=<%=encodedId%>"><%=post.getTitle()%></a>
                                </h4>
                                <div class="location">
                                    <p class="address"><%=post.getAddress()%></p>
                                </div>
                                <div class="contact">
                                    <p class="price">Giá: <%= formatCurrency(post.getPrice()) %></p>
                                </div>
                                <div class="post-date">
                                    <p>Post Date: <%= post.getDate() %></p>
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
            <div class="pagination-contain">
                <div style="background-color: #000000;" class="pagination">
                    <% if (currentPage > 1) { %>
                    <a href="rental?page=<%= currentPage - 1 %>" style="color: #fff;" class="pagination-btn">&laquo;</a> <!-- Nút lùi -->
                    <% } %>
                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                    <a href="#" style="color: #ffffff; background-color: #000000; pointer-events: none;" onclick="return false;"><%= i %></a> <!-- Trang hiện tại -->
                    <% } else { %>
                    <a href="rental?page=<%= i %>" style="color: #ffffff; background-color: #000000;" ><%= i %></a>
                    <% } %>
                    <% } %>
                    <% if (currentPage < totalPages) { %>
                    <a href="rental?page=<%= currentPage + 1 %>" style="color: #fff;" class="pagination-btn">&raquo;</a> <!-- Nút tiến -->
                    <% } %>
                </div>
            </div>

            <!-- ***** Page content End ***** -->
        </div>

        <!-- ***** Footer Start ***** -->
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
        <!-- ***** Footer End ***** -->

        <!-- Scripts -->
        <!-- Bootstrap core JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

        <script src="./assets/js/isotope.js"></script>
        <script src="./assets/js/owl-carousel.js"></script>
        <script src="./assets/js/tabs.js"></script>
        <script src="./assets/js/popup.js"></script>
        <script src="./assets/js/custom.js"></script>
        <script src="./assets/js/rental.js"></script>

        <script>
            var databaseData = <%= new Gson().toJson(postList) %>;
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


