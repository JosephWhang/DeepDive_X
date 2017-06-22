## 另附 lantern 安装方法

### 方案一

  下载文件：https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb 直接点击安装

  安装成功后直接在终端中输入 `lantern`，然后一直开在后台即可。

  期间会弹出一个lantern的网页，不用在意，可以关闭

### 方案二

在终端中运行以下脚本 （对应64位操作系统）：

	$ sudo wget https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb
	$ sudo dpkg -i lantern-installer-64-bit.deb
	$ nohup lantern -startup > /tmp/lantern.log 2>&1 &
	$ sudo rm lantern-installer-64-bit.deb
	