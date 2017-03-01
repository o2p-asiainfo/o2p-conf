package com.ailk.eaap.op2.conf.prov.service;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ailk.eaap.o2p.common.cache.CacheKey;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.conf.prov.dao.IProvAuditDao;
import com.ailk.eaap.op2.dao.OrgDao;


public class ProvAuditService implements IProvAuditService {

	private static Log log = LogFactory.getLog(ProvAuditService.class);
	private IProvAuditDao provAuditDao;
	private OrgDao orgSqlDAO;

	public IProvAuditDao getProvAuditDao() {
		return provAuditDao;
	}

	public void setProvAuditDao(IProvAuditDao provAuditDao) {
		this.provAuditDao = provAuditDao;
	}

	
	public OrgDao getOrgSqlDAO() {
		return orgSqlDAO;
	}

	public void setOrgSqlDAO(OrgDao orgSqlDAO) {
		this.orgSqlDAO = orgSqlDAO;
	}

	public Org showOrg(Org org) {
		// TODO Auto-generated method stub
		Org orgInfo = new Org();
		orgInfo = provAuditDao.showOrg(org);
		return orgInfo;
	}

	public Component showComponent(Component component) {
		// TODO Auto-generated method stub
		Component componentInfo = new Component();
		componentInfo = provAuditDao.showComponent(component);
		return componentInfo;
	}

	public List<Map<String, Object>> provAbility(Map map) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> provAbility = null;
		try {
			provAbility = provAuditDao.provAbility(map);
		} catch (EAAPException e) {
			log.error(e.getStackTrace());
		}	
		return provAbility;
	}

	public void updateAuditing(String componentId, String auditing) {
		// TODO Auto-generated method stub
		String id = null;
		String status=null;
		id = provAuditDao.updateAuditing(componentId, auditing);
		List<Map<String, Object>> showAbilitys;
		List<Map<String, Object>> showPackageList;
		if(auditing.equals(EAAPConstants.COMM_STATE_ONLINE)){
			status=EAAPConstants.PRODUCT_ATTR_ONLINE;
		}else{
			status=EAAPConstants.PRODUCT_ATTR_GIVEUP;
		}
		if(id != null && !id.equals("")){	
			try {
				Map mapTemp = new HashMap();  
				mapTemp.put("componentId", componentId);		
				showAbilitys = provAuditDao.provAbility(mapTemp);
				if ( showAbilitys != null && showAbilitys.size()>0 ){
					for(Map<String,Object> item : showAbilitys ){
						if (!auditing.equals(EAAPConstants.COMM_STATE_ONLINE)){
							auditing = EAAPConstants.COMM_STATE_NEW;
						}
						provAuditDao.operatorSerTechImpl(item.get("SERTECHIMPLID").toString(), auditing);	
				    }			
				}
				provAuditDao.updateModuleVersion(CacheKey.MODULE_ALL);
				Map map2 = new HashMap();  
				map2.put("componentId", componentId);		///
				showPackageList = showPackage(map2);	
				if(showPackageList.size()>0){
					Map tempOffer = new HashMap();
					ProdOffer offer = new ProdOffer();
					List<Map<String, Object>> prods = new ArrayList(); 
					for(int i=0;i<showPackageList.size();i++){
						tempOffer = (Map)showPackageList.get(i);
						offer.setProdOfferId((BigDecimal)tempOffer.get("PROD_OFFER_ID"));
						offer.setStatusCd(status);
						provAuditDao.updateProdOffer(offer);
						Product productBean = new Product();
						prods =provAuditDao.getProduct(tempOffer);
						if(prods.size()>0){
							for(int m =0;m<prods.size();m++){
								Map proInfo = (Map)prods.get(m);
								productBean.setProductId((BigDecimal)proInfo.get("PRODUCT_ID"));
								productBean.setStatusCd(status);
								provAuditDao.updateProduct(productBean);
							}
						}
					}
				}
			} catch (EAAPException e) {
				log.error(e.getStackTrace());
			}					
		}
	}

	public List<Map<String, Object>> showOrgList(Map map) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> showOrg = null;
		try {
			showOrg = provAuditDao.showOrgList(map);
		} catch (EAAPException e) {
			log.error(e.getStackTrace());
		}
		return showOrg;
	}

	public List<Map<String, Object>> selectFileShare(String fileShareId) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> fileShare = new ArrayList();
		try {
			Map mapTemp = new HashMap();  
			mapTemp.put("fileShareId", fileShareId);		///
			fileShare = provAuditDao.selectFileShare(mapTemp);
		} catch (Exception e) {
			log.error(e.getStackTrace());
		}
		return fileShare;
	}
	public List<Map<String, Object>> showPackage(Map map){
		List<Map<String, Object>> showPackage = null;
		try {
			showPackage = (List<Map<String, Object>>) provAuditDao.showPackage(map);
		} catch (EAAPException e) {
			log.error(e.getStackTrace());
		}	
		return showPackage;
	}

	@Override
	public Org queryOrg(Org paramOrg) {
		// TODO Auto-generated method stub
		return orgSqlDAO.queryOrg(paramOrg);
	}

}
