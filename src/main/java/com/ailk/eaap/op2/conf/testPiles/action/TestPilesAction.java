package com.ailk.eaap.op2.conf.testPiles.action;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.servlet.http.Cookie;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.TechImpl;
import com.ailk.eaap.op2.bo.TestMsgMod;
import com.ailk.eaap.op2.bo.TestMsgModRela;
import com.ailk.eaap.op2.bo.TestResult;
import com.ailk.eaap.op2.bo.TestResultLog;
import com.ailk.eaap.op2.bo.TestResultLogMsg;
import com.ailk.eaap.op2.bo.TestScene;
import com.ailk.eaap.op2.bo.TestSceneRela;
import com.ailk.eaap.op2.bo.TestTask;
import com.ailk.eaap.op2.bo.TestTaskScene;
import com.ailk.eaap.op2.bo.TestTaskUser;
import com.ailk.eaap.op2.bo.TestMsgModResponse;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.auditing.service.ICompRegAuditingServ;
import com.ailk.eaap.op2.conf.auditing.service.IOrgRegAuditingServ;
import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;
import com.ailk.eaap.op2.conf.serviceManager.service.IServiceManagerServ;
import com.ailk.eaap.op2.conf.techImpl.service.ITechImplService;
import com.ailk.eaap.op2.conf.testPiles.service.ITestPilesService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.StringUtil;
import com.workflow.remote.WorkflowRemoteInterface;

public class TestPilesAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLog(this.getClass());
	private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();

	private String editOrAdd ;
	private ITestPilesService testPilesService;
	private List<Map> testSceneLists = new ArrayList<Map>() ;
	private List<Map> commProtocalList = new ArrayList<Map>();
	private List<Map<String,Object>> commProtocalResultList = new ArrayList<Map<String,Object>>();
	private IServiceManagerServ iServiceManagerServ;
	private ITechImplService techImplService;
    private String techImplName;
    private String componentId;
    private String techImplId;
    private TechImpl techImpl = new TechImpl();
	private List<Map> testTaskLists = new ArrayList<Map>() ;
	private String taskId;
	private String commProName;
	
	private Component component = new Component();
	private Map compInfoMap = new HashMap() ;
	private ICompRegAuditingServ compRegAuditingServ;
    private Map orgInfoMap = new HashMap() ;
    private IOrgRegAuditingServ orgRegAuditingServ ;
	private Org org = new Org();
	private TestScene testScene = new TestScene();
	private Map serInvokeInsMap = new HashMap() ;
	private String serInvokeInsId;
    private IConfManagerServ confManagerServ ;
	private TestTaskScene testTaskScene = new TestTaskScene();
    private TestTask testTask = new TestTask();
    private Map testMsgInfoMap = new HashMap();
    private Map testResultInfoMap = new HashMap();
    
	private String testId;
    private TestResult testResult = new TestResult();

	private String testUserIdInput;
	private String testUserNameInput;
	private String testUserIds;
	private String testUserNames;
	private List<Map<String,Object>> testUserList = new ArrayList<Map<String,Object>>();

	private String sceneId;
	private List<Map> testSceneRelaList = new ArrayList<Map>() ;
	private TestSceneRela testSceneRela = new TestSceneRela();
	private List<Map> testSceneRelaModLists = new ArrayList<Map>() ;
	private TestMsgMod testMsgMod = new TestMsgMod();
	private TestMsgModRela testMsgModRela = new TestMsgModRela();
	private TestMsgModResponse testMsgModResponse = new TestMsgModResponse();
	private Boolean isChoosePage= false;
	private String sceneIdInput;
	private String sceneNameInput;
	private TestTaskUser testTaskUser = new TestTaskUser();
	private List<Map> testResultSceneObjList = new ArrayList<Map>() ;
    private TestResultLog testResultLog = new TestResultLog();
    private TestResultLogMsg testResultLogMsg = new TestResultLogMsg();

	private List<Map> formatTypeList = new ArrayList<Map>();
	private List<Map> msgModStateList = new ArrayList<Map>();
	private List<Map> objTypeList = new ArrayList<Map>();
	private Map formatTypeMap = new HashMap() ;
	private Map msgModStateMap = new HashMap() ;
	private Map objTypeMap = new HashMap() ;
	private Map expFlagMap = new HashMap() ;
	private List<Map> expFlagList = new ArrayList<Map>();
	private String pageState;
	private String modName;
	private String modId;
	private String personId;
	private String msgId;

	
	public TestPilesAction() {

	}
	
	public String testScene(){
		return SUCCESS;
	}
	
	public Map getTestSceneList(Map para){
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("sceneName", "".equals(getRequest().getParameter("sceneName"))?null:getRequest().getParameter("sceneName")) ;
		 map.put("remark", "".equals(getRequest().getParameter("remark"))?null:getRequest().getParameter("remark")) ;

		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getTestPilesService().queryTestSceneList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
        map.put("end", startRow+rows-1);
        map.put("pro_mysql", startRow - 1);
        map.put("page_record", rows);
        testSceneLists =getTestPilesService().queryTestSceneList(map) ;

		Map returnMap = new HashMap();
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(testSceneLists));

		return returnMap ;
	}
	
	public String testScene_chooseTechImpl(){

        return SUCCESS ;
	}
	
	public Map getTestSceneRelaListBySceneId(Map para){
		String sceneIds=null;
		if(StringUtils.isNotEmpty(para.get("queryParamsData").toString())){
			sceneIds = para.get("queryParamsData").toString();
		}
		Map returnMap = new HashMap();
		if(sceneIds !=null && !sceneIds.equals("")){
			rows = pagination.getRows();
			pageNum = pagination.getPage();
			int startRow;
			startRow = (pageNum - 1) * rows + 1;
			
			Map map = new HashMap() ;
			map.put("sceneId", sceneIds) ;
			
			map.put("queryType", "ALLNUM") ;
			total=Integer.valueOf(String.valueOf(getTestPilesService().getTestSceneRelaListBySceneId(map).get(0).get("ALLNUM"))) ;
			map.put("queryType", "") ;
			map.put("pro", startRow);
			map.put("end", startRow+rows-1);
			map.put("pro_mysql", startRow - 1);
			map.put("page_record", rows);
			testSceneRelaList =getTestPilesService().getTestSceneRelaListBySceneId(map) ;
			
			returnMap.put("startRow", startRow);
			returnMap.put("rows", rows); 	
			returnMap.put("total", total);
			returnMap.put("dataList", page.convertJson(testSceneRelaList));
		}
		return returnMap ;
	}
	
	public void saveTestSceneData(){
	    PrintWriter out =null;
		String sceneName = getRequest().getParameter("sceneName");
		String remark = getRequest().getParameter("remark");
		String _sceneId = getRequest().getParameter("sceneId");
		testScene.setSceneId(Integer.valueOf(_sceneId));
		testScene.setSceneName(sceneName);
		testScene.setRemark(remark);
		try {
			 if("add".equals(editOrAdd)){
				 	getTestPilesService().insertTestScene(testScene);
			 }else{
				 	getTestPilesService().updateTestScene(testScene);
			 }
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"editOrAdd\":\""+editOrAdd+"\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
     }
	
	
    public void deleteTestScene(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
	    	getTestPilesService().deleteTestScene(testScene);
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"OK\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }
	
	public String testSceneAdd(){
		
	    return SUCCESS;
	}

	public String testSceneInfo(){
		String _sceneId =  getRequest().getParameter("sceneId");
		if(_sceneId!=null && !_sceneId.equals("")){
			//修改
			editOrAdd = "edit";
			testScene.setSceneId(Integer.valueOf(_sceneId));
			testScene = getTestPilesService().queryTestScene(testScene);
		}else{
			//新增
			editOrAdd = "add";
			_sceneId = getTestPilesService().selectSeqApp("TEST_SCENE");	//预先生成一个sceneId
			testScene.setSceneId(Integer.valueOf(_sceneId));
		}
	    return SUCCESS;
	}

    public void testSceneListDelete(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
			if(testScene.getSceneId() != null){
				getTestPilesService().testSceneListDelete(testScene);
			}
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }
    
    public void testSceneRelaDel(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
	    	getTestPilesService().testSceneRelaDel(testSceneRela);
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }
	public String testSceneRela_add(){
		 Map map = new HashMap() ;
		 map.put("key", "") ;
		 map.put("value",null) ;
		 objTypeList.add(map) ;
		 formatTypeList.add(map) ;
		 
		  objTypeMap = getMainInfo(EAAPConstants.MOD_OBJ_RELA_TYPE) ;
		  Iterator iter = objTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 objTypeList.add(mapTmp) ;
		  }
		  
		  formatTypeMap = getMainInfo(EAAPConstants.MSG_FORMAT_TYPE) ;
		  Iterator iter2 = formatTypeMap.entrySet().iterator();   
		  while(iter2.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter2.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 formatTypeList.add(mapTmp) ;
		 }
		 return SUCCESS ;
	}
	public Map getTestSceneRelaObjList(Map para){
		Map returnMap = new HashMap();
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;
		
		Map map = new HashMap() ;
		 map.put("objType", "".equals(getRequest().getParameter("objType"))?null:getRequest().getParameter("objType")) ;
		 map.put("objName", "".equals(getRequest().getParameter("objName"))?null:getRequest().getParameter("objName")) ;
		
		map.put("queryType", "ALLNUM") ;
		total=Integer.valueOf(String.valueOf(getTestPilesService().getTestSceneRelaObjList(map).get(0).get("ALLNUM"))) ;
		map.put("queryType", "");
		map.put("pro", startRow);
		map.put("end", startRow+rows-1);
		map.put("pro_mysql", startRow - 1);
		map.put("page_record", rows);
		testSceneRelaModLists =getTestPilesService().getTestSceneRelaObjList(map) ;
		
		returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(testSceneRelaModLists));
		return returnMap;
	}
	public String testSceneRela_chooseMod(){
		  formatTypeMap = getMainInfo(EAAPConstants.MSG_FORMAT_TYPE) ;
		  Iterator iter = formatTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 formatTypeList.add(mapTmp) ;
		 }
		  
        return SUCCESS ;
	}
	public Map getTestSceneRelaModList(Map para){
		String _objType =  getRequest().getParameter("objTypeSel");
		String _objId =  getRequest().getParameter("objId");
		String _modName =  getRequest().getParameter("modName");
		String _msgFormatType =  getRequest().getParameter("msgFormatType");
		if(_objId==null || _objId==null){

		}
		Map returnMap = new HashMap();
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;
		
		Map map = new HashMap() ;
		map.put("objId", (_objId!=null && !"".equals(_objId))?_objId:null);
		map.put("objType", (_objType!=null && !"".equals(_objType))?_objType:null);
		map.put("modName", (_modName!=null && !"".equals(_modName))?_modName:null);
		map.put("msgFormatType", (_msgFormatType!=null && !"".equals(_msgFormatType))?_msgFormatType:null);
		
		map.put("queryType", "ALLNUM") ;
		total=Integer.valueOf(String.valueOf(getTestPilesService().getTestSceneRelaModList(map).get(0).get("ALLNUM"))) ;
		map.put("queryType", "") ;
		map.put("pro", startRow);
		map.put("end", startRow+rows-1);
		map.put("pro_mysql", startRow - 1);
		map.put("page_record", rows);
		testSceneRelaModLists =getTestPilesService().getTestSceneRelaModList(map) ;
		
		returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(testSceneRelaModLists));
		return returnMap ;
	}
    public void testSceneRelaUpdateMod(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
	    	getTestPilesService().testSceneRelaUpdateMod(testSceneRela);
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }
	public String testSceneRelaModSave(){
		PrintWriter out =null;
		try {
			 getRequest().setCharacterEncoding("UTF-8");
			 if("edit".equals(StringUtil.valueOf(editOrAdd))){
				 //update
			    getTestPilesService().testSceneRelaModUpdate(testMsgMod);
			 }else{
				 //add
				String _modId = getTestPilesService().selectSeqApp("TEST_MSG_MOD");
				testMsgMod.setModId(Integer.valueOf(_modId));
				testMsgMod.setState("A");
				String _personId = getPersonId();
				if(_personId != null && !_personId.equals("")){
					testMsgMod.setPersonId(Integer.valueOf(_personId));
				}
				testMsgModRela.setModId(Integer.valueOf(_modId));
				getTestPilesService().testSceneRelaModAdd(testMsgMod,testMsgModRela);
			 }
			 getResponse().setContentType("text/html;charset=UTF-8");
			 out = getResponse().getWriter();
			 String ret="[{\"msg\":\"ok\",\"data\":\"\"}]";
			 out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
         return SUCCESS ;
     }
    public void testSceneRelaModDel(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
	    	getTestPilesService().testSceneRelaModDel(testMsgModRela);
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }
    public void testSceneRelaSave(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
	    	getTestPilesService().testSceneRelaSave(testSceneRela);
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }
    
	
	

	
	
	public String testTask(){
		return SUCCESS;
	}
	public Map getTestTaskList(Map para){
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("taskName", "".equals(getRequest().getParameter("taskName"))?null:getRequest().getParameter("taskName")) ;
		 map.put("sceneName", "".equals(getRequest().getParameter("sceneName"))?null:getRequest().getParameter("sceneName")) ;
		 map.put("testUserName", "".equals(getRequest().getParameter("testUserName"))?null:getRequest().getParameter("testUserName")) ;
		 map.put("remark", "".equals(getRequest().getParameter("remark"))?null:getRequest().getParameter("remark")) ;

		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getTestPilesService().queryTestTaskList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
        map.put("end", startRow+rows-1);
        map.put("pro_mysql", startRow - 1);
        map.put("page_record", rows);
        testTaskLists =getTestPilesService().queryTestTaskList(map) ;

		Map returnMap = new HashMap();
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(testTaskLists));

		return returnMap ;
	}
	public String testTaskInfo(){
		String _taskId =  getRequest().getParameter("taskId");
		if(_taskId!=null && !_taskId.equals("")){
			//修改
			editOrAdd = "edit";
			testTask.setTaskId(Integer.valueOf(_taskId));
			testTask = getTestPilesService().queryTestTask(testTask);
			
			testTaskScene.setTaskId(Integer.valueOf(_taskId));
			testTaskScene = getTestPilesService().queryTestTaskScene(testTaskScene);
			
			if(testTaskScene != null){
				testScene.setSceneId(Integer.valueOf(testTaskScene.getSceneId()));
				testScene = getTestPilesService().queryTestScene(testScene);
			}

			Map map = new HashMap() ;
			map.put("taskId", _taskId);
			Map userMap = getTestPilesService().queryTestTaskUsers(map);
			if(userMap != null && userMap.get("USER_ID") != null){
				testUserNames = userMap.get("USER_NAME").toString();
				testUserIds = userMap.get("USER_ID").toString();
			}
		} else {
			//新增
			editOrAdd = "add";
		}
	    return SUCCESS;
	}
	public String chooseTestScene(){
		isChoosePage = true;
		return SUCCESS;
	}
	public void saveTestTaskData(){
	    PrintWriter out =null;
		try {
			
			String _taskId=  getRequest().getParameter("taskId");
			String taskName = getRequest().getParameter("taskName");
			String remark = getRequest().getParameter("remark");
			String _sceneId = getRequest().getParameter("sceneId");
			String testUserId = getRequest().getParameter("testUserId");
			testTask.setTaskName(taskName);
			testTask.setRemark(remark);
			 if(_taskId !=null && _taskId !=""){
				 //修改
				 testTask.setTaskId(Integer.valueOf(_taskId));
				 getTestPilesService().updateTestTask(testTask);
			 }else{
				 //新增
				 _taskId = getTestPilesService().selectSeqApp("TEST_TASK");	//成一个taskId
				 testTask.setTaskId(Integer.valueOf(_taskId));
				 getTestPilesService().insertTestTask(testTask);
			 }
			 
			 testTaskScene.setTaskId(Integer.valueOf(testTask.getTaskId()));
			 if(_sceneId != null){
				 testTaskScene.setSceneId(Integer.valueOf(_sceneId));
				 getTestPilesService().testTaskSceneSave(testTaskScene);
			 }
			
			testTaskUser.setTaskId(Integer.valueOf(testTask.getTaskId()));
			getTestPilesService().testTaskUserDel(testTaskUser);
			testResult.setTaskId(Integer.valueOf(testTask.getTaskId()));
			getTestPilesService().testResultDel(testResult);
			if(testUserId !=""){
				String ids[] = testUserId.split(",");
				for (int i = 0; i < ids.length; i++) {
					String id = ids[i];
					if(id !=""){
						testTaskUser.setTestUserId(Integer.valueOf(id));
						getTestPilesService().testTaskUserInsert(testTaskUser);
						
						testResult.setTestUserId(Integer.valueOf(id));
						getTestPilesService().testResultInsert(testResult);
					}
				}
			}
        
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"taskId\":\""+taskId+"\"}]";
			out.print(ret);
		}  catch (Exception e) {
			 try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
	}
	
	public void createFlow(){
	    PrintWriter out =null;
		try {
			String _taskId = getRequest().getParameter("taskId");
			Map<String,String> paramMap=new HashMap<String,String>();
			String _personId = getPersonId();
			if(_personId != null && !_personId.equals("")){
				paramMap.put("USER_ID", _personId);
			}else{
				paramMap.put("USER_ID", "123456");
			}
			paramMap.put("PROCESS_MODEL_ID", EAAPConstants.PROCESS_TEST_PILES_FLOW_ID);
			paramMap.put("PROC_NAME","Test Stubs Flow");
	
			String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
			ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
			WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
			Map<String,String> map = new HashMap<String, String>() ; 
			map = wi.processStart(paramMap);
			String retProcId = map.get("PROC_ID");	//流程实例ID
			if(retProcId!=null && !retProcId.equals("")){
				testTask.setTaskId(Integer.valueOf(_taskId));
				testTask.setProcId(Integer.valueOf(retProcId));
				getTestPilesService().updateTestTask(testTask);
			}
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"taskId\":\""+_taskId+"\"}]";
			out.print(ret);
		}  catch (Exception e) {
			 try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
	}
	
	public Map getTestSceneListByTaskId(Map para){

		String js = para.get("queryParamsData").toString();     // [{FIRST_ENDPOINT_ID=6003,TASK_ID=2}]
		String _taskId = "";
		String firstEndpointId = "";
		JSONArray dsObjs = JSONArray.fromObject(js);
		if(dsObjs.size()>0){
			JSONObject obj = (JSONObject) (dsObjs.get(0));
			_taskId = obj.getString("TASK_ID");
			firstEndpointId = obj.getString("FIRST_ENDPOINT_ID");
		}
		
		Map returnMap = new HashMap();
		if(_taskId !=null && firstEndpointId !=null && !_taskId.equals("") && !firstEndpointId.equals("")){
			rows = pagination.getRows();
			pageNum = pagination.getPage();
			int startRow;
			startRow = (pageNum - 1) * rows + 1;
			
			Map map = new HashMap() ;
			map.put("firstEndpointId", firstEndpointId) ;
			map.put("taskId", _taskId) ;
			
			map.put("queryType", "ALLNUM") ;
			total=Integer.valueOf(String.valueOf(getTestPilesService().queryTestSceneListByTaskId(map).get(0).get("ALLNUM"))) ;
			map.put("queryType", "") ;
			map.put("pro", startRow);
			map.put("end", startRow+rows-1);
			map.put("pro_mysql", startRow - 1);
			map.put("page_record", rows);
			testSceneLists =getTestPilesService().queryTestSceneListByTaskId(map) ;
			
			returnMap.put("startRow", startRow);
			returnMap.put("rows", rows); 	
			returnMap.put("total", total);
			returnMap.put("dataList", page.convertJson(testSceneLists));
		}
		return returnMap ;
	}
	public String testTask_chooseSerInvokeIns(){
        return SUCCESS ;
	}
	public String chooseSerInvokeIns(){
		return SUCCESS;
	}
	public String testTaskAdd(){
		 Map paramap = new HashMap();
	     paramap.put("serInvokeInsId", serInvokeInsId) ;
	     serInvokeInsMap = getTestPilesService().selectSerInvokeIns(paramap).get(0) ;
		return SUCCESS;
	}
	public String testTaskAddInsert(){
		 String _taskId = getTestPilesService().selectSeqApp("TEST_TASK");
		 testTask.setTaskId(Integer.valueOf(_taskId));
		 getTestPilesService().insertTestTask(testTask);
         return SUCCESS ;
     }
	public String testTaskEdit(){
		if(testTask.getTaskId() != null){
			testTask = getTestPilesService().queryTestTask(testTask);
		}
		Map paramap = new HashMap();
		serInvokeInsMap = getTestPilesService().selectSerInvokeIns(paramap).get(0) ;
		return SUCCESS;
	}
	public String testTaskEditUpdate(){
		getTestPilesService().updateTestTask(testTask);
        return SUCCESS ;
    }
	public void testTaskDel(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
			if(testTask.getTaskId() != null){
				getTestPilesService().testTaskListDelete(testTask);
			}
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			 try {
				out = getResponse().getWriter();
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			out.print("failure");
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }
	public String testTask_chooseScene(){
        return SUCCESS ;
	}
	
	public String testTask_chooseSceneSave(){
		PrintWriter out =null;
		try {
			 getRequest().setCharacterEncoding("UTF-8");
			 getTestPilesService().testTaskSceneSave(testTaskScene);
			 getResponse().setContentType("text/html;charset=UTF-8");
			 out = getResponse().getWriter();
			 String ret="[{\"msg\":\"ok\",\"data\":\"\"}]";
			 out.print(ret);
		}  catch (Exception e) {
			 try {
					out = getResponse().getWriter();
				} catch (IOException e1) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
				}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
        return SUCCESS ;
	}
	public String chooseTester(){
		if(!"".equals(testUserIds) && !"".equals(testUserNames)){
			String stringUserIdArray[]=testUserIds.split(",");  
			String stringUserNameArray[]=testUserNames.split(",");  
			int i =0;
			for(String stemp:stringUserIdArray){
				Map mapTest = new HashMap(); 
				mapTest.put("UserId", stemp);
				mapTest.put("UserName", stringUserNameArray[i]);
				testUserList.add(mapTest);
			    i++;
			} 
		} 
        return SUCCESS ;
	}

    public List<Object> getProcessDesignUserTree(Map map){
    	List<Object> list = new ArrayList<Object>();
		String id = (String) map.get("nodeId");
		Map paraMap=new HashMap();
		if(id!=null && !id.equals("0")){
			paraMap.put("f_Node", id);
			List<Map> ls = getTestPilesService().getProcessDesignSubGroupAndUser(paraMap);
			for (Map hashMap : ls) {
				int haveSub=Integer.valueOf(String.valueOf(hashMap.get("HAVE_SUB"))) ;
				Map mapTest = new HashMap(); 
				mapTest.put("nodeId", hashMap.get("ID"));
				mapTest.put("p_nodeId", hashMap.get("F_NODE"));
				if(haveSub==0){
					mapTest.put("isParent", false);
				}else{
					mapTest.put("isParent", true);
				}
				mapTest.put("nodeName", hashMap.get("TEXT"));
				list.add(mapTest);
			} 
		}else{
			//目录
			List<Map> ls = getTestPilesService().getProcessDesignRootGroup(paraMap);
			for (Map hashMap : ls) {
				int haveSub=Integer.valueOf(String.valueOf(hashMap.get("HAVE_SUB"))) ;
				Map mapTest = new HashMap(); 
				mapTest.put("nodeId", hashMap.get("ID"));
				mapTest.put("p_nodeId", hashMap.get("F_NODE"));
				if(haveSub==0){
					mapTest.put("isParent", false);
				}else{
					mapTest.put("isParent", true);
				}
				mapTest.put("nodeName", hashMap.get("TEXT"));
				list.add(mapTest);
			}  
		}
		return list ;
	}

    
    
	public String testingList(){
		personId = getPersonId();
		return SUCCESS;
	}
	public Map queryTestTestingList(Map para){
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("taskName", "".equals(getRequest().getParameter("taskName"))?null:getRequest().getParameter("taskName")) ;
		 map.put("sceneName", "".equals(getRequest().getParameter("sceneName"))?null:getRequest().getParameter("sceneName")) ;
		 map.put("testUserName", "".equals(getRequest().getParameter("testUserName"))?null:getRequest().getParameter("testUserName")) ;
		 map.put("remark", "".equals(getRequest().getParameter("remark"))?null:getRequest().getParameter("remark")) ;
		 
		String _personId = getPersonId();
		if(_personId != null && !_personId.equals("")){
			map.put("testUserId", _personId) ;
		}

		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getTestPilesService().queryTestTestingList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
       map.put("end", startRow+rows-1);
       map.put("pro_mysql", startRow - 1);
       map.put("page_record", rows);
       testTaskLists =getTestPilesService().queryTestTestingList(map) ;

		Map returnMap = new HashMap();
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(testTaskLists));
		return returnMap ;
	}
	public String testing(){
		Map map = new HashMap() ;
		map.put("testId", testId) ;
		testResultInfoMap = getTestPilesService().queryTestResultInfoMap(map);
		
		// http://192.168.1.53:8080/eaap_serviceAgent/webservice/offerOrder?SrcSysCode=6000060001
		// http://192.168.1.53:8080/eaap_serviceAgent/webservice/  +  API.api_method  +  ?SrcSysCode=  +  SER_INVOKE_INS.component_id
		String basePath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort()+ "/eaap_serviceAgent/webservice/";
		map.put("basePath", basePath) ;
		
		testResultSceneObjList = getTestPilesService().queryTestResultSceneObjList(map);

		return SUCCESS;
	}
	public void testExe(){
		PrintWriter out =null;
		DataOutputStream out2 = null;
		BufferedReader reader = null;
		try {
				String logId = getRequest().getParameter("logId");
				String _testId = getRequest().getParameter("testId");			
				String relaId = getRequest().getParameter("relaId");
				String _modId = getRequest().getParameter("modId");
				String requestDoc = getRequest().getParameter("requestDoc");
				String objType = getRequest().getParameter("objType");
				String _commProName = getRequest().getParameter("commProName");		//通讯协议类型
				String address = getRequest().getParameter("address");		//URL
			    
		    	String ruquestUrl = "";
				StringBuffer retSbf=new StringBuffer("");
				if("0".equals(objType)){
					//0 服务 
				    if(address!=null && !address.equals("")){
				    	ruquestUrl = address;
				    }
			    }else{
		    		//1 服务调用实例， 调02P对外提供的地址
					String baseSerPath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort();		// http://192.168.1.53:8080/
					if(address!=null && !address.equals("")){
						ruquestUrl = baseSerPath+ "/eaap_serviceAgent/webservice/" +address;
					}
			    }

			    if(!"".equals(ruquestUrl)){
			        URL postUrl = new URL(ruquestUrl);
			        HttpURLConnection connection = (HttpURLConnection) postUrl.openConnection();
			        connection.setDoOutput(true);
			        connection.setDoInput(true);
			        connection.setRequestMethod("POST");
			        connection.setUseCaches(false);
			        connection.setInstanceFollowRedirects(true);
			        connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			        connection.connect();
			        out2 = new DataOutputStream(connection.getOutputStream());
			        out2.writeBytes(requestDoc); 
			        out2.flush();
			        out2.close(); 
			        reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), Charset.forName("UTF-8")));
			        String line;
			        while ((line = reader.readLine()) != null) {
			        	retSbf.append(line);
			        }
			        reader.close();
			        connection.disconnect();
			    }else{
			    	if("0".equals(objType)){
					    retSbf.append("This service corresponding technology not set address.");
				    }else{
					    retSbf.append("Not set address.");
				    }
			    }
		        
				testResultLogMsg.setLogId(Integer.valueOf(logId));
				testResultLogMsg.setRelaId(Integer.valueOf(relaId));
				testResultLogMsg.setRequestMsg(requestDoc);
				testResultLogMsg.setResponseMsg(retSbf.toString());
				getTestPilesService().testResultLogMsgInsert(testResultLogMsg); //保存测试结果
		        
			 getResponse().setContentType("text/html;charset=UTF-8");
			 out = getResponse().getWriter();
			 String retStr= URLDecoder.decode(retSbf.toString(), "UTF-8");

			 out.print(retStr);
		}  catch (Exception e) {
			 try {
					out = getResponse().getWriter();
				} catch (IOException e1) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
				}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null !=  out){
				out.flush();
				out.close();
			}
			if(null !=out2){
				try {
					out2.close();
				} catch (IOException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
				}
			}
			if(null != reader){
				try {
					reader.close();
				} catch (IOException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
				}
			}
		}
	}	
	public void getLogId(){
		PrintWriter out =null;
		try {	
			String _testId = getRequest().getParameter("testId");
			String _logId = getTestPilesService().selectSeqApp("TEST_RESULT_LOG");
			
			testResultLog.setLogId(Integer.valueOf(_logId));
			testResultLog.setTestId(Integer.valueOf(_testId));
			getTestPilesService().testResultLogInsert(testResultLog);
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			String ret="[{'msg':'success','data':'"+_logId+"'}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null !=  out){
				out.flush();
				out.close();
			}
		}
	}
	
	public void saveTestResult(){
		PrintWriter out =null;
		try {
			 String testId = getRequest().getParameter("testId");
			 String _taskId = getRequest().getParameter("taskId");
			 String endpointId = getRequest().getParameter("endpointId");
			 String requestMsg = getRequest().getParameter("requestMsg");
			 String responseMsg = getRequest().getParameter("responseMsg");

			getRequest().setCharacterEncoding("UTF-8");
			Map map = new HashMap() ;
			map.put("taskId", _taskId) ;
			map.put("endpointId", endpointId) ;
			map.put("requestMessage", requestMsg) ;
			map.put("responseMessage", responseMsg) ;
			
		     if(testId==null || testId.equals("")){
		    	 //第一次测试保存
				 testId = getTestPilesService().selectSeqApp("TEST_RESULT");
				 map.put("testId", testId) ;
			     getTestPilesService().saveTestResult(map);
		     }else{
		    	 //重新测试保存
				 map.put("testId", testId) ;
			     getTestPilesService().updateTestResult(map);
		     }
		     
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			String ret="[{'msg':'success','data':'"+testId+"'}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null !=  out){
				out.flush();
				out.close();
			}
		}
	}

	public String testResults(){
		personId = getPersonId();
		return SUCCESS;
	}
	public Map getTestResultsList(Map para){

		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("taskName", "".equals(getRequest().getParameter("taskName"))?null:getRequest().getParameter("taskName")) ;
		 map.put("sceneName", "".equals(getRequest().getParameter("sceneName"))?null:getRequest().getParameter("sceneName")) ;
		 map.put("testUserName", "".equals(getRequest().getParameter("testUserName"))?null:getRequest().getParameter("testUserName")) ;
		 map.put("remark", "".equals(getRequest().getParameter("remark"))?null:getRequest().getParameter("remark")) ;

		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getTestPilesService().queryTestResultsList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
	     map.put("end", startRow+rows-1);
     	map.put("pro_mysql", startRow - 1);
     	map.put("page_record", rows);
     	testTaskLists =getTestPilesService().queryTestResultsList(map) ;

		Map returnMap = new HashMap();
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(testTaskLists));
		return returnMap ;
	}
	public String testResultInfo(){
		 String logId = getRequest().getParameter("logId");
		Map map = new HashMap() ;
		map.put("logId", logId) ;
		testResultInfoMap = getTestPilesService().queryTestResultLogInfoMap(map);
		
		String basePath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort()+ "/eaap_serviceAgent/webservice/";
		map.put("basePath", basePath) ;		
		testResultSceneObjList = getTestPilesService().queryTestResultLogSceneObjList(map);	
		return SUCCESS;
	}
	
	
	
   public String showTestMsgMod(){
		  formatTypeMap = getMainInfo(EAAPConstants.MSG_FORMAT_TYPE) ;
		  Iterator iter = formatTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 formatTypeList.add(mapTmp) ;
		 }
		
		return SUCCESS;
	}
	
	public Map getTestMsgModList(Map para){
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("modName", "".equals(getRequest().getParameter("testMsgMod.modName"))?null:getRequest().getParameter("testMsgMod.modName")) ;
		 map.put("msgFormatType", "".equals(getRequest().getParameter("testMsgMod.msgFormatType"))?null:getRequest().getParameter("testMsgMod.msgFormatType")) ;

		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getTestPilesService().getTestMsgModList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
         map.put("end", startRow+rows-1);
         map.put("pro_mysql", startRow - 1);
         map.put("page_record", rows);
         List<Map> testMsgModList =getTestPilesService().getTestMsgModList(map) ;

		  Map returnMap = new HashMap();
	      returnMap.put("startRow", startRow);
		  returnMap.put("rows", rows); 	
		  returnMap.put("total", total);
		  returnMap.put("dataList", page.convertJson(testMsgModList));

		  return returnMap ;
	}
	
	public String gotoEditTestMsgMod(){
		  formatTypeMap = getMainInfo(EAAPConstants.MSG_FORMAT_TYPE) ;
		  Iterator iter = formatTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 formatTypeList.add(mapTmp) ;
		 }

		  msgModStateMap = getMainInfo(EAAPConstants.MSG_FORMAT_MOD_STATE) ;
		  Iterator iterState = msgModStateMap.entrySet().iterator();   
		  while(iterState.hasNext()) {
			 Map mapTmpState = new HashMap() ;
			 Entry entryState = (Entry)iterState.next();
			 mapTmpState.put("key", entryState.getKey()) ;
			 mapTmpState.put("value", entryState.getValue()) ;
			 msgModStateList.add(mapTmpState) ;
		 }
		  
		  expFlagMap = getMainInfo(EAAPConstants.TEST_MSG_MOD_EXPRESSION_FLAG) ;
		  Iterator iterExpFlag = expFlagMap.entrySet().iterator();   
		  while(iterExpFlag.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iterExpFlag.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 expFlagList.add(mapTmp) ;
		 }
		
		 if (modId !=null && !"".equals(modId)) {
			 TestMsgMod  tempBean = new TestMsgMod();
			 tempBean.setModId(Integer.valueOf(modId));
			 testMsgMod = getTestPilesService().getTestMsgMod(tempBean);
		 }else{
			modId = getTestPilesService().selectSeqApp("TEST_MSG_MOD");		///
			testMsgMod.setExpressionFlag("1");
			testMsgMod.setDelayTime(0);
		 }
		  
		return SUCCESS;
	}

	public Map getTestMsgModResponseListByModId(Map para){
		String modId=null;
		if(StringUtils.isNotEmpty(para.get("queryParamsData").toString())){
			modId = para.get("queryParamsData").toString();
		}
		Map returnMap = new HashMap();
		if(modId !=null && !modId.equals("")){
			rows = pagination.getRows();
			pageNum = pagination.getPage();
			int startRow;
			startRow = (pageNum - 1) * rows + 1;
			
			Map map = new HashMap() ;
			map.put("modId", modId) ;
			
			map.put("queryType", "ALLNUM") ;
			total=Integer.valueOf(String.valueOf(getTestPilesService().getTestMsgModResponseListByModId(map).get(0).get("ALLNUM"))) ;
			map.put("queryType", "") ;
			map.put("pro", startRow);
			map.put("end", startRow+rows-1);
			map.put("pro_mysql", startRow - 1);
			map.put("page_record", rows);
			testSceneRelaList =getTestPilesService().getTestMsgModResponseListByModId(map) ;
			
			returnMap.put("startRow", startRow);
			returnMap.put("rows", rows); 	
			returnMap.put("total", total);
			returnMap.put("dataList", page.convertJson(testSceneRelaList));
		}
		return returnMap ;
	}
	
	public String testMsgModResponseEdit(){
		 if (msgId !=null && !"".equals(msgId)) {
			 TestMsgModResponse  tempBean = new TestMsgModResponse();
			 tempBean.setMsgId(Integer.valueOf(msgId));
			 testMsgModResponse = getTestPilesService().getTestMsgModResponse(tempBean);
		 }else{
			 testMsgModResponse.setModId(Integer.valueOf(modId));
		 }
		return SUCCESS;
	}

	public void saveTestMsgModResponse(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
			if (testMsgModResponse.getMsgId() > 0) {
				getTestPilesService().updateTestMsgModResponse(testMsgModResponse);
			} else {
				getTestPilesService().insertTestMsgModResponse(testMsgModResponse);
			}
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }

	public void deleteTestMsgModResponse(){
	    PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
			getTestPilesService().deleteTestMsgModResponse(testMsgModResponse);
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
    }
	
	public String editTestMsgMod(){
		String _personId = null;
		_personId = getPersonId();
		if (_personId != null) {
			testMsgMod.setPersonId(Integer.valueOf(_personId));
		}
		if (testMsgMod.getModId() > 0) {
			getTestPilesService().updateTestMsgMod(testMsgMod);
		} else {
			testMsgMod.setState("A"); 
			getTestPilesService().insertTestMsgMod(testMsgMod);
		}
		return SUCCESS;
	}
	
	public void saveTestMsgModData(){
	    PrintWriter out =null;
		try {
			String editOrAdd = getRequest().getParameter("editOrAdd");
			String _personId = null;
			_personId = getPersonId();
			if (_personId != null) {
				testMsgMod.setPersonId(Integer.valueOf(_personId));
			}

			if ("edit".equals(editOrAdd)){
				getTestPilesService().updateTestMsgMod(testMsgMod);
			} else {
				testMsgMod.setState("A"); 
				getTestPilesService().insertTestMsgMod(testMsgMod);
			}
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"editOrAdd\":\""+editOrAdd+"\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
     }
	
	public void checkDelayTimeCount(){
	    PrintWriter out =null;
		try {
			String count = getTestPilesService().checkDelayTimeCount();

		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"count\":\""+count+"\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != out){
				out.flush();
				out.close();
			}
		}
     }
	
	public String delTestMsgMod(){
		testMsgMod.setState("R");
		getTestPilesService().updateTestMsgMod(testMsgMod);
		getTestPilesService().deleteTestMsgMod(testMsgMod);
		return SUCCESS;
	}
	
	public String showTestMsgModRela(){
		  objTypeMap = getMainInfo(EAAPConstants.MOD_OBJ_RELA_TYPE) ;
		  Iterator iter = objTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 objTypeList.add(mapTmp) ;
		 }
		return SUCCESS;
	}
	
	public Map getTestMsgModRelaList(Map para){
		
		//测试桩模拟服务端地址   http://192.168.1.53:8080/
		String testPilesSerPath = getRequest().getScheme()+"://"+getRequest().getServerName()+":"+getRequest().getServerPort() + "/o2p-eaap_TestPileServer/servlet/";		
		
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("modName", "".equals(getRequest().getParameter("modName"))?null:getRequest().getParameter("modName")) ;
		 map.put("objName", "".equals(getRequest().getParameter("objName"))?null:getRequest().getParameter("objName")) ;
		 map.put("objType", "".equals(getRequest().getParameter("objType"))?null:getRequest().getParameter("objType")) ;
		 map.put("testPilesSerPath", testPilesSerPath) ;

		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getTestPilesService().getTestMsgModRelaList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
         map.put("end", startRow+rows-1);
         map.put("pro_mysql", startRow - 1);
         map.put("page_record", rows);
         List<Map> testMsgModList =getTestPilesService().getTestMsgModRelaList(map) ;

		  Map returnMap = new HashMap();
	      returnMap.put("startRow", startRow);
		  returnMap.put("rows", rows); 	
		  returnMap.put("total", total);
		  returnMap.put("dataList", page.convertJson(testMsgModList));

		  return returnMap ;
	}
	
	public String gotoEditTestMsgModRela(){

		  objTypeMap = getMainInfo(EAAPConstants.MOD_OBJ_RELA_TYPE) ;
		  Iterator iter = objTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 objTypeList.add(mapTmp) ;
		 }
		  
		return SUCCESS;
	}
	
	public String editTestMsgModRela(){
		testMsgModRela.setObjType(getRequest().getParameter("objType"));
		testMsgModRela.setModId(Integer.valueOf(getRequest().getParameter("modId")));
		if ("0".equals(testMsgModRela.getObjType())) {
			testMsgModRela.setObjId(Integer.valueOf(getRequest().getParameter("serviceId")));
		}
		if ("1".equals(testMsgModRela.getObjType())) {
			testMsgModRela.setObjId(Integer.valueOf(getRequest().getParameter("serInvokeInsId")));
		}
		String _personId = null;
		_personId = getPersonId();
		if (_personId != null) {
			testMsgModRela.setPersonId(Integer.valueOf(_personId));
		}
		
		String xx = "{\"msg\":\"OK\"}";
		getTestPilesService().insertTestMsgModRela(testMsgModRela);
		PrintWriter pw;
		try {
			pw = getResponse().getWriter();
			pw.write(xx) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		
		return SUCCESS;
	}
	
	public String delTestMsgModRela(){
		
		getTestPilesService().deleteTestMsgModRela(testMsgModRela);
		return SUCCESS;
	}
	
	public Map getMainInfo(String mainTypeSign){
	  	      MainDataType mainDataType = new MainDataType();
	  	      MainData mainData = new MainData();
	  	      Map stateMap = new HashMap() ;
	  	      mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
	  	      mainDataType.setMdtSign(mainTypeSign) ;
	  	      List<MainDataType> mdList = getConfManagerServ().selectMainDataType(mainDataType);
	  	      if(mdList!=null && mdList.size()>0){
	  	    	  mainDataType = mdList.get(0) ;
				  mainData.setMdtCd(mainDataType.getMdtCd()) ;
				  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
				  List<MainData> mainDataList = getConfManagerServ().selectMainData(mainData) ;
				  if(mainDataList!=null && mainDataList.size()>0){
					  for(int i=0;i<mainDataList.size();i++){
						  stateMap.put(mainDataList.get(i).getCepCode(), mainDataList.get(i).getCepName()) ;
					  }
				  }
			  }
			  return  stateMap ;
	  }
	
	public String getPersonId(){
		Cookie[] cookies = getRequest().getCookies();
		Cookie cookie = null;
		String sysPersonId = null;
		if(cookies != null){
			for(int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];
				if("sysPersonId".equals(cookie.getName())){
					sysPersonId = cookie.getValue();
				}
			}
		}
		return sysPersonId;
	}
	

	public ITestPilesService getTestPilesService() {
		if(testPilesService==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				testPilesService = (ITestPilesService)ctx.getBean("eaap-op2-conf-testPiles-testPilesService");
	     }
		return testPilesService;
	}
	public void setTestPilesService(ITestPilesService testPilesService) {
		this.testPilesService = testPilesService;
	}
	
	public ITechImplService getTechImplService() {
		if (techImplService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			techImplService = (ITechImplService)ctx.getBean("eaap-op2-conf-techimpl-TechImplService");
		}
		return techImplService;
	}
	public void setTechImplService(ITechImplService techImplService) {
		this.techImplService = techImplService;
	}
	
	public IServiceManagerServ getServiceManagerServ() {
		if(iServiceManagerServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				iServiceManagerServ = (IServiceManagerServ)ctx.getBean("eaap-op2-conf-service-manager-service") ;
	     }
		return iServiceManagerServ;
	}

	public ICompRegAuditingServ getCompRegAuditingServ() {
		if(compRegAuditingServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				compRegAuditingServ = (ICompRegAuditingServ)ctx.getBean("eaap-op2-conf-auditing-compServ");
	     }
		return compRegAuditingServ;
	}
	public void setCompRegAuditingServ(ICompRegAuditingServ compRegAuditingServ) {
		this.compRegAuditingServ = compRegAuditingServ;
	}

	public IOrgRegAuditingServ getOrgRegAuditingServ() {
		if(orgRegAuditingServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				orgRegAuditingServ = (IOrgRegAuditingServ)ctx.getBean("eaap-op2-conf-auditing-orgAndAppServ");
	     }
		return orgRegAuditingServ;
	}
	public void setOrgRegAuditingServ(IOrgRegAuditingServ orgRegAuditingServ) {
		this.orgRegAuditingServ = orgRegAuditingServ;
	}
		
	public IConfManagerServ getConfManagerServ() {
		if(confManagerServ==null){
            //取得spring上下文
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				// 取得spring bean实例
				confManagerServ = (IConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");
			   
	     }
		return confManagerServ;
	}
	public void setConfManagerServ(IConfManagerServ confManagerServ) {
		this.confManagerServ = confManagerServ;
	}
	

	/**
	 * @return the page
	 */
	public Pagination getPage() {
	    return page;
	}

	/**
	 * @param page the page to set
	 */
	public void setPage(Pagination page) {
	    this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public Pagination getPagination() {
		return pagination;
	}
	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	public String getEditOrAdd() {
		return editOrAdd;
	}
	public void setEditOrAdd(String editOrAdd) {
		this.editOrAdd = editOrAdd;
	}
	public List<Map> getTestSceneLists() {
		return testSceneLists;
	}
	public void setTestSceneLists(List<Map> testSceneLists) {
		this.testSceneLists = testSceneLists;
	}
	public List<Map> getCommProtocalList() {
		return commProtocalList;
	}
	public void setCommProtocalList(List<Map> commProtocalList) {
		this.commProtocalList = commProtocalList;
	}
	public List<Map<String, Object>> getCommProtocalResultList() {
		return commProtocalResultList;
	}
	public void setCommProtocalResultList(
			List<Map<String, Object>> commProtocalResultList) {
		this.commProtocalResultList = commProtocalResultList;
	}


	public TechImpl getTechImpl() {
		return techImpl;
	}
	public void setTechImpl(TechImpl techImpl) {
		this.techImpl = techImpl;
	}
	public String getTechImplName() {
		return techImplName;
	}
	
	public void setTechImplName(String techImplName) {
		this.techImplName = techImplName;
	}
	public String getComponentId() {
		return componentId;
	}
	public void setComponentId(String componentId) {
		this.componentId = componentId;
	}
	public String getTechImplId() {
		return techImplId;
	}
	public void setTechImplId(String techImplId) {
		this.techImplId = techImplId;
	}

	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	public List<Map> getTestTaskLists() {
		return testTaskLists;
	}
	public void setTestTaskLists(List<Map> testTaskLists) {
		this.testTaskLists = testTaskLists;
	}

	public Component getComponent() {
		return component;
	}
	public void setComponent(Component component) {
		this.component = component;
	}

	public Map getCompInfoMap() {
		return compInfoMap;
	}
	public void setCompInfoMap(Map compInfoMap) {
		this.compInfoMap = compInfoMap;
	}

	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}

	public Map getOrgInfoMap() {
		return orgInfoMap;
	}
	public void setOrgInfoMap(Map orgInfoMap) {
		this.orgInfoMap = orgInfoMap;
	}
 
	public String getCommProName() {
		return commProName;
	}
	public void setCommProName(String commProName) {
		this.commProName = commProName;
	}

	public TestScene getTestScene() {
		return testScene;
	}
	public void setTestScene(TestScene testScene) {
		this.testScene = testScene;
	}

	public Map getSerInvokeInsMap() {
		return serInvokeInsMap;
	}
	public void setSerInvokeInsMap(Map serInvokeInsMap) {
		this.serInvokeInsMap = serInvokeInsMap;
	}

	public String getSerInvokeInsId() {
		return serInvokeInsId;
	}
	public void setSerInvokeInsId(String serInvokeInsId) {
		this.serInvokeInsId = serInvokeInsId;
	}

	public TestTask getTestTask() {
		return testTask;
	}
	public void setTestTask(TestTask testTask) {
		this.testTask = testTask;
	}

	public TestTaskScene getTestTaskScene() {
		return testTaskScene;
	}
	public void setTestTaskScene(TestTaskScene testTaskScene) {
		this.testTaskScene = testTaskScene;
	}

	public Map getTestMsgInfoMap() {
		return testMsgInfoMap;
	}
	public void setTestMsgInfoMap(Map testMsgInfoMap) {
		this.testMsgInfoMap = testMsgInfoMap;
	}

	public String getTestId() {
		return testId;
	}
	public void setTestId(String testId) {
		this.testId = testId;
	}

	public TestResult getTestResult() {
		return testResult;
	}
	public void setTestResult(TestResult testResult) {
		this.testResult = testResult;
	}

	public Map getTestResultInfoMap() {
		return testResultInfoMap;
	}
	public void setTestResultInfoMap(Map testResultInfoMap) {
		this.testResultInfoMap = testResultInfoMap;
	}

	public String getTestUserIdInput() {
		return testUserIdInput;
	}
	public void setTestUserIdInput(String testUserIdInput) {
		this.testUserIdInput = testUserIdInput;
	}
	public String getTestUserNameInput() {
		return testUserNameInput;
	}
	public void setTestUserNameInput(String testUserNameInput) {
		this.testUserNameInput = testUserNameInput;
	}

	public String getTestUserIds() {
		return testUserIds;
	}
	public void setTestUserIds(String testUserIds) {
		this.testUserIds = testUserIds;
	}
	public String getTestUserNames() {
		return testUserNames;
	}
	public void setTestUserNames(String testUserNames) {
		this.testUserNames = testUserNames;
	}

	public List<Map<String, Object>> getTestUserList() {
		return testUserList;
	}
	public void setTestUserList(List<Map<String, Object>> testUserList) {
		this.testUserList = testUserList;
	}


	public String getSceneId() {
		return sceneId;
	}
	public void setSceneId(String sceneId) {
		this.sceneId = sceneId;
	}

	public List<Map> getTestSceneRelaList() {
		return testSceneRelaList;
	}
	public void setTestSceneRelaList(List<Map> testSceneRelaList) {
		this.testSceneRelaList = testSceneRelaList;
	}
	public TestSceneRela getTestSceneRela() {
		return testSceneRela;
	}
	public void setTestSceneRela(TestSceneRela testSceneRela) {
		this.testSceneRela = testSceneRela;
	}
	public List<Map> getTestSceneRelaModLists() {
		return testSceneRelaModLists;
	}
	public void setTestSceneRelaModLists(List<Map> testSceneRelaModLists) {
		this.testSceneRelaModLists = testSceneRelaModLists;
	}
	public TestMsgMod getTestMsgMod() {
		return testMsgMod;
	}
	public void setTestMsgMod(TestMsgMod testMsgMod) {
		this.testMsgMod = testMsgMod;
	}
	public TestMsgModRela getTestMsgModRela() {
		return testMsgModRela;
	}
	public void setTestMsgModRela(TestMsgModRela testMsgModRela) {
		this.testMsgModRela = testMsgModRela;
	}
	public Boolean getIsChoosePage() {
		return isChoosePage;
	}
	public void setIsChoosePage(Boolean isChoosePage) {
		this.isChoosePage = isChoosePage;
	}
	public String getSceneIdInput() {
		return sceneIdInput;
	}
	public void setSceneIdInput(String sceneIdInput) {
		this.sceneIdInput = sceneIdInput;
	}
	public String getSceneNameInput() {
		return sceneNameInput;
	}
	public void setSceneNameInput(String sceneNameInput) {
		this.sceneNameInput = sceneNameInput;
	}
	public TestTaskUser getTestTaskUser() {
		return testTaskUser;
	}
	public void setTestTaskUser(TestTaskUser testTaskUser) {
		this.testTaskUser = testTaskUser;
	}
	
	public List<Map> getTestResultSceneObjList() {
		return testResultSceneObjList;
	}
	public void setTestResultSceneObjList(List<Map> testResultSceneObjList) {
		this.testResultSceneObjList = testResultSceneObjList;
	}

	public TestResultLog getTestResultLog() {
		return testResultLog;
	}
	public void setTestResultLog(TestResultLog testResultLog) {
		this.testResultLog = testResultLog;
	}
	public TestResultLogMsg getTestResultLogMsg() {
		return testResultLogMsg;
	}
	public void setTestResultLogMsg(TestResultLogMsg testResultLogMsg) {
		this.testResultLogMsg = testResultLogMsg;
	}
	


	public List<Map> getFormatTypeList() {
		return formatTypeList;
	}

	public void setFormatTypeList(List<Map> formatTypeList) {
		this.formatTypeList = formatTypeList;
	}

	public Map getFormatTypeMap() {
		return formatTypeMap;
	}

	public void setFormatTypeMap(Map formatTypeMap) {
		this.formatTypeMap = formatTypeMap;
	}

	public List<Map> getMsgModStateList() {
		return msgModStateList;
	}

	public void setMsgModStateList(List<Map> msgModStateList) {
		this.msgModStateList = msgModStateList;
	}

	public Map getMsgModStateMap() {
		return msgModStateMap;
	}

	public void setMsgModStateMap(Map msgModStateMap) {
		this.msgModStateMap = msgModStateMap;
	}

	public Map getObjTypeMap() {
		return objTypeMap;
	}

	public void setObjTypeMap(Map objTypeMap) {
		this.objTypeMap = objTypeMap;
	}

	public List<Map> getObjTypeList() {
		return objTypeList;
	}

	public void setObjTypeList(List<Map> objTypeList) {
		this.objTypeList = objTypeList;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
	}

	public String getModName() {
		return modName;
	}

	public void setModName(String modName) {
		this.modName = modName;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public Map getExpFlagMap() {
		return expFlagMap;
	}

	public void setExpFlagMap(Map expFlagMap) {
		this.expFlagMap = expFlagMap;
	}

	public List<Map> getExpFlagList() {
		return expFlagList;
	}

	public void setExpFlagList(List<Map> expFlagList) {
		this.expFlagList = expFlagList;
	}

	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}

	public TestMsgModResponse getTestMsgModResponse() {
		return testMsgModResponse;
	}
	public void setTestMsgModResponse(TestMsgModResponse testMsgModResponse) {
		this.testMsgModResponse = testMsgModResponse;
	}

	
}
