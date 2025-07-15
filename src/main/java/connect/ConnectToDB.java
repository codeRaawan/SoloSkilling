package connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectToDB {
	
	private static String urlString = "jdbc:mysql://localhost:3306/soloskilling";
	private static String userString = "root";
	private static String passwordString = "admin";
	private static Connection connection;
	public static Connection getConn() {
		
		//class loader
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					connection=DriverManager.getConnection(urlString, userString, passwordString);
					if(connection!=null) {
						System.out.println("Connection Successful");
					} else {
						System.out.println("Something went wrong");
					}
				} catch (ClassNotFoundException | SQLException e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				return connection;
	}
}
