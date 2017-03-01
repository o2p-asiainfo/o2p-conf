/*
 * @(#)PropertiesUtil.java        2013-4-14
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.adapter.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

/**
 * 类名<br>
 * 这里是类的描述区域，概括出该的主要功能或者类的使用范围的注意事项??
 * <p>
 * @version 1.0
 * @author Administrator 2013-4-14
 * <hr>
 * 修改记录
 * <hr>
 * 1、修改人  修改时间:<br>       
 *    修改内容:
 * <hr>
 */

public class PropertiesUtil {
	public static final String webServerType=getValueByProCode("webServerType");
	
	private static Logger log = Logger.getLogger(PropertiesUtil.class);
	
    public static String DHTML_TREE_ROOT_ICON_IMG0=getValueByProCode("dhtml_Tree_Root_Icon_Img0");
    
    public static String DHTML_TREE_ROOT_ICON_IMG1=getValueByProCode("dhtml_Tree_Root_Icon_Img1");
    
    public static String DHTML_TREE_ROOT_ICON_IMG2=getValueByProCode("dhtml_Tree_Root_Icon_Img2");
    
    public static String DHTML_TREE_BRANCH_ICON_IMG0=getValueByProCode("dhtml_Tree_Branch_Icon_Img0");
    
    public static String DHTML_TREE_BRANCH_ICON_IMG1=getValueByProCode("dhtml_Tree_Branch_Icon_Img1");
    
    public static String DHTML_TREE_BRANCH_ICON_IMG2=getValueByProCode("dhtml_Tree_Branch_Icon_Img2");    
    
    public static String DHTML_TREE_LEAF_ICON_IMG0=getValueByProCode("dhtml_Tree_Leaf_Icon_Img0");
    
    public static String DHTML_TREE_LEAF_ICON_IMG1=getValueByProCode("dhtml_Tree_Leaf_Icon_Img1");
    
    public static String DHTML_TREE_LEAF_ICON_IMG2=getValueByProCode("dhtml_Tree_Leaf_Icon_Img2"); 	
	
	/**
	 * 获取配置文件中的值
	 * @param proCode
	 * @return
	 */
	public static String getValueByProCode(String proCode) {
		Properties p = new Properties();
		InputStream in = null;
		try {
			in = PropertiesUtil.class.getResourceAsStream("/eaap_conf.properties");
			p.load(in);
			if(null != in){
				in.close();
			}
			return (String) p.get(proCode);
		} catch (IOException e) {
			log.error(e.getMessage());
			return null;
		}finally{
			if(null != in){
				try {
					in.close();
				} catch (IOException e) {
					log.error(e.getMessage());
				}
			}
		}
	}	
}
