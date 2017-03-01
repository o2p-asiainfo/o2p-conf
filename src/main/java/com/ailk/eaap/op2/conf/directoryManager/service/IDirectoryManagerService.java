package com.ailk.eaap.op2.conf.directoryManager.service;

import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.bo.Directory;
 
public interface IDirectoryManagerService {
	public List<Directory> queryDirectory(Map map); //查询目录
	public void insertServiceManager( Directory dir);   //增加目录
	public void updateServiceManager( Directory dir);   //更新目录
	public List<Directory> selectDirectoryByFaDirIdAndType(Directory dir);
	public void deleDirNode(String nodeId);
	public Directory queryDirById(Directory directory);//通过id查找目录
	 public int isExistDirName(Map map);
 }
