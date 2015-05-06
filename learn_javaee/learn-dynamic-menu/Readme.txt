
代码稍许改编自以下链接（此文讲解的不错），以便不使用数据库展现核心概念——动态菜单。
感触：中文社区的内容渐渐有点东西了

http://www.cnblogs.com/likailan/p/3328761.html
  Ajax实现动态的二级级联菜单 (JavaScript + JSP)

http://www.cnblogs.com/zgqys1980/archive/2007/11/13/957653.html
  JavaScript 中文问题改正参考

------------------  
原文代码中出现了（但没有被用到） @WebServlet("/InitServlet")
所以原文代码需要  Servlet 3.0 ，在既有代码上降级到 Servlet 2.5 （以便运行在 Tomcat 6.0 上）做了以下修改

o 改 web.xml <web-app>
o 改 http://stackoverflow.com/questions/75786/eclipse-how-can-i-change-a-project-facet-from-tomcat-6-to-tomcat-5-5
o 将原来代码相关行注释掉  （可能是存在这行，导致上面 不能在 Eclipse 工程属性的 Project Facets 中直接改？）

成功. 估计  @WebServlet 是发布用的，可以简化在 web.xml 中费劲的配置．

Raymond 2014/6/15


<!-- 
Raymond: About version of web.xml
 http://stackoverflow.com/questions/15334776/where-i-can-find-valid-values-for-the-version-attribute-of-the-web-app-element-i
 http://en.wikipedia.org/wiki/Java_Servlet#History
  3.0, 2.5, 2.4, 2.3, 2.2, 2.1, 2.0, 1.0

For version 2.5
 http://docs.oracle.com/cd/E13222_01/wls/docs100/webapp/web_xml.html
  The correct text for the namespace declaration and schema location for the web.xml file is as follows.
  ....
 -->

使用 Servlet 3.0 是因为中央库可以找到（作为 Jave EE　b标准）
 	  <dependency>
		<groupId>javax.servlet</groupId>
		<artifactId>javax.servlet-api</artifactId>
		<version>3.0.1</version>
	</dependency>