package cn.yangrongwei;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletOutputStream out = response.getOutputStream();
		out.println("No, we (login) do not accept http GET method here.");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// "application/x-www-form-urlencoded"
		// "multipart/form-data"
		// "text/plain"
		
		// Get the session object for this client session.
		// The parameter indicates to create a session
		// object if one does not exist
		String username = request.getParameter("user");
		String pass = request.getParameter("passwd");

		//http://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletRequest.html#getSession(boolean)
		//
		// 解困惑很久的不懂之谜	 http://iteedu.com/webtech/j2ee/javaservletsbczn/6.php
		// 万千烦恼因为不懂这一句 	
		// 2014/6/18
		//
//		HttpSession session = request.getSession(false);
//		if (session == null) {
//			// no session, create one
//			session = request.getSession(true);	// 打开一个新世界……  
//		} else {
//			// already in session
//		}
		HttpSession session = request.getSession(); // did all previous
		
		// int a = 1;
		
		ServletOutputStream out = response.getOutputStream();
		out.println("You are logined, any password in. " + session.getId());
//		response.addCookie(cookie);
		
	}

}
