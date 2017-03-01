package test.com.ailk.eaap.op2.conf;

import java.util.Map;
import java.util.HashMap;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.springframework.web.client.RestTemplate;

import com.ailk.eaap.op2.common.CommonUtils;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class workFlowTest {

	@Test
	public void test2() {
		
		System.out.println(CommonUtils.getChineseValueByProCode("work_flow_pro_url"));
		
		RestTemplate rest = new RestTemplate();
		String userId = "123456";
    	String message = rest.getForObject(CommonUtils.getChineseValueByProCode("work_flow_pro_url")+"/task/taskListByUserId/{userId}",
	    		String.class,userId);
    	com.alibaba.fastjson.JSONArray jsons = null;
		if(!StringUtils.isEmpty(message)){
			jsons = JSON.parseArray(message);
			System.out.println(jsons);
		}
	}
	@Test
	public void tt(){
		 Map<String,Object> vars = new HashMap<String, Object>();
		vars.put("startRow", String.valueOf(1));
		vars.put("pageSize", String.valueOf(5));
		vars.put("searchKey", "");
        vars.put("userId", EAAPConstants.PROCESS_AUTHENTICATED_USER_ID);
		RestTemplate rest = new RestTemplate();
    	String message =  rest.postForObject("http://localhost:8089/workflow_pro"+"/task/taskListByUserId?userId={userId}&startRow={startRow}&pageSize={pageSize}&searchKey={searchKey}",
	    		null,String.class,vars);
    	com.alibaba.fastjson.JSONObject retJson = new com.alibaba.fastjson.JSONObject();
    	com.alibaba.fastjson.JSONArray jsons = null;
		if(!StringUtils.isEmpty(message)){
			jsons = JSON.parseArray(message);
		}
		System.out.println(jsons);
	}

	@Test
	public void restTest(){
		RestTemplate rest = new RestTemplate();
		
		Map<String, Object> taskVariables = new HashMap<String, Object>();
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("product_audit_result", Boolean.FALSE);
		jsonObject.put("upc_examime_resultDesc", "sssssssssssssss");
		
		taskVariables.put("processInstanceId", "601");
		taskVariables.put("activityId", "UPCAudit");
		taskVariables.put("varJson", jsonObject.toJSONString());
		
		String msg = rest.postForObject(CommonUtils.getChineseValueByProCode("work_flow_pro_url")+"/task/signalTask?processInstanceId={processInstanceId}&activityId={activityId}&varJson={varJson}",
	    		null, String.class,taskVariables);
		
		System.out.println(msg);
		
	}
}
