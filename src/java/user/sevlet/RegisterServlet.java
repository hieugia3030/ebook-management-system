
package user.sevlet;

import entity.User;
import DB.DBConnect;
import DAO.UserDAOImpl;
import java.io.IOException;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp, Object check) throws ServletException, IOException {
        
        try{
            String name = req.getParameter("fname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String password = req.getParameter("password");

          
            User us = new User();
            us.setName(name);
            us.setEmail(email);
            us.setPhone(phone);
            us.setPassword(password);

           
            Connection conn = DBConnect.getConn();

            HttpSession session =req.getSession();
            
            if (check!=null) {
                
            UserDAOImpl dao = new UserDAOImpl(conn);
            boolean f = dao.userRegister(us);
            if(f)
            {           
            
               // System.out.println("User Register Success..");
               
               session.setAttribute("succMsg","Registration Successfully..");
               resp.sendRedirect("register.jsp");
               
            } else {
                //System.out.println("Something wrong on server.."); 
                session.setAttribute("failedMSG","Something wrong on server.");
                resp.sendRedirect("register.jsp");
              }                                 
            } else {
                //System.out.println("Please Check Agree & Terms Condition");
                session.setAttribute("failedMSG","Please Check Agree & Terms Condition");
                 resp.sendRedirect("register.jsp");
            }  
            

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
