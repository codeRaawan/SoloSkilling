<%@page import="entity.UserEntity"%>
<%@page import="entity.TaskEntity"%>
<%@page import="dao.UserDao"%>
<%@page import="dao.TaskDao"%>
<%@page import="connect.ConnectToDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // 🚫 Login Check
    UserEntity user = (UserEntity) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // ✅ DB se latest User fetch
    UserDao udao = new UserDao(ConnectToDB.getConn());
    user = udao.getUserById(user.getId());
    session.setAttribute("user", user); // session update

    int level = user.getLevel();
    int xp = user.getXp();
    if(xp>100){
    	int dig = xp/100;
    	xp=xp-(dig*100);
    }
    int nextXP = 100;
    int xpPercent = (int) ((xp * 100.0f) / nextXP);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>SoloSkilling | Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      min-height: 100vh;
      background: url('Images/dashboard.jpg') no-repeat center center/cover;
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
      font-family: 'Orbitron', sans-serif;
      font-size: 26px;
      color: #5fffd0;
      text-shadow: 0 0 10px #5fffd0;
    }

    .logo-title img {
      height: 40px;
      margin-right: 15px;
    }

    .profile-dropdown {
      position: relative;
    }

    .profile-btn {
      background: transparent;
      border: 2px solid #5fffd0;
      color: #5fffd0;
      padding: 10px 18px;
      font-size: 14px;
      border-radius: 10px;
      cursor: pointer;
      text-shadow: 0 0 5px #5fffd0;
      transition: all 0.3s ease;
    }

    .profile-btn:hover {
      background-color: #5fffd0;
      color: #000;
      box-shadow: 0 0 20px #5fffd0;
    }

    .dropdown-content {
      display: none;
      position: absolute;
      right: 0;
      margin-top: 10px;
      background: rgba(0, 0, 0, 0.95);
      min-width: 180px;
      border: 1px solid #5fffd0;
      border-radius: 10px;
      box-shadow: 0 0 20px #5fffd0;
      backdrop-filter: blur(6px);
      z-index: 100;
    }

    .dropdown-content a {
      color: #5fffd0;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
    }

    .dropdown-content a:hover {
      background: rgba(95, 255, 208, 0.1);
    }

    .profile-dropdown:hover .dropdown-content {
      display: block;
    }

    .dashboard-container {
      padding: 40px 20px;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 40px;
    }

    .welcome-box {
      background: rgba(0, 0, 0, 0.5);
      border: 2px solid #5fffd0;
      border-radius: 20px;
      padding: 30px;
      text-align: center;
      box-shadow: 0 0 20px #5fffd0, 0 0 30px #9e7cff;
      max-width: 700px;
      width: 100%;
      animation: fadeIn 1s ease-out;
    }

    .welcome-box h2 {
      font-size: 32px;
      color: #5fffd0;
      text-shadow: 0 0 15px #5fffd0;
      margin-bottom: 10px;
    }

    .xp-bar-container {
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid #5fffd0;
      border-radius: 10px;
      margin-top: 20px;
      height: 22px;
      width: 100%;
      overflow: hidden;
    }

    .xp-bar {
      height: 100%;
      width: <%=xpPercent%>%;
      background: linear-gradient(to right, #5fffd0, #9e7cff);
      transition: width 1.2s ease-in-out;
    }

    .cards {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
      justify-content: center;
      animation: fadeIn 1.2s ease-in;
    }

    .card {
      width: 260px;
      padding: 20px;
      background: rgba(0, 0, 0, 0.35);
      border: 1px solid #5fffd0;
      border-radius: 16px;
      box-shadow: 0 0 15px #5fffd0, 0 0 25px #9e7cff;
      backdrop-filter: blur(6px);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
      transform: translateY(-5px) scale(1.05);
      box-shadow: 0 0 30px #00e6a8, 0 0 35px #9e7cff;
    }

    .card h3 {
      font-size: 20px;
      color: #5fffd0;
      margin-bottom: 12px;
    }

    .card p {
      color: #ccc;
      font-size: 14px;
      margin-bottom: 10px;
    }

    .card a {
      display: inline-block;
      margin-top: 10px;
      padding: 6px 14px;
      background-color: #5fffd0;
      color: #000;
      font-weight: bold;
      border-radius: 8px;
      text-decoration: none;
      transition: 0.3s;
    }

    .card a:hover {
      background-color: #9e7cff;
      color: #fff;
      box-shadow: 0 0 12px #5fffd0;
    }

    .progress-arc-box {
      background: rgba(0, 0, 0, 0.45);
      border: 1px solid #5fffd0;
      border-radius: 16px;
      padding: 20px;
      width: 100%;
      max-width: 900px;
      text-align: center;
      box-shadow: 0 0 15px #5fffd0;
    }

    .progress-arc-box h3 {
      margin-bottom: 10px;
      color: #5fffd0;
      font-size: 22px;
      text-shadow: 0 0 5px #5fffd0;
    }

    .progress-arcs {
      display: flex;
      justify-content: space-around;
      flex-wrap: wrap;
      gap: 20px;
    }

    .arc {
      width: 140px;
      height: 90px;
      background: rgba(0,0,0,0.3);
      border: 1px solid #9e7cff;
      border-radius: 12px;
      padding: 10px;
      color: #fff;
      box-shadow: 0 0 10px #9e7cff;
      font-size: 14px;
    }

    footer {
      text-align: center;
      padding: 12px;
      font-size: 13px;
      color: #888;
      background: rgba(0, 0, 0, 0.6);
      margin-top: auto;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to   { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>

  <div class="header-container">
    <div class="logo-title">
      <img src="Images/logo.png" alt="Logo" />
      SoloSkilling | Dashboard
    </div>
    <div class="profile-dropdown">
      <button class="profile-btn">👤 <%= user.getName() %></button>
      <div class="dropdown-content">
        <a href="Profile.jsp"><i class="fa-solid fa-user"></i> Profile</a>
        <a href="Settings.jsp"><i class="fa-solid fa-gears"></i> Settings</a>
        <a href="LogoutServlet"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a>
      </div>
    </div>
  </div>

  <div class="dashboard-container">
    <div class="welcome-box">
      <h2>Welcome, <%= user.getName() %> 👋</h2>
      <p>You are currently <strong>Level <%= level %></strong> (XP: <%= xp %>/100)</p>
      <div class="xp-bar-container">
        <div class="xp-bar"></div>
      </div>
    </div>

    <div class="progress-arc-box">
      <h3>🔥 Your Journey Progress</h3>
      <div class="progress-arcs">
        <div class="arc">Foundation<br>✅ Completed</div>
        <div class="arc">Intermediate<br>⏳ 40% Done</div>
        <div class="arc">Advanced<br>❌ Not Started</div>
        <div class="arc">Deployment<br>❌ Not Started</div>
        <div class="arc">Career & Community<br>❌ Locked</div>
      </div>
    </div>

    <div class="cards">
      <div class="card">
        <h3>Today's Mission</h3>
        <% TaskDao tda = new TaskDao(ConnectToDB.getConn()); %>
        <% TaskEntity task = (TaskEntity) tda.getNextTask(user);  %>
        <p><%=task.getTaskTitle()%></p>
        <a href="TodayMission.jsp">Start Now 🚀</a>
      </div>
      <div class="card">
        <h3>All Tasks</h3>
        <p>Explore the full task list and plan ahead.</p>
        <a href="Tasks.jsp">View Tasks 📋</a>
      </div>
      <div class="card">
        <h3>Skill Progress</h3>
        <p>Java: 80%, MySQL: 60%, React: 30%</p>
      </div>
      <div class="card">
        <h3>Next Goal</h3>
        <p>Deploy a CRUD App with GitHub Actions</p>
      </div>
    </div>
  </div>

  <footer>&copy; 2025 SoloSkilling. Your grind is your glow. ⚔️</footer>

</body>
</html>
