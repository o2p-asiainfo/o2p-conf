package com.ailk.eaap.op2.conf.apiManager.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Api;
import com.ailk.eaap.op2.conf.apiManager.dao.IApiManagerDao;

public class ApiManagerServImpl implements IApiManagerServ {
	private IApiManagerDao apiManagerDao;

	public IApiManagerDao getApiManagerDao() {
		return apiManagerDao;
	}

	public void setApiManagerDao(IApiManagerDao apiManagerDao) {
		this.apiManagerDao = apiManagerDao;
	}

	public String queryGridCount(){
		  return null; 
	};//查询所有的数目
	 public List<Map> queryApi(){
		 return null; 
	   };//查询所有的api的对象
	


}
