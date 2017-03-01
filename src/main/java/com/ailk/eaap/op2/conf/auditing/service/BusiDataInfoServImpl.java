/** 
 * Project Name:o2p-portal-pro 
 * File Name:BusiDataInfoServImpl.java 
 * Package Name:com.ailk.o2p.portal.service.busiDataInfo 
 * Date:2016年3月13日下午6:10:19 
 * Copyright (c) 2016, www.asiainfo.com All Rights Reserved. 
 * 
*/  
  
package com.ailk.eaap.op2.conf.auditing.service;  

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
 

import org.apache.commons.lang3.StringUtils;
import com.ailk.eaap.op2.bo.BusiDataInfo;
import com.ailk.eaap.op2.dao.BusiDataInfoDao;

/** 
 * ClassName:BusiDataInfoServImpl <br/> 
 * Function: TODO ADD FUNCTION. <br/> 
 * Reason:   TODO ADD REASON. <br/> 
 * Date:     2016年3月13日 下午6:10:19 <br/> 
 * @author   wushuzhen 
 * @version   
 * @since    JDK 1.7 
 * @see       
 */
@Service("busiDataInfoServ")
public class BusiDataInfoServImpl implements IBusiDataInfoServ{
    @Autowired
	private BusiDataInfoDao  busiDataInfoDao;

	@Override
	public Map getBusiDataInfoMap() {
		// TODO Auto-generated method stub
		Map busiDataInfoMap=new HashMap();
		String tenantId=queryBusiDataInfoTenantId("AcceptChannelType");
		if(StringUtils.isEmpty(tenantId)){
			tenantId="21";
		}
		String acceptChannelType=queryBusinessValue("AcceptChannelType");
		if(StringUtils.isEmpty(acceptChannelType)){
			acceptChannelType="O2P101";
		}
		String acceptStaffId=queryBusinessValue("AcceptStaffId");
		if(StringUtils.isEmpty(acceptStaffId)){
			acceptStaffId="21O2P101";
		}
		String appKey=queryBusinessValue("AppKey");
		if(StringUtils.isEmpty(appKey)){
			appKey="8000000020";
		}
		String businessType=queryBusinessValue("BusinessType");
		if(StringUtils.isEmpty(businessType)){
			businessType="1";
		}
		busiDataInfoMap.put("TenantId", tenantId);
		busiDataInfoMap.put("AcceptChannelType", acceptChannelType);
		busiDataInfoMap.put("AcceptStaffId", acceptStaffId);
		busiDataInfoMap.put("AppKey", appKey);
		busiDataInfoMap.put("BusinessType", businessType);
		return busiDataInfoMap;
	}
	
	public String queryBusinessValue(String paramString){
		String result=null;
		Map paramMap=new HashMap();
		paramMap.put("businessName", paramString);
		BusiDataInfo busiDataInfo=this.getBusiDataInfoDao().qryBusiDataInfoByName(paramMap);
		if(busiDataInfo!=null){
			result=busiDataInfo.getBusinessValue();
		}
		return result;
	}
	
	public String queryBusiDataInfoTenantId(String paramString){
		String result=null;
		Map paramMap=new HashMap();
		paramMap.put("businessName", paramString);
		BusiDataInfo busiDataInfo=this.getBusiDataInfoDao().qryBusiDataInfoByName(paramMap);
		if(busiDataInfo!=null){
			result=busiDataInfo.getTenantId().toString();
		}
		return result;
	}
	
	public BusiDataInfoDao getBusiDataInfoDao() {
		return busiDataInfoDao;
	}

	public void setBusiDataInfoDao(BusiDataInfoDao busiDataInfoDao) {
		this.busiDataInfoDao = busiDataInfoDao;
	}
}
