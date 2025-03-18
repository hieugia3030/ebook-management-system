<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="java.util.List"%>
<%@page import="entity.CartItem"%>
<%@page import="entity.User"%>
<%@page import="DAO.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ebook: Cart</title>
        <script>
            function updateQuantity(bookId, change) {
                let qtyInput = document.getElementById("qty-" + bookId);
                let totalPriceElement = document.getElementById("total-" + bookId);
//                let cartTotalElement = document.getElementById("cart-total");
                let currentQty = parseInt(qtyInput.value);

                let newQty = currentQty + change;
                if (newQty < 1)
                    return; // Prevent quantity going below 1

                qtyInput.value = newQty;

                // Send AJAX request to update quantity in backend
                let xhr = new XMLHttpRequest();
                xhr.open("POST", "updateCartQuantity", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        console.log("Response:", xhr.responseText);  // Debugging
                        if (xhr.status === 200) {
                            let response = JSON.parse(xhr.responseText);
                            if (response.success) {
                                totalPriceElement.innerHTML = response.itemTotal + "$";
                            } else {
                                alert("Error: " + response.error);
                            }
                        }
                    }
                };

                xhr.send("bookId=" + bookId + "&quantity=" + newQty);


                updateTotal();
            }

            function removeFromCart(bookId) {
                if (!confirm("Are you sure you want to remove this item from your cart?")) {
                    return;
                }

                let xhr = new XMLHttpRequest();
                xhr.open("POST", "removeFromCart", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            let response = JSON.parse(xhr.responseText);
                            if (response.success) {
                                document.getElementById("cart-item-" + bookId).remove();
                                let newCount = $(".cart-item").length; // Count remaining items
                                $("#cartCount").text(newCount);
                                if (newCount === 0) {
                                    $("#selectAll").prop("checked", false); // Uncheck "Select All" if empty
                                }
                                updateTotal();
                            } else {
                                alert("Error: " + response.error);
                            }
                        }
                    }
                };

                xhr.send("bookId=" + bookId);
            }

        </script>
        <%@include file="all_component/allCss.jsp" %>
        <style>
            @keyframes fadeOut {
                from {
                    opacity: 0.7;
                    transform: scale(1);
                }
                to {
                    opacity: 0;
                    transform: scale(0.8);
                }
            }

            .cart-item.remove {
                animation: fadeOut 0.5s ease-in-out;
            }
        </style>
    </head>
    <body style="background-color: #f0f1f2">
        <%@include file="all_component/navbar.jsp" %>

        <%
            // Get the user from the session
            User user = (User) session.getAttribute("userobj");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Fetch cart items
            CartDAO cartDAO = new CartDAO();
            List<CartItem> cartItems = cartDAO.getCartItems(user.getId());
            request.setAttribute("cartItems", cartItems);

            BookDAO bDAO = new BookDAO();
            request.setAttribute("bDao", bDAO);

            double cartTotal = 0;
            request.setAttribute("cartTotal", cartTotal);
        %>
        <div class="container mt-5">
            <div class="cart-container">
                <div class="cart-header">Products</div>

                <c:if test="${empty cartItems}">
                    <p class="text-center text-muted mt-3">Your cart is empty.</p>
                </c:if>
                <c:if test="${not empty orderMsg}">
                    <p class="text-center text-danger">${orderMsg}</p>
                    <c:remove var="orderMsg" scope="session" />
                </c:if>  

                <c:if test="${not empty cartItems}">
                    <form action="placeOrder" method="post">
                        <c:forEach var="item" items="${cartItems}">
                            <c:set var="book" scope="session" value="${bDao.getBookById(item.getBookId())}"/>
                            <div class="cart-item" id="cart-item-${item.bookId}">
                                <input type="checkbox" name="selectedItems" value="${item.bookId}" class="cart-checkbox">
                                <img src="book/${book.getPhoto()}" alt="${book.getBookName()}">
                                <div class="cart-details">
                                    <div class="font-weight-bold">${book.getBookName()}</div>
                                    <div class="text-muted">Author: ${book.getAuthor()}</div>
                                    <div class="price">${book.getPrice()}$</div>
                                </div>
                                <div class="cart-actions">
                                    <div class="quantity-box">
                                        <button type="button" onclick="updateQuantity(${item.bookId}, -1)">-</button>
                                        <input type="text" id="qty-${item.bookId}" value="${item.quantity}" class="quantity" readonly>
                                        <button type="button" onclick="updateQuantity(${item.bookId}, 1)">+</button>
                                    </div>
                                    <div class="price" id="total-${item.bookId}">${book.getPrice() * item.quantity}$</div>
                                    <a href="javascript:void(0);" onclick="removeFromCart(${item.bookId})" class="remove-btn text-danger">Remove</a>
                                </div>
                            </div>

                        </c:forEach>
                        <div class="checkout-section">
                            <div>
                                <input type="checkbox" id="selectAll"> Select All (<span id="cartCount">${cartItems.size()}</span>)
                            </div>
                            <div>
                                Total Cost: <span class="price" id="cartTotal">${cartTotal}$</span>
                                <button type="submit" class="checkout-button">ORDER NOW</button>

                            </div>
                        </div>
                    </form>

                </c:if>
            </div>
        </div>
        <!-- Bootstrap Modal -->
        <div class="modal fade" id="confirmRemoveModal" tabindex="-1" aria-labelledby="confirmRemoveLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmRemoveLabel">Confirm Removal</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to remove this item from your cart?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger" id="confirmRemoveBtn">Remove</button>
                    </div>
                </div>
            </div>
        </div>

        <script>

            document.querySelectorAll('.cart-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', updateTotal);
            });

            document.getElementById('selectAll').addEventListener('change', selectAllItems);

            function updateTotal() {
                let total = 0;
                document.querySelectorAll('.cart-item').forEach(item => {
                    let checkbox = item.querySelector('.cart-checkbox');
                    if (checkbox.checked) {
                        let price = parseFloat(item.querySelector('.price').textContent);
                        let quantity = parseInt(item.querySelector('.quantity').value);
                        total += price * quantity;
                    }
                });
                document.getElementById('cartTotal').textContent = total.toLocaleString() + "$";
            }

            function selectAllItems() {
                let selectedAll = document.getElementById('selectAll').checked;
                document.querySelectorAll('.cart-checkbox').forEach(checkbox => {
                    checkbox.checked = selectedAll;
                    updateTotal();
                });
            }

            // animation
            document.querySelectorAll(".remove-btn").forEach(button => {
                button.addEventListener("click", function () {
                    let cartItem = this.closest(".cart-item");
                    cartItem.classList.add("remove");

                    setTimeout(() => {
                        cartItem.remove();
                    }, 300); // Match the animation duration
                });
            });

        </script>
    </body>
    <br>
    <%@include file="all_component/footer.jsp" %>

</html>
