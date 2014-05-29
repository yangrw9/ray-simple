package com.yar9.learnWeb1.web;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.yar9.learnWeb1.model.Tick;


@Path("/tick")	// JAX-RS
//@Produces({"application/xml"})
public class TickWeb {
	
//	@GET							// JAX-RS
//	@Produces(MediaType.TEXT_XML)	// JAX-RS
//	public String getXML()
//	{
//		return "<?xml version=\"1.0\"?>" + "<hello> Hello Jersey" + "</hello>";
//	}
	
	@GET
	@Produces( {MediaType.APPLICATION_JSON })
//	@Produces("application/json")
	public Tick getJson()
	{
		Tick tk = new Tick(17, "A beautiful flower.");
		return tk;
	}
}
