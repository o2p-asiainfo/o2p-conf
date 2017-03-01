package com.ailk.eaap.op2.conf.mealrate.dao;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;

public class MealRateDaoImpl implements IMealRateDao {

	private SqlMapDAO sqlMapDao ;
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "MAIND_ID", propertyNames = "CEP_NAME") 
		}
	)
	public List<Map<String, String>> getDataList(Map<String, String> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-mealRate.getDataList", map);
	}
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "MAIND_ID", propertyNames = "CEP_NAME") 
		}
	)
	public List<Map<String, String>> getMsgList(Map<String, String> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-mealRate.getMsgList", map);
	}

	public ProdOffer getProdOffer(ProdOffer prodOffer) {
		return (ProdOffer) sqlMapDao.queryForObject("prodOffer.selectProdOffer", prodOffer);
	}

	public List<Map<String, String>> getProductList(Map<String, String> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-mealRate.getProductList", map);
	}
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "MAIND_ID", propertyNames = "CEP_NAME") 
		}
	)
	public List<Map<String, String>> getVoiceList(Map<String, String> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-mealRate.getVoiceList", map);
	}

	
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	public PricingPlan getPricingPlan(ProdOffer prodOffer) {
		return (PricingPlan)sqlMapDao.queryForObject("eaap-op2-conf-mealRate.selectPricingPlan", prodOffer);
	}

	public void editProdOfferStatus(ProdOffer prodOffer) {
		sqlMapDao.update("prodOffer.updateProdOffer", prodOffer);
	}

	public List<Map> selectPricingListByOfferId(ProdOffer prodOffer) {
		return sqlMapDao.queryForList("eaap-op2-conf-mealRate.selectPricingListByOfferId", prodOffer) ;
	}

}
