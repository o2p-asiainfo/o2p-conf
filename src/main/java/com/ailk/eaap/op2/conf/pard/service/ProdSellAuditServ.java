package com.ailk.eaap.op2.conf.pard.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.conf.pard.dao.ProdSellAuditDao;

@SuppressWarnings("unchecked")
public class ProdSellAuditServ implements IProdSellAuditServ{

	private ProdSellAuditDao  prodSellAuditDao;
	
	public List<Map> queryApplyInfo(Map map) {
		return prodSellAuditDao.queryApplyInfo(map);
	}
	
	public void updateAuditState(Map map) {
		prodSellAuditDao.updateAuditState(map);
	}

	public ProdSellAuditDao getProdSellAuditDao() {
		return prodSellAuditDao;
	}

	public void setProdSellAuditDao(ProdSellAuditDao prodSellAuditDao) {
		this.prodSellAuditDao = prodSellAuditDao;
	}
}
