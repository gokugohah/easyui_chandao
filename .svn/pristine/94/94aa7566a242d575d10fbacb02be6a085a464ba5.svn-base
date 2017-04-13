/**
 * file name: AbstractMailSender.java
 * Auther: allen
 * Create Date: 2014年12月17日
 * Description: Mail抽象类，用于加载配置文件和设置静态量
 */

package com.baidu.product.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public abstract class AbstractMailSender {

	/*
	 *静态量， properties 配置文件中对应的变量名
	 */
	private static final String PROTOCOL = "mail.transport.protocol";
	private static final String HOST = "mail.smtp.host";
	private static final String PORT = "mail.smtp.port";
	private static final String FROM = "mail.smtp.from";
	private static final String USERNAME = "mail.smtp.user";
	private static final String PASSWORD = "mail.smtp.password";
	private static final String VALIDATE = "mail.smtp.auth";
	private static final String DEBUG = "mail.debug";
	
	private static Properties configs = new Properties(); //properties 配置文件
	private static Properties props = new Properties(); //创建 Session 实例时需要传递的基本参数
	private static Authenticator authenticator; // 创建 Session 实例时需要传递的认证参数

	private Session session;
	protected Message message;

	/**
	 * 初始化静态量
	 */
	static {
		InputStream inputStream = AbstractMailSender.class
				.getResourceAsStream("mail.properties");
		try {
			configs.load(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (inputStream != null) {
					inputStream.close();
				}
			} catch (IOException e) {
			}
		}
		props.put(PROTOCOL, configs.getProperty(PROTOCOL));
		props.put(HOST, configs.getProperty(HOST));
		props.put(PORT, configs.getProperty(PORT));
		props.put(VALIDATE, configs.getProperty(VALIDATE));
		props.put(DEBUG, configs.getProperty(DEBUG));
		authenticator = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(configs.getProperty(USERNAME), configs.getProperty(PASSWORD));
			}
		};
	}

	/**
	 * 创建邮件即创建 java mail 的 session 和 message实例
	 */
	public void createMail() {
		session = Session.getInstance(props, authenticator);
		message = new MimeMessage(session);
		try {
			//设置邮件发送地址
			message.setFrom(new InternetAddress(configs.getProperty(FROM)));
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 发送邮件
	 */
	abstract void sendMail();

}
