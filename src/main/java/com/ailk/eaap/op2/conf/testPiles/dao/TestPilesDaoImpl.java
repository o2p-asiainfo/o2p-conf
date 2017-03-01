package com.ailk.eaap.op2.conf.testPiles.dao;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.TestMsgMod;
import com.ailk.eaap.op2.bo.TestMsgModRela;
import com.ailk.eaap.op2.bo.TestMsgModResponse;
import com.ailk.eaap.op2.bo.TestResult;
import com.ailk.eaap.op2.bo.TestResultLog;
import com.ailk.eaap.op2.bo.TestResultLogMsg;
import com.ailk.eaap.op2.bo.TestScene;
import com.ailk.eaap.op2.bo.TestSceneRela;
import com.ailk.eaap.op2.bo.TestTask;
import com.ailk.eaap.op2.bo.TestTaskScene;
import com.ailk.eaap.op2.bo.TestTaskUser;
import com.linkage.rainbow.dao.SqlMapDAO;
 
public class TestPilesDaoImpl   implements TestPilesDao {
	private SqlMapDAO sqlMapDao;

	public List<Map> queryTestSceneList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestSceneListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestSceneList", map) ;
		}
    }
	public List<Map> getTestSceneRelaListBySceneId(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestSceneRelaListBySceneIdCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestSceneRelaListBySceneId", map) ;
		}
    }

	public List<Map> queryTestTaskList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestTaskListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestTaskList", map) ;
		}
    }
	public List<Map> queryTestSceneListByTaskId(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestSceneListByTaskIdCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestSceneListByTaskId", map) ;
		}
    }



	public List<Map> queryTestTestingList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.queryTestTestingListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.queryTestTestingList", map) ;
		}
    }
	public List<Map> queryTestingSceneListByTaskId(Map map) {
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestingSceneListByTaskId", map) ;
    }



	public List<Map> queryTestResultsList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestResultsListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectTestResultsList", map) ;
		}
    }
	

	public TestScene queryTestScene(TestScene testScene){
		return (TestScene)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.queryTestScene", testScene);
	}
	

	public String queryTestSceneRequestMessageMod(Map map){
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.queryTestSceneRequestMessageMod", map);
	}

	public void insertTestScene(TestScene testScene){
		sqlMapDao.insert("eaap-op2-conf-testPiles.insertTestScene", testScene);
	}
	public void updateTestScene(TestScene testScene){
		sqlMapDao.update("eaap-op2-conf-testPiles.updateTestScene", testScene);
	}
	public void deleteTestScene(TestScene testScene){
		sqlMapDao.delete("eaap-op2-conf-testPiles.deleteTestScene", testScene);
	}
	public void testSceneListDelete(TestScene testScene){
		sqlMapDao.delete("eaap-op2-conf-testPiles.testSceneListDelete", testScene);
	}

	public List<Map>  selectSerInvokeIns(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.selectSerInvokeIns", map) ;
	}
	public void insertTestTask(TestTask testTask){
		sqlMapDao.insert("eaap-op2-conf-testPiles.insertTestTask", testTask);
	}
	public void updateTestTask(TestTask testTask){
		sqlMapDao.update("eaap-op2-conf-testPiles.updateTestTask", testTask);
	}
	public void testTaskListDelete(TestTask testTask){
		sqlMapDao.delete("eaap-op2-conf-testPiles.testTaskSceneDelete", testTask);
		sqlMapDao.delete("eaap-op2-conf-testPiles.testTaskUserDelete", testTask);
		sqlMapDao.delete("eaap-op2-conf-testPiles.testTaskListDelete", testTask);
	}
	public TestTask queryTestTask(TestTask testTask){
		return (TestTask)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.queryTestTask", testTask);
	}
	public void testTaskSceneSave(TestTaskScene testTaskScene){
		sqlMapDao.insert("eaap-op2-conf-testPiles.testTaskSceneDel", testTaskScene);
		sqlMapDao.insert("eaap-op2-conf-testPiles.testTaskSceneInsert", testTaskScene);
	}

	public List<Map>  queryTestMsgInfo(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.queryTestMsgInfo", map) ;
	}
	

	public void testResultLogInsert(TestResultLog testResultLog){
		sqlMapDao.insert("eaap-op2-conf-testPiles.testResultLogInsert", testResultLog);
	}
	public void testResultLogMsgInsert(TestResultLogMsg testResultLogMsg){
		sqlMapDao.delete("eaap-op2-conf-testPiles.testResultLogMsgDel", testResultLogMsg);
		sqlMapDao.insert("eaap-op2-conf-testPiles.testResultLogMsgInsert", testResultLogMsg);
	}
	
	public void saveTestResult(Map map){
		sqlMapDao.insert("eaap-op2-conf-testPiles.insertTestResult", map);
		sqlMapDao.insert("eaap-op2-conf-testPiles.insertTestMessage", map);
	}
	public void updateTestResult(Map map){
		sqlMapDao.update("eaap-op2-conf-testPiles.updateTestResult", map);
		sqlMapDao.update("eaap-op2-conf-testPiles.updateTestMessage", map);
	}

	public TestResult queryTestResult(TestResult testResult){
		return (TestResult)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.queryTestResult", testResult);
	}
	
	public List<Map>  queryTestResultInfo(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.queryTestResultInfo", map) ;
	}

	public List<Map> queryTestResultSceneListByTestId(Map map) {
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.queryTestResultSceneListByTestId", map) ;
    }
	
	public String selectSeqApp(Map map){
		String  retSeq ="";
		if("TEST_SCENE".equals(String.valueOf(map.get("tableName")))){
			retSeq = (String)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.selectTestSceneSeq", null);
		}
		if("TEST_TASK".equals(String.valueOf(map.get("tableName")))){
			retSeq = (String)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.selectTestTaskSeq", null);
		}
		if("TEST_RESULT".equals(String.valueOf(map.get("tableName")))){
			retSeq = (String)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.selectTestResultSeq", null);
		}
		if("TEST_MSG_MOD".equals(String.valueOf(map.get("tableName")))){
			retSeq = (String)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.selectTestMsgModSeq", null);
		}
		if("TEST_RESULT_LOG".equals(String.valueOf(map.get("tableName")))){
			retSeq = (String)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.selectTestResultLogSeq", null);
		}
		return retSeq;
	}
	
	public String getTestUserIds(Map map){
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.getTestUserIds", map);
	}
	
	public List<Map> getProcessDesignRootGroup(Map map){
		return  (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getProcessDesignRootGroup", map);
	}
	
	public List<Map> getProcessDesignSubGroupAndUser(Map map){	
		return  (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getProcessDesignSubGroupAndUser", map);
	}

	public void testSceneRelaDel(TestSceneRela testSceneRela){
		sqlMapDao.delete("eaap-op2-conf-testPiles.testSceneRelaDel", testSceneRela);
	}
	public void testSceneRelaUpdateMod(TestSceneRela testSceneRela){
		sqlMapDao.delete("eaap-op2-conf-testPiles.testSceneRelaUpdateMod", testSceneRela);
	}
	public List<Map> getTestSceneRelaModList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestSceneRelaModListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestSceneRelaModList", map) ;
		}
    }
	public void testSceneRelaModDel(TestMsgModRela testMsgModRela){
		sqlMapDao.delete("eaap-op2-conf-testPiles.testSceneRelaModDel", testMsgModRela);
	}
	public void testSceneRelaModUpdate(TestMsgMod testMsgMod){
		sqlMapDao.update("eaap-op2-conf-testPiles.testSceneRelaModUpdate", testMsgMod);
	}
	public void testSceneRelaModAdd(TestMsgMod testMsgMod, TestMsgModRela testMsgModRela){
		sqlMapDao.insert("eaap-op2-conf-testPiles.testSceneRelaModAdd", testMsgMod);
		sqlMapDao.insert("eaap-op2-conf-testPiles.testSceneRelaModRelaAdd", testMsgModRela);
	}
	public List<Map> getTestSceneRelaObjList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestSceneRelaObjListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestSceneRelaObjList", map) ;
		}
    }
	public void testSceneRelaSave(TestSceneRela testSceneRela){
		sqlMapDao.insert("eaap-op2-conf-testPiles.testSceneRelaInsert", testSceneRela);
	}

	public TestTaskScene queryTestTaskScene(TestTaskScene testTaskScene){
		return (TestTaskScene)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.queryTestTaskScene", testTaskScene);
	}

	public Map queryTestTaskUsers(Map map){
		return (Map)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.queryTestTaskUsers", map);
	}

	public void testTaskUserInsert(TestTaskUser testTaskUser){
		sqlMapDao.insert("eaap-op2-conf-testPiles.testTaskUserInsert", testTaskUser);
	}
	public void testTaskUserDel(TestTaskUser testTaskUser){
		sqlMapDao.delete("eaap-op2-conf-testPiles.testTaskUserDel", testTaskUser);
	}


	public void testResultInsert(TestResult testResult){
		sqlMapDao.insert("eaap-op2-conf-testPiles.testResultInsert", testResult);
	}
	public void testResultDel(TestResult testResult){
		sqlMapDao.delete("eaap-op2-conf-testPiles.testResultDel", testResult);
	}
	public Map queryTestResultInfoMap(Map map){
		return (Map)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.queryTestResultInfoMap", map);
	}
	public List<Map> queryTestResultSceneObjList(Map map) {
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.queryTestResultSceneObjList", map) ;
    }

	public List<Map> getTestMsgModList(Map map){
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestMsgModListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestMsgModList", map) ;
		}
	}

	public Map queryTestResultLogInfoMap(Map map){
		return (Map)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.queryTestResultLogInfoMap", map);
	}
	public List<Map> queryTestResultLogSceneObjList(Map map) {
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.queryTestResultLogSceneObjList", map) ;
    }
	
	public TestMsgMod getTestMsgMod(TestMsgMod testMsgMod){
		return (TestMsgMod)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.getTestMsgMod", testMsgMod);
	}
	
	public void insertTestMsgMod(TestMsgMod testMsgMod){
		sqlMapDao.insert("eaap-op2-conf-testPiles.insertTestMsgMod", testMsgMod);
	}
	public void updateTestMsgMod(TestMsgMod testMsgMod){
		sqlMapDao.update("eaap-op2-conf-testPiles.updateTestMsgMod", testMsgMod);
	}
	public void deleteTestMsgMod(TestMsgMod testMsgMod){
		sqlMapDao.delete("eaap-op2-conf-testPiles.deleteTestMsgMod", testMsgMod);
	}
	public List<Map> getTestMsgModResponseListByModId(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestMsgModResponseListByModIdCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestMsgModResponseListByModId", map) ;
		}
    }
	public TestMsgModResponse getTestMsgModResponse(TestMsgModResponse  testMsgModResponse){
		return (TestMsgModResponse)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.getTestMsgModResponse", testMsgModResponse);
	}
	public void insertTestMsgModResponse(TestMsgModResponse testMsgModResponse){
		sqlMapDao.insert("eaap-op2-conf-testPiles.insertTestMsgModResponse", testMsgModResponse);
	}
	public void updateTestMsgModResponse(TestMsgModResponse testMsgModResponse){
		sqlMapDao.update("eaap-op2-conf-testPiles.updateTestMsgModResponse", testMsgModResponse);
	}
	public void deleteTestMsgModResponse(TestMsgModResponse testMsgModResponse){
		sqlMapDao.delete("eaap-op2-conf-testPiles.deleteTestMsgModResponse", testMsgModResponse);
	}
	public String checkDelayTimeCount(){
		return  (String)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.checkDelayTimeCount", null);
	}
	
	public List<Map> getTestMsgModRelaList(Map map){
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestMsgModRelaListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-testPiles.getTestMsgModRelaList", map) ;
		}
	}
	
	public TestMsgModRela getTestMsgModRela(TestMsgModRela testMsgModRela){
		return (TestMsgModRela)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.getTestMsgModRela", testMsgModRela);
	}
	
	public void insertTestMsgModRela(TestMsgModRela testMsgModRela){
		sqlMapDao.delete("eaap-op2-conf-testPiles.deleteTestMsgModRela", testMsgModRela);
		sqlMapDao.insert("eaap-op2-conf-testPiles.insertTestMsgModRela", testMsgModRela);
	}
	public void updateTestMsgModRela(TestMsgModRela testMsgModRela){
		sqlMapDao.update("eaap-op2-conf-testPiles.updateTestMsgModRela", testMsgModRela);
	}
	public void deleteTestMsgModRela(TestMsgModRela testMsgModRela){
		sqlMapDao.delete("eaap-op2-conf-testPiles.deleteTestMsgModRela", testMsgModRela);
	}
	
	public Integer existTestMsgModRela(TestMsgModRela testMsgModRela){
		return (Integer)sqlMapDao.queryForObject("eaap-op2-conf-testPiles.existTestMsgModRela", testMsgModRela);
	}
	
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
}




