package com.yar9.learn;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yar9.learn.fake.DistrictService;
import com.yar9.learn.model.District;

/**
 * Servlet implementation class InitServlet
 */
@WebServlet("/initial")
public class InitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DistrictService ds;
	
	@Override
	public void init() throws ServletException {
		super.init();
		ds = new DistrictService();
	}
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException ,IOException {
//    	doPost(req, resp);
//    };
//    
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException ,IOException {
//    	resp.getOutputStream().println("gege");
    	req.setCharacterEncoding("UTF-8");
	        resp.setCharacterEncoding("UTF-8");
	        
	        List<District> districts = ds.getAllDistrict();
	        //List<District>对象存在request范围中，并转向到主页
	        req.setAttribute("districts", districts);
	        req.getRequestDispatcher("/index.jsp").forward(req, resp);	
    	}

}
