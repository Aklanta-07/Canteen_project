package in.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import in.dbconnection.DatabaseConnection;
import in.dto.FieldsDTO;

public class ForgotPswdDAO {
	
	boolean isPresent;
	boolean isAvailable;
	
	public boolean findEmail(FieldsDTO field) throws SQLException {
		
		String sql = "SELECT * FROM users WHERE email = ?";
		
		try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql) ) {
			
			pstmt.setString(1, field.getEmail());
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next() ) {
				isPresent = true;
			}
			
			return isPresent;
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}
	
    public boolean findAdminEmail(FieldsDTO field) throws SQLException {
		
		String sql = "SELECT * FROM admin WHERE email = ?";
		
		try(Connection con = DatabaseConnection.getConnection();
				   PreparedStatement pstmt = con.prepareStatement(sql) ) {
			
			pstmt.setString(1, field.getEmail());
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next() ) {
				isAvailable = true;
			}
			
			return isAvailable;
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}


}
