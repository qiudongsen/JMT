# JMT
JMT(JRE 1.7 + MySQL 5.6.36 + Tomcat 8.0.44)集成工具 Windows版
<br/><br/>
特点：<br/>
1.集成JRE1.7，保持对Windows XP/2003系统的支持<br/>
2.通过批处理文件，一键安装/卸载JRE+MySQL+Tomcat环境<br/>
3.增加了对Vista以后的Windows系统自动获取管理员权限的支持，无须手动以管理员权限运行<br/>
<br/>
<br>bat批处理文件说明</br>
1. addnet.bat 添加8080端口到Windows防火墙
2. deleteservice.bat 输入一个服务名称，删除该服务
3. installandstart.bat 如果MySQL Tomcat 没有安装就执行安装服务，若已经安装跳过安装，执行启动服务
4. uninstall.bat 检查安装情况，依次停止并卸载服务

