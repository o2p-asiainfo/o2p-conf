package com.ailk.eaap.op2.conf.testPiles.service;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.TestMsgMod;
import com.ailk.eaap.op2.bo.TestMsgModRela;
import com.ailk.eaap.op2.bo.TestMsgModResponse;
import com.ailk.eaap.op2.bo.TestResult;
import com.ailk.eaap.op2.bo.TestScene;
import com.ailk.eaap.op2.bo.TestTask;
import com.ailk.eaap.op2.bo.TestTaskScene;
import com.ailk.eaap.op2.bo.TestTaskUser;
import com.ailk.eaap.op2.bo.TestResultLog;
import com.ailk.eaap.op2.bo.TestResultLogMsg;
import com.ailk.eaap.op2.bo.TestSceneRela;

public interface ITestPilesService{ 

	public List<Map> queryTestSceneList(Map map) ; 
	public List<Map> getTestSceneRelaListBySceneId(Map map) ; 
	
	public List<Map> queryTestTaskList(Map map) ; 
	public List<Map> queryTestSceneListByTaskId(Map map) ; 

	public List<Map> queryTestTestingList(Map map) ; 
	public List<Map> queryTestingSceneListByTaskId(Map map) ; 

	public List<Map> queryTestResultsList(Map map) ; 

	public TestScene queryTestScene(TestScene testScene);

	public void insertTestScene(TestScene testScene);
	public void updateTestScene(TestScene testScene);
	public void deleteTestScene(TestScene testScene);
	public void testSceneListDelete(TestScene testScene);

	public List<Map>  selectSerInvokeIns(Map map);
	public void insertTestTask(TestTask testTask);
	public void updateTestTask(TestTask testTask);
	public void testTaskListDelete(TestTask testTask);
	public TestTask queryTestTask(TestTask testTask);
	public List<Map>  queryTestMsgInfo(Map map);
	public void testTaskSceneSave(TestTaskScene testTaskScene);

	public void saveTestResult(Map map);
	public void updateTestResult(Map map);
	public TestResult queryTestResult(TestResult testResult);

	public List<Map>  queryTestResultInfo(Map map);
	public List<Map> queryTestResultSceneListByTestId(Map map) ; 

	public String selectSeqApp(String tableName);
	
	public String getTestUserIds(String procId);

	public List<Map> getProcessDesignRootGroup(Map map);
	public List<Map> getProcessDesignSubGroupAndUser(Map map);

	public void testSceneRelaDel(TestSceneRela testSceneRela);
	public void testSceneRelaUpdateMod(TestSceneRela testSceneRela);
	public List<Map> getTestSceneRelaModList(Map map) ; 
	public void testSceneRelaModDel(TestMsgModRela testMsgModRela);
	public void testSceneRelaModUpdate(TestMsgMod testMsgMod);
	public void testSceneRelaModAdd(TestMsgMod testMsgMod, TestMsgModRela testMsgModRela);
	public List<Map> getTestSceneRelaObjList(Map map) ; 
	public void testSceneRelaSave(TestSceneRela testSceneRela);
	public TestTaskScene queryTestTaskScene(TestTaskScene testTaskScene);
	public Map queryTestTaskUsers(Map map);
	
	public void testTaskUserInsert(TestTaskUser testTaskUser);
	public void testTaskUserDel(TestTaskUser testTaskUser);
	
	public void testResultInsert(TestResult testResult);
	public void testResultDel(TestResult testResult);
	public Map queryTestResultInfoMap(Map map);
	public List<Map> queryTestResultSceneObjList(Map map) ; 
	public void testResultLogInsert(TestResultLog testResultLog);
	public void testResultLogMsgInsert(TestResultLogMsg testResultLogMsg);
	public Map queryTestResultLogInfoMap(Map map);
	public List<Map> queryTestResultLogSceneObjList(Map map) ; 

	public List<Map> getTestMsgModList(Map map);
	public TestMsgMod getTestMsgMod(TestMsgMod testMsgMod);
	public void insertTestMsgMod(TestMsgMod testMsgMod);
	public void updateTestMsgMod(TestMsgMod testMsgMod);
	public void deleteTestMsgMod(TestMsgMod testMsgMod);
	public List<Map> getTestMsgModResponseListByModId(Map map) ; 
	public TestMsgModResponse getTestMsgModResponse(TestMsgModResponse  testMsgModResponse);
	public void insertTestMsgModResponse(TestMsgModResponse testMsgModResponse);
	public void updateTestMsgModResponse(TestMsgModResponse testMsgModResponse);
	public void deleteTestMsgModResponse(TestMsgModResponse testMsgModResponse);
	public String checkDelayTimeCount();
	
	public List<Map> getTestMsgModRelaList(Map map);
	public TestMsgModRela getTestMsgModRela(TestMsgModRela testMsgModRela);
	public void insertTestMsgModRela(TestMsgModRela testMsgModRela);
	public void updateTestMsgModRela(TestMsgModRela testMsgModRela);
	public void deleteTestMsgModRela(TestMsgModRela testMsgModRela);
	
	public Integer existTestMsgModRela(TestMsgModRela testMsgModRela);
}
