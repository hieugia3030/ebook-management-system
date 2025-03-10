<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .carousel-inner img {
                height: 100%;
                object-fit: cover;
            }
            .carousel {
                max-width: 100%;
            }
            .carousel-content {
                height: 100%;
            }
            .carousel-item {
                height: 75vh;
                align-items: center;
                justify-content: center;
                background-color: #f8f9fa;
            }
            .slide-content-container{
                display: flex;
                justify-content: center;
            }
            .slide-content {
                opacity: 0;
                transform: translateY(50px);
                transition: all 1s ease-in-out;
            }

            .carousel-item.active .slide-content {
                opacity: 1;
                transform: translateY(0);
            }
            .slide-image {
                max-height: 350px;
                transition: transform 1s ease-in-out, opacity 1s ease-in-out;
                opacity: 0;
            }
            .carousel-item.active .slide-image {
                opacity: 1;
                transform: scale(1);
            }
            .carousel-control-prev, .carousel-control-next {
                position: absolute;
                top: 45%;
                transform: translateY(-50%);
                width: 50px;
                height: 50px;
                background-color: rgba(0, 0, 0, 0.3);
                border-radius: 50%;
                margin: 0px 10px;
            }
            .btn-custom {
                background-color: #0056b3;
                color: white;
                padding: 10px 20px;
                border-radius: 20px;
                text-decoration: none;
                display: inline-block;
                margin-top: 10px;
                transition: 0.3s;
            }
            .btn-custom:hover {
                background-color: #004494;
            }
        </style>
    </head>
    <body>

        <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <ol class="carousel-indicators">
                    <li data-target="#carouselExample" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExample" data-slide-to="1"></li>
                </ol>
                <!-- Slide 1 -->
                <div class="carousel-item active">
                    <div class="container d-flex align-items-center carousel-content">
                        <div class="col-md-6 slide-content-container">
                            <div class="slide-content">
                                <h5 class="text-primary">HOT SALE</h5>
                                <h2 class="fw-bold">The Lord of the Rings Combo</h2>
                                <p>Sale 30%</p>
                                <a href="#" class="btn-custom">BUY NOW →</a>
                            </div>
                        </div>
                        <div class="col-md-6 text-center">
                            <img src="img/slide_1.png" class="slide-image img-fluid" alt="Book Set">
                        </div>
                    </div>
                </div>

                <!-- Slide 2 -->
                <div class="carousel-item">
                    <div class="container d-flex align-items-center carousel-content">
                        <div class="col-md-6 slide-content-container">
                            <div class="slide-content">
                                <h5 class="text-danger">Special Offer</h5>
                                <h2 class="fw-bold">Harry Potter Books for SALE 40%</h2>
                                <p>This program applies to all Harry Potter Novel</p>
                                <a href="#" class="btn-custom">ORDER NOW →</a>
                            </div>
                        </div>
                        <div class="col-md-6 text-center">
                            <img src="img/slide_2.png" class="slide-image img-fluid" alt="Discounted Books">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Controls -->
            <a class="carousel-control-prev" href="#carouselExample" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExample" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </body>
</html>
