package com.ailk.eaap.op2.conf.adapter.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ExpressionUtil {
	public static final String PATH_MATCH_EXPRESSION_CONDITION = "(\\$BODY|\\$HEADER|\\$URL|\\$ATTR):/{0,1}(([^\\,^\\s]+((\\[[^,^\\[^\\]]+=[^,^\\[^\\]]+\\])|/)+[^\\,^\\)^\\s]*)|[^/^\\,^\\)^\\s]+)";
	public static final String PATH_MATCH_EXPRESSION_CONDITION_JSON = "(\\$BODY|\\$HEADER|\\$URL|\\$ATTR):(\\$\\.){0,1}(([^\\,^\\s]+((\\[[^,^\\[^\\]]+==[^,^\\[^\\]]+\\])|\\.)+[^\\,^\\)^\\s]*)|[^\\.^\\,^\\)^\\s]+)";
	public static final String CONSTANT_MATCH_EXPRESSION = "\"((\\\\\")|[^\"])+\"";
	public static final Integer PATH_TYPE = 0;
	public static final Integer CONST_TYPE = 1;
	private static final Integer JSON_TYPE = 2;
	public static final Pattern patternConst = Pattern.compile(CONSTANT_MATCH_EXPRESSION);
	public static final Pattern pattern = Pattern.compile(PATH_MATCH_EXPRESSION_CONDITION);
	public static final Pattern patternJson = Pattern.compile(PATH_MATCH_EXPRESSION_CONDITION_JSON);
	public static final String SRC_NODE_PATH_NAME = "srcNodePath";
	public static final String SRC_NODE_TYPE = "srcNodeType";
	public static final String VARIABLE_NAME = "variable";
	public static final String VARIABLE_TEMPLATE = "$_var_{index}_";
	public static final String CONSTANT_REPLACE_TEMPLATE = "$_CONST_{index}_";
	public static final String LOGIC_AND_FRONT = "and";
	public static final String LOGIC_OR_FRONT = "or";
	public static final String LOGIC_EQ_FRONT = "=";
	public static final String LOGIC_EQ_BACK = "==";
	public static final String LOGIC_AND_BACK = "&&";
	public static final String LOGIC_OR_BACK = "\\|\\|";
	
	public static Expression assembleExpression(String expression, int index, boolean isCondition) {
		Expression exp = new Expression();
		//先处理常量
		Map<String, String> constMap = new HashMap<String, String>();
		expression = doReplaceConst(constMap, expression);
		
		//替换xpath为变量
		Matcher matcher = getMatcher(expression, PATH_TYPE);
		expression = replacePathExp(matcher, expression, index, isCondition, exp);
		
		//替换jsonPath为变量
		matcher = getMatcher(expression, JSON_TYPE);
		expression = replacePathExp(matcher, expression, index, isCondition, exp);
		
		//将常量替换回来
		expression = unReplaceConst(constMap, expression);
		
		//将路径中的常量替换回来
		List<Map<String, String>> variables = exp.getVariables();
		if(variables != null && !variables.isEmpty()) {
			for(Map<String, String> variable: variables) {
				String path = unReplaceConst(constMap, variable.get(SRC_NODE_PATH_NAME));
				variable.put(SRC_NODE_PATH_NAME, path);
			}
		}
		
		exp.setExpress(expression);
		return exp;
	}
	
	private static String doReplaceConst(Map<String, String> constMap,
			String expression) {
		int index = 1;
		Matcher matcher = getMatcher(expression, CONST_TYPE);
		while(matcher.find()) {
			String varName = generateVarName(index++, CONST_TYPE);
			String constant = matcher.group();
			//判断是否表达式里面常量
			int local = expression.indexOf(constant);
			boolean inPath = false;
			while(local > 0) {
				local=local-1;
				char c = expression.charAt(local);
				if(c == ' ') {
					continue;
				}
				if(c == '=') {
					inPath = true;
				}
			}
			if(!inPath) {
				expression = expression.replace(constant, varName);
				constMap.put(varName, constant);
			}
		}
		return expression;
	}
	
	private static String unReplaceConst(Map<String, String> constMap,
			String expression) {
		for(Entry<String, String> entity: constMap.entrySet()) {
			String key = entity.getKey();
			String value = entity.getValue();
			expression = expression.replace(key, value);
		}
		return expression;
	}

	public static String replacePathExp(Matcher matcher, String expression, int index, boolean isCondition, Expression exp) {
		while(matcher.find()) {
			String varName = generateVarName(index++, PATH_TYPE);
			String path = matcher.group();
			Map<String, String> map = new HashMap<String, String>(2);
			map.put(VARIABLE_NAME, varName);
			if(path != null && path.startsWith("$HEADER:")) {
				map.put(SRC_NODE_PATH_NAME, path.replace("$HEADER:", ""));
				map.put(SRC_NODE_TYPE, "1");
			} else if(path != null && path.startsWith("$BODY:")) {
				map.put(SRC_NODE_PATH_NAME, path.replace("$BODY:", ""));
				map.put(SRC_NODE_TYPE, "2");
			} else if(path != null && path.startsWith("$URL:")) {
				map.put(SRC_NODE_PATH_NAME, path.replace("$URL:", ""));
				map.put(SRC_NODE_TYPE, "4");
			} else if(path != null && path.startsWith("$ATTR:")) {
				map.put(SRC_NODE_PATH_NAME, path.replace("$ATTR:", ""));
				map.put(SRC_NODE_TYPE, "7");
			} else {
				map.put(SRC_NODE_PATH_NAME, path.replace("$BODY:", ""));
				map.put(SRC_NODE_TYPE, "2");
			}
			expression = doWithExp(expression, path, varName,isCondition);
			exp.getVariables().add(map);
		}
		if(isCondition) {
			expression = doWithConstantVal(expression);
		}
		return expression;
	}
	
	public static String doWithConstantVal(String expression) {
		String[] array = expression.split("((\\&\\&)|(\\|\\|))");
		if(array != null) {
			for(String item: array) {
				String[] valueArray = item.split("((>=)|(<=)|(==)|(!=)|(>)|(<))");
				if(valueArray != null && valueArray.length > 1) {
					String val = valueArray[1];
					if(val.matches("\\s+[^\\s^\"]+\\s*")) {
						String repVal = " \"" + val.trim() + "\" ";
						expression = expression.replaceAll(val, repVal);
					}
				}
			}
		}
		return expression;
	}

	public static String getCondFromExpression(JSONObject exp, boolean isCondition) {
		if(exp == null) {
			return "";
		}
		String expression = null;
		if(exp.containsKey("express")) {
			expression = exp.getString("express");
		} else if(exp.containsKey("valueExpress")) {
			expression = exp.getString("valueExpress");
		}
		if(exp.containsKey("variables")) {
			JSONArray varArray = exp.getJSONArray("variables");
			if(varArray != null && expression != null) {
				expression = restoreExpFromVari(varArray, expression, isCondition);
			}
		}
		return expression;
	}
	
	public static String restoreExpFromVari(JSONArray varArray, String expression, boolean isCondition) {
		if(isCondition) {
			expression = expression.replaceAll(" "+LOGIC_AND_BACK+" ", " "+LOGIC_AND_FRONT+" ");
			expression = expression.replaceAll(" "+LOGIC_OR_BACK+" ", " "+LOGIC_OR_FRONT+" ");
			expression = expression.replaceAll(" "+LOGIC_EQ_BACK+" ", " "+LOGIC_EQ_FRONT+" ");
		}
		for(int i=0; i<varArray.size(); i++) {
			JSONObject varObj = varArray.getJSONObject(i);
			String var = varObj.getString("variable");
			String path = varObj.getString("srcNodePath");
			String srcNodeType = varObj.getString("srcNodeType");
			if("1".equals(srcNodeType)) {
				path = "$HEADER:"+path;
			} else if("2".equals(srcNodeType)) {
				path = "$BODY:"+path;
			} else if("4".equals(srcNodeType)) {
				path = "$URL:" + path;
			} else if("7".equals(srcNodeType)) {
				path = "$ATTR:" + path;
			}
			expression = expression.replace(var, path);
		}
		return expression;
	}

	public static String doWithExp(String expression, String path, String varName, boolean isCondition) {
		expression = expression.replace(path,varName);
		if(isCondition) {
			expression = expression.replaceAll("\\s"+LOGIC_AND_FRONT+"\\s", " "+LOGIC_AND_BACK+" ");
			expression = expression.replaceAll("\\s"+LOGIC_OR_FRONT+"\\s", " "+LOGIC_OR_BACK+" ");
			expression = expression.replaceAll("\\s"+LOGIC_EQ_FRONT+"\\s", " "+LOGIC_EQ_BACK+" ");
		}
		return expression;
	}

	public static String generateVarName(Integer index, Integer type) {
		if(CONST_TYPE == type) {
			return CONSTANT_REPLACE_TEMPLATE.replaceAll("\\{index\\}", String.valueOf(index));
		} else {
			return VARIABLE_TEMPLATE.replaceAll("\\{index\\}", String.valueOf(index));
		}
	}

	public static Matcher getMatcher(String expression, Integer type) {
		if(PATH_TYPE == type) {
			return pattern.matcher(expression);
		} else if(CONST_TYPE == type) {
			return patternConst.matcher(expression);
		} else if(JSON_TYPE == type) {
			return patternJson.matcher(expression);
		}
		return pattern.matcher(expression);
	}
}
