<%@page import="java.util.List"%>
<%@page import="DAO.*"%>
<%@page import="entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <%
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategories();
        BookDAO bookDAO = new BookDAO();
        List<Book> books = bookDAO.getAllBooks();
    %>
    <head>
        <meta charset="UTF-8">
        <title>Products</title>
        <%@include file ="all_component/allCss.jsp"%>
        <style>
            .sidebar {
                position: sticky;
                top: 10px;
                left: 0;
                background: white;
                padding: 5px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            .category-header {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
                display: flex;
                justify-content: space-between;
                cursor: pointer;
            }

            .category-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .category-list label {
                display: flex;
                align-items: center;
                margin-bottom: 8px;
                cursor: pointer;
            }

            .category-list img {
                width: 24px;
                height: 24px;
                margin-right: 10px;
                border-radius: 5px;
            }

            /* Default checkbox styling */
            input[type="checkbox"] {
                appearance: none; /* Remove default browser styling */
                width: 18px;
                height: 18px;
                border: 2px solid #999;
                border-radius: 4px;
                display: inline-block;
                position: relative;
                cursor: pointer;
            }

            /* Checked checkbox with blue background */
            input[type="checkbox"]:checked {
                background-color: blue; /* Change to blue */
                border-color: blue;
            }

            /* Custom checkmark */
            input[type="checkbox"]::before {
                content: "✓"; /* Checkmark */
                font-size: 14px;
                color: white;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                display: none; /* Hidden by default */
            }

            /* Show checkmark when checked */
            input[type="checkbox"]:checked::before {
                display: block;
                color: white;
            }
            
            #maxPriceInput {
                width: 80%;
            }

            .price-range {
                margin-top: 15px;
            }

            .range-slider {
                width: 100%;
                margin-top: 5px;
            }

            .price-input {
                display: flex;
                justify-content: space-between;
                margin-top: 8px;
            }

            .price-input input {
                width: 45%;
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }


            /* Slider */
            /* Style the range slider */
            .slider {
                -webkit-appearance: none; /* Remove default styling */
                appearance: none;
                width: 100%;
                height: 5px;
                background: #e0e0e0; /* Light gray background */
                border-radius: 5px;
                outline: none;
                transition: background 0.3s;
            }

            /* Track (the background) */
            .slider::-webkit-slider-runnable-track {
                width: 100%;
                height: 5px;
                background: #e0e0e0;
                border-radius: 5px;
            }

            /* Thumb (the circle) */
            .slider::-webkit-slider-thumb {
                -webkit-appearance: none;
                appearance: none;
                width: 15px;
                height: 15px;
                background: #8a4cff; /* Purple color */
                border-radius: 50%;
                cursor: pointer;
                margin-top: -5px; /* Adjust positioning */
                box-shadow: 0px 0px 5px rgba(138, 76, 255, 0.5);
            }

            /* Thumb hover effect */
            .slider::-webkit-slider-thumb:hover {
                background: #6a30e0; /* Darker purple */
            }

            /* For Firefox */
            .slider::-moz-range-track {
                background: #e0e0e0;
                height: 5px;
                border-radius: 5px;
            }
            .slider::-moz-range-thumb {
                width: 15px;
                height: 15px;
                background: #8a4cff;
                border-radius: 50%;
                cursor: pointer;
                box-shadow: 0px 0px 5px rgba(138, 76, 255, 0.5);
            }

            /* Add spacing between sliders */
            .slider-container {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

        </style>
    </head>
    <body style="background-color: #f7f7f7;">
        <%@include file="all_component/navbar.jsp"%>
        <br>
        <div class="container">
            <div class="container-fluid row">
                <div class="col-md-2">
                    <div class="sidebar">
                        <div class="category-header">
                            Category
                        </div>

                        <ul class="category-list">
                            <% for (Category category : categories) { %>
                            <li>
                                <label>
                                    <input type="checkbox" name="category" value="<%= category.getCategoryId() %>">
                                    <%= category.getCategoryName() %>
                                </label>
                            </li>
                            <% } %>
                        </ul>

                        <div class="price-range">
                            <label>
                                <input type="checkbox" name="price-filter"> Price range
                            </label>
                            <div class="slider-container">
                                <input type="range" min="5" max="500" value="20" class="slider" id="maxPrice">
                                <div>
                                    <label for="maxPrice">Up To</label>
                                    <p style="color: green; font-weight: bold" ><input type="number" id="maxPriceInput" value="20" style="text-align: right;"> $</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <h2>Books</h2>
                    <div style="display: flex; flex-wrap: wrap; gap: 15px;">
                        <% for (Book book : books) { %>
                        <div style="width: 200px; padding: 10px; background: white; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); border-radius: 10px;">
                            <img src="book/<%= book.getPhoto() %>" alt="Book Cover" style="width: 100%; height: 150px; object-fit: cover; border-radius: 5px;">
                            <h3 style="font-size: 16px; margin-top: 10px;"><%= book.getBookName() %></h3>
                            <p style="color: gray;"><%= book.getAuthor() %></p>
                            <p style="color: green; font-weight: bold;">$<%= book.getPrice() %></p>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const slider = document.getElementById("maxPrice");
            const numberInput = document.getElementById("maxPriceInput");

            slider.addEventListener("input", function () {
                numberInput.value = this.value;
            });

            numberInput.addEventListener("input", function () {
                let value = parseInt(this.value);

                // Ensure value is within slider range
                if (value < slider.min)
                    value = slider.min;
                if (value > slider.max)
                    value = slider.max;

                slider.value = value;
            });
        </script>
        <%@include file="all_component/footer.jsp" %>
    </body>
</html>
