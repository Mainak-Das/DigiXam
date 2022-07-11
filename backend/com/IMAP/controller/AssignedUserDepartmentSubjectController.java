package com.IMAP.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.UserDepartmentSubject;

/**
 * Servlet implementation class AssignedUserDepartmentSubjectController
 */
public class AssignedUserDepartmentSubjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AssignedUserDepartmentSubjectController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String dept = request.getParameter("dept");
		String sub = request.getParameter("sub");
		String user = request.getParameter("user");
		String year = request.getParameter("year");
		System.out.println(dept + sub + user + year);

		UserDepartmentSubject uds = new UserDepartmentSubject();
		uds.setDept_id(Integer.parseInt(dept));
		uds.setSub_id(Integer.parseInt(sub));
		uds.setUser_id(Integer.parseInt(user));
		uds.setYear(year);
		try {
			DatabaseDAO dao = new DatabaseDAO();
			dao.assigned(uds);
			HttpSession session = request.getSession();
			session.setAttribute("username", session.getAttribute("username"));
			session.setAttribute("email", session.getAttribute("email"));
			response.sendRedirect("assign");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
