<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            /* Features Section */
            .features {
                display: flex;
                justify-content: space-around;
                align-items: center;
                padding: 20px;
                background-color: #fff;
                flex-wrap: wrap; /* Makes it responsive */
            }

            /* Feature Item */
            .feature-item {
                text-align: center;
                max-width: 200px;
                padding: 15px;
                border-radius: 10px;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            /* Feature Image */
            .feature-item img {
                width: 50px;
                height: auto;
                margin-bottom: 10px;
                transition: transform 0.3s;
            }

            /* Title */
            .feature-item h3 {
                font-size: 16px;
                font-weight: bold;
                margin-bottom: 5px;
            }

            /* Description */
            .feature-item p {
                font-size: 14px;
                color: gray;
            }

            /* Hover Effect */
            .feature-item:hover {
                transform: translateY(-5px);
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .feature-item:hover img {
                transform: scale(1.1);
            }

            /* Responsive: Adjusts for smaller screens */
            @media (max-width: 768px) {
                .features {
                    flex-direction: column;
                    gap: 15px;
                }
            }

        </style>
    </head>
    <body>
        <div class="features">
            <div class="feature-item">
                <img src="img/icon-truck.png" alt="Free Shipping">
                <h3>Free Shipping</h3>
                <p>On orders over $50</p>
            </div>
            <div class="feature-item">
                <img src="img/icon-purchase.png" alt="Free Returns">
                <h3>Free Returns</h3>
                <p>Within 30 days</p>
            </div>
            <div class="feature-item">
                <img src="img/icon-bag.png" alt="Get 20% Off">
                <h3>Get 20% Off</h3>
                <p>When you sign up</p>
            </div>
            <div class="feature-item">
                <img src="img/icon-operator.png" alt="24/7 Support">
                <h3>24/7 Support</h3>
                <p>Customer service always on</p>
            </div>
        </div>

    </body>
</html>
