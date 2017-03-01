package com.ailk.eaap.op2.conf.prodOffer.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.Product;
import com.linkage.rainbow.dao.SqlMapDAO;
 
public class ProdOfferDaoImpl   implements ProdOfferDao {
	
	private SqlMapDAO sqlMapDao;
	public List<Map> queryProdOfferList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-prodOffer.queryProdOfferListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-prodOffer.queryProdOfferList", map) ;
		}
		
    }
	
	public BigDecimal addProdOffer(ProdOffer prodOfferBean) {
		BigDecimal prodofferId = (BigDecimal)sqlMapDao.insert("eaap-op2-conf-prodOffer.insertProdOfferInfo", prodOfferBean) ;
		return prodofferId;
	}
	
	public BigDecimal addProduct(Product productBean) {
		BigDecimal productId = (BigDecimal)sqlMapDao.insert("eaap-op2-conf-prodOffer.insertProductInfo", productBean) ;
		return productId;
	}
	
	public Integer addOfferProdRel(OfferProdRel offerProdRelBean) {
		Integer offerProdRelaId = (Integer)sqlMapDao.insert("eaap-op2-conf-prodOffer.insertOfferProdRelInfo", offerProdRelBean) ;
		return offerProdRelaId;
	}
	
	public Integer updateProdOffer(ProdOffer prodOfferBean) {
		
		return (Integer)sqlMapDao.update("prodOffer.updateProdOffer", prodOfferBean) ;
	}
	public Integer updateProduct(Product productBean) {
		
		return (Integer)sqlMapDao.update("eaap-op2-conf-prodOffer.updateProduct", productBean) ; 
	}
	
	public List<OfferProdRel> selectOfferProdRel(OfferProdRel offerProdRelBean){
	 	return (ArrayList<OfferProdRel>)sqlMapDao.queryForList("eaap-op2-conf-prodOffer.selectOfferProdRel", offerProdRelBean) ;
    }
	
	public List<ProdOffer> selectProdOffer(ProdOffer prodOffer){
	 	return (ArrayList<ProdOffer>)sqlMapDao.queryForList("prodOffer.selectProdOffer", prodOffer) ;
    }
	
	public List<Product>  selectProduct(Product product){
		return (ArrayList<Product>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectProduct", product) ;
		
	}
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
}
