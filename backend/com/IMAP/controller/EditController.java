package com.IMAP.controller;

import java.io.File;
import java.io.FileOutputStream;
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
import com.IMAP.model.User;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10MB
		maxFileSize = 1024 * 1024 * 50, // 50MB
		maxRequestSize = 1024 * 1024 * 100// 100MB
)
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EditController() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");

		String year = request.getParameter("year");
		String dept_id = request.getParameter("dept");

		Part profile = request.getPart("profile");
		InputStream inputStream = null;
		User u = new User();
		if (profile != null) {
			System.out.println(profile.getSubmittedFileName());
			System.out.println(profile.getSize());
			System.out.println(profile.getContentType());
			String profile_name = profile.getSubmittedFileName();
			String path = request.getServletContext().getRealPath("/" + "files" + File.separator + profile_name);
			// String path =
			// "C:\\Users\\monis\\Desktop\\digixam\\DigiXam\\src\\main\\webapp\\Assets\\img"
			// + File.separator
			// + profile_name;
			// String path = request.getRealPath("files");

			System.out.println(path);
			inputStream = profile.getInputStream();
			boolean success = uploadPhoto(inputStream, path);
			u.setProfile_name(profile_name);
			u.setProfile_path(path);
			u.setProfile(profile);
			if (success) {
				System.out.println("success");

			} else {
				System.out.println("not");
			}

		}

		u.setId(Integer.parseInt(id));
		u.setName(name);
		u.setEmail(email);
		u.setDept(Integer.parseInt(dept_id));
		u.setYear(year);
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if (dao.editUser(u, inputStream) >= 1) {
				HttpSession session = request.getSession();
				session.setAttribute("username", session.getAttribute("username"));
				session.setAttribute("email", session.getAttribute("email"));
				response.sendRedirect("user");
			} else {
				request.getSession().setAttribute("msg", "Server Error!");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public boolean uploadPhoto(InputStream is, String path) {
		boolean f = false;
		try {
			FileOutputStream fos = new FileOutputStream(path);
			byte[] data = new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();
			fos.flush();
			f = true;
		} catch (Exception e) {

		}
		return f;
	}

}
