package com.ailk.eaap.op2.conf.prodOffer.dao;

import java.math.BigDecimal;
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.Product;
 
public interface ProdOfferDao { 
	
	public List<Map> queryProdOfferList(Map map);
	public BigDecimal addProdOffer(ProdOffer prodOfferBean);
	public BigDecimal addProduct(Product productBean);
	public Integer addOfferProdRel(OfferProdRel offerProdRelBean);
	public Integer updateProdOffer(ProdOffer prodOfferBean);
	public Integer updateProduct(Product productBean);
	public List<OfferProdRel> selectOfferProdRel(OfferProdRel offerProdRelBean) ;
	public List<ProdOffer> selectProdOffer(ProdOffer prodOffer);
	public List<Product>  selectProduct(Product product) ;
}
