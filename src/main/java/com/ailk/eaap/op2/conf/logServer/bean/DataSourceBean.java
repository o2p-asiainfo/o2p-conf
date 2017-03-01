package com.ailk.eaap.op2.conf.logServer.bean;

/**
 * @ClassName: DataSourceBean
 * @Description: 
 * @author zhengpeng
 * @date 2015-1-28 上午9:51:26
 *
 */
public class DataSourceBean {

	private String dataSourceId;
	private String dataSourceName;
	private String componentCode;
	private String componentName;
	private String tabSuffix;
	private String remarks;
	private String isDefault;
	private String isbegininit;
	private Integer tenantId;
	
	public String getDataSourceId() {
		return dataSourceId;
	}
	public void setDataSourceId(String dataSourceId) {
		this.dataSourceId = dataSourceId;
	}
	public String getDataSourceName() {
		return dataSourceName;
	}
	public void setDataSourceName(String dataSourceName) {
		this.dataSourceName = dataSourceName;
	}
	public String getComponentCode() {
		return componentCode;
	}
	public void setComponentCode(String componentCode) {
		this.componentCode = componentCode;
	}
	public String getComponentName() {
		return componentName;
	}
	public void setComponentName(String componentName) {
		this.componentName = componentName;
	}
	public String getTabSuffix() {
		return tabSuffix;
	}
	public void setTabSuffix(String tabSuffix) {
		this.tabSuffix = tabSuffix;
	}
	public String getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}
	public String getIsbegininit() {
		return isbegininit;
	}
	public void setIsbegininit(String isbegininit) {
		this.isbegininit = isbegininit;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Integer getTenantId() {
		return tenantId;
	}
	public void setTenantId(Integer tenantId) {
		this.tenantId = tenantId;
	}

}
