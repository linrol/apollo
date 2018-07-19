package com.ctrip.framework.apollo.common.log.formatter;

import ch.qos.logback.classic.spi.ILoggingEvent;

/** 
* @author 罗林 E-mail:1071893649@qq.com 
* @version 创建时间：2018年7月19日 下午12:39:45 
* 类说明 
*/
public class MessageFormatter implements Formatter {
	 
	@Override
	public String format(ILoggingEvent event) {
		return event.getFormattedMessage();
	}
 
}
