<%@page import="java.util.List" %>
<%@page import="DAO.*" %>
<%@page import="entity.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isThreadSafe="false"  %>

<!DOCTYPE html>
<html>
    <% CategoryDAO categoryDAO=new CategoryDAO(); List<Category> categories =
        categoryDAO.getAllCategories();
        BookDAO bookDAO = new BookDAO();
        List<Book> books = bookDAO.getAllBooks();
        CategoryDAO catDao = new CategoryDAO();
    %>

    <head>
        <meta charset="UTF-8">
        <title>Products</title>
        <%@include file="all_component/allCss.jsp" %>
        <link rel="stylesheet" href="css/products.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            function filterBooks() {
                console.log("Filtering books...");

                let selectedCategories = $(".category-checkbox:checked")
                        .map(function () {
                            return $(this).val();
                        })
                        .get();
                let maxPrice = $("#maxPriceInput").val();
                let searchQuery = $("#searchInput").val().trim();

                // Use correct format: categoryIds=1&categoryIds=3
                let params = new URLSearchParams();
                selectedCategories.forEach(id => params.append("categoryIds", id));
                params.append("maxPrice", maxPrice);
                params.append("searchQuery", searchQuery);

                $.ajax({
                    url: "filter-book?" + params.toString(),
                    type: "GET",
                    success: function (response) {
                        let bookHtml = "";
                        if (response.length === 0) {
                            bookHtml = `<div class="col-12 text-center">
                        <p class="alert alert-warning">No books found. Try adjusting your filters or search.</p>
                    </div>`;
                        } else {
                            response.forEach(book => {
                                bookHtml += '<div class="col-lg-3 col-md-4 col-sm-6 col-12"> <div class="card crd-ho"> <img src="book/' + book.photo + '" alt="' + book.bookName + '" class="img-container"> <p class="book-category">' + book.categoryName + '</p> <h5 class="book-title">' + book.bookName + '</h5> <p class="book-price">$' + book.price.toFixed(2) + '</p> <a href="#" class="cart-icon"> <i class="fa fa-shopping-cart"></i></a></div></div>';
                            });
                        }

                        setTimeout(() => {
                            $("#book-list").html(bookHtml).fadeIn(300);
                        }, 200);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching books:", error);
                        alert("Error fetching books." + error.toString());
                    },
                    beforeSend: function () {
                        $("#book-list").fadeOut(200);
                    }
                });
            }
            $(document).ready(function () {
                $(".category-checkbox").change(filterBooks);
                $("#maxPrice, #maxPriceInput").on("input", filterBooks);

                // Trigger search when clicking the button or pressing Enter
                $("#searchButton").click(filterBooks);
                $("#searchInput").keypress(function (event) {
                    if (event.which === 13) { // 13 is the Enter key
                        event.preventDefault();
                        filterBooks();
                    }
                });
            });

            document.addEventListener("DOMContentLoaded", function () {
                const urlParams = new URLSearchParams(window.location.search);
                const categoryId = urlParams.get("categoryId");

                if (categoryId) {
                    // Find the checkbox with the corresponding categoryId and check it
                    let checkbox = document.querySelector('input[type="checkbox"][value="' + categoryId + '"]');
                    if (checkbox) {
                        checkbox.checked = true;
                        checkbox.dispatchEvent(new Event("input"));
                        filterBooks();
                    } else {
                        console.log('input[type="checkbox"][value="' + categoryId + '"]")');
                    }
                }
            });

            $(document).ready(function () {
                $(".addToCartBtn").click(function () {
                    var bookId = $(this).data("book-id");

                    $.ajax({
                        type: "POST",
                        url: "add-to-cart",
                        data: {bookId: bookId},
                        dataType: "json",
                        success: function (response) {
                            alert(response.message);
                        },
                        error: function () {
                            alert("Error adding item to cart.");
                        }
                    });
                });
            });
        </script>
    </head>

    <body style="background-color: #f7f7f7;">
        <%@include file="all_component/navbar.jsp" %>
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
                                    <input type="checkbox" class="category-checkbox"
                                           name="category"
                                           value="<%= category.getCategoryId() %>">
                                    <%= category.getCategoryName() %>
                                </label>
                            </li>
                            <% } %>
                        </ul>

                        <div class="price-range">
                            <label>
                                <b>Price range</b>
                            </label>
                            <div class="slider-container">
                                <input type="range" min="5" max="20" value="20"
                                       class="slider" id="maxPrice">
                                <div>
                                    <label for="maxPrice">Up To</label>
                                    <p style="color: green; font-weight: bold">
                                        <input type="number" id="maxPriceInput" value="20"
                                               style="text-align: right;"> $
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="d-flex justify-content-between align-items-center">
                        <h2>Books</h2>
                        <div class="col-md-6 justify-content-center">
                            <form class="form-inline my-2 my-lg-0" onsubmit="event.preventDefault();
                                    filterBooks();">
                                <input id="searchInput" class="form-control mr-sm-2" type="search" placeholder="Search books..." aria-label="Search">
                                <button id="searchButton" class="btn btn-primary my-2 my-sm-0" type="button">Search</button>
                            </form>
                        </div>
                    </div>

                    <div class="row" id="book-list">

                        <% for (Book book : books) { int categoryId=book.getCategoryId();
                            String
                            category=catDao.getCategoryById(categoryId).getCategoryName();
                        %>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                            <div class="card crd-ho">
                                <img src="book/<%= book.getPhoto() %>" alt="Book Cover"
                                     class="img-container">
                                <p class="book-category">
                                    <%= category %>
                                </p>
                                <h5 class="book-title">
                                    <%= book.getBookName() %>
                                </h5>
                                <p class="book-price">$<%= book.getPrice() %>
                                </p>
                                <button class="addToCartBtn hover-btn btn btn-outline-primary" id="addToCartBtn-<%= book.getBookId()%>" data-book-id="<%= book.getBookId() %>">
                                    Add to Cart
                                </button>
                            </div>
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