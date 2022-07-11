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

public class DepartmentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DepartmentController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		Department d = new Department();

		d.setName(name);
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			dao.insertDepartment(d);
			HttpSession session = request.getSession();
			session.setAttribute("username", session.getAttribute("username"));
			session.setAttribute("email", session.getAttribute("email"));
			response.sendRedirect("department");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
