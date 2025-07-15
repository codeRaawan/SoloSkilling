<%@page import="entity.TaskEntity"%>
<%@page import="java.util.ArrayList"%>
<%@page import="connect.ConnectToDB"%>
<%@page import="dao.TaskDao"%>
<%@page import="entity.UserEntity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
UserEntity user = (UserEntity) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("Login.jsp");
    return;
}

TaskDao td = new TaskDao(ConnectToDB.getConn());
ArrayList<TaskEntity> taskList = td.completedTasks(user);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SoloSkilling | Recent Tasks</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            background: url('Images/dashboard.jpg') no-repeat center center/cover;
            background-attachment:fixed;
            font-family: 'Orbitron', sans-serif;
            color: #fff;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: rgba(0, 0, 0, 0.7);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 0 15px #5fffd0;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 26px;
            color: #5fffd0;
            text-shadow: 0 0 10px #5fffd0;
        }

        .logo img {
            height: 40px;
            margin-right: 15px;
        }

        .main-container {
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 30px;
        }

        .section-title {
            font-size: 32px;
            color: #5fffd0;
            text-shadow: 0 0 15px #5fffd0;
            margin-bottom: 10px;
        }

        .task-card {
            background: rgba(0, 0, 0, 0.4);
            border: 2px solid #5fffd0;
            border-radius: 15px;
            padding: 20px 30px;
            width: 100%;
            max-width: 700px;
            box-shadow: 0 0 20px #5fffd0, 0 0 30px #9e7cff;
            backdrop-filter: blur(5px);
            transition: transform 0.3s ease;
        }

        .task-card:hover {
            transform: scale(1.02);
            box-shadow: 0 0 25px #00e6a8, 0 0 35px #9e7cff;
        }

        .task-title {
            font-size: 22px;
            color: #9e7cff;
            margin-bottom: 10px;
        }

        .task-info {
            font-size: 15px;
            color: #ccc;
            margin-bottom: 6px;
        }

        .no-task {
            font-size: 20px;
            color: #ddd;
            margin-top: 40px;
            text-shadow: 0 0 5px #5fffd0;
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

<div class="header">
    <div class="logo">
        <img src="Images/logo.png" alt="Logo" />
        SoloSkilling | Recent Tasks
    </div>
</div>

<div class="main-container">
    <h1 class="section-title">Last 5 Tasks Completed ⚔️</h1>

    <% if (taskList.size() == 0) { %>
        <p class="no-task">No tasks completed yet. Begin your journey! 🚀</p>
    <% } else {
        for (TaskEntity task : taskList) {
    %>
    <div class="task-card">
        <div class="task-title">🎯 <%= task.getTaskTitle() %></div>
        <div class="task-info">📝 <%= task.getTaskDescription() %></div>
        <div class="task-info">⚡ XP Earned: <%= task.getTaskXP() %></div>
        <div class="task-info">📚 Subject: <%= task.getTaskSubject() %></div>
    </div>
    <%  }
    } %>
    
    <div class="go-back">
      <a href="Dashboard.jsp"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
    </div>
    
</div>

<footer>
    &copy; 2025 SoloSkilling | Keep Skilling, Keep Thriving 🚀
</footer>

</body>
</html>
