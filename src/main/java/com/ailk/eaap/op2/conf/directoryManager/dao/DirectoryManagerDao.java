package com.ailk.eaap.op2.conf.directoryManager.dao;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.bo.Directory;
import com.linkage.rainbow.dao.SqlMapDAO;

public class DirectoryManagerDao implements IDirectoryManagerDao {
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	public void insertDirectory(Directory diretory) {
		// TODO Auto-generated method stub
		                
		sqlMapDao.insert("eaap-op2-conf-directoryManager.insertDirectory", diretory);
		
	}
	
	public void updateDirectory(Directory diretory) {
		// TODO Auto-generated method stub
		
		sqlMapDao.update("eaap-op2-conf-directoryManager.updateDirectory", diretory);
		
	}
	
	public Directory queryDirById(Directory directory){
		return (Directory) sqlMapDao.queryForObject("eaap-op2-conf-directoryManager.queryDirById", directory);
	}

	public List<Directory> queryDirectory(Map map) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Directory> selectDirectoryByFaDirAndType(Directory diretory) {
		// TODO Auto-generated method stub
		return (ArrayList<Directory>)sqlMapDao.queryForList("eaap-op2-conf-directoryManager.queryOrgInfoByFaDirId", diretory) ;
	}

	public void deleDirNode(String nodeId) {
		sqlMapDao.delete("eaap-op2-conf-directoryManager.deleDirNode", nodeId);
		
	}
	 public int isExistDirName(Map map){
		 return (Integer) sqlMapDao.queryForObject("eaap-op2-conf-directoryManager.isExistDirName", map);
	 }
    
}
