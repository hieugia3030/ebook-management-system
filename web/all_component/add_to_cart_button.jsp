<%-- 
    Document   : add_to_cart_button
    Created on : Mar 11, 2025, 3:05:02 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /* From Uiverse.io by SouravBandyopadhyay */
            .button {
                --width: 100px;
                --height: 35px;
                --tooltip-height: 35px;
                --tooltip-width: 90px;
                --gap-between-tooltip-to-button: 18px;
                --button-color: #222;
                --tooltip-color: #fff;
                width: var(--width);
                height: var(--height);
                background: var(--button-color);
                position: relative;
                text-align: center;
                border-radius: 0.5em;
                font-family: "Arial";
                transition: background 0.7s;
            }

            .button::before {
                position: absolute;
                content: attr(data-tooltip);
                width: var(--tooltip-width);
                height: var(--tooltip-height);
                background-color: #555;
                font-size: 0.9rem;
                color: #fff;
                border-radius: 0.25em;
                line-height: var(--tooltip-height);
                bottom: calc(var(--height) + var(--gap-between-tooltip-to-button) + 10px);
                left: calc(50% - var(--tooltip-width) / 2);
            }

            .button::after {
                position: absolute;
                content: "";
                width: 0;
                height: 0;
                border: 10px solid transparent;
                border-top-color: #555;
                left: calc(50% - 10px);
                bottom: calc(100% + var(--gap-between-tooltip-to-button) - 10px);
            }

            .button::after,
            .button::before {
                opacity: 0;
                visibility: hidden;
                transition: all 0.5s;
            }

            .text {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .button-wrapper,
            .text,
            .icon {
                overflow: hidden;
                position: absolute;
                width: 100%;
                height: 100%;
                left: 0;
                color: #fff;
            }

            .text {
                top: 0;
            }

            .text,
            .icon {
                transition: top 0.5s;
            }

            .icon {
                color: #fff;
                top: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .icon svg {
                width: 24px;
                height: 24px;
            }

            .button:hover {
                background: #222;
            }

            .button:hover .text {
                top: -100%;
            }

            .button:hover .icon {
                top: 0;
            }

            .button:hover:before,
            .button:hover:after {
                opacity: 1;
                visibility: visible;
            }

            .button:hover:after {
                bottom: calc(var(--height) + var(--gap-between-tooltip-to-button) - 20px);
            }

            .button:hover:before {
                bottom: calc(var(--height) + var(--gap-between-tooltip-to-button));
            }

        </style>
    </head>
    <body>
        <!-- From Uiverse.io by SouravBandyopadhyay --> 
        <div class="button">
            <div class="button-wrapper">
                <div class="text">Add To Cart</div>
                <span class="icon">
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="16"
                        height="16"
                        fill="currentColor"
                        class="bi bi-cart2"
                        viewBox="0 0 16 16"
                        >
                    <path
                        d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5zM3.14 5l1.25 5h8.22l1.25-5H3.14zM5 13a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0zm9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0z"
                        ></path>
                    </svg>
                </span>
            </div>
        </div>

    </body>
</html>
