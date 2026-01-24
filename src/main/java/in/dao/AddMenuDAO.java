package in.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import in.dbconnection.DatabaseConnection;
import in.dto.MenuDTO;

public class AddMenuDAO {

	public boolean insertMenu(MenuDTO menu) {
		
		String sql =
				"INSERT INTO menus(menu_date, dish_name, meal_type, price, availability, TIME_SLOT) VALUES(?, ?, ?, ?, ?, ?)";
		
		 try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
				
			    String menuDateStr = menu.getMenuDate();
			    Date sqlDate = Date.valueOf(menuDateStr);
			 
			    pstmt.setDate(1, sqlDate);;
				pstmt.setString(2, menu.getItemName());
				pstmt.setString(3, menu.getCategory());
				pstmt.setDouble(4, menu.getPrice());
				pstmt.setString(5, menu.getAvailability());
				pstmt.setString(6, menu.getTimeSlot());
							
				int rowsInserted = pstmt.executeUpdate();
				
				return rowsInserted > 0;
				
			} catch (SQLException e) {
				
				e.printStackTrace();
				return false;
			}
		
	}
	
}
