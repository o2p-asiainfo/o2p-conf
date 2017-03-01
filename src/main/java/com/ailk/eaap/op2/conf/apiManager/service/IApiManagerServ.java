package com.ailk.eaap.op2.conf.apiManager.service;

import java.util.Map;
import java.util.List;

public interface IApiManagerServ {
   public String queryGridCount();//查询所有的数目
   public List<Map> queryApi();//查询所有的api的对象
}
