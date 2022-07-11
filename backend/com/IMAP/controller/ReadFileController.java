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

/**
 * Servlet implementation class ReadFileController
 */
public class ReadFileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ReadFileController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String qid = request.getParameter("qid");
		String aid = request.getParameter("aid");
		System.out.println(qid + "qid");
		System.out.println(aid + "aid");
		DatabaseDAO dao, dao1;
		if (qid != null) {
			try {
				dao = new DatabaseDAO();
				if (dao.getFileName(Integer.parseInt(qid))[0].equals("true")) {
					String file[] = new Gson().fromJson(dao.getFileName(Integer.parseInt(qid))[1], String[].class);

					System.out.println(file[0]);

					String param = Arrays.toString(file);
					param = param.substring(1, param.length() - 1); // removing enclosing []
					String encArray = URLEncoder.encode(param, "utf-8");

					// Send encArray as parameter.
					HttpSession session = request.getSession();
					session.setAttribute("username", session.getAttribute("username"));
					session.setAttribute("email", session.getAttribute("email"));

					session.setAttribute("qid", qid);

					response.sendRedirect("question?file=" + encArray);
				} else {
					request.getSession().setAttribute("msg", "Server Error!");
					response.sendRedirect("error.jsp");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (aid != null) {
			try {
				dao1 = new DatabaseDAO();
				if (dao1.getAnswer(Integer.parseInt(aid))[0].equals("true")) {
					String file[] = new Gson().fromJson(dao1.getAnswer(Integer.parseInt(aid))[1], String[].class);

					System.out.println(file[0]);

					String param = Arrays.toString(file);
					param = param.substring(1, param.length() - 1); // removing enclosing []
					String encArray = URLEncoder.encode(param, "utf-8");

					// Send encArray as parameter.
					HttpSession session = request.getSession();
					session.setAttribute("username", session.getAttribute("username"));
					session.setAttribute("email", session.getAttribute("email"));

					session.setAttribute("aid", aid);

					response.sendRedirect("answer?file=" + encArray);
				} else {
					request.getSession().setAttribute("msg", "Server Error!");
					response.sendRedirect("error.jsp");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
