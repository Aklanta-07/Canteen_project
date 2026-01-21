package in.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import in.dao.ForgotPswdDAO;
import in.dto.FieldsDTO;

@WebServlet("/admin-forgot-pswd")
public class AdminForgotPasswordServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
        String email = req.getParameter("email");
		
		FieldsDTO field = new FieldsDTO();
		field.setEmail(email);
		
		ForgotPswdDAO dao = new ForgotPswdDAO();
		try {
		    boolean isPresent = dao.findAdminEmail(field);
		    if(isPresent) {
		        // Store email in session or request
		        HttpSession session = req.getSession();
		        session.setAttribute("adminEmail", field.getEmail());
		        
		        // Redirect to reset password page
		        resp.sendRedirect("resetAdminPswd.jsp");
		    } else {
		    	 
                resp.sendRedirect("forgotAdminPswd.jsp?message=Access denied");
		    }
		} catch (SQLException e) {
		    e.printStackTrace();
		}
		
		
	}

}
