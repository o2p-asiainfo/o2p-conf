/*
 * @(#)AdapterConfigHelp.java        2013-8-16
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.adapter.util;

import java.util.List;

import net.sf.json.JSONObject;
import net.sf.json.xml.XMLSerializer;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * AdapterConfigHelp <br>
 * 协议适配界面配置工具类
 * <p>
 * @version 1.0
 * @author Administrator 2013-8-16
 * <hr>
 * 修改记录
 * <hr>
 * 1、修改人员:    修改时间:<br>       
 *    修改内容:
 * <hr>
 */

public class AdapterConfigHelp {
	
	private static Logger log = Logger.getLogger("eaap_conf");
	
	/**
	 * 
	 * @param xml
	 * @return
	 */
	public static String xmlToJSON(String xml){
		return new XMLSerializer().read(xml).toString();
	}
	
	/**
	 * 
	 * @param json
	 * @return
	 */
	public static String jsonToXML(String json){
		JSONObject jobj = JSONObject.fromObject(json);
		String xml =  new XMLSerializer().write(jobj);
		return xml;
	}
	
	/**
	 * 
	 * @param domcument
	 * @return
	 */
	public static String changeXmlToJsonTree(Document domcument){
		String xml = domcument.asXML();
		xml=xmlToJSON(xml);
		return xml;
	}
	
	/**
	 * 将domcument对象转换成dbtml树结构的XML
	 * @param domcument
	 * @return
	 */
	public static void changeXmlToDhtmlTree(Document domcument,Document treeDocument){
		//根 节点转换
		Element rootElement = domcument.getRootElement();
		Element treeRootElement = treeDocument.addElement("tree");
		treeRootElement.addAttribute("id","0");
		Element tarRootElement = treeRootElement.addElement("item");
		if(rootElement.getNamespacePrefix()!=null&&!rootElement.getNamespacePrefix().equals("")){
			tarRootElement.addAttribute("id",rootElement.getNamespacePrefix()+":"+rootElement.getName());
			tarRootElement.addAttribute("text", rootElement.getNamespacePrefix()+":"+rootElement.getName());
		}else{
			tarRootElement.addAttribute("id",tarRootElement.getPath());
			tarRootElement.addAttribute("text",rootElement.getName());
		}			
		tarRootElement.addAttribute("im0", PropertiesUtil.DHTML_TREE_ROOT_ICON_IMG0);
		tarRootElement.addAttribute("im1", PropertiesUtil.DHTML_TREE_ROOT_ICON_IMG1);
		tarRootElement.addAttribute("im2", PropertiesUtil.DHTML_TREE_ROOT_ICON_IMG2);		
		recursiveChangeSubNodeToDhtmlTree(rootElement,tarRootElement);
	}
	
	public static String recursiveChangeSubNodeToDhtmlTree(Element src,Element tar){
		List subElemenList = src.elements();
		for(int i=0;i<subElemenList.size();i++){
			Element subElement = (Element)subElemenList.get(i);
			List subSubElemetList =  subElement.elements();
			Element addElemnt= tar.addElement("item");
			if(subElement.getNamespacePrefix()!=null&&!subElement.getNamespacePrefix().equals("")){
				addElemnt.addAttribute("text", subElement.getNamespacePrefix()+":"+subElement.getName());
			}else{
				addElemnt.addAttribute("text", subElement.getName());
			}
			addElemnt.addAttribute("id", subElement.getPath());
			if(subSubElemetList.size()>0){
				addElemnt.addAttribute("im0", PropertiesUtil.DHTML_TREE_BRANCH_ICON_IMG0);
				addElemnt.addAttribute("im1", PropertiesUtil.DHTML_TREE_BRANCH_ICON_IMG1);
				addElemnt.addAttribute("im2", PropertiesUtil.DHTML_TREE_BRANCH_ICON_IMG2);
				recursiveChangeSubNodeToDhtmlTree(subElement,addElemnt);
			}else{
				addElemnt.addAttribute("im0", PropertiesUtil.DHTML_TREE_LEAF_ICON_IMG0);
				addElemnt.addAttribute("im1", PropertiesUtil.DHTML_TREE_LEAF_ICON_IMG1);
				addElemnt.addAttribute("im2", PropertiesUtil.DHTML_TREE_LEAF_ICON_IMG2);				
			}
		}
		return "";
	}
	
	public static String getElementPath(Element element){
		return "";
	}
	
	public static String changeXmlToDhtmlTreeProperty(Element src,Element tar){
		List srcAttributeList =src.attributes();
		for(int i=0;i<srcAttributeList.size();i++){
			
		}
		return null;
	}

}
