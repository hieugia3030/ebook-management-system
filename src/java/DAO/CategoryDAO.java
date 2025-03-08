package DAO;

import entity.Category;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends MyDAO {

    public String insertCategory(Category category) throws SQLException {
        xSql = "INSERT INTO BookCategory (categoryName, image) VALUES (?, ?)";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getImage());
            
            int rowsAffected = ps.executeUpdate();
            return ""; // Returns empty if insertion is successful
        } catch (SQLException e) {
            throw e;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                throw e;
            }
        }
    }

    public List<Category> getAllCategories() throws SQLException{
        List<Category> categories = new ArrayList<>();
        xSql = "SELECT * FROM BookCategory";
        
        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("categoryId"),
                        rs.getString("categoryName"),
                        rs.getString("image")
                );
                categories.add(category);
            }
        } catch (SQLException e) {
            throw e;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                throw e;
            }
        }
        return categories;
    }

    public Category getCategoryById(int id) throws SQLException {
        Category category = null;
        xSql = "SELECT * FROM BookCategory WHERE categoryId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                category = new Category(
                        rs.getInt("categoryId"),
                        rs.getString("categoryName"),
                        rs.getString("image")
                );
            }
        } catch (SQLException e) {
            throw e;
        }
        return category;
    }

    public boolean updateCategory(Category category) throws SQLException {
        xSql = "UPDATE BookCategory SET categoryName=?, image=? WHERE categoryId=?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getImage());
            ps.setInt(3, category.getCategoryId());
            
            return ps.executeUpdate() > 0; // Returns true if update successful
        } catch (SQLException e) {
            throw e;
        }
    }

    public boolean deleteCategory(int categoryId) throws SQLException {
        xSql = "DELETE FROM BookCategory WHERE categoryId = ?";
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw e;
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                throw e;
            }
        }
    }
}
