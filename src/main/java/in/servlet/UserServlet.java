package in.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import in.dao.UserDAO;
import in.dto.FieldsDTO;

@WebServlet("/profile")
public class UserServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session  = req.getSession(false);
		
		if(session == null || session.getAttribute("userEmail") == null) {
			resp.sendRedirect("login.jsp");
			return;
		}
		
		String userEmail = (String)session.getAttribute("userEmail");
		
		FieldsDTO dto = new FieldsDTO();
		dto.setEmail(userEmail);
		
		UserDAO dao = new UserDAO();
		FieldsDTO user = dao.fetchUser(dto);
		
		if(user == null) {
		    session.invalidate();
		    resp.sendRedirect("login.jsp?error=userNotFound");
		    return;
		}

		
		req.setAttribute("user", user);
		req.getRequestDispatcher("profile.jsp").forward(req, resp);
		
	}

}
