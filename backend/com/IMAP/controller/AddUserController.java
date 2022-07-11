package com.IMAP.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.User;
import com.IMAP.required.RandomUsername;
import com.IMAP.required.SendMail;

public class AddUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddUserController() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String role = request.getParameter("role");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String year = request.getParameter("year");
		String dept_id = request.getParameter("dept");

		String password = request.getParameter("password");
		if (password == null) {
			password = new RandomUsername().generateUsername(6);
		}
		String username = name.split(" ", 2)[0].toLowerCase() + new RandomUsername().generateUsername(3);
		User u = new User();
		u.setRole(role);
		u.setName(name);
		u.setUsername(username);
		u.setEmail(email);
		u.setPassword(password);
		u.setDept(Integer.parseInt(dept_id));
		u.setYear(year);
		// out.println(u.getUsername());
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			dao.registration(u);
			new SendMail().registrationMail(u);
			HttpSession session = request.getSession();
			session.setAttribute("username", session.getAttribute("username"));
			session.setAttribute("email", session.getAttribute("email"));
			response.sendRedirect("home");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

}
