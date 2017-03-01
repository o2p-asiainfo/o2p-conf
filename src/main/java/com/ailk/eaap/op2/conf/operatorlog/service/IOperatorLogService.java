package com.ailk.eaap.op2.conf.operatorlog.service;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.conf.operatorlog.action.FuzzyModel;

public interface IOperatorLogService {

	public int countOptLogList(Map map);

	public List<Map> queryOptLogList(Map map);

	public List<Map> getOptLogById(Map map);

	public List<Map> getDataLogByMap(Map<String, String> paramMap);

	public List<Map> getAllTableColByName(Map map);

	public int countFuzzyList(Map map);

	public List<Map> queryFuzzyList(Map map);

	public String queryNextPriId();

	public void addHideRrocess(FuzzyModel fuzzyModel);

	public void delHideProcess(Map map);

	public void updateSubmitProcess(FuzzyModel fuzzyModel);

}
