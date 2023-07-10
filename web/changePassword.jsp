<%-- 
    Document   : forgot
    Created on : Jul 6, 2023, 5:53:45 PM
    Author     : kaiso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">


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
                <ul class="nav" style="display: flex; align-items: center;">
                    <li class="effect"><a href="./home" >Home</a></li>
                    <li class="effect"><a href="./rental">Rental</a></li>
                    <li class="effect"><a href="./instruction">Instruction</a></li>
                    <li class="effect"><a href="./register">Register</a></li>
                    <li class="effect"><a href="./login"  class="active">Login</a></li>
                </ul>

                <a class='menu-trigger'>
                    <span>Menu</span>
                </a>
                <!-- ***** Menu End ***** -->
            </nav>
        </header>
        <!-- ***** Header Area End ***** -->


        <div class="container-fluid vh-40" style="margin-top:150px">
            <div class="">
                <div class="rounded d-flex justify-content-center">
                    <div class="col-lg-4 col-md-6 col-sm-12 shadow-lg p-5 bg-light">
                        <div class="text-center">
                            <h3 class="text-primary">Change Password</h3>
                        </div>
                        <form id="changePasswordform" method="POST" action="changePassword">
                            <div class="p-4">
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 36px;"><i class="bi bi-person-plus-fill text-white mr-auto"></i></span>
                                    <input value="${username}" name="username" type="text" class="col-lg-10 col-md-10 col-sm-8 form-control" placeholder="Username" readonly>
                                </div>
                                
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 36px;"><i class="bi bi-key-fill text-white"></i></span>
                                    <input id="password" name="password" type="password" class="form-control" placeholder="Password">
                                </div>
                                
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 36px;"><i class="bi bi-key-fill text-white"></i></span>
                                    <input id="cfpassword" name="cfpassword" type="password" class="form-control" placeholder="Confirm Password">
                                </div>

                                <button class="w-50 mx-auto btn btn-primary text-center mt-2" style="display: flex; justify-content: center;" type="submit">
                                    Change
                                </button>
                                <p class="text-center mt-5">
                                    Don't have an account?
                                    <a href="./login" class="text-primary" style="cursor: pointer;">
                                        Sign In
                                    </a>
                                </p>
                            </div>
                        </form>
                    </div>
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




        <!--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>-->
        <!--<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>-->
        <script>
            $(document).ready(function () {
                $('#changePasswordform').validate({
                    rules: {
                        password: {
                            required: true, // Field is required
                            minlength: 6 // Minimum length of 5 characters
                        },
                        cfpassword: {
                            required: true, // Field is required
                            equalTo: "#password"
                        },
                        // Add more fields and rules as needed
                    },
                    messages: {
                        password: {
                            required: 'Please enter a value for this field',
                            minlength: 'Minimum length is 6 characters'
                        },
                        cfpassword: {
                            required: 'Please enter a value for this field',
                            equalTo: 'Please enter equall password'
                        },
                        // Add more fields and messages as needed
                    }
                });
            });
        </script>
    </body>

</html>

