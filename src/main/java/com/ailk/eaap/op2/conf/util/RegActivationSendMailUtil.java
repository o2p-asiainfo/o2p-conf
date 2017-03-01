package com.ailk.eaap.op2.conf.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;

import com.ailk.eaap.op2.conf.adapter.util.PropertiesUtil;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.foundation.common.ExceptionCommon;

public class RegActivationSendMailUtil {
     protected javax.mail.Session session = null;
     private static Logger log = Logger.getLog(RegActivationSendMailUtil.class);

	String sendMailUser 		= this.getValueByProCode("regActivation.sendMailUser");	//你通过哪个帐号发送邮件
	String sendMailPwd 		= this.getValueByProCode("regActivation.sendMailPwd");	//你所要通过的帐号的密码是多少，也就是sendMailUser的密码
	String sendSmtpHost 	= this.getValueByProCode("regActivation.sendSmtpHost");	//你通过哪个主机发送邮件
	String sendSmtpPort 		= this.getValueByProCode("regActivation.sendSmtpPort");	//发送邮件主机的端口
	String mailTitle 				= this.getValueByProCode("regActivation.mailTitle");			//邮件主题
 	
	String getter = "" ;       //谁接收邮件
     
     public RegActivationSendMailUtil() {
         Properties props = new Properties();          //先声明一个配置文件以便存储信息
         props.put("mail.transport.protocol", "smtp"); //首先说明邮件的传输协议
         props.put("mail.smtp.host", sendSmtpHost);            //说明发送邮件的主机地址
         props.put("mail.smtp.auth", "true");          //说明发送邮件是否需要验证，表示自己的主机发送是需要验证的
         props.put("mail.smpt.port", sendSmtpPort);            //说明邮件发送的端口号
   
         //session认证 getInstance()
         session = javax.mail.Session.getInstance(props,new Authenticator(){
		       public PasswordAuthentication getPasswordAuthentication() {
		           return new PasswordAuthentication(sendMailUser,sendMailPwd);
		       }
         });
         //这个是跟踪后台消息。打印在控制台
         session.setDebug(true);
     }
     
     public void send(String from,String content) {
         try {
	          this.getter = from;
	          Message msg = new MimeMessage(session);
	          //设置发送者
             msg.setFrom(new InternetAddress(sendMailUser)); 
             //设置接受者
             msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse(getter));
             //设置发送时间
             msg.setSentDate(new Date()); 
             //设置内容的基本机制，字体等
             String htmltext=content; 
             msg.setContent(htmltext, "text/html;charset=GBK"); 
             //设置发送主题
             msg.setSubject(mailTitle);
             //设置邮件内容
             // msg.setText(htmltext); //如果以html的格式发送邮件那么邮件的内容需要通过setContent来设置并且不能用setText
             Transport transport = session.getTransport("smtp"); //得到发送协议
             transport.connect(sendSmtpHost, sendMailUser, sendMailPwd);//与发送者的邮箱相连
             transport.send(msg); //发送消息
         } catch (Exception ee) {
        	 log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,ee.getMessage(),null));
         }
     }
     

 	public static String getValueByProCode(String proCode) {
 		Properties p = new Properties();
 		InputStream in = null;
 		try {
 			in = PropertiesUtil.class.getResourceAsStream("/mail-send.properties");
 			p.load(in);
 			if(null != in){
 				in.close();
 			}
 			return (String) p.get(proCode);
 		} catch (IOException e) {
 			log.error(LogModel.EVENT_APP_EXCPT, e.getMessage());
 			return null;
 		}finally{
 			if(null != in){
 				try {
					in.close();
				} catch (IOException e) {
					log.error(LogModel.EVENT_APP_EXCPT, e.getMessage());
				}
 			}
 		}
 	}

}