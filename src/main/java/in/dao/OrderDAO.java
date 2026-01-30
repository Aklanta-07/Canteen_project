package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import in.dbconnection.DatabaseConnection;
import in.dto.MenuDTO;
import in.dto.OrderDTO;

public class OrderDAO {
	
	public List<MenuDTO> fetchTodayMenu() {
		
		String sql =
				"SELECT * FROM menus WHERE availability = 'available' AND TRUNC(menu_date) = TRUNC(SYSDATE) ORDER BY MEAL_TYPE";
		List<MenuDTO> menuItems = new ArrayList<>();

		try(Connection con = DatabaseConnection.getConnection();
				   Statement stmt = con.createStatement();
				   ResultSet rs = stmt.executeQuery(sql)) {
			
			
			while(rs.next()) {
				 MenuDTO dto = new MenuDTO();
		         dto.setMenuId(rs.getInt("MENU_ID"));
		         dto.setCategory(rs.getString("MEAL_TYPE"));
		         dto.setItemName(rs.getString("DISH_NAME"));
		         dto.setPrice(rs.getDouble("PRICE"));
		         dto.setAvailability(rs.getString("AVAILABILITY"));
		         dto.setTimeSlot(rs.getString("TIME_SLOT"));
		         dto.setStockQuantity(rs.getInt("STOCK_QUANTITY"));
				
		         menuItems.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return menuItems;
	}
	
	public int createOrder(OrderDTO order) {
		String sql =
				"INSERT INTO orders (user_email, total_amount, subtotal, tax_amount, order_status, payment_status) "
		                   + "VALUES (?, ?, ?, ?, ?, ?)";
		
		int generratedOrderId = 0;
		
		try(Connection con = DatabaseConnection.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql, new String[]{"ORDER_ID"})) {
			
			  pstmt.setString(1, order.getUserEmail());
	          pstmt.setDouble(2, order.getTotalAmount());
	          pstmt.setDouble(3, order.getSubtotal());
	          pstmt.setDouble(4, order.getTaxAmount());
	          pstmt.setString(5, "PENDING");
	          pstmt.setString(6, "UNPAID");
	          
	          int rowsInserted = pstmt.executeUpdate();
	          
	          if(rowsInserted > 0) {
	        	  ResultSet rs = pstmt.getGeneratedKeys();
	        	  if(rs.next()) {
	        		  generratedOrderId = rs.getInt(1);
	        	  }
	          }
	            
			
		}catch(Exception e) {
			e.printStackTrace();		
		}
		
		return generratedOrderId;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
