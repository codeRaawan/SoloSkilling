package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.catalina.realm.AuthenticatedUserRealm;

import entity.UserEntity;

public class UserDao {
	private Connection connection;

	public UserDao(Connection connection) {
		super();
		this.connection = connection;
	}

	
	public UserEntity getUserById(int id) {
	    UserEntity user = null;
	    try {
	        String query = "SELECT * FROM user WHERE id = ?";
	        PreparedStatement ps = connection.prepareStatement(query);
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            user = new UserEntity();
	            user.setId(rs.getInt("id"));
	            user.setName(rs.getString("name"));
	            user.setUsername(rs.getString("username"));
	            user.setEmail(rs.getString("email"));
	            user.setLevel(rs.getInt("level"));
	            user.setXp(rs.getInt("xp"));
	            // add other fields too
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public boolean userRegister(UserEntity user) {
		boolean f = false;
		try {
			String query = "insert into user(name, username, email, password) values(?,?,?,?)";
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getUsername());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getPassword());
			int i = pstmt.executeUpdate();
			if (i > 0) {
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return false;
	}

	public UserEntity userLogin(String username, String password) {
		UserEntity user = null;
		try {

			String query = "select * from user where username = ? and password = ?";
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				user=new UserEntity();
				user.setId(rs.getInt(1));
				user.setName(rs.getString(2));
				user.setUsername(rs.getString(3));
				user.setEmail(rs.getString(4));
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();

		}
		return user;
	}
}
