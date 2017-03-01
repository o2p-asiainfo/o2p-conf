package com.ailk.eaap.op2.conf.prodOffer.service;

import java.math.BigDecimal;
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.conf.auditing.dao.OrgRegAuditingDao;
import com.ailk.eaap.op2.conf.prodOffer.dao.ProdOfferDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;
 
 
public class ProdOfferServ implements IProdOfferServ {
	
	private ProdOfferDao prodOfferDao;
	private OrgRegAuditingDao orgRegAuditingDao ;
	private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;
	
	/**
	 * ��ȡ�������Ϣ
	 * @param mainData
	 * @return
	 */
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData) ;
	}
	
	/**
	 * ��ȡ�����������Ϣ
	 * @param mainDataType
	 * @return
	 */
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType) ;
	}
	public List<Map> selectMainDataList(Map map) {
		return orgRegAuditingDao.selectMainDataList(map) ;
	}
	
	public ProdOfferDao getProdOfferDao() {
		return prodOfferDao;
	}

	public void setProdOfferDao(ProdOfferDao prodOfferDao) {
		this.prodOfferDao = prodOfferDao;
	}

	public MainDataDao getMainDataSqlDAO() {
		return mainDataSqlDAO;
	}

	public void setMainDataSqlDAO(MainDataDao mainDataSqlDAO) {
		this.mainDataSqlDAO = mainDataSqlDAO;
	}

	public MainDataTypeDao getMainDataTypeSqlDAO() {
		return mainDataTypeSqlDAO;
	}

	public void setMainDataTypeSqlDAO(MainDataTypeDao mainDataTypeSqlDAO) {
		this.mainDataTypeSqlDAO = mainDataTypeSqlDAO;
	}
	
	public OrgRegAuditingDao getOrgRegAuditingDao() {
		return orgRegAuditingDao;
	}
	
	public void setOrgRegAuditingDao(OrgRegAuditingDao orgRegAuditingDao) {
		this.orgRegAuditingDao = orgRegAuditingDao;
	}

	 public List<Map> queryMainDateTypeList(Map map){
			return orgRegAuditingDao.queryMainDateTypeList(map);
	 }
 
	public List<Product>  selectProduct(Product product){
		return orgRegAuditingDao.selectProduct(product) ;
	}
	
	public List<Map> queryProdOfferList(Map map) {
		return prodOfferDao.queryProdOfferList(map);
	}
	
	public BigDecimal addProdOffer(ProdOffer prodOfferBean) {
		return prodOfferDao.addProdOffer(prodOfferBean) ;
	}
	
	public BigDecimal addProduct(Product productBean) {
		return prodOfferDao.addProduct(productBean) ;
	}
	
	public Integer addOfferProdRel(OfferProdRel offerProdRelBean) {
		
		return prodOfferDao.addOfferProdRel(offerProdRelBean) ;
	}
	
	public Integer updateProdOffer(ProdOffer prodOfferBean) {
		
		return prodOfferDao.updateProdOffer(prodOfferBean);
	}
	public Integer updateProduct(Product productBean) {
		
		return prodOfferDao.updateProduct(productBean);
	}
	
	public List<OfferProdRel> selectOfferProdRel(OfferProdRel offerProdRelBean){
		return prodOfferDao.selectOfferProdRel(offerProdRelBean) ;
	}
	
	public List<ProdOffer> selectProdOffer(ProdOffer prodOffer){
		return prodOfferDao.selectProdOffer(prodOffer) ;
	}
}
