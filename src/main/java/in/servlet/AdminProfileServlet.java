package in.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import in.dao.AdminProfileDAO;
import in.dto.AdminDTO;

@WebServlet("/admin-profile")
public class AdminProfileServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if(session == null) {
			resp.sendRedirect("adminLogin.jsp");
	        return;
		}
		
		 String sessionEmail = (String) session.getAttribute("adminEmail");
		 if(sessionEmail == null || sessionEmail.isEmpty()) {
		        resp.sendRedirect("adminLogin.jsp");
		        return;
		    }
		
		AdminProfileDAO adminDAO  = new AdminProfileDAO();
		AdminDTO admin = adminDAO.profile();
		
		if(admin == null) {
		    session.invalidate();
		    resp.sendRedirect("adminLogin.jsp?error=userNotFound");
		    return;
		}
		
		req.setAttribute("admin", admin);
		req.getRequestDispatcher("adminProfile.jsp").forward(req, resp);
	}

}
