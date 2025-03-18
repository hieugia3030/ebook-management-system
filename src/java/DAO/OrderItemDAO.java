package DAO;

import entity.OrderItem;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO extends MyDAO {

    public boolean insert(OrderItem orderItem) throws SQLException {
        xSql = "INSERT INTO OrderItems (orderId, bookId, quantity) VALUES (?, ?, ?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getBookId());
            ps.setInt(3, orderItem.getQuantity());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw e;
        }
    }

    public List<OrderItem> getAll() throws SQLException {
        List<OrderItem> orderItems = new ArrayList<>();
        xSql = "SELECT * FROM OrderItems";
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                orderItems.add(new OrderItem(
                        rs.getInt("orderItemId"),
                        rs.getInt("orderId"),
                        rs.getInt("bookId"),
                        rs.getInt("quantity")));
            }
        } catch (SQLException e) {
            throw e;
        }
        return orderItems;
    }

    public OrderItem getById(int orderItemId) throws SQLException {
        OrderItem orderItem = null;
        xSql = "SELECT * FROM OrderItems WHERE orderItemId = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, orderItemId);
            rs = ps.executeQuery();
            if (rs.next()) {
                orderItem = new OrderItem(
                        rs.getInt("orderItemId"),
                        rs.getInt("orderId"),
                        rs.getInt("bookId"),
                        rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            throw e;
        }
        return orderItem;
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM OrderItems WHERE orderId = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(new OrderItem(
                            rs.getInt("orderItemId"),
                            rs.getInt("orderId"),
                            rs.getInt("bookId"),
                            rs.getInt("quantity")));
                }
            }
        }
        return items;
    }

    public boolean updateOrderItem(OrderItem orderItem) throws SQLException {
        xSql = "UPDATE OrderItems SET orderId=?, bookId=?, quantity=? WHERE orderItemId=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getBookId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setInt(4, orderItem.getOrderItemId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw e;
        }
    }

    public boolean deleteOrderItem(int orderItemId) throws SQLException {
        xSql = "DELETE FROM OrderItems WHERE orderItemId=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, orderItemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw e;
        }
    }

}
