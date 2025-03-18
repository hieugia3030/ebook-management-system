<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="DAO.*"%>
<%@page import="entity.*"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin: All Orders</title>
        <%@include file="allCss.jsp" %> <!-- Include the common CSS file -->
        <link rel="stylesheet" href="orders.css">
    </head>

    <body>
        <%@include file="navbar.jsp" %> 

        <%
        OrderDAO orderDAO = new OrderDAO();
        OrderItemDAO orderItemDAO = new OrderItemDAO();
        BookDAO bookDAO = new BookDAO();


        List<OrderRes> orders = orderDAO.getAllOrderRes();
        %>

        <div class="container-fluid mt-5">
            <h3 class="text-center">Manage Orders</h3>

            <table class="table table-striped">
                <thead class="bg-primary text-white">
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Order Date</th>
                        <th>Total Price</th>
                        <th>Status</th>
                        <th>Details</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (OrderRes order : orders) { %>
                    <tr id="order-<%= order.getOrderId() %>">
                        <td><%= order.getOrderId() %></td>
                        <td><%= order.getCustomerName() %></td>
                        <td><%= order.getOrderDate() %></td>
                        <td>$<%= order.getTotalPrice() %></td>
                        <td id="status-<%= order.getOrderId() %>"><strong><%= order.getStatus() %></strong></td>
                        <td>
                            <!-- Toggle Button for Details -->
                            <button class="btn btn-info" data-toggle="collapse" data-target="#order<%= order.getOrderId() %>">
                                View Items
                            </button>
                        </td>
                        <td class="action-buttons">
                            <%-- <% if (order.getStatus().equals("Pending")) { %> --%>
                            <button class="icon-btn accept" data-tooltip="Accept Order"
                                    onclick="updateOrderStatus(<%= order.getOrderId() %>, 'Success')">
                                <i class="fas fa-check-circle"></i>
                            </button>

                            <button class="icon-btn cancel" data-tooltip="Cancel Order"
                                    onclick="updateOrderStatus(<%= order.getOrderId() %>, 'Cancelled')">
                                <i class="fas fa-times-circle"></i>
                            </button>
                            <%-- <% } else { %>
                            <button class="icon-btn" disabled data-tooltip="Already Processed">
                                <i class="fas fa-check-circle"></i>
                            </button>
                            <button class="icon-btn" disabled data-tooltip="Already Processed">
                                <i class="fas fa-times-circle"></i>
                            </button>
                            <% } %> --%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <div id="order<%= order.getOrderId() %>" class="collapse">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Book Name</th>
                                            <th>Author</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                            <th>Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            // Fetch order items for this order
                                            List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId(order.getOrderId());
                                            for (OrderItem item : orderItems) {
                                                Book book = bookDAO.getBookById(item.getBookId());
                                                double subtotal = book.getPrice() * item.getQuantity();
                                        %>
                                        <tr>
                                            <td><%= book.getBookName() %></td>
                                            <td><%= book.getAuthor() %></td>
                                            <td><%= item.getQuantity() %></td>
                                            <td>$<%= book.getPrice() %></td>
                                            <td>$<%= subtotal %></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <%@include file="footer.jsp" %>

        <script>
    function updateOrderStatus(orderId, status) {
        fetch('../update-order', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: "orderId=" + orderId + "&status=" + status,
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Success message
                alert("Order successfully updated!");

                // Smooth fade-out animation
                const row = document.getElementById("order-" + orderId);
                row.style.transition = "opacity 0.5s";
                row.style.opacity = "0";

                setTimeout(() => {
                    // Reload the table by refreshing the page or making an AJAX call
                    location.reload();  // Option 1: Reload the entire page
                    // loadOrders();  // Option 2: If you have a function to reload data dynamically
                }, 500);
            } else {
                // Show error alert with details
                alert("Error: " + (data.error ? data.error : "Unknown error occurred."));
            }
        })
        .catch(error => {
            console.error("AJAX Error:", error);
            alert("AJAX Request Failed: " + error.message);
        });
    }
</script>



    </body>

</html>
