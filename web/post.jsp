<%-- 
    Document   : post
    Created on : Jul 8, 2023, 3:04:46 AM
    Author     : Quoc Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                <ul class="nav" style="display: flex; align-items: center;">
                    <li class="effect"><a href="./home" class="active">Home</a></li>
                    <li class="effect"><a href="./rental">Rental</a></li>
                    <li class="effect"><a href="./instruction">Instruction</a></li>
                    <li class="effect"><a href="./post">Post</a></li>
                    <li class="effect"><a href="./login">Logout</a></li>
                    <li class="effect">
                        <a class="nav-link" href="#">
                            <i class="fas fa-user"></i> <%= user %>
                        </a>
                    </li>
                </ul>

                <a class='menu-trigger'>
                    <span>Menu</span>
                </a>
                <!-- ***** Menu End ***** -->
            </nav>
        </header>
        <!-- ***** Header Area End ***** -->


        <div class="container-fluid vh-40" style="margin-top:150px">
            <div id="toast" style="z-index: 1;"></div>
            <div class="">
                <div class="rounded d-flex justify-content-center" style="margin-bottom: 70px;">
                    <div class="col-lg-4 col-md-6 col-sm-12 shadow-lg p-5 bg-light">
                        <div class="text-center">
                            <h3 class="text-primary">Post</h3>
                        </div>
                        <form id="postform" method="POST" action="post">
                            <div class="p-4">
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 40px;"><i class="bi bi-person-plus-fill text-white"></i></span>
                                    <input name="title" type="text" class="form-control" placeholder="Title">
                                </div>
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 40px;"><i class="bi bi-person-plus-fill text-white"></i></span>
                                    <input name="description" type="text" class="form-control" placeholder="Description">
                                </div>
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 40px;"><i class="bi bi-phone text-white"></i></span>
                                    <input name="address" type="text" class="form-control" placeholder="Address">
                                </div>
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 40px;"><i class="bi bi-phone text-white"></i></span>
                                    <input name="phoneNumber" type="text" class="form-control" placeholder="Phone Number">
                                </div>
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 40px;"><i class="bi bi-envelope text-white"></i></span>
                                    <input name="numberOfRoom" type="email" class="form-control" placeholder="Number Of Room">
                                </div>
                                <div class="row input-group mb-3">
                                    <span class="input-group-text bg-primary" style="width: 40px;"><i class="bi bi-key-fill text-white"></i></span>
                                    <input name="availableRoom" type="password" class="form-control" placeholder="Available Room">
                                </div>                           

                                <button class="w-50 mx-auto btn btn-primary text-center mt-2" style="display: flex; justify-content: center;" type="submit">
                                    Post
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
                            minlength: 5 // Minimum length of 5 characters
                        },
                        description: {
                            required: true, // Field is required
                        },
                        address: {
                            required: true, // Field is required
                            minlength: 5
                        },
                        phoneNumber: {
                            required: true, // Field is required
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
                        // Add more fields and rules as needed
                    },
                    messages: {
                        // Define error messages for your form fields
                        title: {
                            required: 'Please enter a value for this field',
                            minlength: 'Minimum length is 6 characters'
                        },
                        description: {
                            required: 'Please enter a value for this field',
                        },
                        address: {
                            required: 'Please enter a value for this field',
                            minlength: 'Minimum length is 6 characters'
                        },
                        phoneNumber: {
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
                        
                        // Add more fields and messages as needed
                    }
                });
            });
        </script>
    </body>

</html>


