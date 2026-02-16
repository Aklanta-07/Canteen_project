package in.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.dao.ManageMenuDAO;
import in.dao.MenuListDAO;
import in.dto.MenuDTO;

@WebServlet("/menulist")
public class MenuListServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MenuListDAO dao = new MenuListDAO();
		dao.updateStatus();
		List<MenuDTO> menus = dao.fetchMenu();
		
		req.setAttribute("menus", menus);
		req.getRequestDispatcher("/menuList.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String category = req.getParameter("category");
		String availability = req.getParameter("availability");
		
		MenuDTO menu = new MenuDTO();
		menu.setCategory(category);
		menu.setAvailability(availability);
		
		ManageMenuDAO menuDAO = new ManageMenuDAO();
		List<MenuDTO> menus = menuDAO.filterMenu(menu);
		
		req.setAttribute("menus", menus);
		req.getRequestDispatcher("/menuList.jsp").forward(req, resp);
	}

}
