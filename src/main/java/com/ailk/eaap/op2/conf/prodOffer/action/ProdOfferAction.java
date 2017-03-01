package com.ailk.eaap.op2.conf.prodOffer.action;
 
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;
import java.util.Map.Entry;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.prodOffer.service.IProdOfferServ;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;
import com.linkage.rainbow.util.StringUtil;
public class ProdOfferAction extends BaseAction {
	
    private IProdOfferServ prodOfferServ ;
    private Map prodOfferStatusMap = new HashMap() ;
    private Map prodOfferMap = new HashMap() ;
    private ProdOffer prodOffer = new ProdOffer() ;
    private Product product = new Product() ;
    private OfferProdRel offerProdRel = new OfferProdRel();
    private List<Map> prodOfferStatusList = new ArrayList<Map>() ;
    
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();
	private List<Map> mainDataTypeList = new ArrayList<Map>() ;
	private MainDataType mainDataType = new MainDataType();
	private MainData mainData = new MainData();
	private List<MainData> mainDataList =new ArrayList<MainData>();
	private Service service = new Service();
	private int rows;
	private int pageNum;
	private int total;
	
	public int getRows() {
		return rows;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public Map getProdOfferStatusMap() {
		return prodOfferStatusMap;
	}

	public void setProdOfferStatusMap(Map prodOfferStatusMap) {
		this.prodOfferStatusMap = prodOfferStatusMap;
	}

	public ProdOfferAction() {
		
		
	}
	
	public String queryProdOfferInfo(){
		
		List<ProdOffer> prodOfferList = getProdOfferServ().selectProdOffer(prodOffer);
		if (prodOfferList != null && prodOfferList.size() >= 1) {
			
			prodOffer.setProdOfferName(prodOfferList.get(0).getProdOfferName());
			prodOffer.setExtProdOfferId(prodOfferList.get(0).getExtProdOfferId());
			prodOffer.setFormatEffDate("".equals(StringUtil.valueOf(prodOfferList.get(0).getEffDate()))?null:DateUtil.convDateToString(prodOfferList.get(0).getEffDate(), "yyyy-MM-dd")) ;
			prodOffer.setFormatExpDate("".equals(StringUtil.valueOf(prodOfferList.get(0).getExpDate()))?null:DateUtil.convDateToString(prodOfferList.get(0).getExpDate(), "yyyy-MM-dd")) ;
			prodOffer.setProdOfferDesc(prodOfferList.get(0).getProdOfferDesc());
		}
	    
	    return SUCCESS ;
	}
	
	 public String showProdOfferList(){
		 prodOfferStatusMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_PRODGOODSSTATE) ;
		 Iterator iter = prodOfferStatusMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 prodOfferStatusList.add(mapTmp) ;
		 }
		 
		 return SUCCESS ;
	 }
	
 
	public Map getProdOfferList(Map para){
		
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;
		 
		 Map returnMap = new HashMap();
		 Map map = new HashMap() ;
		 map.put("offerProviderId", "900000004");
		 map.put("prodOfferName", "".equals(getRequest().getParameter("prodOffer.prodOfferName"))?null:getRequest().getParameter("prodOffer.prodOfferName"));
		 if(StringUtil.valueOf(getRequest().getParameter("prodOffer.prodOfferName")).equals(getText("eaap.op2.conf.manager.auth.canlike"))){
			 map.put("prodOfferName",null);
		 }
		 map.put("extProdOfferId", "".equals(getRequest().getParameter("prodOffer.extProdOfferId"))?null:getRequest().getParameter("prodOffer.extProdOfferId"));
		 map.put("status", "".equals(getRequest().getParameter("prodOffer.status"))?null:getRequest().getParameter("prodOffer.status"));
		 
		 map.put("cooperationType", "11");
		 map.put("pro", startRow);
         map.put("end", startRow+rows-1);
         map.put("queryType", "ALLNUM") ;
          
         total = Integer.valueOf(String.valueOf(getProdOfferServ().queryProdOfferList(map).get(0).get("ALLNUM"))) ;
		 
         map.put("queryType", "") ;
	     List<Map> prodOfferList=getProdOfferServ().queryProdOfferList(map);
 
		returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(prodOfferList));
		
		return returnMap ;
	}
	
	public String addProdOfferInfo(){
		
	    return SUCCESS;
	}
	
	public String updateProdOffer(){
		if(!"".equals(StringUtil.valueOf(prodOffer.getProdOfferId()))){
			prodOffer.setEffDate(parseDate("yyyy-MM-dd", prodOffer.getFormatEffDate()));
			prodOffer.setExpDate(parseDate("yyyy-MM-dd", prodOffer.getFormatExpDate()));
			getProdOfferServ().updateProdOffer(prodOffer) ;
			offerProdRel.setProdOfferId(prodOffer.getProdOfferId());
			List<OfferProdRel> offerProdrelList = getProdOfferServ().selectOfferProdRel(offerProdRel) ;
			if (offerProdrelList != null && offerProdrelList.size() >= 1) {
				
				product.setProductId(offerProdrelList.get(0).getProductId());
				product.setProductName(prodOffer.getProdOfferName());
				product.setExtProdId(prodOffer.getExtProdOfferId());
				product.setProductDesc(prodOffer.getProdOfferDesc());
				product.setEffDate(prodOffer.getEffDate());
				product.setExpDate(prodOffer.getExpDate());
				getProdOfferServ().updateProduct(product);
			}
		 } 
	     return SUCCESS ;
	}
	
	
	public String updateProdOfferStatus(){
		if(!"".equals(StringUtil.valueOf(prodOffer.getProdOfferId()))){
			prodOffer.setStatusDate(DateUtil.getDate());
			getProdOfferServ().updateProdOffer(prodOffer) ;
			offerProdRel.setProdOfferId(prodOffer.getProdOfferId());
			List<OfferProdRel> offerProdrelList = getProdOfferServ().selectOfferProdRel(offerProdRel) ;
			if (offerProdrelList != null && offerProdrelList.size() >= 1) {
				
				product.setProductId(offerProdrelList.get(0).getProductId());
				product.setStatusCd(prodOffer.getStatusCd());
				product.setStatusDate(DateUtil.getDate());
				getProdOfferServ().updateProduct(product);
			}
		 } 
		
	     return SUCCESS ;
	}
	
	public Date parseDate(String strFormat, String dateValue) {
		if (dateValue == null)
			return null;

		if (strFormat == null)
			strFormat = "yyyy-MM-dd";

		SimpleDateFormat dateFormat = new SimpleDateFormat(strFormat);
		Date newDate = null;

		try {
			newDate = dateFormat.parse(dateValue);
		} catch (ParseException pe) {
			newDate = null;
		}

		return newDate;
	}
	
	public String insertProdOfferInfo(){
		
		prodOffer.setStatusCd("1299");
		prodOffer.setCooperationType("11");
		BigDecimal prodOfferId = (BigDecimal)getProdOfferServ().addProdOffer(prodOffer);
		
		product.setProductName(prodOffer.getProdOfferName());
		product.setExtProdId(prodOffer.getExtProdOfferId());
		product.setProductDesc(prodOffer.getProdOfferDesc());
		product.setEffDate(prodOffer.getEffDate());
		product.setExpDate(prodOffer.getExpDate());
		product.setStatusCd("1299");
		product.setCooperationType("11");
		BigDecimal productId = (BigDecimal)getProdOfferServ().addProduct(product);
		
		offerProdRel.setProdOfferId(prodOfferId);
		offerProdRel.setProductId(productId);
		offerProdRel.setRoleCd(Integer.parseInt("10600000"));
		offerProdRel.setMaxCount(1);
		offerProdRel.setMinCount(1);
		offerProdRel.setCompoentType("10");
		getProdOfferServ().addOfferProdRel(offerProdRel);
		
		return SUCCESS ;
	}
	
	public Map getMainInfo(String mainTypeSign){
	  	  MainDataType mainDataType = new MainDataType();
	  	  MainData mainData = new MainData();
	  	  Map stateMap = new HashMap() ;
	  	
	  	  mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
	  	  mainDataType.setMdtSign(mainTypeSign) ;
			  mainDataType = getProdOfferServ().selectMainDataType(mainDataType).get(0) ;
			  mainData.setMdtCd(mainDataType.getMdtCd()) ;
			  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
			  List<MainData> mainDataList = getProdOfferServ().selectMainData(mainData) ;
			 
			  if(mainDataList!=null && mainDataList.size()>0){
				  for(int i=0;i<mainDataList.size();i++){
					  stateMap.put(mainDataList.get(i).getCepCode(),
							          mainDataList.get(i).getCepName()) ;
				  }
			  }
	  	
	  	return  stateMap ;
	  }
	

	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	public ProdOffer getProdOffer() {
		return prodOffer;
	}

	public void setProdOffer(ProdOffer prodOffer) {
		this.prodOffer = prodOffer;
	}

	public OfferProdRel getOfferProdRel() {
		return offerProdRel;
	}

	public void setOfferProdRel(OfferProdRel offerProdRel) {
		this.offerProdRel = offerProdRel;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}


	public List<Map> getMainDataTypeList() {
		return mainDataTypeList;
	}

	public void setMainDataTypeList(List<Map> mainDataTypeList) {
		this.mainDataTypeList = mainDataTypeList;
	}

	public MainDataType getMainDataType() {
		return mainDataType;
	}

	public void setMainDataType(MainDataType mainDataType) {
		this.mainDataType = mainDataType;
	}

	public MainData getMainData() {
		return mainData;
	}

	public void setMainData(MainData mainData) {
		this.mainData = mainData;
	}

	public List<MainData> getMainDataList() {
		return mainDataList;
	}

	public void setMainDataList(List<MainData> mainDataList) {
		this.mainDataList = mainDataList;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public IProdOfferServ getProdOfferServ() {
		
		if(prodOfferServ==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			prodOfferServ = (IProdOfferServ)ctx.getBean("eaap-op2-conf-prodOffer-prodOfferServ");
			   
	     }
		return prodOfferServ;
	}

	public void setProdOfferServ(IProdOfferServ prodOfferServ) {
		this.prodOfferServ = prodOfferServ;
	}

	public List<Map> getProdOfferStatusList() {
		return prodOfferStatusList;
	}

	public void setProdOfferStatusList(List<Map> prodOfferStatusList) {
		this.prodOfferStatusList = prodOfferStatusList;
	}

	public Map getProdOfferMap() {
		return prodOfferMap;
	}

	public void setProdOfferMap(Map prodOfferMap) {
		this.prodOfferMap = prodOfferMap;
	}
}
