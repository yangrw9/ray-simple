package com.yar9.learn.fake;

import java.util.ArrayList;
import java.util.List;

import com.yar9.learn.model.District;

public class DistrictService {
	@SuppressWarnings("serial")
	List<District> dist = new ArrayList<District>() {{
		add(new District(21, "上海"));
		add(new District(10, "北京"));
		add(new District(521, "苏州"));
	}};

	public List<District> getAllDistrict() {
		
		return dist;
	}

}
