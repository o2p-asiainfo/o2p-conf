package com.ailk.eaap.op2.conf.message.action;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.bo.message.MessageRecipientRel;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;
import com.ailk.eaap.op2.conf.message.bean.MessageBean;
import com.ailk.eaap.op2.conf.message.service.MessageServ;
import com.ailk.eaap.op2.conf.util.DataInteractiveUtil;
import com.ailk.eaap.op2.loginFilter.bo.UserInfo;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;
import com.linkage.rainbow.util.StringUtil;

public class MessageAction extends BaseAction {
	private static final long serialVersionUID = -3061243248539347377L;
	private Logger log = Logger.getLog(this.getClass());
	
	private MessageServ messageServ;
	private IConfManagerServ confManagerServ;
	private Message message = new Message();
	private MessageRecipientRel msgRecRel = new MessageRecipientRel();
	private List<Map<String,String>> msgRecTypelist = new ArrayList<Map<String,String>>();
	private List<Map<String,String>> msgTypeList = new ArrayList<Map<String,String>>();
	private List<Map<String,String>> msgWayList = new ArrayList<Map<String,String>>();
	private List<Map<String, String>> msgRoleList = new ArrayList<Map<String,String>>();
	private List<Map<String, String>> msgStatusList = new ArrayList<Map<String,String>>();
	
	//get/set method
	public MessageServ getMessageServ() {
		if(messageServ==null){
            //取得spring上下文
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			// 取得spring bean实例
			messageServ = (MessageServ)ctx.getBean("eaap-op2-conf-message-messageServ");
	     }
		return messageServ;
	}
	public void setMessageServ(MessageServ messageServ) {
		this.messageServ = messageServ;
	}
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public MessageRecipientRel getMsgRecRel() {
		return msgRecRel;
	}
	public void setMsgRecRel(MessageRecipientRel msgRecRel) {
		this.msgRecRel = msgRecRel;
	}
	public List<Map<String, String>> getMsgRecTypelist() {
		return msgRecTypelist;
	}
	public void setMsgRecTypelist(List<Map<String, String>> msgRecTypelist) {
		this.msgRecTypelist = msgRecTypelist;
	}
	public List<Map<String, String>> getMsgTypeList() {
		return msgTypeList;
	}
	public void setMsgTypeList(List<Map<String, String>> msgTypeList) {
		this.msgTypeList = msgTypeList;
	}
	public List<Map<String, String>> getMsgRoleList() {
		return msgRoleList;
	}
	public void setMsgRoleList(List<Map<String, String>> msgRoleList) {
		this.msgRoleList = msgRoleList;
	}
	public List<Map<String, String>> getMsgWayList() {
		return msgWayList;
	}
	public void setMsgWayList(List<Map<String, String>> msgWayList) {
		this.msgWayList = msgWayList;
	}
	public IConfManagerServ getConfManagerServ() {
		if(confManagerServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				confManagerServ = (IConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");
	     }
		return confManagerServ;
	}
	public List<Map<String, String>> getMsgStatusList() {
		return msgStatusList;
	}
	public void setMsgStatusList(List<Map<String, String>> msgStatusList) {
		this.msgStatusList = msgStatusList;
	}
	//action method
	public String goMessageList(){
		try{
			this.getAddSelectInputValue();
			
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
		}
		return SUCCESS;
	}
	
	public String dataGridOfMsgList(){
		try{
			message = getMessageBO();
			Integer draw = !"".equals(getRequest().getParameter("draw"))&&null!=getRequest().getParameter("draw")?Integer.parseInt(getRequest().getParameter("draw")):1;
			Integer start = !"".equals(getRequest().getParameter("start"))&&null!=getRequest().getParameter("start")?Integer.parseInt(getRequest().getParameter("start")):0;
			Integer pageNum = !"".equals(getRequest().getParameter("length"))&&null!=getRequest().getParameter("length")?Integer.parseInt(getRequest().getParameter("length")):10;
			message.setBegin(start);
			message.setEnd(pageNum);
			message.setMsgBeginDate(null);
			message.setMsgEndDate(null);
			//获取用户过滤框里的字符
		    String searchValue = getRequest().getParameter("search[value]");
		    Boolean flag = Boolean.TRUE;
		    Map<String,Object> map = new HashMap<String, Object>();
		    if (null!=searchValue&&!"".equals(searchValue)) {
		    	
		    	map.put("msgTitle", searchValue.trim());
		    	map.put("msgSubtitle", searchValue.trim());
		    	map.put("msgContent", searchValue.trim());
		    	map.put("msgHandleAddress", searchValue.trim());
		    	map.put("begin", start);
		    	map.put("end", pageNum);
		    	flag = Boolean.FALSE;
		    }
		    
			JSONObject info = new JSONObject();
			Integer total = flag?this.getMessageServ().counMsgList(message):this.getMessageServ().countMessageByData(map);
			List<Message> msgList = null;
			List<MessageBean> msgBeanList = new ArrayList<MessageBean>();
			
			if(null!=total&&total>0){
				msgList = flag?this.getMessageServ().queryMsgList(message):this.getMessageServ().selectMessageByData(map);
				MessageBean msgBean = null;
				int i = 1;
				Map<String,String> msgRecTypeMap = this.getMessageServ().getMainInfo(EAAPConstants.MESSAGE_MSG_REC_TYPE);
				Map<String,String> msgTypeMap = this.getMessageServ().getMainInfo(EAAPConstants.MESSAGE_MSG_TYPE);
				Map<String,String> msgWayMap = this.getMessageServ().getMainInfo(EAAPConstants.MESSAGE_MSG_WAY);
				Map<String,String> msgStatusMap = this.getMessageServ().getMainInfo(EAAPConstants.MESSAGE_STATUS);
				for(Message msg:msgList){
					msgBean = changeToBean(msgRecTypeMap,msgTypeMap,msgWayMap,msgStatusMap,msg,null,i,null);
					msgBeanList.add(msgBean);
					i++;
				}
				msgBean = null;
				msgRecTypeMap = null;
				msgTypeMap = null;
				msgWayMap = null;
			}
			msgList = null;
			
			info.put("recordsTotal", total);
			info.put("recordsFiltered", total);
			info.put("draw", draw);
			info.put("data", msgBeanList.size()>0?msgBeanList:new JSONArray());
			
			DataInteractiveUtil.actionResponsePage(getResponse(),info);
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
		}
		return 	NONE;
	}
	
	
	private void getAddSelectInputValue(){
		msgRecTypelist = this.getMessageServ().showSelectList(msgRecTypelist, EAAPConstants.MESSAGE_MSG_REC_TYPE);
		msgTypeList = this.getMessageServ().showSelectList(msgTypeList, EAAPConstants.MESSAGE_MSG_TYPE);
		msgWayList = this.getMessageServ().showSelectList(msgWayList, EAAPConstants.MESSAGE_MSG_WAY);
		msgStatusList = this.getMessageServ().showSelectList(msgStatusList, EAAPConstants.MESSAGE_STATUS);
		msgRoleList = this.getMessageServ().getRoleList();
	}
	
	public String goToAddMsgPage(){
		try{
			this.getAddSelectInputValue();
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
			return ERROR;
		}
		return SUCCESS;
	}
	
	private MessageBean changeToBean(Map<String,String> msgRecTypeMap,Map<String,String> msgTypeMap,Map<String,String> msgWayMap,Map<String,String> msgStatusMap,Message msg,MessageRecipientRel msgRecRel,Integer i,String recName){

		MessageBean msgBean = new MessageBean();
		msgBean.setMsgId(msg.getMsgId()+"");
		msgBean.setMsgContent(msg.getMsgContent());
		msgBean.setFormatBeginDate(msg.getFormatBeginDate());
		msgBean.setFormatEndDate(msg.getFormatEndDate());
		msgBean.setMsgHandleAddress(msg.getMsgHandleAddress());
		if(null!=i){
			msgBean.setIndex("<input type='checkbox' value='"+msg.getMsgId()+"' class='checkboxes' name='msgId' />");
		}
		msgBean.setMsgOriginator(msg.getMsgOriginator()+"");
		msgBean.setMsgPriority(msg.getMsgPriority());
		msgBean.setMsgRecType(msg.getMsgRecType()+"");
		msgBean.setMsgRecTypeText(msgRecTypeMap.get(msg.getMsgRecType()+""));
		msgBean.setMsgSubtitle(msg.getMsgSubtitle());
		msgBean.setMsgTitle(msg.getMsgTitle());
		msgBean.setMsgTypeText(msgTypeMap.get(msg.getMsgType()+""));
		msgBean.setMsgType(msg.getMsgType()+"");
		msgBean.setOpId(msg.getOpId());
		msgBean.setMsgWayText(msgWayMap.get(msg.getMsgWay()));
		msgBean.setMsgWay(msg.getMsgWay());
		msgBean.setStatusCdText(msgStatusMap.get(msg.getStatusCd()));
		msgBean.setStatusCd(msg.getStatusCd());
		if(null!=msgRecRel){
			msgBean.setRecId(msgRecRel.getRecId());
		}
		if(null!=recName){
			msgBean.setRecName(recName);
		}
		
		return msgBean;
	}
	
	public String selectOrg(){
		try{
			this.getAddSelectInputValue();
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
		}
		return SUCCESS;
	}
	
	public String getMsgById(){
		try{
			JSONObject info = new JSONObject ();
			
			Map<String,Object> obs = this.getMessageServ().getMsgById(message);
			message = (Message) obs.get("message");
			msgRecRel = (MessageRecipientRel) obs.get("msgRec");
			String recName = (String) obs.get("recName");
			
			message.setFormatBeginDate("".equals(StringUtil.valueOf(message.getFormatBeginDate()))?null:DateUtil.convDateToString(message.getMsgBeginDate(), "yyyy-MM-dd"));
			message.setFormatEndDate("".equals(StringUtil.valueOf(message.getFormatEndDate()))?null:DateUtil.convDateToString(message.getMsgEndDate(), "yyyy-MM-dd"));
			
			Map<String,String> msgRecTypeMap = this.getMessageServ().getMainInfo(EAAPConstants.MESSAGE_MSG_REC_TYPE);
			Map<String,String> msgTypeMap = this.getMessageServ().getMainInfo(EAAPConstants.MESSAGE_MSG_TYPE);
			Map<String,String> msgWayMap = this.getMessageServ().getMainInfo(EAAPConstants.MESSAGE_MSG_WAY);
			Map<String,String> msgStatusMap = this.getMessageServ().getMainInfo(EAAPConstants.MESSAGE_STATUS);
			info.put("message", this.changeToBean(msgRecTypeMap,msgTypeMap,msgWayMap,msgStatusMap,message,msgRecRel, null,recName));
			
			msgRecTypeMap = null;
			msgTypeMap = null;
			msgWayMap = null;
			
			DataInteractiveUtil.actionResponsePage(getResponse(),info);
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
		}
		return NONE;
	}
	
	public String addOrUpdateMessage(){
		try{
			message = getMessageBO();
			message.setMsgOriginator(new BigDecimal(getLoginId()));
			message.setOpId(getLoginId());
			
			String msgRecId = null;
			if(1==(message.getMsgRecType())){//角色
				msgRecId = getRequest().getParameter("msgRecRelRoleId");
			}else if(2==message.getMsgRecType()){//个人
				msgRecId = getRequest().getParameter("msgRecRelPersonalId");
			}
			msgRecRel.setRecId(msgRecId);
			
			if(null!=message&&null!=message.getMsgId()){
				//this.getMessageServ().modifyMessage(message);
			}else{
				this.getMessageServ().addMessage(message,msgRecRel);
			}
			
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
			return ERROR;
		}
		return SUCCESS;
	}
	
	private Message getMessageBO(){
		String msgId = this.getRequest().getParameter("msgId");
		String msgTitle = this.getRequest().getParameter("msgTitle");
		String msgSubtitle = this.getRequest().getParameter("msgSubtitle");
		String msgWay = this.getRequest().getParameter("msgWay");
		String msgType = this.getRequest().getParameter("msgType");
		String msgRecType = this.getRequest().getParameter("msgRecType");
		String msgHandleAddress = this.getRequest().getParameter("msgHandleAddress");
		String formatBeginDate = this.getRequest().getParameter("formatBeginDate");
		String formatEndDate = this.getRequest().getParameter("formatEndDate");
		String msgContent = this.getRequest().getParameter("msgContent");
		String statusCd = this.getRequest().getParameter("statusCd");
		
		if(null!=msgId&&!"".equals(msgId)){message.setMsgId(new BigDecimal(msgId));}
		if(null!=msgTitle&&!"".equals(msgTitle)){message.setMsgTitle(msgTitle);}
		if(null!=msgSubtitle&&!"".equals(msgSubtitle)){message.setMsgSubtitle(msgSubtitle);}
		if(null!=msgWay&&!"".equals(msgWay)){message.setMsgWay(msgWay);}
		if(null!=msgType&&!"".equals(msgType)){message.setMsgType(Integer.parseInt(msgType));}
		if(null!=msgRecType&&!"".equals(msgRecType)){message.setMsgRecType(Integer.parseInt(msgRecType));}
		if(null!=msgHandleAddress&&!"".equals(msgHandleAddress)){message.setMsgHandleAddress(msgHandleAddress);}
		if(null!=formatBeginDate&&!"".equals(formatBeginDate)){message.setFormatBeginDate(formatBeginDate);}
		if(null!=formatEndDate&&!"".equals(formatEndDate)){message.setFormatEndDate(formatEndDate);}
		if(null!=msgContent&&!"".equals(msgContent)){message.setMsgContent(msgContent);}
		if(null!=statusCd&&!"".equals(statusCd)){message.setStatusCd(statusCd);}else{message.setStatusCd(EAAPConstants.MESSAGE_ADD_MSG);}
		
		try {
			message.setMsgEndDate("".equals(StringUtil.valueOf(message.getFormatEndDate()))?null:DateUtil.stringToDate(message.getFormatEndDate().replace("-","/"), "yyyy/MM/dd"));
			message.setMsgBeginDate("".equals(StringUtil.valueOf(message.getFormatBeginDate()))?null:DateUtil.stringToDate(message.getFormatBeginDate().replace("-","/"), "yyyy/MM/dd"));
		} catch (ParseException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
		}
		
		return message;
	}
	
	public String getOrgList(){
		try{
			int draw = !"".equals(getRequest().getParameter("draw"))&&null!=getRequest().getParameter("draw")?Integer.parseInt(getRequest().getParameter("draw")):1;
			int startRow = !"".equals(getRequest().getParameter("start"))&&null!=getRequest().getParameter("start")?Integer.parseInt(getRequest().getParameter("start")):1;
			int pageNum = !"".equals(getRequest().getParameter("length"))&&null!=getRequest().getParameter("length")?Integer.parseInt(getRequest().getParameter("length")):10;
	
			Map<String,Object> map = new HashMap<String,Object>() ;
			map.put("begin", startRow);
			map.put("end", pageNum);
			
			String searchValue = getRequest().getParameter("search[value]");
		    if (null!=searchValue&&!"".equals(searchValue)) {
		    	map.put("name", "%"+searchValue.trim()+"%");
		    	map.put("orgCode", "%"+searchValue.trim()+"%");
		    	map.put("orgUsername", "%"+searchValue.trim()+"%");
		    	map.put("telephone", "%"+searchValue.trim()+"%");
		    	map.put("email", "%"+searchValue.trim()+"%");
		    }
			
			Integer total = this.getMessageServ().cntOrgList(map);
			List<Map<String, Object>> tmpOrgList = null;
			if(null!=total){
				tmpOrgList  = this.getMessageServ().getOrgList(map);
				
				if(null!=tmpOrgList&&tmpOrgList.size()>0){
					for(Map<String,Object> p :tmpOrgList){
						p.put("index", "<input type='checkbox' value='"+p.get("ORGID")+"' class='checkboxes' name='' />");
					}
				}
			}
			
			JSONObject info = new JSONObject ();
			info.put("recordsTotal", total);
			info.put("recordsFiltered", total);
			info.put("draw", draw);
			info.put("data", (null!=tmpOrgList&&tmpOrgList.size()>0)?tmpOrgList:new JSONArray());
			
			DataInteractiveUtil.actionResponsePage(getResponse(),info);
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"getOrgList exception",null));
		}
		return NONE;
	}
	
	public void delMessage(){
		try{
			String msgIds = getRequest().getParameter("msgIds");
			Boolean flag = Boolean.FALSE;
			if(null!=msgIds){
				flag = this.getMessageServ().delMessage(msgIds,getLoginId());
			}
			
			if(flag){
				JSONObject info = new JSONObject();
				info.put("ret", flag);
				DataInteractiveUtil.actionResponsePage(getResponse(),info);
			}
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
		}
	}
//	request.getSession().setAttribute("cardNumber", userInfo);//用户信息
//	request.getSession().setAttribute("sysIdType", sysPerson.getSysIdTypeId()); //用户身份类型（管理员。。）
	private String getLoginId(){
		UserInfo userInfo = (UserInfo) this.getRequest().getSession().getAttribute("cardNumber");
		if(null==userInfo){
			return EAAPConstants.PROVIDER_ID;
		}
		return userInfo.getId();
	}
}
