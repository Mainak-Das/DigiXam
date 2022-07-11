package com.IMAP.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.Examination;
import com.IMAP.required.PDFtoJPEG;
import com.IMAP.required.SendMail;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10MB
		maxFileSize = 1024 * 1024 * 50, // 50MB
		maxRequestSize = 1024 * 1024 * 100// 100MB
)
public class ExaminationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ExaminationController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user_id = request.getParameter("user");
		String sub_id = request.getParameter("sub");
		String dept_id = request.getParameter("dept");
		String year = request.getParameter("year");
		String due = request.getParameter("due");
		Part qsn = request.getPart("qsn");
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
				Examination u = new Examination();

				u.setDept_id(Integer.parseInt(dept_id));
				u.setSub_id(Integer.parseInt(sub_id));
				u.setUser_id(Integer.parseInt(user_id));
				u.setYear(year);
				u.setQsn_name(new_name);
				u.setQsn(qsn);
				u.setDuration(Integer.parseInt(due));
				DatabaseDAO dao;
				try {
					dao = new DatabaseDAO();
					dao.insertExam(u, inputStream);
					String p = request.getServerName() + ":" + request.getLocalPort() + request.getContextPath();
					new SendMail().examinationMail(u, p);
					HttpSession session = request.getSession();
					session.setAttribute("username", session.getAttribute("username"));
					session.setAttribute("email", session.getAttribute("email"));
					response.sendRedirect("examination");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
				} catch (AddressException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (MessagingException e) {
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
