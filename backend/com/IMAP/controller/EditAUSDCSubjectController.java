package com.IMAP.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.AssignedUserDepartmentSubject;

/**
 * Servlet implementation class EditAUSDCSubjectController
 */
public class EditAUSDCSubjectController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditAUSDCSubjectController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user_id = request.getParameter("user");
		String sub_id = request.getParameter("sub");
		String dept_id = request.getParameter("dept");
		String id = request.getParameter("id");
		String year = request.getParameter("year");
		AssignedUserDepartmentSubject u = new AssignedUserDepartmentSubject();
		u.setId(Integer.parseInt(id));
		u.setDept_id(Integer.parseInt(dept_id));
		u.setSub_id(Integer.parseInt(sub_id));
		u.setUser_id(Integer.parseInt(user_id));
		u.setYear(year);
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if (dao.editAssigned(u) >= 1) {
				HttpSession session = request.getSession();
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("email", session.getAttribute("email"));
				response.sendRedirect("assign");
			} else {
				request.getSession().setAttribute("msg", "Server Error!");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
