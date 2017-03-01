package com.ailk.eaap.op2.conf.mealrate.service;

import java.util.Map;
import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.conf.mealrate.dao.IMealRateDao;

public class MealRateServImpl implements IMealRateServ {

	private IMealRateDao mealRateDAO ;
	
	public List<Map<String, String>> getDataList(Map<String, String> map) {
		return mealRateDAO.getDataList(map) ;
	}

	public List<Map<String, String>> getMsgList(Map<String, String> map) {
		return mealRateDAO.getMsgList(map) ;
	}

	public ProdOffer getProdOffer(ProdOffer prodOffer) {
		return mealRateDAO.getProdOffer(prodOffer) ;
	}

	public List<Map<String, String>> getProductList(Map<String, String> map) {
		return mealRateDAO.getProductList(map);
	}

	public List<Map<String, String>> getVoiceList(Map<String, String> map) {
		return mealRateDAO.getVoiceList(map) ;
	}
	
	
	public void setMealRateDAO(IMealRateDao mealRateDAO) {
		this.mealRateDAO = mealRateDAO;
	}

	public PricingPlan getPricingPlan(ProdOffer prodOffer) {
		return mealRateDAO.getPricingPlan(prodOffer);
	}

	public void editProdOfferStatus(ProdOffer prodOffer) {
		mealRateDAO.editProdOfferStatus(prodOffer) ;
	}

	public List<Map> selectPricingListByOfferId(ProdOffer prodOffer) {
		return mealRateDAO.selectPricingListByOfferId(prodOffer) ;
	}

}
