package com.ailk.eaap.op2.conf.proofmanage.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.security.SecurityUtil;
import com.ailk.eaap.o2p.security.SecurityType;
import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;
import com.ailk.eaap.op2.conf.proofmanage.model.ProofType;
import com.ailk.eaap.op2.conf.proofmanage.service.IProofEffectService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

/**
 * 有效验证管理配置
 * 
 * @author MAWL
 * 
 */
public class ProofEffectAction extends BaseAction {
	private static final long serialVersionUID = 756984991176050620L;
	private Logger log = Logger.getLog(this.getClass());
	private IProofEffectService proofeffectService;// spring注入对象业务
	private IConfManagerServ confManagerServ ;
	/* 分页相关参数 */
	private int rows;
	private int pageNum;
	private int total;
	private Pagination page = new Pagination();
	private Pagination pagination = new Pagination();
	private List<ProofType> listProofType = new ArrayList<ProofType>();
	private String pt_cd;
	private String prooffId;// 有效验证ID
	private List<Map> prooflList = new ArrayList<Map>();// 有效验证列表
	private List<Map> attrValuesList = new ArrayList<Map>() ; 
	private String[] attrValues;//页面传来的数组参数
	private String componentId;
	private String comName;
	private String flag;
	private String pagePwd;
	/**
	 * 查看有效验证管理页面
	 * 
	 * @return
	 */
	public String showProofEffectPage() {
		listProofType = this.getProofeffectService().getAllProofType();
		return SUCCESS;
	}

	/**
	 * 选择有效配置
	 * @return
	 */
	public String selectProofEffect(){
		listProofType = this.getProofeffectService().getAllProofType();
		return SUCCESS;
	}
	/**
	 * 添加有效认证配置页面
	 * @return
	 */
	public String add_ProofEffect(){
		listProofType = this.getProofeffectService().getAllProofType();
		pt_cd = this.getRequest().getParameter("pt_cd");
		if(null != pt_cd && !"".equals(pt_cd)){
			Map map = new HashMap();
			map.put("pt_cd", pt_cd);
			prooflList = this.getProofeffectService().getAllAttrValueByType(map);
		}else{
			Map map = new HashMap();
			map.put("pt_cd", "0");
			prooflList = this.getProofeffectService().getAllAttrValueByType(map);
		}
		attrValuesList = getConfManagerServ().quertAttrValuesByProof(null); 
		return SUCCESS;
	}
	/**
	 * 有效认证配置提交
	 * @return
	 */
	public String submit_ProofEffect(){
		Map<String,String> map = new HashMap<String,String>();
		if(null != pt_cd && !"".equals(pt_cd)){
			Map ptmap = new HashMap();
			ptmap.put("pt_cd", pt_cd);
			prooflList = this.getProofeffectService().getAllAttrValueByType(ptmap);
			
			for(int i=0;i<prooflList.size();i++){
				String key = prooflList.get(i).get("PR_ATR_SPEC_CD").toString();
				String value = attrValues[i];
				if("1".equals(pt_cd) && "1".equals(key)){//说明是密码验证
					//加密
					try {
						String encry = SecurityUtil.getInstance().encryMsg(value);
						map.put(key,encry);
					} catch (Exception e) {
						log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
					}
				}else{
					map.put(key, value);
				}
			}
			//添加有效认证实例
			String hide_attr_proofe_id = this.getProofeffectService().getMaxProofId();//有效认证实例ID
			if(null == hide_attr_proofe_id || "".equals(hide_attr_proofe_id)){
				hide_attr_proofe_id = "1";
			}
			Map<String, String> parammap = new HashMap<String, String>();
			parammap.put("proof_id", hide_attr_proofe_id);
			parammap.put("pt_cd", pt_cd);
			parammap.put("componentId", componentId);
			this.getProofeffectService().addProofEffect(parammap);
			//添加认证属性值
			for(Map.Entry<String, String> entry : map.entrySet()){
				String hidden_pr_attr_spec_id = entry.getKey();
				String attr_value = entry.getValue();
				Map<String, String> paramMap = new HashMap<String, String>();
				paramMap.put("hidden_pr_attr_spec_id", hidden_pr_attr_spec_id);
				paramMap.put("attr_value", attr_value);
				paramMap.put("hide_attr_proofe_id", hide_attr_proofe_id);
				this.getProofeffectService().addAttrValues(paramMap);
			}
		}
		return showProofEffectPage();
	}
	/**
	 * 修改提交
	 * @return
	 */
	public String submit_updatePro(){
		Map<String,String> map = new HashMap<String,String>();
		if(null != pt_cd && !"".equals(pt_cd)){
			Map ptmap = new HashMap();
			ptmap.put("pt_cd", pt_cd);
			prooflList = this.getProofeffectService().getAllAttrValueByType(ptmap);
			
			for(int i=0;i<prooflList.size();i++){
				String key = prooflList.get(i).get("PR_ATR_SPEC_CD").toString();
				String value = attrValues[i];
				map.put(key, value);
			}
			//添加认证属性值
			log.info("map"+map);
			for(Map.Entry<String, String> entry : map.entrySet()){
				String hidden_pr_attr_spec_id = entry.getKey();
				String attr_value = entry.getValue();
				Map<String, String> paramMap = new HashMap<String, String>();
				paramMap.put("hidden_pr_attr_spec_id", hidden_pr_attr_spec_id);
				paramMap.put("attr_value", attr_value);
				paramMap.put("hide_attr_proofe_id", prooffId);
				this.getProofeffectService().updateAttrValues(paramMap);
			}
		}
		return showProofEffectPage();
	}
	/**
	 * 查看有效认证配置
	 * @return
	 */
	public String show_ProofEffectPage(){
		listProofType = this.getProofeffectService().getAllProofType();
		try {
			this.setComName(new String(this.getComName().getBytes("ISO-8859-1"),"UTF-8"));
		} catch (UnsupportedEncodingException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Cast error",null));
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("pt_cd", pt_cd);
		map.put("prooffId", prooffId);
		prooflList = this.getProofeffectService().getAllAttrValueByMap(map);
		attrValuesList = getConfManagerServ().quertAttrValuesByProof(null); 
		return SUCCESS;
	}
	/**
	 * 跳到修改页面
	 * @return
	 */
	public String show_updatePage(){
		return show_ProofEffectPage();
	}
	/**
	 * 选择有效认证配置
	 */
	public void showSelectedMes(){
		PrintWriter out = null;
		String pt_cd = "";// 页面传来的ID
		String proof_id = "";// 新生成数据ID
		StringBuffer sb = new StringBuffer();
		try {
			getRequest().setCharacterEncoding("UTF-8");
			if (StringUtils.isNotEmpty(getRequest().getParameter(
					"pt_cd")) && StringUtils.isNotEmpty(getRequest().getParameter(
							"proofe_id"))) {
				pt_cd = getRequest().getParameter("pt_cd");
				proof_id = getRequest().getParameter("proofe_id");
				String checkId = "page"+pt_cd;
				String ptCode="";
				Map<String,String> map = new HashMap<String,String>();
				map.put("pt_cd", pt_cd);
				map.put("prooffId", proof_id);
				prooflList = this.getProofeffectService().getAllAttrValueByMap(map);
				if(null != prooflList && prooflList.size() > 0){
					ptCode = prooflList.get(0).get("PT_CODE").toString();
					sb.append(" <tr id='del"+proof_id+"'><td  colspan='4' class='itemCss'>");
					sb.append("<input type='hidden' name='page_proofe_id' value='"+proof_id+"'/>");//有效认证ID隐藏域
					sb.append("<input type='hidden' name='page_type' id='"+checkId+"' value='"+proof_id+"'/>");//有效认证ID隐藏域
					sb.append("<input type='hidden' name='page_code'  id='page_code'  value='"+prooflList.get(0).get("PT_CODE").toString()+"'/>");//有效认证CODE隐藏域
					sb.append("<B>"+prooflList.get(0).get("PT_NAME").toString()+"</B> ");
					sb.append("&nbsp;&nbsp;&nbsp;<a href='javascript:delSelf("+proof_id+");'  title='Delete'><img src='../resource/orange/images/tmp/3g_style_2_pop_1_03.gif' width='14' height='14' align='absmiddle'/></a>");
					sb.append(" </td></tr>");
					//字符串拼接
					for(int i=0;i<prooflList.size();i++){
						sb.append("<tr id='del"+proof_id+"'>");
						sb.append("<td align='right' width='150'>"+prooflList.get(i).get("PR_ATR_SPEC_NAME").toString()+":</td>");
						sb.append("<td  colspan='3'>");
						if("10".equals(prooflList.get(i).get("DISPLAY_TYPE").toString())){
							sb.append("<label>"+prooflList.get(i).get("ATTR_VALUE").toString()+"</label>");
						}else if("12".equals(prooflList.get(i).get("DISPLAY_TYPE").toString())){
							sb.append("<label>******</label>");
						}
						else if( "11".equals(prooflList.get(i).get("DISPLAY_TYPE").toString())){
							String attr_spec_id = prooflList.get(i).get("ATTR_SPEC_ID").toString();
							String attr_value = prooflList.get(i).get("ATTR_VALUE").toString();
							Map<String,String> paMap = new HashMap<String,String>();
							paMap.put("attr_spec_id", attr_spec_id);
							paMap.put("attr_value", attr_value);
							String showPageValue = this.getProofeffectService().getShowPageValue(paMap);
							sb.append("<label>"+showPageValue+"</label>");
						}else if("15".equals(prooflList.get(i).get("DISPLAY_TYPE").toString())){
							sb.append("<label>"+prooflList.get(i).get("ATTR_VALUE").toString()+"</label>");
						}
						sb.append("</td></tr>");
					}
				}
				
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				String xx = "[{\"msg\":\"ok\",\"data\":\"" + sb + "\",\"ptCode\":\"" + ptCode + "\"}]";
				out.print(xx);
			}else{
				out = getResponse().getWriter();
				out.print("failure");
			}
		} catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Modify the configuration anomalies",null));
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	/**
	 * 查看有效配置数据
	 * 
	 * @return
	 */
	public String showProofEffect() {
		listProofType = this.getProofeffectService().getAllProofType();
		return SUCCESS;
	}

	/**
	 * 有效验证表格数据展现
	 * 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map showProofEffectGrid(Map param) {
		// 分页条件设置
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;

		Map hashMap = new HashMap();
		hashMap.put("startPage", startRow);
		hashMap.put("endPage", startRow + rows - 1);

		hashMap.put("startPage_mysql", startRow - 1);
		hashMap.put("endPage_mysql", rows);
		prooffId = getRequest().getParameter("prooffId");
		pt_cd = getRequest().getParameter("proofType.pt_cd");
		String componentId = getRequest().getParameter("componentId");
		if (StringUtils.isNotEmpty(pt_cd)) {
			hashMap.put("pt_cd", pt_cd);
		}
		if (StringUtils.isNotEmpty(prooffId)) {
			hashMap.put("prooffId", prooffId);
		}
		if(StringUtils.isNotEmpty(componentId)){
			hashMap.put("componentId", componentId);
		}
		total = Integer.parseInt(this.getProofeffectService()
				.queryAllProofInstanceCount(hashMap));
		prooflList = this.getProofeffectService().getAllProofInstance(hashMap);

		Map pageMap = new HashMap();// 页面返回集合
		pageMap.put("startRow", startRow);
		pageMap.put("rows", rows);
		pageMap.put("total", total);
		pageMap.put("dataList", pagination.convertJson(prooflList));
		return pageMap;
	}

	/**
	 * 获得属性规格列表
	 * 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getAttrSpecValue(Map param) {
		// 分页条件设置
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;

		Map hashMap = new HashMap();
		hashMap.put("startPage", startRow);
		hashMap.put("endPage", startRow + rows - 1);

		hashMap.put("startPage_mysql", startRow - 1);
		hashMap.put("endPage_mysql", rows);
		String attr_spec_name = getRequest().getParameter("attr_spec_name");
		String attr_spec_code = getRequest().getParameter("attr_spec_code");
		if (StringUtils.isNotEmpty(attr_spec_name)) {
			hashMap.put("attr_spec_name", attr_spec_name);
		}
		if (StringUtils.isNotEmpty(attr_spec_code)) {
			hashMap.put("attr_spec_code", attr_spec_code);
		}
		total = Integer.parseInt(this.getProofeffectService()
				.queryAllAttrSpecValue(hashMap));
		prooflList = this.getProofeffectService().getAllAttrSpecValule(hashMap);

		Map pageMap = new HashMap();// 页面返回集合
		pageMap.put("startRow", startRow);
		pageMap.put("rows", rows);
		pageMap.put("total", total);
		pageMap.put("dataList", pagination.convertJson(prooflList));
		return pageMap;
	}

	/**
	 * 获得配置好的属性值
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getAttrValue(Map map) {
		// 分页条件设置
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;

		Map hashMap = new HashMap();
		hashMap.put("startPage", startRow);
		hashMap.put("endPage", startRow + rows - 1);

		hashMap.put("startPage_mysql", startRow - 1);
		hashMap.put("endPage_mysql", rows);
		String attr_proofe_id = getRequest().getParameter("attr_proofe_id");// 页面传来的有效验证ID
		if (StringUtils.isNotEmpty(attr_proofe_id)) {
			hashMap.put("attr_proofe_id", attr_proofe_id);
		} else {
			hashMap.put("attr_proofe_id", "0");
		}
		total = Integer.parseInt(this.getProofeffectService()
				.queryAllAttrValue(hashMap));
		prooflList = this.getProofeffectService().getAllAttrValule(hashMap);

		Map pageMap = new HashMap();// 页面返回集合
		pageMap.put("startRow", startRow);
		pageMap.put("rows", rows);
		pageMap.put("total", total);
		pageMap.put("dataList", pagination.convertJson(prooflList));
		return pageMap;
	}

	/**
	 * 查看有效验证配置
	 * 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getShowAttrValue(Map param) {
		// 分页条件设置
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;

		Map hashMap = new HashMap();
		hashMap.put("startPage", startRow);
		hashMap.put("endPage", startRow + rows - 1);

		hashMap.put("startPage_mysql", startRow - 1);
		hashMap.put("endPage_mysql", rows);
		String attr_proofe_id = param.get("queryParamsData").toString();;// 页面传来的有效验证ID
		if (StringUtils.isNotEmpty(attr_proofe_id)) {
			hashMap.put("attr_proofe_id", attr_proofe_id);
		} else {
			hashMap.put("attr_proofe_id", "0");
		}
		total = Integer.parseInt(this.getProofeffectService()
				.queryAllAttrValue(hashMap));
		prooflList = this.getProofeffectService().getAllAttrValule(hashMap);

		Map pageMap = new HashMap();// 页面返回集合
		pageMap.put("startRow", startRow);
		pageMap.put("rows", rows);
		pageMap.put("total", total);
		pageMap.put("dataList", pagination.convertJson(prooflList));
		return pageMap;
	}

	/**
	 * 获得认证类型属性规格列表
	 * 
	 * @param prarm
	 * @return
	 */
	public Map getPrAttrSpecValue(Map prarm) {
		// 分页条件设置
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;

		Map hashMap = new HashMap();
		hashMap.put("startPage", startRow);
		hashMap.put("endPage", startRow + rows - 1);

		hashMap.put("startPage_mysql", startRow - 1);
		hashMap.put("endPage_mysql", rows);
		String pr_attr_spec_name = getRequest().getParameter(
				"pr_attr_spec_name");// 页面传来的有效验证ID
		if (StringUtils.isNotEmpty(pr_attr_spec_name)) {
			hashMap.put("pr_attr_spec_name", pr_attr_spec_name);
		}
		total = Integer.parseInt(this.getProofeffectService()
				.queryAllPrAttrValue(hashMap));
		prooflList = this.getProofeffectService().getAllPrAttrValule(hashMap);

		Map pageMap = new HashMap();// 页面返回集合
		pageMap.put("startRow", startRow);
		pageMap.put("rows", rows);
		pageMap.put("total", total);
		pageMap.put("dataList", pagination.convertJson(prooflList));
		return pageMap;
	}

	/**
	 * 选择认证类型属性规格页面
	 * 
	 * @return
	 */
	public String selectProofAttrType() {
		listProofType = this.getProofeffectService().getAllProofType();
		return SUCCESS;
	}

	/**
	 * 跳转到验证规则添加页面
	 * 
	 * @return
	 */
	public String addProofEffect() {
		listProofType = this.getProofeffectService().getAllProofType();
		return SUCCESS;
	}

	/**
	 * 添加新的有效认证
	 */
	public void addProofEffectType() {
		PrintWriter out = null;
		String pt_cd = "";// 页面传来的ID
		String proof_id = "";// 新生成数据ID
		try {
			getRequest().setCharacterEncoding("UTF-8");
			if (StringUtils.isNotEmpty(getRequest().getParameter(
					"proofType.pt_cd"))) {
				pt_cd = getRequest().getParameter("proofType.pt_cd");
				proof_id = this.getProofeffectService().getMaxProofId();
				Map<String, String> map = new HashMap<String, String>();
				map.put("proof_id", proof_id);
				map.put("pt_cd", pt_cd);
				this.getProofeffectService().addProofEffect(map);
			}
			getResponse().setContentType("text/html;charset=UTF-8");
			out = getResponse().getWriter();
			String xx = "[{\"msg\":\"ok\",\"data\":\"" + proof_id + "\"}]";
			out.print(xx);
		} catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Adding authentication exception",null));
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
    /**
     * 得到加密后结果
     */
	@SuppressWarnings("resource")
	public void encodePwd(){
		PrintWriter pw = null;
		try{
			//加密
			String encry = SecurityUtil.getInstance().encryMsg(pagePwd);
			pw = getResponse().getWriter();
			pw.write(encry);
			pw.flush();
		}catch (Exception e){
			try {
				pw = getResponse().getWriter();
				pw.write("fail");
				pw.flush();
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
		}finally{
			if(null != pw){
				pw.close();
			}
		}
	}
	/**
	 * 添加认证类型属性规格
	 */
	public void addPrAttrValues() {
		PrintWriter out = null;
		String pr_attr_spec_name = "";
		String hidden_attr_spec_id = "";
		String pt_cd = "";
		try {
			getRequest().setCharacterEncoding("UTF-8");
			Map<String, String> map = new HashMap<String, String>();
			if (StringUtils.isNotEmpty(getRequest().getParameter(
					"pr_attr_spec_name"))) {
				pr_attr_spec_name = getRequest().getParameter(
						"pr_attr_spec_name");
				map.put("pr_attr_spec_name", pr_attr_spec_name);
			}
			if ((StringUtils.isNotEmpty(getRequest().getParameter(
					"hidden_attr_spec_id")))) {
				hidden_attr_spec_id = getRequest().getParameter(
						"hidden_attr_spec_id");
				map.put("hidden_attr_spec_id", hidden_attr_spec_id);
			}
			if ((StringUtils.isNotEmpty(getRequest().getParameter("pt_cd")))) {
				pt_cd = getRequest().getParameter("pt_cd");
				map.put("pt_cd", pt_cd);
			}
			if (!"".equals(pr_attr_spec_name)
					&& !"".equals(hidden_attr_spec_id) && !"".equals(pt_cd)) {
				this.getProofeffectService().addPrAttrSpecValue(map);
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				String xx = "[{\"msg\":\"ok\",\"data\":\"\"}]";
				out.print(xx);
			} else {
				out = getResponse().getWriter();
				out.print("failure");
			}
		} catch (Exception e) {
			if (out != null) {

			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Adding authentication exception",null));
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * 删除认证类型属性规格配置
	 */
	public void delPrAttrSpec() {
		PrintWriter out = null;
		String pr_attr_spec_cd = "";
		try {
			getRequest().setCharacterEncoding("UTF-8");
			Map<String, String> map = new HashMap<String, String>();
			if (StringUtils.isNotEmpty(getRequest().getParameter(
					"pr_attr_spec_cd"))) {
				pr_attr_spec_cd = getRequest().getParameter("pr_attr_spec_cd");
				map.put("pr_attr_spec_cd", pr_attr_spec_cd);
			}
			if (!"".equals(pr_attr_spec_cd)) {
				this.getProofeffectService().delPrAttrSpecValue(map);
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				String xx = "[{\"msg\":\"ok\",\"data\":\"\"}]";
				out.print(xx);
			} else {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
			}
		} catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Delete authentication exception",null));
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * 添加论证属性值的配置
	 */
	public void addAttrValues() {
		PrintWriter out = null;
		String hidden_pr_attr_spec_id = "";
		String attr_value = "";
		String hide_attr_proofe_id = "";
		try {
			getRequest().setCharacterEncoding("UTF-8");
			hidden_pr_attr_spec_id = getRequest().getParameter(
					"hidden_pr_attr_spec_id");
			attr_value = getRequest().getParameter("attr_value");
			hide_attr_proofe_id = getRequest().getParameter(
					"hide_attr_proofe_id");
			if (!"".equals(hidden_pr_attr_spec_id) && !"".equals(attr_value)
					&& !"".equals(hide_attr_proofe_id)) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("hidden_pr_attr_spec_id", hidden_pr_attr_spec_id);
				map.put("attr_value", attr_value);
				map.put("hide_attr_proofe_id", hide_attr_proofe_id);
				this.getProofeffectService().addAttrValues(map);
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				String xx = "[{\"msg\":\"ok\",\"data\":\""
						+ hide_attr_proofe_id + "\"}]";
				out.print(xx);
			} else {
				out = getResponse().getWriter();
				out.print("failure");
			}
		} catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Adding authentication exception",null));
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * 删除认证属性值
	 */
	public void delProofValues() {
		PrintWriter out = null;
		String pv_id = "";
		try {
			getRequest().setCharacterEncoding("UTF-8");
			Map<String, String> map = new HashMap<String, String>();
			if (StringUtils.isNotEmpty(getRequest().getParameter("pv_id"))) {
				pv_id = getRequest().getParameter("pv_id");
				map.put("pv_id", pv_id);
			}
			if (!"".equals(pv_id)) {
				this.getProofeffectService().delProofValues(map);
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				String xx = "[{\"msg\":\"ok\",\"data\":\"\"}]";
				out.print(xx);
			} else {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
			}
		} catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Delete authentication exception",null));
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * 删除有效验证实例
	 */
	public void delProofEffect() {
		PrintWriter out = null;
		String proofe_id = "";
		try {
			getRequest().setCharacterEncoding("UTF-8");
			Map<String, String> map = new HashMap<String, String>();
			if (StringUtils.isNotEmpty(getRequest().getParameter("proofe_id"))) {
				proofe_id = getRequest().getParameter("proofe_id");
				map.put("proofe_id", proofe_id);
			}
			if (!"".equals(proofe_id)) {
				
				Map ptmap = new HashMap();
				ptmap.put("proofe_id", proofe_id);
				
				int numRecourds = this.getProofeffectService().countRecourds(ptmap);//查看该记录有没有被用
				if(numRecourds  >  0){
					getResponse().setContentType("text/html;charset=UTF-8");
					out = getResponse().getWriter();
					String xx = "Data has been used";
					out.print(xx);
				}else{
					this.getProofeffectService().delProofValuesBuProofId(map);
					this.getProofeffectService().delProofEffect(map);
					getResponse().setContentType("text/html;charset=UTF-8");
					out = getResponse().getWriter();
					String xx = "ok";
					out.print(xx);
				}
			} else {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				String xx = "fail";
				out.print(xx);
			}
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Delete authentication exception",null));
		} finally {
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	/**
	 * 选择属性页面
	 * 
	 * @return
	 */
	public String selectattr() {
		return SUCCESS;
	}
	/* JAVABEAN方法 */
	public IProofEffectService getProofeffectService() {
		if (proofeffectService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			proofeffectService = (IProofEffectService) ctx
					.getBean("eaap-op2-conf-proofeffect-proofeffectService");
		}
		return proofeffectService;
	}
	public IConfManagerServ getConfManagerServ() {
		if(confManagerServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				confManagerServ = (IConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");
			   
	     }
		return confManagerServ;
	}
	public void setProofeffectService(IProofEffectService proofeffectService) {
		this.proofeffectService = proofeffectService;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}

	public List<ProofType> getListProofType() {
		return listProofType;
	}

	public void setListProofType(List<ProofType> listProofType) {
		this.listProofType = listProofType;
	}

	public String getProoffId() {
		return prooffId;
	}

	public void setProoffId(String prooffId) {
		this.prooffId = prooffId;
	}

	public List<Map> getProoflList() {
		return prooflList;
	}

	public void setProoflList(List<Map> prooflList) {
		this.prooflList = prooflList;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	public String getPt_cd() {
		return pt_cd;
	}

	public void setPt_cd(String pt_cd) {
		this.pt_cd = pt_cd;
	}

	public List<Map> getAttrValuesList() {
		return attrValuesList;
	}

	public void setAttrValuesList(List<Map> attrValuesList) {
		this.attrValuesList = attrValuesList;
	}

	public void setConfManagerServ(IConfManagerServ confManagerServ) {
		this.confManagerServ = confManagerServ;
	}

	public String[] getAttrValues() {
		return attrValues;
	}

	public void setAttrValues(String[] attrValues) {
		this.attrValues = Arrays.copyOf(attrValues, attrValues.length);
	}

	public String getComponentId() {
		return componentId;
	}

	public void setComponentId(String componentId) {
		this.componentId = componentId;
	}

	public String getComName() {
		return comName;
	}

	public void setComName(String comName) {
		this.comName = comName;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getPagePwd() {
		return pagePwd;
	}

	public void setPagePwd(String pagePwd) {
		this.pagePwd = pagePwd;
	}
}
