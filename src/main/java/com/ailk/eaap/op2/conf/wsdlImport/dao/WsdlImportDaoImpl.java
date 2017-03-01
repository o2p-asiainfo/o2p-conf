package com.ailk.eaap.op2.conf.wsdlImport.dao;

import java.util.Map;
import java.util.List;
import java.util.HashMap;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.WsdlImport;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;
 
public class WsdlImportDaoImpl   implements WsdlImportDao {
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "IMPORT_OBJECT_TYPE_id", propertyNames = "IMPORT_OBJECT_TYPE_NAME") 
		}
	)
	public List<Map> getWsdlImportList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-wsdlImport.getWsdlImportListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-wsdlImport.getWsdlImportList", map) ;
		}
    }

	public void insertWsdlImport(WsdlImport wsdlImport){
		sqlMapDao.insert("eaap-op2-conf-wsdlImport.insertWsdlImport", wsdlImport);
	}

	public int getSeq(String sequenceName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sequenceName", sequenceName);
		int seq = 0;
		if(sequenceName.equals("SEQ_CONTRACT")){
			seq = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-wsdlImport.getSeqContract", map);
		}else if(sequenceName.equals("SEQ_CONTRACT_VERSION")){
			seq = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-wsdlImport.getSeqContractVersion", map);
		}else if(sequenceName.equals("SEQ_CONTRACT_FORMAT")){
			seq = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-wsdlImport.getSeqContractFormat", map);
		}else if(sequenceName.equals("SEQ_NODE_DESC")){
			seq = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-wsdlImport.getSeqNodeDesc", map);
		}
		return seq;
	}
	
	public WsdlImport getWsdlImport(WsdlImport wsdlImport){
		return (WsdlImport) sqlMapDao.queryForObject("eaap-op2-conf-wsdlImport.getWsdlImport", wsdlImport);
	}

	public List<Map<String, Object>> queryDocContractList(DocContract docContract) {
		return sqlMapDao.queryForList("eaap-op2-conf-wsdlImport.queryDocContractList", docContract);
	}
	
}

