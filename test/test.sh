#!/usr/bin/env bash

#提示并退出脚本，$1英文
test_exit() {
    clear
    echo
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    [ "$language" == "cn" ] && echo "错误：$1" || echo "Error：$1"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo
    exit
}

#测试是否是root
test_root() {
    if [[ $EUID -ne 0 ]]; then
        test_exit "This soft_install must be run as root"
    fi
}
# test_root

#系统是64位则返回0
test_64bit() {
    if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
        return 0
    else
        return 1
    fi
}
# echo `test_64bit`

#测试网站是否正常，$1为网址
test_www() {
    local a=`curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1`
    [ $a -eq 200 ] || test_exit "Unable to access external network, please try again or debug network" 
}
# test_www "www.baidu.com"

#测试输入的是否为ip，$1填写ip
test_ip() {
    local status=$(echo $1|awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}')
    if echo $1|grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$">/dev/null;
then
	if [ status == "yes" ]; then
		return 0
	else
		return 1
	fi
else
	return 1
fi
}

#crond进程是否在运行
check_crond_status() {
  NAME=crond
  NUM=$(ps -ef |grep $NAME |grep -vc grep)
  if [ $NUM -eq 1 ]; then
      echo "$NAME running."
  else
      echo "$NAME is not running!"
  fi
}
# check_crond_status
