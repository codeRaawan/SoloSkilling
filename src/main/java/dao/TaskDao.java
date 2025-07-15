package dao;

import java.awt.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.TaskEntity;
import entity.UserEntity;

public class TaskDao {
	private Connection connection;

	public TaskDao(Connection connection) {
		super();
		this.connection = connection;
	}
	
	public TaskEntity getNextTask(UserEntity user) {
	    TaskEntity nextTask = null;

	    String query = "SELECT task_id FROM user_task_record WHERE user_id = ? ORDER BY task_id DESC LIMIT 1";
	    try {
	        PreparedStatement pstmt = connection.prepareStatement(query);
	        pstmt.setInt(1, user.getId());
	        ResultSet rs = pstmt.executeQuery();

	        int nextTaskId = 1;

	        if (rs.next()) {
	            nextTaskId = rs.getInt("task_id") + 1; // Next task after last done
	        }

	        String taskQuery = "SELECT * FROM tasks WHERE id = ?";
	        PreparedStatement taskStmt = connection.prepareStatement(taskQuery);
	        taskStmt.setInt(1, nextTaskId);
	        ResultSet taskRs = taskStmt.executeQuery();

	        if (taskRs.next()) {
	            nextTask = new TaskEntity();
	            nextTask.setTaskId(taskRs.getInt("id"));
	            nextTask.setTaskTitle(taskRs.getString("title"));
	            nextTask.setTaskDescription(taskRs.getString("description"));
	            nextTask.setTaskSubject(taskRs.getString("subject"));
	            nextTask.setTaskXP(taskRs.getInt("xp_value"));
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return nextTask;
	}

	
	public ArrayList<TaskEntity> getAllTasks(){
		ArrayList<TaskEntity> tasks = new ArrayList<>();
		String queryString = "select * from tasks";
		try {
			PreparedStatement pstmt = connection.prepareStatement(queryString);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				TaskEntity taskEntity = new TaskEntity();
				taskEntity.setTaskId(rs.getInt("id"));
				taskEntity.setTaskTitle(rs.getString("title"));
				taskEntity.setTaskDescription(rs.getString("description"));
				taskEntity.setTaskSubject(rs.getString("subject"));
				taskEntity.setTaskXP(rs.getInt("xp_value"));
				tasks.add(taskEntity);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return tasks; 	
	}
	
	
	public ArrayList<TaskEntity> completedTasks(UserEntity user){
		ArrayList<TaskEntity> cTasks = new ArrayList<>();
		int userId = user.getId();
		String pstmtString = "select t.* from tasks t join user_task_record utr on t.id = utr.task_id where utr.user_id = ? order by t.id desc limit 5";
		try {
			PreparedStatement pstmt = connection.prepareStatement(pstmtString);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				TaskEntity taskEntity = new TaskEntity();
				taskEntity.setTaskId(rs.getInt("id"));
				taskEntity.setTaskTitle(rs.getString("title"));
				taskEntity.setTaskDescription(rs.getString("description"));
				taskEntity.setTaskSubject(rs.getString("subject"));
				taskEntity.setTaskXP(rs.getInt("xp_value"));
				cTasks.add(taskEntity);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return cTasks;
	}
}
