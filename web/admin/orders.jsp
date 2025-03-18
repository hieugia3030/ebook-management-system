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
    <script>
        // Function to confirm and send request to update order status
        function updateOrderStatus(orderId, action) {
            if (confirm("Are you sure you want to " + action + " this order?")) {
                var form = document.createElement("form");
                form.method = "POST";
                form.action = action === 'accept' ? "../accept_order" : "../cancel_order";  // Handle action routes

                var input = document.createElement("input");
                input.type = "hidden";
                input.name = "orderId";
                input.value = orderId;
                form.appendChild(input);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</head>

<body>
    <%@include file="navbar.jsp" %>  <!-- Include navigation bar -->

    <div class="container mt-5">
        <h3 class="text-center">Manage Orders</h3>

        <c:if test="${not empty succMsg}">
            <p class="text-center text-success">${succMsg}</p>
            <c:remove var="succMsg" scope="session"/>
        </c:if>

        <c:if test="${not empty errMsg}">
            <p class="text-center text-danger">${errMsg}</p>
            <c:remove var="errMsg" scope="session"/>
        </c:if>

        <table class="table table-striped">
            <thead class="bg-primary text-white">
                <tr>
                    <th scope="col">Order ID</th>
                    <th scope="col">Customer</th>
                    <th scope="col">Order Date</th>
                    <th scope="col">Total Price</th>
                    <th scope="col">Status</th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.customerName}</td>
                        <td>${order.orderDate}</td> <!-- Use JSTL to output order date -->
                        <td>$${order.totalPrice}</td>
                        <td>${order.status}</td>
                        <td>
                            <button onclick="updateOrderStatus(${order.orderId}, 'accept')" class="btn btn-sm btn-success">Accept</button>
                            <button onclick="updateOrderStatus(${order.orderId}, 'cancel')" class="btn btn-sm btn-danger">Cancel</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <%@include file="footer.jsp" %> <!-- Include the footer -->

</body>

</html>
