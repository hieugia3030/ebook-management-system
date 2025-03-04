package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import entity.User;
import DB.DBConnect;
import java.sql.SQLException;
import java.util.HashSet;

public class UserDAOImpl extends MyDAO implements UserDAO {

    private Connection conn;

    public UserDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean userRegister(User us) {
        boolean f = false;
        try {
            String sql = "INSERT INTO [User] (name, email, phone, password, address, landmark, state, pincode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, us.getName());
            ps.setString(2, us.getEmail());
            ps.setString(3, us.getPhone());
            ps.setString(4, us.getPassword());
            ps.setString(5, us.getAddress());
            ps.setString(6, us.getLandmark());
            ps.setString(7, us.getState());
            ps.setString(8, us.getPincode());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public User Login(String email, String password) {
        User us = null;

        try {

            String xSql = "SELECT * FROM [User] WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(xSql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                us = new User();
                us.setId(rs.getInt("id"));
                us.setName(rs.getString("name"));
                us.setEmail(rs.getString("email"));
                us.setPhone(rs.getString("phone"));
                us.setPassword(rs.getString("password"));
                us.setAddress(rs.getString("address"));
                us.setLandmark(rs.getString("landmark"));
                us.setState(rs.getString("state"));
                us.setPincode(rs.getString("pincode"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return us;
    }

    public User login(String email, String password) {
        try {
            xSql = "SELECT * FROM [User] WHERE email = ? AND password = ?";
            ps = conn.prepareStatement(xSql);

            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next() == false) {
                return null;
            } else {
                User us = new User();
                us.setId(rs.getInt("id"));
                us.setName(rs.getString("name"));
                us.setEmail(rs.getString("email"));
                us.setPhone(rs.getString("phone"));
                us.setPassword(rs.getString("password"));
                us.setAddress(rs.getString("address"));
                us.setLandmark(rs.getString("landmark"));
                us.setState(rs.getString("state"));
                us.setPincode(rs.getString("pincode"));
                return us;
            }
        } catch (Exception e) {

        }
        return null;
    }
}
