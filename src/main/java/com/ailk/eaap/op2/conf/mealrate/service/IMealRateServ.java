package com.ailk.eaap.op2.conf.mealrate.service;

import java.util.Map;
import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.ProdOffer;

public interface IMealRateServ {

	List<Map<String, String>> getVoiceList(Map<String, String> map);

	List<Map<String, String>> getDataList(Map<String, String> map);

	List<Map<String, String>> getMsgList(Map<String, String> map);

	List<Map<String, String>> getProductList(Map<String, String> map);

	ProdOffer getProdOffer(ProdOffer prodOffer);

	PricingPlan getPricingPlan(ProdOffer prodOffer);

	void editProdOfferStatus(ProdOffer prodOffer);

	List<Map> selectPricingListByOfferId(ProdOffer prodOffer);

}
