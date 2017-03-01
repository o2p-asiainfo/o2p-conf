package com.ailk.eaap.op2.conf.pard.service;

import java.util.Map;
import java.util.List;

@SuppressWarnings("unchecked")
public interface IProdSellAuditServ {

	public List<Map> queryApplyInfo (Map map);
	
	public void updateAuditState(Map map);
}
