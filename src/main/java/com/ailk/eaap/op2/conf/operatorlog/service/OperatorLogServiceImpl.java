package com.ailk.eaap.op2.conf.operatorlog.service;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.conf.operatorlog.action.FuzzyModel;
import com.ailk.eaap.op2.conf.operatorlog.dao.IOperatorLogDao;

public class OperatorLogServiceImpl implements IOperatorLogService{

	private IOperatorLogDao operatorLogDao;

	public IOperatorLogDao getOperatorLogDao() {
		return operatorLogDao;
	}

	public void setOperatorLogDao(IOperatorLogDao operatorLogDao) {
		this.operatorLogDao = operatorLogDao;
	}

	@Override
	public int countOptLogList(Map map) {
		return operatorLogDao.countOptLogList(map);
	}

	@Override
	public List<Map> queryOptLogList(Map map) {
		return operatorLogDao.queryOptLogList(map);
	}

	@Override
	public List<Map> getOptLogById(Map map) {
		return operatorLogDao.getOptLogById(map);
	}

	@Override
	public List<Map> getDataLogByMap(Map<String, String> paramMap) {
		return operatorLogDao.getDataLogByMap(paramMap);
	}

	@Override
	public List<Map> getAllTableColByName(Map map) {
		return operatorLogDao.getAllTableColByName(map);
	}

	@Override
	public int countFuzzyList(Map map) {
		return operatorLogDao.countFuzzyList(map);
	}

	@Override
	public List<Map> queryFuzzyList(Map map) {
		return operatorLogDao.queryFuzzyList(map);
	}

	@Override
	public String queryNextPriId() {
		return operatorLogDao.queryNextPriId();
	}

	@Override
	public void addHideRrocess(FuzzyModel fuzzyModel) {
		operatorLogDao.addHideRrocess(fuzzyModel);
	}

	@Override
	public void delHideProcess(Map map) {
		operatorLogDao.delHideProcess(map);
	}

	@Override
	public void updateSubmitProcess(FuzzyModel fuzzyModel) {
		operatorLogDao.updateSubmitProcess(fuzzyModel);
	}
	
}
