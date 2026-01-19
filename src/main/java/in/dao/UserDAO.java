package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import in.dbconnection.DatabaseConnection;
import in.dto.FieldsDTO;

public class UserDAO {
	
	public FieldsDTO fetchUser(FieldsDTO field) {
		
		String sql = "SELECT * FROM users WHERE email = ?";
		
		FieldsDTO user = null;
		
		try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, field.getEmail());
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				 user = new FieldsDTO();
		         user.setFullName(rs.getString("FULLNAME"));
		         user.setUserName(rs.getString("USERNAME"));
		         user.setEmail(rs.getString("EMAIL"));
		         user.setPhoneNo(Integer.parseInt(rs.getString("PHONE")));
                 user.setUserType(rs.getString("USERTYPE"));
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

}
