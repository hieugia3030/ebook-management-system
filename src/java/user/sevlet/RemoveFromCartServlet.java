package user.sevlet;

import DAO.CartDAO;
import entity.User;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.sql.SQLException;

@WebServlet(name = "RemoveFromCartServlet", urlPatterns = {"/removeFromCart"})
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userobj");

            if (user == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("error", "User not logged in.");
                out.print(gson.toJson(jsonResponse));
                out.flush();
                return;
            }

            int userId = user.getId();
            int bookId = Integer.parseInt(request.getParameter("bookId"));

            CartDAO cartDAO = new CartDAO();
            boolean success = cartDAO.removeFromCart(userId, bookId);

            jsonResponse.put("success", success);
            out.print(gson.toJson(jsonResponse));
            out.flush();
        } catch (SQLException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", e.getMessage());
            out.print(gson.toJson(jsonResponse));
            out.flush();
        }
    }
}
