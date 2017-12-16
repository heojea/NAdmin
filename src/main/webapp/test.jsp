<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/function.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--                                                                           --%>
<%--  Copyright 2008-2010 Xebia and the original author or authors.            --%>
<%--                                                                           --%>
<%--  Licensed under the Apache License, Version 2.0 (the "License");          --%>
<%--  you may not use this file except in compliance with the License.         --%>
<%--  You may obtain a copy of the License at                                  --%>
<%--                                                                           --%>
<%--       http://www.apache.org/licenses/LICENSE-2.0                          --%>
<%--                                                                           --%>
<%--  Unless required by applicable law or agreed to in writing, software      --%>
<%--  distributed under the License is distributed on an "AS IS" BASIS,        --%>
<%--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. --%>
<%--  See the License for the specific language governing permissions and      --%>
<%--  limitations under the License.                                           --%>
<%--                                                                           --%>
<%@ page import="java.lang.management.ManagementFactory"%>
<%@ page import="javax.management.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@page import="java.net.InetAddress"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%!public void dumpMbeans(Set<ObjectInstance> objectInstances, JspWriter out, MBeanServer mbeanServer, String... mbeanAttributes)
            throws Exception {
        out.write("<table border='1'>");

        out.write("<tr>");
        out.print("<th>ObjectName</th>");
        for (String mbeanAttribute : mbeanAttributes) {
            out.print("<th>" + mbeanAttribute + "</th>");
        }
        out.println("</tr>");

        for (ObjectInstance objectInstance : objectInstances) {
            ObjectName objectName = objectInstance.getObjectName();
            out.print("<tr><td>" + objectName + "</td>");
            for (String mbeanAttribute : mbeanAttributes) {
                out.print("<td>" + mbeanServer.getAttribute(objectName, mbeanAttribute) + "</td>");
            }
            out.println("</tr>");
        }

        out.println("</table>");

    }%>

<html>
<head>
<title>@Profiled Services</title>
</head>
<body>
<h1>@Profiled Services</h1>
<%
    try {
        java.sql.Timestamp applicationStartupDate = WebApplicationContextUtils.getWebApplicationContext(application) == null ? null
                : new java.sql.Timestamp(WebApplicationContextUtils.getWebApplicationContext(application).getStartupDate());

        out.println("Server=" + InetAddress.getLocalHost() + ", current date: "
                + new java.sql.Timestamp(System.currentTimeMillis()).toString() + ", application startup date="
                + applicationStartupDate + "<br>");

        List<MBeanServer> mbeanServers = MBeanServerFactory.findMBeanServer(null);
        for (MBeanServer mbeanServer : mbeanServers) {

            out.println("<h2> MbeanServer domain = " + mbeanServer.getDefaultDomain() + "</h2>");
            {
                out.println("<h2>@Profiled</h2>");
                Set<ObjectInstance> objectInstances = mbeanServer.queryMBeans(new ObjectName(
                        "fr.xebia:type=ServiceStatistics,*"), null);
                dumpMbeans(objectInstances, out, mbeanServer, "CurrentActive", "InvocationCount", "TotalDurationInMillis", "SlowInvocationCount", "VerySlowInvocationCount",
                        "BusinessExceptionCount", "CommunicationExceptionCount", "OtherExceptionCount");
            }

        }
    } catch (Throwable e) {
        out.println("<pre>");
        PrintWriter printWriter = new PrintWriter(out);
        e.printStackTrace(printWriter);
        out.println("</pre>");
        printWriter.flush();
    }
%>
</body>
</html>
