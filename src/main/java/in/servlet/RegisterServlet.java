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
		String phoneNo = req.getParameter("phone").trim();
		String userType = req.getParameter("usertype");
		String password = req.getParameter("password");
		String confirmpassword = req.getParameter("confirmpassword");
		
		if(fullName != null) {
			fullName = fullName.trim();
		}
		if(fullName == null && fullName.isEmpty()) {
			req.setAttribute("error", "Name is required");
			req.getRequestDispatcher("register.jsp").forward(req, res);
			return;
		}
		if(fullName.isBlank()) {
			req.setAttribute("error", "Name cannot be only spaces");
			req.getRequestDispatcher("register.jsp").forward(req, res);
			return;
		}
		if(fullName.length() < 2) {
			req.setAttribute("error", "Name must be atleast 2 characters");
			req.getRequestDispatcher("register.jsp").forward(req, res);
			return;
		}
		
		if (!password.equals(confirmpassword)) {
            res.sendRedirect("register.jsp?error=password");
            return;
        }
		
		FieldsDTO field = new FieldsDTO();
		field.setFullName(fullName.trim());
		field.setUserName(userName.trim());
		field.setEmail(email.trim());
		field.setPhoneNo(Integer.parseInt(phoneNo));
		field.setUserType(userType.trim());
		field.setPassword(password.trim());
		
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
