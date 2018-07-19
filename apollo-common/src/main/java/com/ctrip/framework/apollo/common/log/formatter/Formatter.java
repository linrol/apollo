package com.ctrip.framework.apollo.common.log.formatter;

import ch.qos.logback.classic.spi.ILoggingEvent;

/**
 * 定义格式化接口
 * @author liuyazhuang
 *
 */
public interface Formatter {
	
	String format(ILoggingEvent event);
}
