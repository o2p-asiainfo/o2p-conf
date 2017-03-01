package com.ailk.eaap.op2.conf.apiManager.action;

import com.ailk.eaap.op2.conf.apiManager.service.IApiManagerServ;
import com.linkage.rainbow.ui.struts.BaseAction;


public class ApiManagerAction extends BaseAction{
    private IApiManagerServ apiManagerService;

	public IApiManagerServ getApiManagerService() {
		return apiManagerService;
	}

	public void setApiManagerService(IApiManagerServ apiManagerService) {
		this.apiManagerService = apiManagerService;
	}


    
}
