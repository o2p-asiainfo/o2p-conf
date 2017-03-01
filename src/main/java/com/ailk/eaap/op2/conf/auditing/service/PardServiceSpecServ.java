package com.ailk.eaap.op2.conf.auditing.service;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.ProductServiceRel;
import com.ailk.eaap.op2.bo.ServiceSpec;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.dao.ProductServiceDAO;
import com.ailk.eaap.op2.dao.ServiceSpecDao;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
public class PardServiceSpecServ implements IPardServiceSpecServ {
	private ServiceSpecDao serviceSpecDao;
	private ProductServiceDAO productServiceDao;

	public ServiceSpecDao getServiceSpecDao() {
		return serviceSpecDao;
	}

	public void setServiceSpecDao(ServiceSpecDao serviceSpecDao) {
		this.serviceSpecDao = serviceSpecDao;
	}

	public ProductServiceDAO getProductServiceDao() {
		return productServiceDao;
	}

	public void setProductServiceDao(ProductServiceDAO productServiceDao) {
		this.productServiceDao = productServiceDao;
	}

	public List<ServiceSpec> qryServiceSpeclist(ServiceSpec serviceSpec) {
		return serviceSpecDao.qryServiceSpeclist(serviceSpec);
	}

	public String cntServiceSpeclist(ServiceSpec serviceSpec) {
		return serviceSpecDao.cntServiceSpeclist(serviceSpec);
	}
	
	public void addOrUpdateProductService(String productId,String serviceId){
		if(null!=productId && null!=serviceId){
			ProductServiceRel productServiceRel = new ProductServiceRel();
			productServiceRel.setProductId(productId);
			productServiceRel.setStatus(EAAPConstants.COMM_STATE_VALID);
			
			ProductServiceRel productServiceRelTemp = productServiceDao.queryProductService(productServiceRel);
			productServiceRel.setServiceId(serviceId);
			if(null != productServiceRelTemp){
				productServiceDao.updateProductService(productServiceRel);
			}else{
				productServiceDao.insertProductService(productServiceRel);
			}
			
		}else{
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"O2P service --> productId and serviceId is not empty!", null);
		}
	}
	
	public ProductServiceRel getProductServiceRel(String productId){
		ProductServiceRel productServiceRel = new ProductServiceRel();
		if(null!=productId){
			productServiceRel.setProductId(productId);
			productServiceRel.setStatus(EAAPConstants.COMM_STATE_VALID);
			productServiceRel = productServiceDao.queryProductService(productServiceRel);
		}
		return productServiceRel;
	}
	
	public List<Map<String,Object>> qryServiceSpecAttr(Map<String,Object> params){
		return serviceSpecDao.qryServiceSpecAttr(params);
	}
}

