package entity;

public class TaskEntity {
	private int taskId;
	private String taskTitle;
	private String taskDescription;
	private String taskSubject;
	private int taskXP;
	
	
	public int getTaskId() {
		return taskId;
	}
	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}
	public String getTaskTitle() {
		return taskTitle;
	}
	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}
	public String getTaskDescription() {
		return taskDescription;
	}
	public void setTaskDescription(String taskDescription) {
		this.taskDescription = taskDescription;
	}
	public String getTaskSubject() {
		return taskSubject;
	}
	public void setTaskSubject(String taskSubject) {
		this.taskSubject = taskSubject;
	}
	public int getTaskXP() {
		return taskXP;
	}
	public void setTaskXP(int taskXP) {
		this.taskXP = taskXP;
	}
	
	public TaskEntity(int taskId, String taskTitle, String taskDescription, String taskSubject, int taskXP) {
		super();
		this.taskId = taskId;
		this.taskTitle = taskTitle;
		this.taskDescription = taskDescription;
		this.taskSubject = taskSubject;
		this.taskXP = taskXP;
	}
	
	public TaskEntity(String taskTitle, String taskDescription, String taskSubject, int taskXP) {
		super();
		this.taskTitle = taskTitle;
		this.taskDescription = taskDescription;
		this.taskSubject = taskSubject;
		this.taskXP = taskXP;
	}
	
	public TaskEntity() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
}
