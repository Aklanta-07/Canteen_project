package in.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import in.dao.ResetPswdDAO;
import in.dto.FieldsDTO;

@WebServlet("/reset-pswd")
public class ResetPasswordServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String email = req.getParameter("email");
		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");
		
		PrintWriter out = resp.getWriter();
		
		if(!newPassword.equals(confirmPassword)) {
			resp.sendRedirect("resetPswd.jsp?msg=Error");
	         return;
		}
		
		FieldsDTO field = new FieldsDTO();
		field.setEmail(email);
		field.setPassword(confirmPassword.trim());
		
		ResetPswdDAO dao = new ResetPswdDAO();
		try {
		boolean isUpdated = dao.resetPassword(field);
		
		if(isUpdated) {
			HttpSession session = req.getSession();
			session.removeAttribute("email");
			
			resp.sendRedirect("login.jsp?msg=success");
			
		} else {
			out.println("<h2>Error!</h2>");
            out.println("<p>Failed to update password!</p>");
        }
		
		}catch (Exception e) {
            e.printStackTrace();
            out.println("<h2>Error!</h2>");
            out.println("<p>Database error occurred.</p>");
        }
		
		
	}

}
