package com.ailk.eaap.op2.conf.upload.serv;

 
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.FileShare;
 
public interface IFileShareServ{
	
 
	public Integer saveFileShare(FileShare fileShare);
	public List<Map>  selectFileShare(FileShare fileShareBean) ;
	 }
