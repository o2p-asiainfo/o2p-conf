package test.com.ailk.eaap.op2.conf.auditing.action;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import test.com.ailk.eaap.op2.conf.util.BaseStrutsTest;

import com.ailk.eaap.op2.conf.auditing.action.CompRegAuditingAction;
import com.ailk.eaap.op2.conf.auditing.service.ICompRegAuditingServ;

/**
 * @ClassName: CompRegAuditingActionTest
 * @Description: 
 * @author zhengpeng
 * @date 2015-7-2 下午8:50:23
 *
 */
public class CompRegAuditingActionTest extends BaseStrutsTest{

	@Test
	public void testQueryCompInfo() {
		try {
			CompRegAuditingAction compRegAuditingAction = createAction(CompRegAuditingAction.class,"/component","queryCompInfo");
			ICompRegAuditingServ compRegAuditingServ = (ICompRegAuditingServ) getBean("eaap-op2-conf-auditing-compServ");
			compRegAuditingAction.setCompRegAuditingServ(compRegAuditingServ);
			compRegAuditingAction.setContent_Id("1");
			String result = compRegAuditingAction.queryCompInfo();
			assertEquals("success", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testShowCompList(){
		try {
			CompRegAuditingAction compRegAuditingAction = createAction(CompRegAuditingAction.class,"/component","showCompList");
			ICompRegAuditingServ compRegAuditingServ = (ICompRegAuditingServ) getBean("eaap-op2-conf-auditing-compServ");
			compRegAuditingAction.setCompRegAuditingServ(compRegAuditingServ);
			String result = compRegAuditingAction.showCompList();
			assertEquals("success", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testPreAddCompInfo_1(){
		try {
			CompRegAuditingAction compRegAuditingAction = createAction(CompRegAuditingAction.class,"/component","preAddCompInfo");
			ICompRegAuditingServ compRegAuditingServ = (ICompRegAuditingServ) getBean("eaap-op2-conf-auditing-compServ");
			compRegAuditingAction.setCompRegAuditingServ(compRegAuditingServ);
			compRegAuditingAction.setTmpType("edit");
			String result = compRegAuditingAction.preAddCompInfo();
			assertEquals("successtoedit", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testPreAddCompInfo_2(){
		try {
			CompRegAuditingAction compRegAuditingAction = createAction(CompRegAuditingAction.class,"/component","preAddCompInfo");
			ICompRegAuditingServ compRegAuditingServ = (ICompRegAuditingServ) getBean("eaap-op2-conf-auditing-compServ");
			compRegAuditingAction.setCompRegAuditingServ(compRegAuditingServ);
			compRegAuditingAction.setTmpType("add");
			String result = compRegAuditingAction.showCompList();
			assertEquals("success", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
