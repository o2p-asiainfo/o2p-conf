package test.com.ailk.eaap.op2.conf.crmorder.action;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import test.com.ailk.eaap.op2.conf.util.BaseStrutsTest;
import test.com.ailk.eaap.op2.conf.util.WebMockUtil;

import com.ailk.eaap.op2.conf.crmorder.action.CrmOrderAction;
import com.ailk.eaap.op2.conf.crmorder.service.ICrmOrderService;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.util.DateUtil;

/**
 * @ClassName: CrmOrderActionTest
 * @Description:
 * @author zhengpeng
 * @date 2015-6-29 下午2:16:46
 * 
 */
public class CrmOrderActionTest extends BaseStrutsTest {
	
	@Test
	public void testShowCrmOrderList() {
		try {
			CrmOrderAction crmOrderAction = createAction(CrmOrderAction.class,"/crmOrder","showCrmOrderList");
			ICrmOrderService crmOrderService = (ICrmOrderService) getBean("eaap-op2-conf-crmorder-crmService");
			crmOrderAction.setCrmOrderService(crmOrderService);
			String result = crmOrderAction.showCrmOrderList();
			assertEquals("success", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testGetOrderList(){
		try {
			String startAcceptDate = DateUtil.convDateToString(DateUtil.getDateBefore(new Date(), -1),"yyyy-MM-dd");
			String endAcceptDate = DateUtil.convDateToString(new Date(), "yyyy-MM-dd");
			getRequest().addParameter("rows", "10");
			getRequest().addParameter("page", "10");
			getRequest().addParameter("soType", "1");
			getRequest().addParameter("soNbr", "1");
			getRequest().addParameter("startAcceptDate", startAcceptDate);
			getRequest().addParameter("endAcceptDate", endAcceptDate);
			Pagination page=new Pagination();
			CrmOrderAction crmOrderAction = createAction(CrmOrderAction.class,"/crmOrder","getOrderList");
			ICrmOrderService crmOrderService = (ICrmOrderService) getBean("eaap-op2-conf-crmorder-crmService");
			crmOrderAction.setPage(page);
			crmOrderAction.setCrmOrderService(crmOrderService);
			
			Map paramMap = new HashMap(); 
			Map result = crmOrderAction.getOrderList(paramMap); 
			assertNotNull(result); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testGetOrderInfoById(){
		try {
			getRequest().addParameter("orderId", "1");
			CrmOrderAction crmOrderAction = createAction(CrmOrderAction.class,"/crmOrder","getOrderInfoById");
			ICrmOrderService crmOrderService = (ICrmOrderService) getBean("eaap-op2-conf-crmorder-crmService");
			crmOrderAction.setCrmOrderService(crmOrderService);
			crmOrderAction.getOrderInfoById();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
