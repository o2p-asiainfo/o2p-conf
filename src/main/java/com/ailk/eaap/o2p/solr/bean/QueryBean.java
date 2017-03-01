package com.ailk.eaap.o2p.solr.bean;

import java.io.Serializable;


public class QueryBean implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6829840669040932920L;
	
	private String contractInteractionId;
	private String responseCode;
	private String status;
	private String startSrcReqTime;
	private String endSrcReqTime;
	private String srcTranId;
	private String contractVersion;
	private String srcSysCode;
	private String dstSysCode;
	private String table;
	
	
	public String getResponseCode() {
		return responseCode;
	}
	public void setResponseCode(String responseCode) {
		this.responseCode = responseCode;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public String getSrcTranId() {
		return srcTranId;
	}
	public void setSrcTranId(String srcTranId) {
		this.srcTranId = srcTranId;
	}
	public String getContractVersion() {
		return contractVersion;
	}
	public void setContractVersion(String contractVersion) {
		this.contractVersion = contractVersion;
	}
	public String getSrcSysCode() {
		return srcSysCode;
	}
	public void setSrcSysCode(String srcSysCode) {
		this.srcSysCode = srcSysCode;
	}
	public String getDstSysCode() {
		return dstSysCode;
	}
	public void setDstSysCode(String dstSysCode) {
		this.dstSysCode = dstSysCode;
	}
	public String getTable() {
		return table;
	}
	public void setTable(String table) {
		this.table = table;
	}
	public String getStartSrcReqTime() {
		return startSrcReqTime;
	}
	public void setStartSrcReqTime(String startSrcReqTime) {
		this.startSrcReqTime = startSrcReqTime;
	}
	public String getEndSrcReqTime() {
		return endSrcReqTime;
	}
	public void setEndSrcReqTime(String endSrcReqTime) {
		this.endSrcReqTime = endSrcReqTime;
	}
	public String getContractInteractionId() {
		return contractInteractionId;
	}
	public void setContractInteractionId(String contractInteractionId) {
		this.contractInteractionId = contractInteractionId;
	}

}
