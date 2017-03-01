package test.com.ailk.eaap.op2.conf.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @ClassName: TestUtil
 * @Description:
 * @author zhengpeng
 * @date 2015-4-29 下午4:02:35
 * 
 */
public class TestUtil {

	public static void testPrintln(Object object) {
		System.out.println("==========================================");
		if (object instanceof Map) {
			TestUtil.printlnHashMap((Map) object);
		} else if (object instanceof List) {
			TestUtil.printlnList((List) object);
		} else {
			TestUtil.printlnObject(object);
		}
		System.out.println("==========================================");
	}

	public static void printlnObject(Object object) {
		if (object != null) {
			System.out.println(" result :" + object.toString());
		} else {
			System.out.println(" result is null");
		}
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static void printlnHashMap(Map object) {
		Set<Map.Entry<String, Object>> entries = object.entrySet();
		StringBuffer sb = new StringBuffer();
		for (Map.Entry<String, Object> entry : entries) {
			if (entry.getValue() == null) {
				sb.append("|| key:" + entry.getKey() + "; value:null");
			} else {
				sb.append("  key:" + entry.getKey() + "; value:"
						+ entry.getValue().toString());
			}
		}
		System.out.println(sb);
	}

	@SuppressWarnings("rawtypes")
	public static void printlnList(List<Object> objectList) {
		if (objectList != null) {
			System.out.println("result list size:" + objectList.size());
			for (Object object : objectList) {
				if (object instanceof Map) {
					TestUtil.printlnHashMap((HashMap) object);
				} else {
					System.out.println(" result:" + object.toString());
				}
			}
		}
	}

}
