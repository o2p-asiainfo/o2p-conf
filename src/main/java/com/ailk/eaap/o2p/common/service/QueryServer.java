package com.ailk.eaap.o2p.common.service;



import com.ailk.eaap.op2.bo.QueryBean;

public interface QueryServer {
	
	public String queryCIDataPage(QueryBean queryBean,int pageNo, int pageSize);

	public String queryEIDataPage(QueryBean queryBean,int pageNo, int pageSize);
	
	public long queryCICount(QueryBean queryBean);

	public long queryEICount(QueryBean queryBean);
	
	public String queryCIByRowkey(String rowkey, Integer tenantId);

	public String queryEIByRowkey(String rowkey, Integer tenantId);

	public String queryCtgDataPage(QueryBean queryBean,int pageNo, int pageSize);
	public long queryCtgCount(QueryBean queryBean);
	public String queryCtgByRowkey(String rowkey, Integer tenantId);
}
