package com.ailk.eaap.op2.conf.prodOffer.service;

import java.math.BigDecimal;
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.Product;

 
public interface IProdOfferServ{ 
	
	public List<Map> queryProdOfferList(Map map);
	public BigDecimal addProdOffer(ProdOffer prodOfferBean);
	public BigDecimal addProduct(Product productBean);
	public Integer addOfferProdRel(OfferProdRel offerProdRelBean);
	public Integer updateProdOffer(ProdOffer prodOfferBean);
	public Integer updateProduct(Product productBean);
	public List<OfferProdRel> selectOfferProdRel(OfferProdRel offerProdRel);
	public List<ProdOffer> selectProdOffer(ProdOffer prodOffer) ;
	
	public List<Product>  selectProduct(Product product) ;
	
	/**
 	 * ��ȡ�������Ϣ
 	 * @param mainData
 	 * @return
 	 */
 	public List<MainData> selectMainData(MainData mainData) ;
 	
 	public List<Map> selectMainDataList(Map map) ;
 	/**
	 * ��ȡ�����������Ϣ
	 * @param mainDataType
	 * @return
	 */
	public List<MainDataType> selectMainDataType(MainDataType mainDataType) ;
   
	public List<Map> queryMainDateTypeList(Map map) ;
}
