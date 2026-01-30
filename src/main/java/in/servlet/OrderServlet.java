package in.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.dao.OrderDAO;
import in.dto.MenuDTO;

@WebServlet("/order")
public class OrderServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		OrderDAO dao = new OrderDAO();
		List<MenuDTO> menuItems = dao.fetchTodayMenu();
		
		req.setAttribute("menuItems", menuItems);
		req.getRequestDispatcher("/order.jsp").forward(req, resp);
	}

}
