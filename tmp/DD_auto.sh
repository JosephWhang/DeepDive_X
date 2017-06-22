#!/bin/bash
echo "Please input password of the current user:"
read input
echo "Received."

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sh -c "echo > /etc/apt/sources.list"

sudo sh -c "cat << EOF > /etc/apt/sources.list
deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
EOF"

sudo apt-get update
sudo apt-get -y install expect

expect <<-END
	spawn sudo add-apt-repository ppa:webupd8team/java
	expect "$USER:"
	send "$input\n"
	expect "*it*"
	send "\n"
	expect eof
END

command -v curl >/dev/null 2>&1 || { echo "Installing curl..."; sudo apt-get -y install curl; }
command -v git >/dev/null 2>&1 || { echo "Installing git..."; sudo apt-get -y install git; }

sudo apt-get update
sudo apt-get -y install oracle-java8-installer

sudo wget https://dl.bintray.com/sbt/debian/sbt-0.13.8.deb
sudo dpkg -i sbt-0.13.8.deb
sudo rm sbt-0.13.8.deb

sudo wget https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb
sudo dpkg -i lantern-installer-64-bit.deb
nohup lantern -startup > /tmp/lantern.log 2>&1 &
sudo rm lantern-installer-64-bit.deb

curl -fsSL git.io/getdeepdive > tmp.sh
sudo chmod 777 tmp.sh

expect <<-END
	set timeout -1
	spawn ./tmp.sh postgres
	expect "$USER:"
	send "$input\n"
	expect eof
END

expect <<-END
	set timeout -1
	spawn ./tmp.sh deepdive
	expect "$USER:"
	send "$input\n"
	expect eof
END

sudo ln -s /home/$USER/local/bin/deepdive /bin
sudo ln -s /home/$USER/local/bin/ddlog /bin
sudo ln -s /home/$USER/local/bin/mindbender /bin

