package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import in.dbconnection.DatabaseConnection;
import in.dto.AdminDTO;

public class AdminProfileDAO {
	
	public AdminDTO profile() {
		String sql = "SELECT * FROM admin";
		AdminDTO admin = null;
		
		try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				admin = new AdminDTO();
				admin.setUserName(rs.getString("USERNAME"));
				admin.setEmail(rs.getString("EMAIL"));
				admin.setPhoneNo(Integer.parseInt(rs.getString("PHONE")));
				admin.setFullName(rs.getString("FULL_NAME"));
				admin.setRole(rs.getString("ROLE"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return admin;
	}
	
}
