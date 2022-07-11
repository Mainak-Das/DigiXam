package com.IMAP.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.Subject;

/**
 * Servlet implementation class AddSubjectController
 */
public class AddSubjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddSubjectController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String year = request.getParameter("year");
		String sem = request.getParameter("sem");
		String dept = request.getParameter("dept");
		Subject d = new Subject();
		d.setSem(sem);
		d.setYear(year);
		d.setName(name);
		d.setDept(Integer.parseInt(dept));
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			dao.insertSubject(d);
			HttpSession session = request.getSession();
			session.setAttribute("username", session.getAttribute("username"));
			session.setAttribute("email", session.getAttribute("email"));
			response.sendRedirect("subject");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
