package com.ailk.eaap.op2.conf.directoryManager.service;

import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.bo.Directory;
import com.ailk.eaap.op2.conf.directoryManager.dao.IDirectoryManagerDao;

public class DirectoryManagerService implements IDirectoryManagerService {
	private IDirectoryManagerDao directoryManagerDao;
	
	public IDirectoryManagerDao getDirectoryManagerDao() {
		return directoryManagerDao;
	}

	public void setDirectoryManagerDao(IDirectoryManagerDao directoryManagerDao) {
		this.directoryManagerDao = directoryManagerDao;
	}

	public void insertServiceManager(Directory dir) {
		// TODO Auto-generated method stub
		directoryManagerDao.insertDirectory(dir);
	}

	public void updateServiceManager( Directory dir){
		directoryManagerDao.updateDirectory(dir);
	}
	
	public List<Directory> queryDirectory(Map map) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Directory> selectDirectoryByFaDirIdAndType(Directory dir) {
		// TODO Auto-generated method stub

		return directoryManagerDao.selectDirectoryByFaDirAndType(dir) ;
	}

	public void deleDirNode(String nodeId) {
		directoryManagerDao.deleDirNode(nodeId);		
	}

	public Directory queryDirById(Directory directory){
		return directoryManagerDao.queryDirById(directory);
	}

	 public int isExistDirName(Map map){
		 return directoryManagerDao.isExistDirName(map);
	 }
}
