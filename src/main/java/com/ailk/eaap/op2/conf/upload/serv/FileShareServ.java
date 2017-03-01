package com.ailk.eaap.op2.conf.upload.serv;

 
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.FileShare;
 
import com.ailk.eaap.op2.dao.FileShareDao;
 
public class FileShareServ implements IFileShareServ {
	
	private FileShareDao fileShareSqlDao; 
	
	public Integer saveFileShare(FileShare fileShareBean){
		return fileShareSqlDao.addFileShare(fileShareBean) ;
	 }
	public List<Map>  selectFileShare(FileShare fileShareBean){
		return fileShareSqlDao.selectFileShare(fileShareBean) ;
	}
	public FileShareDao getFileShareSqlDao() {
		return fileShareSqlDao;
	}

	public void setFileShareSqlDao(FileShareDao fileShareSqlDao) {
		this.fileShareSqlDao = fileShareSqlDao;
	}

}
