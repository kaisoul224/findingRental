<%-- 
    Document   : findRental
    Created on : Jul 8, 2023, 1:52:43 AM
    Author     : Tan Phat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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


        <!-- ***** Page content Start ***** -->
        <div class="row">
            <div class="page-content-find">

                <div class="side-content">

                    <div class="filter-price">
                    <p>Find by Price</p>
                    <div class="filter-content">
                        <ul class="list-items-rental">
                            <li class="rental-item">
                                <input type="radio" name="price" value="Tat ca" id="tat-ca">
                                <label for="tat-ca">Tất cả</label>
                            </li>
                            <li class="rental-item">
                                <input type="radio" name="price" value="Duoi 1 trieu" id="duoi1trieu">
                                <label for="duoi1trieu">Dưới 1 triệu</label>
                            </li>
                            <li class="rental-item">
                                <input type="radio" name="price" value="1 trieu - 2 trieu" id="1-2trieu">
                                <label for="1-2trieu">1 triệu - 2 triệu</label>
                            </li>
                            <li class="rental-item">
                                <input type="radio" name="price" value="2 trieu - 3 trieu" id="2-3trieu">
                                <label for="2-3trieu">2 triệu - 3 triệu</label>
                            </li>
                            <li class="rental-item">
                                <input type="radio" name="price" value="3 trieu - 5 trieu" id="3-5trieu">
                                <label for="3-5trieu">3 triệu - 5 triệu</label>
                            </li>
                            <li class="rental-item">
                                <input type="radio" name="price" value="5 trieu - 7 trieu" id="5-7trieu">
                                <label for="5-7trieu">5 triệu - 7 triệu</label>
                            </li>
                            <li class="rental-item">
                                <input type="radio" name="price" value="7 trieu - 10 trieu" id="7-10trieu">
                                <label for="7-10trieu">7 triệu - 10 triệu</label>
                            </li>
                            <li class="rental-item">
                                <input type="radio" name="price" value="10 trieu - 15 trieu" id="10-15trieu">
                                <label for="10-15trieu">10 triệu - 15 triệu</label>
                            </li>
                            <li class="rental-item">
                                <input type="radio" name="price" value="Tren 15 trieu" id="tren15trieu">
                                <label for="tren15trieu">Trên 15 triệu</label>
                            </li>
                        </ul>
                    </div>
                </div>

                    <div class="filter-location">
                        <p>Find by Location</p>
                        <div class="filter-content">
                            <div class="wrapper">
                                <div class="search-input">
                                    <a href="" target="_blank" hidden></a>
                                    <input type="text" placeholder="Search...">
                                    <div class="icon"><i class="fas fa-search"></i></div>
                                    <div class="autocom-box">
                                        <!-- here list are inserted from javascript -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>

                <div class="main-content">
                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game1.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hồ Chí Minh</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        PHÒNG NGAY VINCOM Q9 - NGÃ TƯ THỦ ĐỨC </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>147/19 Đường Tân Lập 2, Phường Hiệp Phú, Quận 9, Hồ Chí Minh , Quận 9</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>2.700.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game-02.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hà Nội</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        2 phòng ngủ tại triều khúc mới tinh vào ở luôn </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>Nguyễn Xiển, Thanh Xuân Nam, Thanh Xuân , Thanh Xuân</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>5.400.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game1.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hồ Chí Minh</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        PHÒNG NGAY VINCOM Q9 - NGÃ TƯ THỦ ĐỨC </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>147/19 Đường Tân Lập 2, Phường Hiệp Phú, Quận 9, Hồ Chí Minh , Quận 9</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>2.700.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game-02.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hà Nội</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        2 phòng ngủ tại triều khúc mới tinh vào ở luôn </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>Nguyễn Xiển, Thanh Xuân Nam, Thanh Xuân , Thanh Xuân</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>5.400.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game1.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hồ Chí Minh</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        PHÒNG NGAY VINCOM Q9 - NGÃ TƯ THỦ ĐỨC </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>147/19 Đường Tân Lập 2, Phường Hiệp Phú, Quận 9, Hồ Chí Minh , Quận 9</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>2.700.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game-02.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hà Nội</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        2 phòng ngủ tại triều khúc mới tinh vào ở luôn </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>Nguyễn Xiển, Thanh Xuân Nam, Thanh Xuân , Thanh Xuân</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>5.400.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game1.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hồ Chí Minh</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        PHÒNG NGAY VINCOM Q9 - NGÃ TƯ THỦ ĐỨC </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>147/19 Đường Tân Lập 2, Phường Hiệp Phú, Quận 9, Hồ Chí Minh , Quận 9</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>2.700.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game-02.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hà Nội</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        2 phòng ngủ tại triều khúc mới tinh vào ở luôn </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>Nguyễn Xiển, Thanh Xuân Nam, Thanh Xuân , Thanh Xuân</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>5.400.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game1.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hồ Chí Minh</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        PHÒNG NGAY VINCOM Q9 - NGÃ TƯ THỦ ĐỨC </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>147/19 Đường Tân Lập 2, Phường Hiệp Phú, Quận 9, Hồ Chí Minh , Quận 9</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>2.700.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game-02.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hà Nội</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        2 phòng ngủ tại triều khúc mới tinh vào ở luôn </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>Nguyễn Xiển, Thanh Xuân Nam, Thanh Xuân , Thanh Xuân</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>5.400.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game1.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hồ Chí Minh</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        PHÒNG NGAY VINCOM Q9 - NGÃ TƯ THỦ ĐỨC </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>147/19 Đường Tân Lập 2, Phường Hiệp Phú, Quận 9, Hồ Chí Minh , Quận 9</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>2.700.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game-02.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hà Nội</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        2 phòng ngủ tại triều khúc mới tinh vào ở luôn </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>Nguyễn Xiển, Thanh Xuân Nam, Thanh Xuân , Thanh Xuân</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>5.400.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="last-item-find">
                        <div class="row">
                            <div class="col-md-5 pic">
                                <a href="browse.html"><img src="assets/images/game-03.jpg" alt="" class="img-item"></a>
                            </div>
                            <div class="col-md-7 des">
                                <div class="city">
                                    <span>
                                        <a href="browse.html">Hồ Chí Minh</a>
                                    </span>
                                </div>
                                <h4 class="title">
                                    <a href="browse.html">
                                        PHÒNG SẠCH SẼ, THOÁNG MÁT GẦN ĐẠI HỌC KINH TẾ </a>
                                </h4>
                                <div class="location">
                                    <dl class="address">
                                        <dt>97D Đường Nguyễn Tri Phương, Phường 3, Quận 10, Hồ Chí Minh</dt>
                                    </dl>
                                </div>
                                <div class="contact">
                                    <dl class="price">
                                        <dt>2.700.000 VNĐ</dt>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="pagination-contain">
                        <div class="pagination">
                            <a href="#">&laquo;</a>
                            <a class="active" href="#">1</a>
                            <a href="#">2</a>
                            <a href="#">3</a>
                            <a href="#">4</a>
                            <a href="#">5</a>
                            <a href="#">6</a>
                            <a href="#">&raquo;</a>
                        </div>
                    </div>


                </div>

            </div>
        </div>
        <!-- ***** Page content End ***** -->



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

        <script src="assets/js/isotope.js"></script>
        <script src="assets/js/owl-carousel.js"></script>
        <script src="assets/js/tabs.js"></script>
        <script src="assets/js/popup.js"></script>
        <script src="assets/js/custom.js"></script>
        <script src="assets/js/rentalAutoSearch.js"></script>
        
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
