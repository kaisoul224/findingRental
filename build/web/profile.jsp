<%-- 
    Document   : register
    Created on : Jul 6, 2023, 3:42:34 PM
    Author     : Quoc Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" integrity="sha512-1sCRPdkRXhBV2PBLUdRb4tMg1w2YPf37qatUFeS7zlBy7jJI8Lf4VHwWfZZfpXtYSLy85pkm9GaYVYMfw5BC1A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- Additional CSS Files -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
              <link rel="stylesheet" href="assets/css/fontawesome.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/owl.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />
        <style>
            @media screen and (min-width: 1920px) {
               .footer {
                   position: fixed;
                   left: 0;
                   bottom: 0;
                   width: 100%;
                   background-color: #f8f8f8;
               }
           }

           @media screen and (max-width: 16in) {
               .footer {
                   margin-top: 70px;
               }
           }
        </style>
    </head>

    <body>


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


        <div class="container-fluid vh-40" style="margin-top: 150px;">
    <div id="toast" style="z-index: 1;"></div>
    <div class="d-flex justify-content-center align-items-center">
        <div class="col-lg-4 col-md-6 col-sm-12 shadow-lg p-5 background-light rounded" style="background-color: rgba(255, 255, 255, 0.5); border-radius: 25px;">
            <div class="text-center">
                <h3 class="text-primary">Your Profile</h3>
            </div>
            <% User u = (User) request.getAttribute("data"); %>
            <form id="profileform" method="POST">
                <div class="p-4">
                    <div class="mb-3">
                        <div class="input-group">
                            <span class="input-group-text bg-primary"><i class="bi bi-person-plus-fill text-white"></i></span>
                            <input name="fullname" type="text" class="form-control" placeholder="Full Name" readonly value="<%= u.getFullName() %>">
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="input-group">
                            <span class="input-group-text bg-primary"><i class="bi bi-person-plus-fill text-white"></i></span>
                            <input name="username" type="text" class="form-control" placeholder="User Name" readonly value="<%= u.getUserName() %>">
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="input-group">
                            <span class="input-group-text bg-primary"><i class="bi bi-phone text-white"></i></span>
                            <input name="phoneNumber" type="text" class="form-control" placeholder="Phone Number" readonly value="<%= u.getPhoneNumber() %>">
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="input-group">
                            <span class="input-group-text bg-primary"><i class="bi bi-envelope text-white"></i></span>
                            <input name="email" type="email" class="form-control" placeholder="Email" readonly value="<%= u.getEmail() %>">
                        </div>
                    </div>
                    
                </div>
            </form>
            <div class="mb-3">
                <a class="btn btn-primary w-100" href="./changeInfo">
                    Change Information
                </a>
            </div>
            <div>
                <a class="btn btn-primary w-100" href="./changePassword">
                    Change Password
                </a>
            </div>

        </div>
    </div>
</div>



        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row mr-bottom-0">
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

        <script src="./assets/js/isotope.js"></script>
        <script src="./assets/js/owl-carousel.js"></script>
        <script src="./assets/js/tabs.js"></script>
        <script src="./assets/js/popup.js"></script>
        <script src="./assets/js/custom.js"></script>
        
        <script>
            $(document).ready(function() {
                $('.dropdown').on('focusin mouseenter', function() {
                    $(this).addClass('show').find('.dropdown-menu').addClass('show');
                }).on('focusout mouseleave', function() {
                    $(this).removeClass('show').find('.dropdown-menu').removeClass('show');
                });
            });
        </script>
    </body>

</html>


