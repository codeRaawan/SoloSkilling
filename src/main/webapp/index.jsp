<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>SoloSkilling | Welcome</title>

  <!-- Orbitron Font -->
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@600&display=swap" rel="stylesheet">

  <style>
    * { box-sizing: border-box; }

    body {
      margin: 0;
      padding: 0;
      background: #000;
      color: #fff;
      font-family: 'Orbitron', sans-serif;
      overflow: hidden;
    }

    #matrixCanvas {
      position: fixed;
      top: 0;
      left: 0;
      z-index: 0;
      width: 100vw;
      height: 100vh;
    }

    .intro-container {
      position: absolute;
      top: 40%;
      left: 50%;
      transform: translate(-50%, -50%);
      font-size: 4em;
      color: #0ff;
      text-shadow: 0 0 10px #0ff, 0 0 20px #0ff, 0 0 40px #00faff;
      opacity: 0;
      animation: flicker 3s ease-in-out forwards, moveToCorner 1.5s ease-in-out 3s forwards;
      z-index: 2;
    }

    @keyframes flicker {
      0% { opacity: 0; }
      10% { opacity: 1; }
      20% { opacity: 0.4; }
      30% { opacity: 1; }
      40% { opacity: 0.3; }
      50% { opacity: 1; }
      100% { opacity: 1; }
    }

    @keyframes moveToCorner {
      to {
        top: 30px;
        left: 40px;
        transform: translate(0, 0);
        font-size: 2em;
      }
    }

    .logo-container {
      position: absolute;
      top: 52%;
      left: 50%;
      transform: translate(-50%, -50%);
      opacity: 0;
      animation: fadeInLogo 1.8s ease-in-out 4.5s forwards;
      z-index: 1;
    }

    .logo-container img {
      width: 300px;
      height: auto;
      filter: drop-shadow(0 0 15px #0ff);
      border-radius: 12px;
    }

    @keyframes fadeInLogo {
      0% {
        opacity: 0;
        transform: translate(-50%, -40%) scale(0.8);
      }
      100% {
        opacity: 1;
        transform: translate(-50%, -50%) scale(1);
      }
    }

    .cta-box {
      position: absolute;
      bottom: 100px;
      left: 50%;
      transform: translateX(-50%);
      text-align: center;
      z-index: 2;
    }

    .cta a {
      display: inline-block;
      margin: 10px;
      padding: 15px 30px;
      font-size: 1.2em;
      text-decoration: none;
      color: #fff;
      border: 2px solid #0ff;
      border-radius: 10px;
      background-color: transparent;
      transition: background-color 0.3s, color 0.3s;
    }

    .cta a:hover {
      background-color: #0ff;
      color: #000;
    }

    footer {
      position: absolute;
      bottom: 20px;
      width: 100%;
      text-align: center;
      color: #aaa;
      font-size: 0.9em;
      z-index: 2;
    }

    .popup-box {
      position: absolute;
      opacity: 0;
      padding: 12px 20px;
      color: #0ff;
      background: rgba(0, 255, 255, 0.08);
      border: 1px solid #0ff;
      border-radius: 10px;
      font-size: 0.95em;
      font-family: 'Orbitron', sans-serif;
      box-shadow: 0 0 12px #0ff;
      z-index: 3;
      animation-duration: 0.9s;
      animation-fill-mode: forwards;
      backdrop-filter: blur(3px);
      max-width: 230px;
      line-height: 1.4em;
    }

    @keyframes popInBounce {
      0%   { transform: scale(0.4); opacity: 0; }
      60%  { transform: scale(1.1); opacity: 1; }
      80%  { transform: scale(0.95); }
      100% { transform: scale(1); }
    }
  </style>
</head>

<body>

  <!-- Matrix Canvas -->
  <canvas id="matrixCanvas"></canvas>

  <!-- SoloSkilling Text -->
  <div class="intro-container" id="introTitle">SoloSkilling</div>

  <!-- Logo Image -->
  <div class="logo-container" id="logoArea">
    <img src="Images/logo.png" alt="SoloSkilling Logo">
  </div>

  <!-- Popups (spaced inside from edges) -->
  <div id="popupLeft1" class="popup-box" style="top: 20%; left: 100px;">
    Gain Real-World XP by Building Projects
  </div>

  <div id="popupLeft2" class="popup-box" style="top: 65%; left: 120px;">
    Explore Backend to DevOps Journey
  </div>

  <div id="popupRight1" class="popup-box" style="top: 25%; right: 100px;">
    Master Skills Employers Actually Need
  </div>

  <div id="popupRight2" class="popup-box" style="top: 70%; right: 120px;">
    Get Interview-Ready with Real Practice
  </div>

  <!-- CTA Buttons -->
  <div class="cta-box">
    <div class="cta">
      <a href="Register.jsp">Start Your Quest</a>
      <a href="Login.jsp">Login</a>
    </div>
  </div>

  <!-- Footer -->
  <footer>
    &copy; 2025 SoloSkilling. All rights reserved.
  </footer>

  <!-- JavaScript -->
  <script>
    // Matrix Effect
    const canvas = document.getElementById("matrixCanvas");
    const ctx = canvas.getContext("2d");

    canvas.height = window.innerHeight;
    canvas.width = window.innerWidth;

    let matrixChars = "アァイイウエオカキクケコABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    matrixChars = matrixChars.split("");

    let fontSize = 16;
    let columns = canvas.width / fontSize;
    let drops = Array(Math.floor(columns)).fill(1);

    function drawMatrix() {
      ctx.fillStyle = "rgba(0, 0, 0, 0.05)";
      ctx.fillRect(0, 0, canvas.width, canvas.height);

      ctx.fillStyle = "#0F0";
      ctx.font = fontSize + "px monospace";

      for (let i = 0; i < drops.length; i++) {
        const text = matrixChars[Math.floor(Math.random() * matrixChars.length)];
        ctx.fillText(text, i * fontSize, drops[i] * fontSize);

        if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
          drops[i] = 0;
        }

        drops[i]++;
      }
    }

    setInterval(drawMatrix, 35);

    // Popup Animation Trigger
    setTimeout(() => {
      const popups = [
        "popupLeft1",
        "popupLeft2",
        "popupRight1",
        "popupRight2"
      ];

      popups.forEach((id, index) => {
        setTimeout(() => {
          const el = document.getElementById(id);
          el.style.animationName = "popInBounce";
        }, index * 900); // Delay between each popup
      });

    }, 6500); // Start after main animations
  </script>

</body>
</html>
