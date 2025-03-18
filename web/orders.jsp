<%@ page import="java.util.*, DAO.*, entity.*, java.time.format.DateTimeFormatter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders</title>
        <%@include file="all_component/allCss.jsp" %>
        <link rel="stylesheet" href="css/orders.css"/>
    </head>
    <body style="background-color: #f0f1f2">
        <%@include file="all_component/navbar.jsp" %>

        <%
            // Get the user from session
            User user = (User) session.getAttribute("userobj");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Fetch orders for the logged-in user
            OrderDAO orderDAO = new OrderDAO();
            BookDAO bookDAO = new BookDAO();
            CategoryDAO catDAO = new CategoryDAO();
            OrderItemDAO itemDAO = new OrderItemDAO();

            List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
            List<OrderItem> items = itemDAO.getAll();
            Map<Integer, Book> bookMap = new HashMap<>();
            Map<Integer, Category> catMap = new HashMap<>();

            for (Order order : orders) {
                for (OrderItem item : items) {
                    if (item.getOrderId() == order.getOrderId()) {
                        order.addOrderItem(item);

                        // Fetch book only if not already fetched
                        if (!bookMap.containsKey(item.getBookId())) {
                            Book book = bookDAO.getBookById(item.getBookId());
                            bookMap.put(item.getBookId(), book);
                            Category cat = catDAO.getCategoryById(book.getCategoryId());
                            catMap.put(cat.getCategoryId(), cat);
                        }
                    }
                }
            }

            request.setAttribute("orders", orders);
            request.setAttribute("bookMap", bookMap);
            request.setAttribute("catMap", catMap);
        %>

        <div class="container mt-4">
            <h2>Your Orders</h2>

            <c:choose>
                <c:when test="${empty orders}">
                    <div class="no-orders">
                        <i class="fas fa-frown"></i>
                        <p>No orders found.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <!-- Order Header -->
                            <div class="order-header">
                                <span class="fw-bold">Order Date: ${order.orderDateFormatted}</span>
                                <span class="status status-${order.status.toLowerCase()}">
                                    ${order.status}
                                </span>
                            </div>

                            <hr>

                            <c:set var="orderTotal" value="0" />
                            <!-- Order Items -->
                            <c:forEach var="orderItem" items="${order.orderItems}">
                                <c:set var="book" value="${bookMap[orderItem.bookId]}" />
                                <c:set var="cat" value="${catMap[book.categoryId]}" />
                                <c:set var="itemTotal" value="${book.price * orderItem.quantity}" />
                                <c:set var="orderTotal" value="${orderTotal + itemTotal}" />

                                <div class="order-item">
                                    <img src="book/${book.photo}" alt="Book Image">
                                    <div class="order-details">
                                        <h5>${book.bookName}</h5>
                                        <p>Category: ${cat.categoryName}</p>
                                        <p>Quantity: ${orderItem.quantity}</p>
                                    </div>
                                    <span class="price">₫${itemTotal}</span>
                                </div>
                            </c:forEach>

                            <!-- Order Footer -->
                            <div class="order-footer">
                                <strong>Total:</strong> <span class="total-amount">₫${orderTotal}</span>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </body>
</html>
