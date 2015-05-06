package com.yar9.learn.fake;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yar9.learn.model.District;
import com.yar9.learn.model.Street;

public class StreetService {
	@SuppressWarnings("serial")
	Map<Integer, List<Street> > dist = new HashMap<Integer, List<Street> > () {{
		put(21, new ArrayList<Street>(){{
			      add(new Street(1, "淮海路"));
			      add(new Street(2, "西藏路"));
		        }});
		put(10, new ArrayList <Street>(){{
			      add(new Street(1, "中南海路"));
			      add(new Street(2, "故宫路"));
			      add(new Street(4, "长城路"));
		        }});
		put(521, new ArrayList<Street>(){{
		      add(new Street(1, "人民路"));
		      add(new Street(2, "星湖街"));
	        }});
	}};

	public List<Street> getAllStreet(District district) {
		int distId = district.getId();
		return dist.get(distId);

//		return null;
	}

}
