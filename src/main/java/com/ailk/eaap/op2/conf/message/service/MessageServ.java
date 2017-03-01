package com.ailk.eaap.op2.conf.message.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.bo.message.MessageRecipientRel;
import com.asiainfo.foundation.exception.BusinessException;

public interface MessageServ {
	public List<Map<String,String>> getRoleList();
	
	public Map<String,Object> getMsgById(Message msg);
	public String addMessage(Message msg,MessageRecipientRel msgRecRel);
	public List<Message> queryMsgList(Message msg);
	public Integer counMsgList(Message msg);
	public Integer modifyMessage(Message msg);
	public boolean delMessage(String msgIds,String op_id);
	public String addMsgRecRla(MessageRecipientRel msgRecRel);
	public List<MessageRecipientRel> queryMsgRecRla(MessageRecipientRel msgRecRel);
	public Integer countMsgRecRla(MessageRecipientRel msgRecRel);
	public Integer modifyMsgRecRla(MessageRecipientRel msgRecRel);
	
	public Map<String,String> getMainInfo(String mdtSign);
	public List<Map<String,String>> showSelectList(List<Map<String,String>> list ,String mdtSign);
	
	public List<Map<String,Object>> getOrgList(Map<String,Object> m);
	public Integer cntOrgList(Map<String,Object> m);
	public String selectOrgName(Map<String,Object> p);
	public List<Message> selectMessageByData(Map<String,Object> map);
	public Integer countMessageByData(Map<String,Object> map);
	public String addMsg(BigDecimal msgOriginator,String msgWay,String msgTitle,String msgSubtitle,Integer msgType,
			String msgContent,String msgHandleAddress,String recIdArr) throws BusinessException;
}
