package com.ailk.eaap.op2.conf.message.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.bo.message.MessageRecipientRel;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;
import com.ailk.eaap.op2.dao.MessageBaseDao;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.linkage.rainbow.util.DateUtil;
import com.linkage.rainbow.util.StringUtil;

public class MessageServImpl implements MessageServ{

	private MessageBaseDao messageDao;
	private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;
	
	public MessageBaseDao getMessageDao() {
		return messageDao;
	}
	public void setMessageDao(MessageBaseDao messageDao) {
		this.messageDao = messageDao;
	}
	public MainDataDao getMainDataSqlDAO() {
		return mainDataSqlDAO;
	}
	public void setMainDataSqlDAO(MainDataDao mainDataSqlDAO) {
		this.mainDataSqlDAO = mainDataSqlDAO;
	}
	public MainDataTypeDao getMainDataTypeSqlDAO() {
		return mainDataTypeSqlDAO;
	}
	public void setMainDataTypeSqlDAO(MainDataTypeDao mainDataTypeSqlDAO) {
		this.mainDataTypeSqlDAO = mainDataTypeSqlDAO;
	}
	
	//--------------------------------------------------------------------------------
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData);
	}
	
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType);
	}
	
	public String addMsg(BigDecimal msgOriginator,String msgWay,String msgTitle,String msgSubtitle,Integer msgType,
			String msgContent,String msgHandleAddress,String recIdArr) throws BusinessException{
		if(null==msgOriginator){
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"Add Msg msgOriginator is Null",null);
		}
		if(null==msgWay){
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"Add Msg msgWay is Null",null);
		}
		if(null==msgTitle||"".equals(msgTitle)){
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"Add Msg msgTitle is Null",null);
		}
		if(null==msgContent){
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"Add Msg msgContent is Null",null);
		}
		if(null==recIdArr){
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"Add Msg recIdArr is Null",null);
		}
		
		Message msg = new Message();
		MessageRecipientRel msgRecRel = new MessageRecipientRel();
		try{
			msg.setMsgOriginator(msgOriginator);
			msg.setMsgWay(msgWay);
			msg.setMsgTitle(msgTitle);
			msg.setMsgSubtitle(msgSubtitle);
			msg.setMsgContent(msgContent);
			msg.setMsgHandleAddress(msgHandleAddress);
			msg.setMsgPriority("400");
			msg.setMsgType(msgType);
			msg.setStatusCd("1000");
			msg.setMsgRecType(2);
			msg.setOpId(msgOriginator.toString());
			msg.setMsgBeginDate("".equals(StringUtil.valueOf(msg.getFormatBeginDate()))?null:DateUtil.stringToDate(msg.getFormatBeginDate().replace("-","/"), "yyyy/MM/dd"));
			msg.setMsgEndDate("".equals(StringUtil.valueOf(msg.getFormatEndDate()))?null:DateUtil.stringToDate(msg.getFormatEndDate().replace("-","/"), "yyyy/MM/dd"));
			
			msgRecRel.setRecId(recIdArr);
			msgRecRel.setMsgRecType(2);
			msgRecRel.setStatusCd("1000");
			return addMessage(msg, msgRecRel);
		}catch(Exception e){
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"Add Msg err:"+e.getCause(),null);
		}
	}
	
	public Map<String,String> getMainInfo(String mdtSign){
		MainDataType mainDataType = new MainDataType();
	  	  MainData mainData = new MainData();
	  	  Map<String,String> stateMap = new HashMap<String,String>() ;
	  	  mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
	  	  mainDataType.setMdtSign(mdtSign) ;
		  mainDataType = this.selectMainDataType(mainDataType).get(0) ;
		  mainData.setMdtCd(mainDataType.getMdtCd()) ;
		  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
		  List<MainData> mainDataList = this.selectMainData(mainData) ;
		  if(mainDataList!=null && mainDataList.size()>0){
			  for(int i=0;i<mainDataList.size();i++){
				  stateMap.put(mainDataList.get(i).getCepCode(),
						          mainDataList.get(i).getCepName()) ;
			  }
		  }
	  	return  stateMap ;
	}
	public List<Map<String,String>> showSelectList(List<Map<String,String>> list ,String mdtSign){
		Map<String,String> map = new HashMap<String,String>();
		map = getMainInfo(mdtSign);
		Iterator<Entry<String, String>> iter = map.entrySet().iterator();   
		while(iter.hasNext()) {
			HashMap<String,String> mapTmp = new HashMap<String,String>() ;
			Entry<String,String> entry = (Entry<String,String>)iter.next();
			mapTmp.put("key", entry.getKey().toString());
			mapTmp.put("value", entry.getValue().toString()) ;
			list.add(mapTmp);
		}
		return list;
	}
	
	public String addMessage(Message msg,MessageRecipientRel msgRecRel) {
		if(null==msgRecRel.getRecId()||"".equals(msgRecRel.getRecId())){
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"System Error!==>addMessage method : tRecId null");
		}
		
		msg.setStatusCd(EAAPConstants.MESSAGE_ADD_MSG);
		msg.setMsgPriority(EAAPConstants.SETTLE_PRIORITY_NUM);
		msg.setMsgType(null==msg.getMsgType()?1:msg.getMsgType());
		msg.setOpId(msg.getMsgOriginator().toString());
		String msgId = messageDao.insertMes(msg);
		msgRecRel.setMsgRecType(msg.getMsgRecType());
		msgRecRel.setStatusCd(EAAPConstants.MESSAGE_ADD_MSG);
		msgRecRel.setMsgId(new BigDecimal(msgId));
		
		if(1==msg.getMsgRecType()){//角色
			messageDao.insertMsgRecRel(msgRecRel);
		}else if(2==msg.getMsgRecType()){//个人
			String[] arr = msgRecRel.getRecId().split(",");
			for(String recId:arr){
				msgRecRel.setRecId(recId);
				messageDao.insertMsgRecRel(msgRecRel);
			}
		}
		
		msg = null;
		msgRecRel = null;
		
		return msgId;
	}
	
	public List<Message> queryMsgList(Message msg) {
		return messageDao.queryMessageList(msg);
	}
	
	public Integer counMsgList(Message msg){
		return messageDao.countMessageList(msg);
	}
	
	public Integer modifyMessage(Message msg) {
		return messageDao.updateMsg(msg);
	}
	
	public boolean delMessage(String msgIds,String op_id){
		boolean retResult = Boolean.TRUE;
		String[] msgIdArr = msgIds.split(",");
		Message msg = null;
		MessageRecipientRel msgRecRel = null;
		for(String msgId:msgIdArr){
			msg = new Message();
			msg.setOpId(op_id);
			msg.setMsgId(new BigDecimal(msgId));
			msg.setStatusCd(EAAPConstants.MESSAGE_DELETE_MSG);
			retResult = retResult&&messageDao.updateMsg(msg)>0;
			
			msgRecRel = new MessageRecipientRel();
			msgRecRel.setMsgId(new BigDecimal(msgId));
			msgRecRel.setStatusCd(EAAPConstants.MESSAGE_DELETE_MSG);
			retResult = retResult&&messageDao.updateMsgRecRelByMsgId(msgRecRel)>0;
			
			msgId = null;
		}
		msgRecRel = null;
		return retResult;
	}
	
	public Map<String,Object> getMsgById(Message msg){
		Map<String,Object> obs = new HashMap<String,Object>();
		
		msg.setStatusCd(EAAPConstants.MESSAGE_ADD_MSG);
		msg = messageDao.getMsgById(msg);
		
		MessageRecipientRel msgRec = new MessageRecipientRel();
		if(null!=msg){
			msgRec.setMsgId(msg.getMsgId());
		}
		List<MessageRecipientRel> msgRecList = messageDao.queryMessageRecipientRelList(msgRec);
		
		String recName = null;
		
		if(null!=msg&&null!=msgRecList){
			if(1==msg.getMsgRecType()){
				msgRec = msgRecList.get(0);
			}else if(2==msg.getMsgRecType()){
				StringBuffer sb = new StringBuffer();
				msgRec = msgRecList.get(0);
				for(MessageRecipientRel msgRecParam:msgRecList){
					sb.append(msgRecParam.getRecId()).append(",");
				}
				String recIds = sb.toString().substring(0, sb.toString().length()-1);
				Map<String,Object> p = new HashMap<String, Object>();
				p.put("recIds", recIds.split(","));
				
				recName = this.selectOrgName(p);
				msgRec.setRecId(recIds);
				recIds = null;
			}
			
		}else{
			throw new BusinessException(ExceptionCommon.WebExceptionCode,"System Error!==>lookMsgById method : msgRecList null");
		}
		obs.put("message", msg);
		obs.put("msgRec", msgRec);
		obs.put("recName", recName);
		
		return obs ;
	}
	
	public String addMsgRecRla(MessageRecipientRel msgRecRel){
		return messageDao.insertMsgRecRel(msgRecRel);
	}
	public List<MessageRecipientRel> queryMsgRecRla(MessageRecipientRel msgRecRel){
		return messageDao.queryMessageRecipientRelList(msgRecRel);
	}
	public Integer countMsgRecRla(MessageRecipientRel msgRecRel){
		return messageDao.countMessageRecipientRelList(msgRecRel);
	}
	public Integer modifyMsgRecRla(MessageRecipientRel msgRecRel){
		return messageDao.updateMessageRecipientRel(msgRecRel);
	}
	
	public List<Map<String,String>> getRoleList(){
		List<Map<String, String>> roleList = messageDao.getRoleList();
		List<Map<String, String>> roleRetList = new ArrayList<Map<String,String>>();
		if(null!=roleList&&roleList.size()>0){
			Map<String, String> m = null;
			for(Map<String,String> param:roleList){
				m = new HashMap<String, String>();
				m.put("key", param.get("ROLE_CODE"));
				m.put("value", param.get("ROLE_NAME"));
				roleRetList.add(m);
			}
			m = null;
		}
		roleList = null;
		return roleRetList;
	}
	
	public List<Map<String,Object>> getOrgList(Map<String,Object> m){
		return messageDao.getOrgList(m);
	}
	public Integer cntOrgList(Map<String,Object> m){
		return messageDao.cntOrgList(m);
	}
	public String selectOrgName(Map<String,Object> p){
		StringBuffer recNameSB = new StringBuffer();
		List<Map<String, String>> orgNameList = messageDao.selectOrgName(p);
		if(null!=orgNameList&&orgNameList.size()>0){
			for(Map<String, String> t:orgNameList){
				recNameSB.append(t.get("userName".toUpperCase())).append(",");
			}
		}
		return recNameSB.toString().substring(0,recNameSB.toString().length()-1);
	}
	public List<Message> selectMessageByData(Map<String,Object> map){
		return messageDao.selectMessageByData(map);
	}
	public Integer countMessageByData(Map<String,Object> map){
		return messageDao.countMessageByData(map);
	}
}
