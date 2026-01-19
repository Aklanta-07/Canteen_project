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
import javax.servlet.*;

import in.dao.LoginDAO;
import in.dto.FieldsDTO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		    req.setCharacterEncoding("UTF-8");
		    res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();
			
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			
			FieldsDTO field = new FieldsDTO();
			field.setEmail(email);
			field.setPassword(password);
			
		    LoginDAO dao = new LoginDAO();
			boolean isPresent = dao.fetchField(field);
			
			out.println("<html>");
			out.println("<title> Result </title>");
			out.println("<body>");
			
			try {
				if(isPresent) {
					 HttpSession session = req.getSession();
					 session.setAttribute("userEmail", field.getEmail());  
				     res.sendRedirect("home.jsp");
			         
				} 
				 else {
					 req.setAttribute("error", "❌ Access Denied - Please register or Try again!.");
		    		 req.getRequestDispatcher("login.jsp").forward(req, res);
				}
			} catch(Exception e) {
				RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
				rd.include(req, res);
				out.println("<h2>Error!</h2>");
				out.println("<h4> Access Denied. </h4>");
			}
	}		
			
}
