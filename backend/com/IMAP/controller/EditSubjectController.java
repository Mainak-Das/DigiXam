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
 * Servlet implementation class EditSubjectController
 */
public class EditSubjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditSubjectController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String year = request.getParameter("year");
		String sem = request.getParameter("sem");
		String dept = request.getParameter("dept");
		Subject u = new Subject();
		u.setId(Integer.parseInt(id));
		u.setName(name);
		u.setYear(year);
		u.setName(name);
		u.setDept(Integer.parseInt(dept));
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if (dao.editSubject(u) >= 1) {
				HttpSession session = request.getSession();
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("email", session.getAttribute("email"));
				response.sendRedirect("subject");
			} else {
				request.getSession().setAttribute("msg", "Server Error!");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
