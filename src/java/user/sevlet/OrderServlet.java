package user.sevlet;

import DAO.BookDAO;
import DAO.CartDAO;
import DAO.OrderDAO;
import entity.CartItem;
import entity.Order;
import entity.OrderItem;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/placeOrder")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("userobj");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String[] selectedItemIds = req.getParameterValues("selectedItems");
        if (selectedItemIds == null || selectedItemIds.length == 0) {
            session.setAttribute("orderMsg", "No items selected.");
            resp.sendRedirect("cart.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        OrderDAO orderDAO = new OrderDAO();
        BookDAO bookDAO = new BookDAO();
        List<OrderItem> orderItems = new ArrayList<>();

        try {
            for (String itemId : selectedItemIds) {
                int bookId = Integer.parseInt(itemId);
                double price = bookDAO.getBookById(bookId).getPrice();
                CartItem cartItem = cartDAO.getCartItem(user.getId(), bookId);
                int quantity = cartItem.getQuantity();
                if (cartItem != null) {
                    orderItems.add(new OrderItem(0, 0, bookId, quantity));
                }
            }

            if (orderItems.isEmpty()) {
                session.setAttribute("orderMsg", "No valid items found.");
                resp.sendRedirect("cart.jsp");
                return;
            }

            Order order = new Order();
            order.setUserId(user.getId());
            order.setOrderDate(LocalDateTime.now());
            order.setStatus("Pending");
            order.setOrderItems(orderItems);

            int orderId = orderDAO.createOrder(order);
            if (orderId > 0) {
                for (OrderItem item : orderItems) {
                    cartDAO.removeFromCart(user.getId(), item.getBookId());
                }
                resp.sendRedirect("orders.jsp");
            } else {
                session.setAttribute("orderMsg", "Failed to place order.");
                resp.sendRedirect("cart.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("orderMsg", "Order failed: " + getStackTrace(e));
            resp.sendRedirect("cart.jsp");
        }
    }

     private String getStackTrace(Exception e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        return sw.toString();
    }

}
