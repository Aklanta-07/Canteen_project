package in.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import in.dbconnection.DatabaseConnection;
import in.dto.MenuDTO;

public class MenuListDAO {
	
	public List<MenuDTO> fetchMenu() {
		
		List<MenuDTO> menus = new ArrayList<>();
		String sql = "SELECT * FROM menus";
		
		try(Connection con = DatabaseConnection.getConnection();
				   Statement stmt = con.createStatement();
				   ResultSet rs = stmt.executeQuery(sql)) {
			
			
			while(rs.next()) {
				 MenuDTO dto = new MenuDTO();
		         dto.setMenuId(rs.getInt("MENU_ID"));
		         Date menuDate = rs.getDate("MENU_DATE");
		         if (menuDate != null) {
		             dto.setMenuDate(menuDate.toString()); // Format: yyyy-MM-dd
		         }
		         dto.setCategory(rs.getString("MEAL_TYPE"));
		         dto.setItemName(rs.getString("DISH_NAME"));
		         dto.setPrice(rs.getDouble("PRICE"));
		         dto.setAvailability(rs.getString("AVAILABILITY"));
				
		         menus.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return menus;
	}
}
