package com.ailk.eaap.o2p.common.service;

import java.util.List;

import com.ailk.eaap.op2.bo.ExceptionDealInfo;

public interface IExceptionDealInfoService {
	
	//异常信息保存接口：（通过接口方式调用日志服务接口，持久化异常信息到数据库）
	public  boolean  saveExceptionDealInfo(ExceptionDealInfo  exceptionDealInfo);
	
	//条件查询总数
	public Integer queryCountExceptionDealInfo(ExceptionDealInfo  exceptionDealInfo);

	//异常信息查询接口，返回json：（通过接口方式调用日志服务接口，根据条件查询异常信息数据）
	public  String  selectExceptionDealInfoJson(ExceptionDealInfo  exceptionDealInfo,Integer startNo,Integer pageNo);
	
	//异常信息查询接口，返回List：（通过接口方式调用日志服务接口，根据条件查询异常信息数据）
	public List<ExceptionDealInfo> selectExceptionDealInfoList(ExceptionDealInfo  exceptionDealInfo,Integer startNo,Integer pageNo);

	//根据ID查询详情
	public ExceptionDealInfo selectExceptionDealInfoById(Integer id);
	
	//删除
	public void deleteById(Integer exceptionId);

	//更新
	public void updateExceptionDealInfo(ExceptionDealInfo info);
	
	//保存到历史表
	public void insertExceptionDealInfoHis(ExceptionDealInfo info);
	
}
