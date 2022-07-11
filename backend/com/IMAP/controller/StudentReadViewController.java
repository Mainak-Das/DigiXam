package com.IMAP.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.google.gson.Gson;

public class StudentReadViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public StudentReadViewController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		System.out.println(id + "vi");
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if (dao.getFileName(Integer.parseInt(id))[0].equals("true")) {
				String file[] = new Gson().fromJson(dao.getFileName(Integer.parseInt(id))[1], String[].class);

				System.out.println(file[0]);

				String param = Arrays.toString(file);
				param = param.substring(1, param.length() - 1); // removing enclosing []
				String encArray = URLEncoder.encode(param, "utf-8");

				// Send encArray as parameter.
				HttpSession session = request.getSession();
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("email", session.getAttribute("email"));

				session.setAttribute("id", id);

				response.sendRedirect("screen1?qsn_id=" + id + "&file=" + encArray);
			} else {
				request.getSession().setAttribute("msg", "Server Error!");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
