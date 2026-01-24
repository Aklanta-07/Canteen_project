package in.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.dao.AddMenuDAO;
import in.dto.MenuDTO;

@WebServlet("/admin-add-menu")
public class AddMenuServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	    req.setCharacterEncoding("UTF-8");
	    resp.setContentType("text/html; charset=UTF-8");
    	PrintWriter out = resp.getWriter();
		
    	String menuDate = req.getParameter("menuDate");
		String itemName = req.getParameter("dishName");
		String category = req.getParameter("mealType");
		double price = Double.parseDouble(req.getParameter("price"));
		String availability = req.getParameter("availability");
		String timeSlot = req.getParameter("timeslot");
		
		if(itemName == null || itemName.trim().isEmpty()) {
		    resp.sendRedirect("adminDashboard.jsp?section=add-menu&error=empty_name");
		    return;
		}

		if(itemName.length() < 3) {
		    resp.sendRedirect("adminDashboard.jsp?section=add-menu&error=name_too_short");
		    return;
		}
		
		if(price <= 0) {
	       resp.sendRedirect("adminDashboard.jsp?section=add-menu&error=invalid_price");
		        return;
	    }
		    
	    if(price > 10000) {
           resp.sendRedirect("adminDashboard.jsp?section=add-menu&error=price_too_high");
	       return;
	    }
	    
	    if(timeSlot == null || timeSlot.trim().isEmpty()) {
		    resp.sendRedirect("adminDashboard.jsp?section=add-menu&error=empty_date");
		    return;
		}

		
		MenuDTO dto = new MenuDTO();
		dto.setMenuDate(menuDate);
		dto.setItemName(itemName.trim());
		dto.setCategory(category.trim());
		dto.setPrice(price);
		dto.setAvailability(availability.trim());
		dto.setTimeSlot(timeSlot.trim());
		
		AddMenuDAO dao = new AddMenuDAO();
		boolean isInserted = dao.insertMenu(dto);
		
		if(isInserted) {
		    resp.sendRedirect("adminDashboard.jsp?section=add-menu&added=success");
		} else {
		    resp.sendRedirect("adminDashboard.jsp?section=add-menu&error=failed");
		}
	}

}
