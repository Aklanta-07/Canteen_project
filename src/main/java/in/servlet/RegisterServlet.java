package in.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.dao.RegisterDAO;
import in.dto.FieldsDTO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet{
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		
	    req.setCharacterEncoding("UTF-8");
        res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		String fullName = req.getParameter("fullname");
		String userName = req.getParameter("username");
		String email = req.getParameter("email");
		String phoneNo = req.getParameter("phone");
		String userType = req.getParameter("usertype");
		String password = req.getParameter("password");
		String confirmpassword = req.getParameter("confirmpassword");
		
		if (!password.equals(confirmpassword)) {
            res.sendRedirect("register.jsp?error=password");
            return;
        }
		
		FieldsDTO field = new FieldsDTO();
		field.setFullName(fullName);
		field.setUserName(userName);
		field.setEmail(email);
		field.setPhoneNo(Integer.parseInt(phoneNo));
		field.setUserType(userType);
		field.setPassword(password);
		
		RegisterDAO dao = new RegisterDAO();
		
		boolean isInserted = dao.insertField(field);
		
		out.println("<html>");
		out.println("<title> Result </title>");
		out.println("<body>");
		
		if(isInserted) {
			 res.sendRedirect("login.jsp?registered=success");
	         
		} else {
			res.sendRedirect("register.jsp?error=failed");
		}
		
		 out.println("<br><a href='login.jsp'>Login</a>");
	     out.println("</body>");
		 
	}
}
