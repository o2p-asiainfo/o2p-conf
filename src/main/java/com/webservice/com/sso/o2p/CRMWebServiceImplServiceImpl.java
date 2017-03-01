
package com.webservice.com.sso.o2p;

import javax.jws.WebService;

@WebService(serviceName = "CRMWebServiceImplService", targetNamespace = "", endpointInterface = "com.webservice.com.sso.o2p.CRMWebServiceImpl")
public class CRMWebServiceImplServiceImpl
    implements CRMWebServiceImpl
{


    public String exchange(String parameters) {
        throw new UnsupportedOperationException();
    }

    public static void main(String[] args){
//    	CRMWebServiceImplServiceImpl obj = new CRMWebServiceImplServiceImpl();
//    	String value = "<ContractRoot><RequestHead> <AppKey>1</AppKey> <TransactionID>509751</TransactionID> <ReqTime>20131129103231</ReqTime>"
//				+"<Sign>***</Sign><AccessToken>a</AccessToken><Version>String</Version><TenantId>C</TenantId><AcceptChannelType>23</AcceptChannelType>"
//				+"<AcceptChannelCode>1000</AcceptChannelCode><AcceptStaffId>21OSE103</AcceptStaffId><BusiCode>GetLoginMenus</BusiCode> </RequestHead>"
//				+"<RequestBody><OperatorId>100000138</OperatorId><MenuType>H</MenuType><EntClassId>9600</EntClassId></RequestBody></ContractRoot>";
//      String result = obj.exchange(value);
    }
}
