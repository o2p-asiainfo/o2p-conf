package com.ailk.eaap.op2.conf.directoryManager.dao;

import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.bo.Directory;
 
public interface IDirectoryManagerDao {
	   public List<Directory> queryDirectory(Map map);//查询目录表
	   public void insertDirectory(Directory diretory);      //增加目录
	   public void updateDirectory(Directory diretory);      //更新目录
	   public List<Directory>  selectDirectoryByFaDirAndType(Directory diretory) ; //通过父目录ID查找所有子目录
	   public void deleDirNode(String nodeId);
	   public Directory queryDirById(Directory directory);
	   public int isExistDirName(Map map);
}
