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

import in.dao.AdminLoginDAO;
import in.dto.FieldsDTO;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		 req.setCharacterEncoding("UTF-8");
		    resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			
			FieldsDTO field = new FieldsDTO();
			field.setEmail(email);
			field.setPassword(password);
			
		    AdminLoginDAO dao = new AdminLoginDAO();
			boolean isPresent = dao.fetchField(field);
			
			out.println("<html>");
			out.println("<title>Result</title>");
			out.println("<body>");
			
			try {
				if(isPresent) {
					 HttpSession session = req.getSession();
					 session.setAttribute("adminEmail", field.getEmail());  
				     resp.sendRedirect("adminDashboard.jsp");
			         
				} 
				 else {
					 req.setAttribute("error", "❌ Access Denied - Please register or Try again!.");
		    		 req.getRequestDispatcher("login.jsp").forward(req, resp);
				}
			} catch(Exception e) {
				RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
				rd.include(req, resp);
				out.println("<h2>Error!</h2>");
				out.println("<h4> Access Denied. </h4>");
			}
		
	}

}
