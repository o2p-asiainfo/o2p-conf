package com.ailk.eaap.op2.conf.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.springframework.core.io.ClassPathResource;

import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;

public class PropertiesUtil {
	private static final Logger log = Logger.getLog(PropertiesUtil.class);
	private static Properties pro = new Properties();
	static {
		InputStream in = null;
		try {
			if(new ClassPathResource("/eaap_common.properties").exists()) {
				in = PropertiesUtil.class
						.getResourceAsStream("/eaap_common.properties");
				pro.load(in);
				if(null != in){
					in.close();
				}
			}
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, e.getMessage());
		}finally{
			if(null != in){
				try {
					in.close();
				} catch (IOException e) {
					log.error(LogModel.EVENT_APP_EXCPT, e.getMessage());
				}
			}
		}
	}

	/**
	 * 获取公共配置文件中eaap_common.properties中的值
	 * @param proCode
	 * @return
	 */
	public static String getValueByProCode(String proCode) {
		if(pro.containsKey(proCode)) {
			return pro.getProperty(proCode);
		} else {
			return null;
		}
	}

}
