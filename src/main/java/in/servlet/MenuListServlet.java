package in.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.dao.MenuListDAO;
import in.dto.MenuDTO;

@WebServlet("/menulist")
public class MenuListServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MenuListDAO dao = new MenuListDAO();
		List<MenuDTO> menus = dao.fetchMenu();
		
		req.setAttribute("menus", menus);
		req.getRequestDispatcher("/menuList.jsp").forward(req, resp);
	}

}
