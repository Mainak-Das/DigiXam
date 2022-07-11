package com.IMAP.required;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.Examination;
import com.IMAP.model.ForgotPasswordModel;
import com.IMAP.model.NewPasswordModel;
import com.IMAP.model.User;

public class SendMail {
	Session session;
	final String fromEmail = "digixamofficial@gmail.com";
	final String password = "wtvmyyfmgmaqcigb";

	public SendMail() {
		Properties p = new Properties();
		p.setProperty("mail.smtp.host", "smtp.gmail.com");
		p.setProperty("mail.smtp.port", "587");
		p.setProperty("mail.smtp.auth", "true");
		p.setProperty("mail.smtp.starttls.enable", "true");
		p.put("gmail.smtp.socketFactory.port", "587");
		p.put("gmail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		session = Session.getInstance(p, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});
	}

	public boolean otpMail(ForgotPasswordModel fpm)
			throws AddressException, MessagingException, UnsupportedEncodingException {
		boolean test = false;
		String toMail = fpm.getEmail();
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(fromEmail, "DigiXam"));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
		String otp = fpm.getOtp();
		message.setSubject("Password Recovery Code");
		message.setText(
				"We received a request to reset your digiXam login password. Please validate the OTP on digiXam's authentication confirmation page.\r\n"
						+ "Your One Time Password is " + otp);
		Transport.send(message);
		test = true;
		return test;
	}

	public boolean passwordChangedMail(NewPasswordModel npm)
			throws AddressException, MessagingException, UnsupportedEncodingException {
		boolean test = false;
		String toMail = npm.getEmail();
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(fromEmail, "DigiXam"));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
		String np = npm.getPassword();
		message.setSubject("New Password");
		message.setText("Your DigiXam's password has been changed.\r\n" + "Your New Password is " + np);
		Transport.send(message);
		test = true;
		return test;
	}

	public boolean registrationMail(User u) throws AddressException, MessagingException, UnsupportedEncodingException {
		boolean test = false;
		String toMail = u.getEmail();
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(fromEmail, "DigiXam"));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
		String n = u.getName();
		String un = u.getUsername();
		String e = u.getEmail();
		String p = u.getPassword();
		message.setSubject("Login Credential!");
		message.setText("Hello, " + n + "\nYour DigiXam's login credentials are:\r\n" + "Your User Name is: " + un
				+ "\nYour Password is: " + p);
		Transport.send(message);
		test = true;
		return test;
	}

	public boolean examinationMail(Examination u, String path)
			throws AddressException, MessagingException, UnsupportedEncodingException, SQLException {
		boolean test = false;
		int dept_id = u.getDept_id();
		String year = u.getYear();
		User us = new User();
		us.setDept(dept_id);
		us.setYear(year);
		// ArrayList<String> emails = (ArrayList<String>) new
		// DatabaseDAO().getEmails(us);
		// HashMap<String, String> emails = new DatabaseDAO().getEmails(us);
		// List<HashMap<String, String>> emails = new DatabaseDAO().getEmails(us);
		HashMap<String, ArrayList<String>> emails = new DatabaseDAO().getEmails(us);
		String[] e = new String[emails.get("emails").size()];
		System.out.println("ssssss:" + emails.size() + e.length);
		for (int i = 0; i < emails.get("emails").size(); i++) {
			e[i] = emails.get("emails").get(i);
		}

		InternetAddress[] address = new InternetAddress[e.length];
		int i = 0;
		for (String email : e) {
			System.out.println("email:" + email);
			address[i] = new InternetAddress(email);
			i++;
		}
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(fromEmail, "DigiXam"));
		message.addRecipients(Message.RecipientType.TO, address);
//		String n=u.getName(); 
//		String un=u.getUsername(); 
//		String e=u.getEmail(); 
//		String p=u.getPassword(); 
		message.setSubject("Examination Credential!");
		// message.setText("Hello, " + n + "\nYour DigiXam's login credentials are:\r\n"
		// + "Your User Name is: " + un
		// + "\nYour Password is: " + p);
		message.setText("Hello, Yours Examination Login Link is:" + path + "/student-examination");
		Transport.send(message);
		test = true;
		return test;
	}

}