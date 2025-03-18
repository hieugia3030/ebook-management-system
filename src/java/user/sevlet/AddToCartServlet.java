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

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            // Get user object from session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("userobj");

            if (user == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "You must be logged in to add items to the cart.");
                out.print(gson.toJson(jsonResponse));
                out.flush();
                return;
            }

            int userId = user.getId();
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = 1;

            CartDAO cartDAO = new CartDAO();
            boolean success = cartDAO.addToCart(userId, bookId, quantity);

            jsonResponse.put("success", success);
            jsonResponse.put("message", success ? "Item added to cart!" : "Failed to add item.");

            out.print(gson.toJson(jsonResponse));
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error occurred: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        }
        out.flush();
    }
}
