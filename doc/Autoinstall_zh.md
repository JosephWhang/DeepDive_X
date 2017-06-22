## DeepDive 自动化安装

Linux 下的 DeepDive 自动安装脚本测试版已发布，用于简便地在中国大陆地区安装 DeepDive ( 不包括 Demo )。点击 [此处](http://wakafa-1252719529.costj.myqcloud.com/DD_auto.sh) 下载。

### **使用方法**

将该脚本下载到 linux 中， 利用命令 `$ sudo chmod 777 DD_auto.sh` 赋予脚本运行权限

然后利用命令 `$ ./DD_auto.sh` 运行脚本即可。

过程中可能有少量的环节需要输入用户密码或者点击确认等。

## tips

1. 本脚本在 Ubuntu 14.04 英文版 测试通过，不保证在其他平台的通用性。鉴于 DeepDive 安装情况不确定因素较多，建议读者重新开一个空白的虚拟机用此脚本进行安装。

2. 本脚本会修改本机的 apt 源，请有需要的用户做好备份工作。

3. 本脚本将自动安装 Lantern ，关于其详细使用方式请参考 [Lantern 官方网站](https://github.com/getlantern/forum)

**如果脚本卡在下载阶段，十分钟内无下载进度，推荐键入 `Ctrl-C` 中止后重新运行该脚本**