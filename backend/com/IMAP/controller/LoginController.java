package com.IMAP.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.User;
import com.IMAP.required.UserRole;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// System.out.println("LoginController!");
		PrintWriter out = response.getWriter();
		// out.println("HELLO!");
		String usernameOrEmail = request.getParameter("usernameOrEmail");
		String password = request.getParameter("password");
		// out.println(password);
		User u = new User();
		if (usernameOrEmail.contains("@")) {
			u.setEmail(usernameOrEmail);
		} else
			u.setUsername(usernameOrEmail);
		u.setPassword(password);
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if (dao.login(u)) {
				HttpSession session = request.getSession();
				session.setAttribute("username", u.getUsername());
				session.setAttribute("email", u.getEmail());
				UserRole role = new UserRole();
				// if (!role.getRole(u.getEmail(), u.getUsername())[0].equals("student")) {
				response.sendRedirect("home");
				// }
//				else {
//					response.sendRedirect("examination");
//				}
			} else {
				response.sendRedirect("login");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
