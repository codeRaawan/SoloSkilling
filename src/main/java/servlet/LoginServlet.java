package servlet;

import java.io.CharConversionException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connect.ConnectToDB;
import dao.UserDao;
import entity.UserEntity;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{
		
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String usernameString = req.getParameter("username");
		String passwordString = req.getParameter("password");
		UserDao uDao = new UserDao(ConnectToDB.getConn());
		UserEntity user = uDao.userLogin(usernameString, passwordString);
		
		HttpSession session = req.getSession();
		
		if(user!=null) {
			session.setAttribute("user", user);
			System.out.println("loggedIN");
			res.sendRedirect("Dashboard.jsp");
		} else {
			session.setAttribute("errorMsg", "invalid email or password");
			System.out.println("lag gaye");
			res.sendRedirect("Login.jsp");
		}
	}
}
