package com.ailk.eaap.op2.conf.mealrate.action;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.workflow.engine.activity.ActivityInstance;
import com.workflow.remote.WorkflowRemoteInterface;

public class werwer {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//content_Id=1465&activity_Id=104005
		String user_Id="123456";
		
		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
		
		ActivityInstance activityInstance=wi.getActivityInstance("104005");
		wi.activityExecuteByUser(activityInstance, user_Id, null, 
				null, "E", "audit_result=1,suggestion=", null, null, null, null);
		 
	}

}
