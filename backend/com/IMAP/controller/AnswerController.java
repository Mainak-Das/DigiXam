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
import com.IMAP.model.Answer;
import com.IMAP.required.PDFtoJPEG;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10MB
		maxFileSize = 1024 * 1024 * 50, // 50MB
		maxRequestSize = 1024 * 1024 * 100// 100MB
)
public class AnswerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AnswerController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String file_id = request.getParameter("file_id");
		String user_id = request.getParameter("user_id");
		Part qsn = request.getPart("ans");

		InputStream inputStream = null;

		if (qsn != null) {
			System.out.println(qsn.getSubmittedFileName());
			System.out.println(qsn.getSize());
			System.out.println(qsn.getContentType());

			String fileName = qsn.getSubmittedFileName();
			String path = request.getServletContext().getRealPath("/" + "files" + File.separator + fileName);
			String path2 = request.getServletContext().getRealPath("/" + "doc");
			System.out.println(path);
			inputStream = qsn.getInputStream();
			boolean success = new EditController().uploadPhoto(inputStream, path);
			if (success) {
				System.out.println("success");
				String[] new_name = new PDFtoJPEG().pdfToImg(path, path2);
				System.out.println(path2);
				System.out.println("ss: " + new_name.toString());
				Answer u = new Answer();

				u.setFile_id(Integer.parseInt(file_id));
				u.setAns_name(new_name);
				u.setAns(qsn);
				u.setUser_id(Integer.parseInt(user_id));

				DatabaseDAO dao;
				try {
					dao = new DatabaseDAO();
					dao.insertAnswer(u, inputStream);
					HttpSession session = request.getSession();
					session.setAttribute("username", session.getAttribute("username"));
					session.setAttribute("email", session.getAttribute("email"));
					session.setAttribute("file_id", session.getAttribute("file_id"));
					session.setAttribute("user_id", session.getAttribute("user_id"));
					response.sendRedirect("screen2");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				System.out.println("not");
			}
		}

	}

	public boolean upload(InputStream is, String path) {
		boolean f = false;
		byte[] byt;
		try {
			byt = new byte[is.available()];
			is.read();
			FileOutputStream fos = new FileOutputStream(path);
			fos.write(byt);
			fos.flush();
			fos.close();
			f = true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}
}
