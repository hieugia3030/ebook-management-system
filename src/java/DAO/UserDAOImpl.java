package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import entity.User;

public class UserDAOImpl implements UserDAO {
      
    private Connection con;
    
    // Constructor nhận kết nối
    public UserDAOImpl(Connection con) {
        this.con = con;
    }

    // Kết nối SQL Server
    public static Connection getConnection() {
        Connection con = null;
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName=YourDatabase;encrypt=false";
            String user = "sa"; // Thay bằng username của bạn
            String password = "sa"; // 

            con = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    // Phương thức đăng ký User
    public boolean userRegister(User us) {
        boolean f = false;
        try {
            String sql = "INSERT INTO [User] (name, email, phone, password) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, us.getName());
            ps.setString(2, us.getEmail());
            ps.setString(3, us.getPhone());
            ps.setString(4, us.getPassword());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
