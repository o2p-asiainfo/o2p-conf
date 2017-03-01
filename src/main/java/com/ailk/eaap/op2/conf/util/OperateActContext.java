package com.ailk.eaap.op2.conf.util;

import com.ailk.eaap.o2p.sqllog.model.OperateActInfo;

/**
 * @ClassName: OperateActContext
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-6 上午10:13:12
 *
 */
public class OperateActContext {
	
	private OperateActContext(){}
	
	private static ThreadLocal<OperateActInfo> actInfoLocal = new ThreadLocal<OperateActInfo>();
	
	public static OperateActInfo getActInfo() {
		return (OperateActInfo) actInfoLocal.get();
	}

	public static void setActInfo(OperateActInfo operateActInfo) {
		actInfoLocal.set(operateActInfo);
	}
	
	public static void removeActInfo(){
		actInfoLocal.remove();
	}

}
