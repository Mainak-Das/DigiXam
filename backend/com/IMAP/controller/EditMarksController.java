package com.IMAP.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.Marks;

public class EditMarksController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditMarksController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String aid = request.getParameter("aid");
		String eid = request.getParameter("eid");
		String marks = request.getParameter("marks");
		String id = request.getParameter("id");
		Marks u = new Marks();
		u.setAid(Integer.parseInt(aid));
		u.setEid(Integer.parseInt(eid));
		u.setMarks(Integer.parseInt(marks));
		u.setId(Integer.parseInt(id));

		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if (dao.editMarks(u) >= 1) {
				HttpSession session = request.getSession();
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("email", session.getAttribute("email"));
				response.sendRedirect("result");
			} else {
				request.getSession().setAttribute("msg", "Server Error!");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
