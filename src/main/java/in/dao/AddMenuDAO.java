package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import in.dbconnection.DatabaseConnection;
import in.dto.MenuDTO;

public class AddMenuDAO {

	public boolean insertMenu(MenuDTO menu) {
		
		String sql =
				"INSERT INTO menus(dish_name, meal_type, price, availability, TIME_SLOT) VALUES(?, ?, ?, ?, ?)";
		
		 try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
				
				pstmt.setString(1, menu.getItemName());
				pstmt.setString(2, menu.getCategory());
				pstmt.setDouble(3, menu.getPrice());
				pstmt.setString(4, menu.getAvailability());
				pstmt.setString(5, menu.getTimeSlot());
							
				int rowsInserted = pstmt.executeUpdate();
				
				return rowsInserted > 0;
				
			} catch (SQLException e) {
				
				e.printStackTrace();
				return false;
			}
		
	}
	
}
