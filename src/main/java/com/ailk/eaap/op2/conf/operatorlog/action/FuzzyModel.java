package com.ailk.eaap.op2.conf.operatorlog.action;

public class FuzzyModel {

	private String fuzzyId;
	private String fuzzyType;
	private String fuzzySymbols;
	private String fuzzyStart;
	private String fuzzyEnd;
	private String tenantId;
	
	public String getTenantId() {
		return tenantId;
	}
	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}
	public String getFuzzyId() {
		return fuzzyId;
	}
	public void setFuzzyId(String fuzzyId) {
		this.fuzzyId = fuzzyId;
	}
	public String getFuzzyType() {
		return fuzzyType;
	}
	public void setFuzzyType(String fuzzyType) {
		this.fuzzyType = fuzzyType;
	}
	public String getFuzzySymbols() {
		return fuzzySymbols;
	}
	public void setFuzzySymbols(String fuzzySymbols) {
		this.fuzzySymbols = fuzzySymbols;
	}
	public String getFuzzyStart() {
		return fuzzyStart;
	}
	public void setFuzzyStart(String fuzzyStart) {
		this.fuzzyStart = fuzzyStart;
	}
	public String getFuzzyEnd() {
		return fuzzyEnd;
	}
	public void setFuzzyEnd(String fuzzyEnd) {
		this.fuzzyEnd = fuzzyEnd;
	}
}
