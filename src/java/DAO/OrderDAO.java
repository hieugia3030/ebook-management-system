package DAO;

import entity.Order;
import entity.OrderItem;
import entity.OrderRes;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends MyDAO {

    // Create a new order and insert order items
    public int createOrder(Order order) throws SQLException {
        int generatedOrderId = -1;
        xSql = "INSERT INTO Orders (userId, orderDate, status) VALUES (?, ?, ?)";

        try {
            con.setAutoCommit(false);

            // Insert order
            ps = con.prepareStatement(xSql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, java.sql.Timestamp.valueOf(order.getOrderDate()));
            ps.setString(3, order.getStatus());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedOrderId = rs.getInt(1);
                    order.setOrderId(generatedOrderId);
                }
            }

            // Insert order items
            if (generatedOrderId != -1) {
                xSql = "INSERT INTO OrderItems (orderId, bookId, quantity) VALUES (?, ?, ?)";
                ps = con.prepareStatement(xSql);
                for (OrderItem item : order.getOrderItems()) {
                    ps.setInt(1, generatedOrderId);
                    ps.setInt(2, item.getBookId());
                    ps.setInt(3, item.getQuantity());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            con.commit(); // Commit transaction
        } catch (SQLException e) {
            con.rollback(); // Rollback if something goes wrong
            throw e;
        } finally {
            con.setAutoCommit(true); // Restore auto-commit mode
        }

        return generatedOrderId;
    }

    // Read order by ID
    public Order getOrderById(int orderId) throws SQLException {
        Order order = null;
        xSql = "SELECT * FROM Orders WHERE orderId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate").toLocalDateTime());
                order.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            throw e;
        }
        return order;
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        xSql = "SELECT * FROM Orders";

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate").toLocalDateTime());
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        } catch (SQLException e) {
            throw e;
        }
        return orders;
    }

    // Get all orders for a specific user
    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        xSql = "SELECT * FROM Orders WHERE userId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("orderId"));
                order.setUserId(rs.getInt("userId"));
                order.setOrderDate(rs.getTimestamp("orderDate").toLocalDateTime());
                order.setStatus(rs.getString("status"));
                orders.add(order);
            }
        } catch (SQLException e) {
            throw e;
        }
        return orders;
    }

    public List<OrderRes> getAllOrderRes() throws SQLException {
        List<OrderRes> orders = new ArrayList<>();
        String xSql = "SELECT o.orderId, u.name AS customerName, " +
              "FORMAT(o.orderDate, 'yyyy-MM-dd HH:mm:ss') AS orderDate, " +
              "COALESCE(SUM(b.price * oi.quantity), 0) AS totalPrice, o.status " +
              "FROM Orders o " +
              "JOIN [User] u ON o.userId = u.id " +
              "LEFT JOIN OrderItems oi ON o.orderId = oi.orderId " +
              "LEFT JOIN Book b ON oi.bookId = b.bookId " +
              "GROUP BY o.orderId, u.name, o.orderDate, o.status " +
              "ORDER BY " +
              "  CASE " +
              "    WHEN o.status = 'Pending' THEN 1 " +
              "    WHEN o.status = 'Cancelled' THEN 2 " +
              "    WHEN o.status = 'Success' THEN 3 " +
              "    ELSE 4 " +
              "  END, " +
              "  o.orderDate DESC;";


        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderRes order = new OrderRes(
                        rs.getInt("orderId"),
                        rs.getString("customerName"),
                        rs.getString("orderDate"),
                        rs.getDouble("totalPrice"),
                        rs.getString("status"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return orders;
    }

    // Update order status
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        xSql = "UPDATE Orders SET [status] = ? WHERE orderId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            throw e;
        }
    }

    // Delete an order
    public boolean deleteOrder(int orderId) throws SQLException {
        xSql = "DELETE FROM Orders WHERE orderId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, orderId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            throw e;
        }
    }
}
