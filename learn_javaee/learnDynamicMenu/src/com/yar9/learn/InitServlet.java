package com.yar9.learn;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yar9.learn.fake.DistrictService;
import com.yar9.learn.model.District;

/**
 * Servlet implementation class InitServlet
 */
//@WebServlet("/InitServlet")
public class InitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException ,IOException {
    	doPost(req, resp);
    };
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException ,IOException {
    	req.setCharacterEncoding("UTF-8");
	        resp.setCharacterEncoding("UTF-8");
	        /*
	         * DistrictService  ds为操作数据库的对象.
	         * 调用该对象的getAllDistrict()方法，可以从数据库中取得所有的区域信息，封装为List<District>对象，并返回。
	         * 其中District是数据库District表的实体类 
	         * 为了把重点放在Ajax和级联菜单的实现上，本文省略了操作数据库的代码！！！
	         */
	        DistrictService ds = new DistrictService();
	        List<District> districts = ds.getAllDistrict();
	        //List<District>对象存在request范围中，并转向到主页
	        req.setAttribute("districts", districts);
	        req.getRequestDispatcher("index.jsp").forward(req, resp);	}

}
