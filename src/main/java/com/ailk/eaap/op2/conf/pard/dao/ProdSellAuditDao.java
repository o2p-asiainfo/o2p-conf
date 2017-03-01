package com.ailk.eaap.op2.conf.pard.dao;

import java.util.Map;
import java.util.List;

@SuppressWarnings("unchecked")
public interface ProdSellAuditDao {

	public List<Map> queryApplyInfo (Map map);
	
	public void updateAuditState(Map map);
}
