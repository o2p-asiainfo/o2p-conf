package test.com.ailk.eaap.op2.conf.manager.action;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import test.com.ailk.eaap.op2.conf.util.BaseStrutsTest;

import com.ailk.eaap.op2.conf.manager.action.ConfManagerAction;
import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;

/**
 * @ClassName: ConfManagerActionTest
 * @Description: 
 * @author zhengpeng
 * @date 2015-7-2 下午8:15:23
 *
 */
public class ConfManagerActionTest extends BaseStrutsTest{

	@Test
	public void testShowOrgList() {
		try {
			ConfManagerAction confManagerAction = createAction(ConfManagerAction.class,"/mgr","showOrgList");
			IConfManagerServ confManagerServ = (IConfManagerServ) getBean("eaap-op2-conf-manager-confManagerServ");
			confManagerAction.setConfManagerServ(confManagerServ);
			String result = confManagerAction.showOrgList();
			assertEquals("success", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testChooseOrgInfo(){
		try {
			ConfManagerAction confManagerAction = createAction(ConfManagerAction.class,"/mgr","chooseOrgInfo");
			IConfManagerServ confManagerServ = (IConfManagerServ) getBean("eaap-op2-conf-manager-confManagerServ");
			confManagerAction.setConfManagerServ(confManagerServ);
			String result = confManagerAction.chooseOrgInfo();
			assertEquals("success", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testPreAddOrgInfo(){
		try {
			ConfManagerAction confManagerAction = createAction(ConfManagerAction.class,"/mgr","preAddOrgInfo");
			IConfManagerServ confManagerServ = (IConfManagerServ) getBean("eaap-op2-conf-manager-confManagerServ");
			confManagerAction.setConfManagerServ(confManagerServ);
			String result = confManagerAction.preAddOrgInfo();
			assertEquals("success", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
