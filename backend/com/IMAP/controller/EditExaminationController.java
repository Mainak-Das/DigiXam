package com.IMAP.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.Examination;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10MB
		maxFileSize = 1024 * 1024 * 50, // 50MB
		maxRequestSize = 1024 * 1024 * 100// 100MB
)
public class EditExaminationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditExaminationController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String user_id = request.getParameter("user");
		String sub_id = request.getParameter("sub");
		String dept_id = request.getParameter("dept");
		String year = request.getParameter("year");
		System.out.println("id: " + id);
		Part qsn = request.getPart("qsn");
		InputStream inputStream = null;
		if (qsn != null) {
			System.out.println(qsn.getSubmittedFileName());
			System.out.println(qsn.getSize());
			System.out.println(qsn.getContentType());
			String fileName = qsn.getSubmittedFileName();
			String path = request.getServletContext().getRealPath("/" + "files" + File.separator + fileName);
			System.out.println(path);
			inputStream = qsn.getInputStream();
			boolean success = new ExaminationController().upload(inputStream, path);
			if (success) {
				System.out.println("success");
			} else {
				System.out.println("not");
			}
		}
		Examination u = new Examination();
		u.setId(Integer.parseInt(id));
		u.setDept_id(Integer.parseInt(dept_id));
		u.setSub_id(Integer.parseInt(sub_id));
		u.setUser_id(Integer.parseInt(user_id));
		u.setYear(year);
		u.setQsn_name(new String[] { qsn.getSubmittedFileName() });
		u.setQsn(qsn);

		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if (dao.editExamination(u, inputStream) >= 1) {
				HttpSession session = request.getSession();
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("email", session.getAttribute("email"));
				response.sendRedirect("examination");

			} else {
				request.getSession().setAttribute("msg", "Server Error!");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
