package com.yar9.learnWeb1.model;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement	// JAXB
public class Tick {
	
	@XmlElement
	long id;
	String Name;
	
	public String getName() {
		return Name;
	}
	public Tick()
	{
		
	}
	public Tick(long id, String name) {
		super();
		this.id = id;
		Name = name;
	}
	
}
