/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package admin.servelet;

import DAO.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "UpdateOrderServlet", urlPatterns = { "/update-order" })
public class UpdateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            OrderDAO orderDAO = new OrderDAO();
            boolean success = orderDAO.updateOrderStatus(orderId, status);

            if (success) {
                out.print("{\"success\": true, \"orderId\": " + orderId + ", \"status\": \"" + status + "\"}");
            } else {
                out.print("{\"success\": false, \"error\": \"Failed to update order status in the database.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();

            // Send error details back to client
            out.print("{\"success\": false, \"error\": \"" + e.getMessage().replace("\"", "'") + "\"}");
        }
    }
}