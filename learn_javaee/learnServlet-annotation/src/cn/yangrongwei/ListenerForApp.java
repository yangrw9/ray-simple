package cn.yangrongwei;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class ListenerForApp
 *
 */
@WebListener
public class ListenerForApp implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public ListenerForApp() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Our application launched.");
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Bye bye ... yes, bye bye.");
    }
	
}
