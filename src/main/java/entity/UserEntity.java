package entity;

import javax.swing.plaf.multi.MultiInternalFrameUI;

public class UserEntity {
	private int id;
	private String name;
	private String username;
	private String email;
	private String password;
	private int xp;
	private int level;

	public int getXp() {
	    return xp;
	}

	public void setXp(int xp) {
	    this.xp = xp;
	}

	public int getLevel() {
	    return level;
	}

	public void setLevel(int level) {
	    this.level = level;
	}

	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public UserEntity(String name, String username, String email, String password, int xp, int level) {
		super();
		this.name = name;
		this.username = username;
		this.email = email;
		this.password = password;
		this.xp = xp;
		this.level = level;
	}
	
	public UserEntity(String name, String username, String email, String password) {
		super();
		this.name = name;
		this.username = username;
		this.email = email;
		this.password = password;
	}
	public UserEntity() {
		super();
	}
	
	
}
