<%@page import="entity.TaskEntity"%>
<%@page import="connect.ConnectToDB"%>
<%@page import="dao.TaskDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="entity.UserEntity"%>
<%
UserEntity user = (UserEntity) session.getAttribute("user");
if (user == null) {
	response.sendRedirect("Login.jsp");
	return;
}
int level = user.getLevel();
int xp = user.getXp();
int nextXP = 100;
int xpPercent = (int) ((xp * 100.0f) / nextXP);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>SoloSkilling | Today's Mission</title>
	<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

	<style>
		* { box-sizing: border-box; margin: 0; padding: 0; }

		body {
			background: url('Images/dashboard.jpg') no-repeat center center/cover;
			min-height: 100vh;
			font-family: 'Orbitron', sans-serif;
			color: #fff;
			display: flex;
			flex-direction: column;
		}

		.header-container {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 20px 40px;
			background: rgba(0, 0, 0, 0.7);
			box-shadow: 0 0 15px #5fffd0;
			position: sticky;
			top: 0;
			z-index: 10;
		}

		.logo-title {
			display: flex;
			align-items: center;
			font-size: 24px;
			color: #5fffd0;
			text-shadow: 0 0 10px #5fffd0;
		}
		.logo-title img {
			height: 40px;
			margin-right: 12px;
		}

		.profile-dropdown {
			position: relative;
		}
		.profile-btn {
			background: transparent;
			border: 2px solid #5fffd0;
			color: #5fffd0;
			padding: 10px 18px;
			border-radius: 10px;
			cursor: pointer;
			transition: 0.3s;
		}
		.profile-btn:hover {
			background-color: #5fffd0;
			color: #000;
			box-shadow: 0 0 15px #5fffd0;
		}

		.dropdown-content {
			display: none;
			position: absolute;
			right: 0;
			margin-top: 10px;
			background: rgba(0,0,0,0.95);
			min-width: 180px;
			border: 1px solid #5fffd0;
			border-radius: 10px;
			box-shadow: 0 0 20px #5fffd0;
			backdrop-filter: blur(6px);
		}
		.dropdown-content a {
			color: #5fffd0;
			padding: 12px 16px;
			display: block;
			text-decoration: none;
		}
		.profile-dropdown:hover .dropdown-content {
			display: block;
		}

		.progress-box {
			text-align: center;
			margin-top: 20px;
		}
		.progress-bar {
			width: 80%;
			margin: auto;
			background: #333;
			border: 2px solid #5fffd0;
			border-radius: 20px;
			overflow: hidden;
			box-shadow: 0 0 15px #5fffd0;
		}
		.progress-bar-inner {
			height: 22px;
			background: linear-gradient(to right, #5fffd0, #9e7cff);
			width: <%=xpPercent%>%;
			text-align: center;
			color: #000;
			font-weight: bold;
			line-height: 22px;
		}

		.mission-container {
			max-width: 800px;
			margin: 40px auto;
			background: rgba(0, 0, 0, 0.6);
			padding: 30px;
			border: 2px solid #5fffd0;
			border-radius: 20px;
			box-shadow: 0 0 20px #5fffd0;
		}

		.mission-container h2 {
			text-align: center;
			color: #5fffd0;
			margin-bottom: 30px;
		}

		.task-box {
			background: rgba(0,0,0,0.4);
			padding: 20px;
			border-radius: 12px;
			box-shadow: 0 0 10px #5fffd0;
			margin-bottom: 30px;
		}
		.task-box p strong {
			color: #5fffd0;
		}
		
		.go-back {
      text-align: center;
      margin-top: 30px;
    }

    .go-back a {
      color: #5fffd0;
      font-weight: bold;
      text-decoration: none;
      padding: 10px 20px;
      border: 1px solid #5fffd0;
      border-radius: 10px;
      transition: all 0.3s;
    }

    .go-back a:hover {
      background-color: #5fffd0;
      color: #000;
      box-shadow: 0 0 20px #5fffd0;
    }

		footer {
      text-align: center;
      padding: 12px;
      font-size: 13px;
      color: #888;
      background: rgba(0, 0, 0, 0.6);
      margin-top: auto;
    }
	</style>
</head>
<body>

	<!-- Header -->
	<div class="header-container">
		<div class="logo-title">
			<img src="Images/logo.png" alt="Logo"> SoloSkilling | Mission Board
		</div>
		<div class="profile-dropdown">
			<button class="profile-btn">👤 <%=user.getName()%></button>
			<div class="dropdown-content">
				<a href="Profile.jsp">Profile</a>
				<a href="LastActivity.jsp">Last 5 Missions</a>
				<a href="LogoutServlet">Logout</a>
			</div>
		</div>
	</div>

	<!-- XP Progress Bar -->
	<div class="progress-box">
		<h5>Level <%=level%> | XP: <%=xp%>/100</h5>
		<div class="progress-bar">
			<div class="progress-bar-inner"><%=xp%> XP</div>
		</div>
	</div>

	<!-- Task Container -->
	<div class="mission-container">
		<h2>🎯 Today's Mission</h2>
		<%
			TaskDao taskDao = new TaskDao(ConnectToDB.getConn());
			TaskEntity task = taskDao.getNextTask(user);
		%>
		<div class="task-box">
			<p><strong>Title:</strong> <%=task.getTaskTitle()%></p>
			<p><strong>Description:</strong> <%=task.getTaskDescription()%></p>
			<p><strong>Subject:</strong> <%=task.getTaskSubject()%></p>
			<p><strong>XP:</strong> <%=task.getTaskXP()%></p>

			<!-- Trigger Modal -->
			<button type="button" class="btn btn-outline-info mt-3" data-toggle="modal" data-target="#completeModal">
				✅ Mark as Done
			</button>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="completeModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content" style="background: #111; color: #5fffd0; border: 1px solid #5fffd0;">
				<div class="modal-header">
					<h5 class="modal-title">Confirm Completion</h5>
					<button type="button" class="close text-light" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">Are you sure you've completed this task?</div>
				<div class="modal-footer">
					<form action="CompleteTaskServlet" method="post">
						<input type="hidden" name="taskId" value="<%=task.getTaskId()%>">
						<button type="submit" class="btn btn-success">✅ Yes, Done</button>
					</form>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				</div>
			</div>
		</div>
	</div>
	<div class="go-back">
      <a href="Dashboard.jsp"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>

	<footer>&copy; 2025 SoloSkilling. Rise. Grind. Repeat. ⚔️</footer>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
