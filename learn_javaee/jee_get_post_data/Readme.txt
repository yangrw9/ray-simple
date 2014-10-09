
@WebServlet("/weixin")
public class WeixinBroker extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletInputStream  stream = request.getInputStream();
		//request.setCharacterEncoding("UTF-8");
		BufferedReader reader = request.getReader();

	}
}

要“反复”使用 Servlet 所 POST 上来的数据，应先读到 String 中（或其他 Buffer 中），这样做简单、有效．


做过以下尝试（精巧地）复用 ，皆失败
o mark/reset 组合 （Reader 或 InputStream）
o BufferedInputStream 之 mark/reset

	首先  mark/reset 组合不一定可用，其次使用者可能关闭流，令使后继使用者无法复用．
	如对于从 request 获得的 ServletInputStream 或 BufferedReader ，它们的 mark/reset 就不可用．
	虽然 BufferedInputStream 能确保 mark/reset 可用，但它不能保障流不被关闭．

结论，如果为达到目的，所用“高级技巧”实在是古怪，那这技巧本身就是个大问题．

流模型中，想要“复用（输入）流”，也实在是个有点妖的诉求．


http://stackoverflow.com/questions/3831680/httpservletrequest-get-post-data




http://docs.oracle.com/javase/7/docs/api/java/nio/ByteBuffer.html

/**
 * @param src		BufferedInputStream ensures we can reset (back) 
 * @param msgHandler
 */
// Reader, BufferedInputStream, BufferedReader, ... 
public static void Parse(String data, MessageHandler msgHandler) throws JAXBException, IOException, XMLStreamException, FactoryConfigurationError
{
	Reader src = new StringReader(data);
	XMLStreamReader  xmlReader = XMLInputFactory.newInstance().createXMLStreamReader(src);

