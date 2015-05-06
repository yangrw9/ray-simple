package com.yar9.learn;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yar9.learn.fake.StreetService;
import com.yar9.learn.model.District;
import com.yar9.learn.model.Street;

@WebServlet("/cascade")
public class CascadeServlet extends HttpServlet{

    /**
	 * 
	 */
	private static final long serialVersionUID = -7740288544754774302L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        int id =Integer.parseInt(req.getParameter("id"));
        District district=new District();
        district.setId(id);
        
        /*
         * StreetService  ss为操作数据库的对象.
         * 调用该对象的getAllStreet()方法，可以从数据库中取得所有的区域信息，封装为List<Street>对象，并返回。
         * 其中Street是数据库Street表的实体类 
         * 为了把重点放在Ajax和级联菜单的实现上，本文省略了操作数据库的代码！！！
         */
        StreetService ss=new StreetService();
        List<Street> streets=ss.getAllStreet(district);
        //把得到的街道对象集合拼接成字符串文本
        StringBuffer sb=new StringBuffer();
        for(int i=0;i<streets.size();i++){
            sb.append(streets.get(i).getId()).append("=").append(streets.get(i).getName());
            if(i!=streets.size()-1){
                sb.append(",");
            }
        }
        //servlet不转向或重定向到任何页面，使用resp.getWriter().print()方法可以把文本响应给XMLHttpRequest对象
         PrintWriter out = resp.getWriter();
         out.print(sb.toString());
         out.flush();
         out.close();
    }
    
}