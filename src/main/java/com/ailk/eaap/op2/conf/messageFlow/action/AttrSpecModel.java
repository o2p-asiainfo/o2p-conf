package com.ailk.eaap.op2.conf.messageFlow.action;
/**
 * 属性规格,属性值模型
 * @author MAWL
 *
 */
public class AttrSpecModel {

	private String attr_spec_value;
	private String attr_spec_name;
	public String getAttr_spec_name() {
		return attr_spec_name;
	}
	public void setAttr_spec_name(String attrSpecName) {
		this.attr_spec_name = attrSpecName;
	}
	public String getAttr_spec_value() {
		return attr_spec_value;
	}
	public void setAttr_spec_value(String attrSpecValue) {
		this.attr_spec_value = attrSpecValue;
	}
}
