package com.ailk.eaap.op2.conf.adapter.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Expression {
	private List<Map<String, String>> variables = new ArrayList<Map<String, String>>();
	private String express = null;
	
	public List<Map<String, String>> getVariables() {
		return variables;
	}
	public void setVariables(List<Map<String, String>> variables) {
		this.variables = variables;
	}
	public String getExpress() {
		return express;
	}
	public void setExpress(String express) {
		this.express = express;
	}
	
}
