package servlet;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connect.ConnectToDB;
import dao.UserDao;
import entity.UserEntity;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String nameString = req.getParameter("name");
		String usernameString= req.getParameter("username");
		String emailString= req.getParameter("email");
		String passwordString = req.getParameter("password");
		UserEntity user = new UserEntity(nameString, usernameString, emailString, passwordString);
		UserDao dao = new UserDao(ConnectToDB.getConn());
		boolean registered = dao.userRegister(user);
		
		HttpSession session = req.getSession();
		
		if(registered) {
			session.setAttribute("successMsg", "You've Registered Successfully");
			res.sendRedirect("Login.jsp");
		} else {
			session.setAttribute("errorMsg", "Something went wrong");
			res.sendRedirect("Register.jsp");
		}
	}
}
