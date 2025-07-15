package servlet;

import java.io.IOException;
import java.security.PrivateKey;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connect.ConnectToDB;
import entity.UserEntity;

@WebServlet("/CompleteTaskServlet")
public class CompleteTaskServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException{
		HttpSession session = req.getSession(false);
		UserEntity userEntity = (UserEntity) session.getAttribute("user");
		
		if(userEntity==null) {
			res.sendRedirect("Login.jsp");
			return;
		}
		 int userId = userEntity.getId();
		 int taskId = Integer.parseInt(req.getParameter("taskId"));
		LocalDateTime nowDateTime = LocalDateTime.now();
		
		try {
			Connection connection = ConnectToDB.getConn();
			String query = "insert into user_task_record (user_id, task_id, completed_date) values(?,?,?)";
			PreparedStatement pstmt = connection.prepareStatement(query);
			pstmt.setInt(1, userId);
			pstmt.setInt(2, taskId);
			pstmt.setTimestamp(3, Timestamp.valueOf(nowDateTime));
			pstmt.executeUpdate();
			
			String xpquery = "update user set xp = xp + (select xp_value from tasks where id = ?) where id = ?";
			PreparedStatement xpstate = connection.prepareStatement(xpquery);
			xpstate.setInt(1, taskId);
			xpstate.setInt(2, userId);
			xpstate.executeUpdate();
			
			String levelquery = "update user set level = xp/100 where id = ?";
			PreparedStatement levelstate = connection.prepareStatement(levelquery);
			levelstate.setInt(1, userId);
			levelstate.executeUpdate();
			
			res.sendRedirect("TodayMission.jsp?msg=Done");
			session.setAttribute("user", userEntity);
			
			
			
			
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
}
