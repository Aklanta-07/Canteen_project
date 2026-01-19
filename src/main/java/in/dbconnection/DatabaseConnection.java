package in.dbconnection;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DatabaseConnection {
	
private static DataSource datasource = null;
	
	static {
		try {
			File f = new File("D:\\Advanced Java\\CanteenProject\\db.properties");
			FileInputStream fis = new FileInputStream(f);
			
			Properties p = new Properties();
			p.load(fis);
			
			String url = p.getProperty("db.url");
			String uname = p.getProperty("db.uname");
			String pswd = p.getProperty("db.pswd");
			
			HikariConfig config = new HikariConfig();
			
			config.setJdbcUrl(url);
			config.setUsername(uname);
			config.setPassword(pswd);
			
			datasource = new HikariDataSource(config);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws SQLException{	
		 return datasource.getConnection();
	}

}
