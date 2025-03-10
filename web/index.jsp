<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.List" %>
<%@page import="DAO.*" %>
<%@page import="entity.*" %>
<%
    BookDAO bDAO = new BookDAO();
    List<Book> fictionBooks = bDAO.getTopBooksByCategory(1, 4);
    List<Book> dystopianBooks = bDAO.getTopBooksByCategory(2, 4);
    List<Book> classicBooks = bDAO.getTopBooksByCategory(3, 4);
%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ebook: Index</title>
        <%@include file="all_component/allCss.jsp" %>

    </head>

    <body style="background-color: #f7f7f7;">
        <%@include file="all_component/navbar.jsp" %>
        <jsp:include page="all_component/slide_show.jsp" />
        <jsp:include page="all_component/highlights.jsp" />
        <jsp:include page="all_component/categories.jsp" />
        <br>

        <!-- Start Fiction Bookt -->

        <div class="container-fluid">
            <h3 class="text-center">Fiction</h3>
            <div class="row book-list">
                <% for (Book book : fictionBooks) { %>
                <div class="col-md-3 card-container">
                    <div class="card crd-ho">
                        <img src="book/<%= book.getPhoto() %>" class="card-img-top" alt="Book Cover">
                        <div class="card-body">
                            <h5 class="book-title"><%= book.getBookName() %></h5>
                            <p class="book-price"><%= book.getPrice() %>$</p>
                            <form action="add-to-cart" method="post">
                                <input type="hidden" name="productId" value="<%= book.getBookId() %>" />
                                <button type="submit" class="cart-btn">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </form>

                        </div>
                    </div>    
                </div>
                <% } %>
            </div>
            <br>
            <div class="text-center mt-3">
                <a href="products.jsp?categoryId=1" class="btn btn-danger btn-sm px-4 py-2 rounded-pill shadow-sm">
                    <i class="fa fa-book-open me-2"></i> View All
                </a>
            </div>

        </div>
        <!-- End Fiction Book -->
        <hr>
        <!-- Start Dystopian Book -->

        <div class="container-fluid">
            <h3 class="text-center">Dystopian</h3>
            <div class="row book-list">
                <% for (Book book : dystopianBooks) { %>
                <div class="col-md-3 card-container">
                    <div class="card crd-ho">
                        <img src="book/<%= book.getPhoto() %>" class="card-img-top" alt="Book Cover">
                        <div class="card-body text-center">
                            <h5 class="book-title"><%= book.getBookName() %></h5>
                            <p class="book-price"><%= book.getPrice() %>$</p>
                            <form action="add-to-cart" method="post">
                                <input type="hidden" name="productId" value="<%= book.getBookId() %>" />
                                <button type="submit" class="cart-btn">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </form>

                        </div>
                    </div>    
                </div>
                <% } %>
            </div>
            <br>
            <div class="text-center mt-3">
                <a href="products.jsp?categoryId=2" class="btn btn-danger btn-sm px-4 py-2 rounded-pill shadow-sm">
                    <i class="fa fa-book-open me-2"></i> View All
                </a>
            </div>

        </div>
        <!-- End Dystopian Book -->
        <hr>
        <!-- Start Classic Book -->

        <div class="container-fluid">
            <h3 class="text-center">Classic</h3>
            <div class="row book-list">
                <% for (Book book : classicBooks) { %>
                <div class="col-md-3 card-container">
                    <div class="card crd-ho">
                        <img src="book/<%= book.getPhoto() %>" class="card-img-top" alt="Book Cover">
                        <div class="card-body text-center">
                            <h5 class="book-title"><%= book.getBookName() %></h5>
                            <p class="book-price"><%= book.getPrice() %>$</p>
                            <form action="add-to-cart" method="post">
                                <input type="hidden" name="productId" value="<%= book.getBookId() %>" />
                                <button type="submit" class="cart-btn">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </form>

                        </div>
                    </div>    
                </div>
                <% } %>
            </div>
            <br>
            <div class="text-center mt-3">
                <a href="products.jsp?categoryId=3" class="btn btn-danger btn-sm px-4 py-2 rounded-pill shadow-sm">
                    <i class="fa fa-book-open me-2"></i> View All
                </a>
            </div>

        </div>
        <!-- End Classic Book -->




        <%@include file="all_component/footer.jsp" %>
    </body>

</html>