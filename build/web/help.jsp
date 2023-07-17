<%-- 
    Document   : help
    Created on : Jul 8, 2023, 2:53:29 AM
    Author     : Quoc Anh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <title>Instruction</title>
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
            .footer{
                margin-top: 70px;
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

        <div class="container" style="background-color: #eee; padding: 20px; margin-top: 70px; border-radius: 0 0 10px 10px;">
            <h2 class="text-center mb-4 text-primary" >Post Instruction</h2>
            <p class="text-center">Follow these steps to post your rental listing:</p>

            <ol>
                <li>Step 0: You need to register an account and login to your account.</li>
                <li>Step 1: Click on the "Post" button in the navigation menu.</li>
                <li>Step 2: Fill in the required information in the provided fields.</li>
                <li>Step 3: Upload a photo of your rental property.</li>
                <li>Step 4: Click the "Post" button to submit your listing.</li>
            </ol>

            <div class="text-center mt-5">
                <a href="./assets/images/instruction.png" target="_blank">
                    <img style="height: 100%; object-fit: cover; border-radius: 10px; cursor: pointer;" src="./assets/images/instruction.png" alt="Detailed Image" width="600" height="400">
                </a>
            </div>
        </div>

        <!--Start footer-->
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

        <script>
      $(document).ready(function () {
          $('.dropdown').on('focusin mouseenter', function () {
              $(this).addClass('show').find('.dropdown-menu').addClass('show');
          }).on('focusout mouseleave', function () {
              $(this).removeClass('show').find('.dropdown-menu').removeClass('show');
          });
      });
        </script>
        <script>
            function showFullImage(imageElement) {
                var imageUrl = imageElement.getAttribute('src');

                // Create a modal/lightbox element
                var modal = document.createElement('div');
                modal.classList.add('modal');

                // Create an image element inside the modal
                var modalImage = document.createElement('img');
                modalImage.classList.add('modal-image');
                modalImage.setAttribute('src', imageUrl);

                // Append the modal image to the modal
                modal.appendChild(modalImage);

                // Append the modal to the document body
                document.body.appendChild(modal);

                // Add a click event listener to the modal to close it when clicked
                modal.addEventListener('click', function () {
                    modal.remove();
                });
            }
        </script>
    </body>

</html>

