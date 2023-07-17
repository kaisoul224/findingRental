<%-- 
    Document   : post
    Created on : Jul 8, 2023, 3:04:46 AM
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
<%@ page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Post</title>
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
            body{
                background-image: url("https://scontent.fsgn2-4.fna.fbcdn.net/v/t39.30808-6/359827930_1520293782043096_977618124555652208_n.jpg?stp=dst-jpg_s2048x2048&_nc_cat=101&cb=99be929b-59f725be&ccb=1-7&_nc_sid=730e14&_nc_ohc=ZwQXfxPsazoAX96sNee&_nc_ht=scontent.fsgn2-4.fna&oh=00_AfCQuH4l8TlLxOGG4J5wFzYzK8gHXDyxosIKoMzNL3y63A&oe=64B396FE");
                background-repeat: no-repeat;
                background-size: 100% 100%;
                background-position: center;
            }

            .row-change:focus {
                border: 1px solid #00FF00; /* Viền màu xanh khi được chọn */
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
                    user = (String) session.getAttribute("username");

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


        <div class="container-fluid vh-40" style="margin-top:70px; padding-top: 40px;">
            <div id="toast" style="z-index: 1;"></div>
            <% 
                Post post = new Post();
                post = (Post) session.getAttribute("post");                   
            %>

            <div class="">
                <div class="rounded d-flex justify-content-center" style="margin-bottom: 70px;">
                    <div class="col-lg-4 col-md-6 col-sm-12 shadow-lg p-5 background-light"style="width: 80vw; background-color: rgba(255, 255, 255, 0.7); border-radius: 25px;" >
                        <div class="text-center">
                            <h3 class="text-primary">Post</h3>
                        </div>
                        <form id="postform" method="POST" action="post" enctype="multipart/form-data">
                            <div class="p-4">
                                <div class="row input-group mb-3">
                                    <input name="title" type="text" class="form-control" placeholder="Title" value="<%=post.getTitle() %>">
                                </div>
                                <div class="row input-group mb-3" style="height: 15vh;">
                                    <textarea style="height: 100%; resize: vertical;" name="description" class="form-control" placeholder="Description"><%=post.getDescription() %></textarea>
                                </div>

                                <div class="row input-group mb-3">
                                    <div class="col-lg-4 col-sm-12 d-flex" style="padding-left: 0;">
                                        <select name="city" id="citySelect" class="w-100 form-select" aria-label="City">
                                            <option selected disabled>Select a city</option>
                                            <!-- Add options dynamically using JavaScript -->
                                        </select>
                                    </div>
                                    <div class="col-lg-8 col-sm-12" style="padding-right: 0;">
                                        <input name="address" type="text" class="w-100 form-control" placeholder="Address detail"  value="<%=post.getAddress() %>">
                                    </div>
                                </div>

                                <div class="row input-group mb-3">
                                    <input name="phoneNumber" type="text" class="form-control" placeholder="Phone Number" value="<%=post.getPhoneNumber() %>">
                                </div>
                                <div class="row input-group mb-3">
                                    <input name="area" type="text" class="form-control" placeholder="Area" value="<%=post.getArea() %>">
                                </div>
                                <div class="row input-group mb-3">
                                    <input name="numberOfRoom" type="text" class="form-control" placeholder="Number Of Room" value="<%=post.getNumberOfRoom() %>">
                                </div>
                                <div class="row input-group mb-3">
                                    <input name="availableRoom" type="text" class="form-control" placeholder="Available Room" value="<%=post.getAvailableRoom() %>">
                                </div> 
                                <div class="row input-group mb-3">
                                    <input name="price" type="text" class="form-control" placeholder="Price" value="<%=post.getPrice() %>">
                                </div> 
                                <div class="row input-group mb-3">
                                    <input name="image" type="file" class="form-control">
                                </div>

                                <button class="w-50 mx-auto btn btn-primary text-center mt-2" style="display: flex; justify-content: center;" type="submit">
                                    Update Post
                                </button>

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
        <script src="./assets/js/toast.js"></script>
        <script src="./assets/js/post.js"></script>

        <script>
            if ("${requestScope.registrationStatus}" === "failure") {
                showErrorRegister();
            <%
                request.setAttribute("registrationStatus", null);
            %>
            }

            $(document).ready(function () {
                $('#postform').validate({
                    rules: {
                        // Define validation rules for your form fields
                        title: {
                            required: true, // Field is required
                            minlength: 5, // Minimum length of 5 characters
                            maxlength: 100
                        },
                        description: {
                            required: true, // Field is required
                            maxlength: 1000,
                        },
                        address: {
                            required: true, // Field is required
                            minlength: 5,
                            maxlength: 500,
                        },
                        phoneNumber: {
                            required: true, // Field is required
                            number: true,
                            maxlength: 10,
                        },
                        area: {
                            required: true,
                            number: true
                        },
                        numberOfRoom: {
                            required: true, // Field is required
                            number: true // Minimum length of 5 characters
                        },
                        availableRoom: {
                            required: true, // Field is required
                            number: true // Minimum length of 5 characters
                        },
                        price: {
                            required: true, // Field is required
                            number: true // Minimum length of 5 characters
                        },
                        image: {
                            required: true, // Field is required
                        },

                        // Add more fields and rules as needed
                    },
                    messages: {
                        // Define error messages for your form fields
                        title: {
                            required: 'Please enter a value for this field',
                            minlength: 'Minimum length is 6 characters',
                            maxlength: 'Minimum length is 100 characters'
                        },
                        description: {
                            required: 'Please enter a value for this field',
                            maxlength: 'Minimum length is 1000 characters'
                        },
                        address: {
                            required: 'Please enter a value for this field',
                            minlength: 'Minimum length is 6 characters',
                            maxlength: 'Minimum length is 500 characters'
                        },
                        phoneNumber: {
                            required: 'Please enter a value for this field',
                            number: 'Please enter a valid number',
                            maxlength: 'Minimum length is 10 characters'
                        },
                        area: {
                            required: 'Please enter a value for this field',
                            number: 'Please enter a valid number'
                        },
                        numberOfRoom: {
                            required: 'Please enter a value for this field',
                            number: 'Please enter a valid number'
                        },
                        availableRoom: {
                            required: 'Please enter a value for this field',
                            number: 'Please enter a valid number'
                        },
                        price: {
                            required: 'Please enter a value for this field',
                            number: 'Please enter a valid number'
                        },
                        image: {
                            required: 'Please enter a value for this field',
                        },

                        // Add more fields and messages as needed
                    }
                });
            });

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


