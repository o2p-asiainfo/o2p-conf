package com.ailk.eaap.op2.conf.auditing.service;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.ProductServiceRel;
import com.ailk.eaap.op2.bo.ServiceSpec;

public interface IPardServiceSpecServ {
	
	public List<ServiceSpec> qryServiceSpeclist(ServiceSpec serviceSpec);
	public String cntServiceSpeclist(ServiceSpec serviceSpec);
	public void addOrUpdateProductService(String productId,String serviceId);
	public ProductServiceRel getProductServiceRel(String productId);
	public List<Map<String,Object>> qryServiceSpecAttr(Map<String,Object> params);
	
}