package com.ailk.eaap.op2.conf.sqllog.action;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.conf.sqllog.service.SqlLogService;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.struts.BaseAction;

/**
 * @ClassName: SqlLogAction
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-19 下午4:46:36
 *
 */
public class SqlLogAction extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLog(this.getClass());
	private SqlLogService sqlLogService;
	
	public void setSqlLogService(SqlLogService sqlLogService) {
		this.sqlLogService = sqlLogService;
	}
	
	public SqlLogService getSqlLogService() {
		if(sqlLogService==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			sqlLogService = (SqlLogService)ctx.getBean("eaap-op2-conf-sqllog-sqllogService");
	     }
		return sqlLogService;
	}
	
	public String bakOperateLog(){
		return SUCCESS;
	}
	
	public void saveBakOperateLog(){
		this.getSqlLogService().saveBakOperateLog();
	}

	
}
