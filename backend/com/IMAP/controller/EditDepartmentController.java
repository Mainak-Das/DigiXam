package com.IMAP.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.Department;

/**
 * Servlet implementation class EditDepartmentController
 */
public class EditDepartmentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditDepartmentController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");

		Department u = new Department();
		u.setId(Integer.parseInt(id));
		u.setName(name);

		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if (dao.editDepartment(u) >= 1) {
				HttpSession session = request.getSession();
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("email", session.getAttribute("email"));
				response.sendRedirect("department");
			} else {
				request.getSession().setAttribute("msg", "Server Error!");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
