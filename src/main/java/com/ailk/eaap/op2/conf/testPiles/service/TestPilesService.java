package com.ailk.eaap.op2.conf.testPiles.service;

import java.util.Map;
import java.util.List;
import java.util.HashMap;

import com.ailk.eaap.op2.bo.TestMsgMod;
import com.ailk.eaap.op2.bo.TestMsgModRela;
import com.ailk.eaap.op2.bo.TestMsgModResponse;
import com.ailk.eaap.op2.bo.TestResult;
import com.ailk.eaap.op2.bo.TestScene;
import com.ailk.eaap.op2.bo.TestTask;
import com.ailk.eaap.op2.bo.TestTaskScene;
import com.ailk.eaap.op2.bo.TestTaskUser;
import com.ailk.eaap.op2.conf.testPiles.dao.TestPilesDao;
import com.ailk.eaap.op2.bo.TestResultLog;
import com.ailk.eaap.op2.bo.TestResultLogMsg;
import com.ailk.eaap.op2.bo.TestSceneRela;

public class TestPilesService implements ITestPilesService {
	private TestPilesDao testPilesDao ;
	
	public TestPilesDao getTestPilesDao() {
		return testPilesDao;
	}
	public void setTestPilesDao(TestPilesDao testPilesDao) {
		this.testPilesDao = testPilesDao;
	}

	
	
	 public List<Map> queryTestSceneList(Map map){
			return testPilesDao.queryTestSceneList(map);
	 }
	 public List<Map> getTestSceneRelaListBySceneId(Map map){
			return testPilesDao.getTestSceneRelaListBySceneId(map);
	 }
	 
	 public List<Map> queryTestTaskList(Map map){
			return testPilesDao.queryTestTaskList(map);
	 }
	 public List<Map> queryTestSceneListByTaskId(Map map){
			return testPilesDao.queryTestSceneListByTaskId(map);
	 }

	 public List<Map> queryTestTestingList(Map map){
		   return testPilesDao.queryTestTestingList(map);
	 }
	 public List<Map> queryTestingSceneListByTaskId(Map map){
		   return testPilesDao.queryTestingSceneListByTaskId(map);
	 }

	 public List<Map> queryTestResultsList(Map map){
		   return testPilesDao.queryTestResultsList(map);
	 }

	public void insertTestScene(TestScene testScene){
			testPilesDao.insertTestScene(testScene);
	}
	public void updateTestScene(TestScene testScene){
			testPilesDao.updateTestScene(testScene);
	}
	public void deleteTestScene(TestScene testScene){
			testPilesDao.deleteTestScene(testScene);
	}
	public void testSceneListDelete(TestScene testScene){
		testPilesDao.testSceneListDelete(testScene);
	}
	
	public List<Map>  selectSerInvokeIns(Map map){
		return testPilesDao.selectSerInvokeIns(map);
	}
	public void insertTestTask(TestTask testTask){
		testPilesDao.insertTestTask(testTask);
	}
	public void updateTestTask(TestTask testTask){
		testPilesDao.updateTestTask(testTask);
	}
	public void testTaskListDelete(TestTask testTask){
		testPilesDao.testTaskListDelete(testTask);
	}
	 public TestTask queryTestTask(TestTask testTask_in){
		    TestTask testTask = testPilesDao.queryTestTask(testTask_in);
			return testTask;
	}
	public void testTaskSceneSave(TestTaskScene testTaskScene){
			testPilesDao.testTaskSceneSave(testTaskScene);
	}

	public List<Map>  queryTestMsgInfo(Map map){
		return testPilesDao.queryTestMsgInfo(map);
	}

	public String selectSeqApp(String tableName){
		Map map = new HashMap();
		map.put("tableName", tableName) ;
		return testPilesDao.selectSeqApp(map);
	}

	 public TestScene queryTestScene(TestScene testScene){
			testScene = testPilesDao.queryTestScene(testScene);
			return testScene;
	}
	 public TestResult queryTestResult(TestResult testResult_in){
		 TestResult testResult = testPilesDao.queryTestResult(testResult_in);
		return testResult;
	}

	public List<Map>  queryTestResultInfo(Map map){
		return testPilesDao.queryTestResultInfo(map);
	}
	 public List<Map> queryTestResultSceneListByTestId(Map map){
		   return testPilesDao.queryTestResultSceneListByTestId(map);
	 }


	public void saveTestResult(Map map){
		testPilesDao.saveTestResult(map);
	}
	public void updateTestResult(Map map){
		testPilesDao.updateTestResult(map);
	}
	
	public String getTestUserIds(String procId){
		Map map = new HashMap();
		map.put("procId", procId) ;
		return testPilesDao.getTestUserIds(map);
	}

	public List<Map> getProcessDesignRootGroup(Map map){
		   return testPilesDao.getProcessDesignRootGroup(map);
	}
	public List<Map> getProcessDesignSubGroupAndUser(Map map){
		   return testPilesDao.getProcessDesignSubGroupAndUser(map);
	}


	public void testSceneRelaDel(TestSceneRela testSceneRela){
		testPilesDao.testSceneRelaDel(testSceneRela);
	}
	public void testSceneRelaUpdateMod(TestSceneRela testSceneRela){
		testPilesDao.testSceneRelaUpdateMod(testSceneRela);
	}
	 public List<Map> getTestSceneRelaModList(Map map){
			return testPilesDao.getTestSceneRelaModList(map);
	 }
	public void testSceneRelaModDel(TestMsgModRela testMsgModRela){
			testPilesDao.testSceneRelaModDel(testMsgModRela);
	}
	public void testSceneRelaModUpdate(TestMsgMod testMsgMod){
		testPilesDao.testSceneRelaModUpdate(testMsgMod);
	}
	public void testSceneRelaModAdd(TestMsgMod testMsgMod, TestMsgModRela testMsgModRela){
		testPilesDao.testSceneRelaModAdd(testMsgMod,testMsgModRela);
	}
	 public List<Map> getTestSceneRelaObjList(Map map){
			return testPilesDao.getTestSceneRelaObjList(map);
	 }
	public void testSceneRelaSave(TestSceneRela testSceneRela){
		testPilesDao.testSceneRelaSave(testSceneRela);
	}
	
	 public TestTaskScene queryTestTaskScene(TestTaskScene testTaskScene){
		 testTaskScene = testPilesDao.queryTestTaskScene(testTaskScene);
			return testTaskScene;
	}
	public Map queryTestTaskUsers(Map map){
		   return testPilesDao.queryTestTaskUsers(map);
	}
	
	public void testTaskUserInsert(TestTaskUser testTaskUser){
		testPilesDao.testTaskUserInsert(testTaskUser);
	}
	public void testTaskUserDel(TestTaskUser testTaskUser){
			testPilesDao.testTaskUserDel(testTaskUser);
	}

	public void testResultInsert(TestResult testResult){
		testPilesDao.testResultInsert(testResult);
	}
	public void testResultDel(TestResult testResult){
		testPilesDao.testResultDel(testResult);
	}

	public Map queryTestResultInfoMap(Map map){
		   return testPilesDao.queryTestResultInfoMap(map);
	}
	 public List<Map> queryTestResultSceneObjList(Map map){
		   return testPilesDao.queryTestResultSceneObjList(map);
	 }
	 
	public void testResultLogInsert(TestResultLog testResultLog){
		testPilesDao.testResultLogInsert(testResultLog);
	}
	public void testResultLogMsgInsert(TestResultLogMsg testResultLogMsg){
		testPilesDao.testResultLogMsgInsert(testResultLogMsg);
	}


	public Map queryTestResultLogInfoMap(Map map){
		   return testPilesDao.queryTestResultLogInfoMap(map);
	}
	 public List<Map> queryTestResultLogSceneObjList(Map map){
		   return testPilesDao.queryTestResultLogSceneObjList(map);
	 }
	
	public List<Map> getTestMsgModList(Map map){
		 return testPilesDao.getTestMsgModList(map);
	}
	
	public TestMsgMod getTestMsgMod(TestMsgMod testMsgMod){
		return testPilesDao.getTestMsgMod(testMsgMod); 
	}
	
	public void insertTestMsgMod(TestMsgMod testMsgMod){
		testPilesDao.insertTestMsgMod(testMsgMod); 
	}
	public void updateTestMsgMod(TestMsgMod testMsgMod){
		testPilesDao.updateTestMsgMod(testMsgMod); 
	}
	public void deleteTestMsgModRela(TestMsgModRela testMsgModRela){
		testPilesDao.deleteTestMsgModRela(testMsgModRela); 
	}
	public List<Map> getTestMsgModResponseListByModId(Map map){
		return testPilesDao.getTestMsgModResponseListByModId(map);
	}
	public TestMsgModResponse getTestMsgModResponse(TestMsgModResponse  testMsgModResponse){
		return testPilesDao.getTestMsgModResponse(testMsgModResponse); 
	}
	public void insertTestMsgModResponse(TestMsgModResponse testMsgModResponse){
		testPilesDao.insertTestMsgModResponse(testMsgModResponse); 
	}
	public void updateTestMsgModResponse(TestMsgModResponse testMsgModResponse){
		testPilesDao.updateTestMsgModResponse(testMsgModResponse); 
	}
	public void deleteTestMsgModResponse(TestMsgModResponse testMsgModResponse){
		testPilesDao.deleteTestMsgModResponse(testMsgModResponse); 
	}
	public String checkDelayTimeCount(){
		return testPilesDao.checkDelayTimeCount();
	}
	
	public List<Map> getTestMsgModRelaList(Map map){
		 return testPilesDao.getTestMsgModRelaList(map);
	}
	
	public TestMsgModRela getTestMsgModRela(TestMsgModRela testMsgModRela){
		return testPilesDao.getTestMsgModRela(testMsgModRela); 
	}
	
	public void insertTestMsgModRela(TestMsgModRela testMsgModRela){
		testPilesDao.insertTestMsgModRela(testMsgModRela); 
	}
	public void updateTestMsgModRela(TestMsgModRela testMsgModRela){
		testPilesDao.updateTestMsgModRela(testMsgModRela); 
	}
	public void deleteTestMsgMod(TestMsgMod testMsgMod){
		testPilesDao.deleteTestMsgMod(testMsgMod); 
	}
	
	public Integer existTestMsgModRela(TestMsgModRela testMsgModRela){
		return testPilesDao.existTestMsgModRela(testMsgModRela);
	}
}
