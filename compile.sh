#/bin/sh
odate=`date +%Y%m%d_%k%M`

function error_check {
    if [ $1 != "0" ]; then
        echo -e "\e[1;31;40m Error!! Install stoppted \e[0m"
        exit
    fi
}

function string_check {
    grep -r $1 $2
    string=`echo $?`
}

echo -e "\e[1;32;40m Bash install start \e[0m"
sleep 2
# compile
./configure
error_check `echo $?`

# make
/usr/bin/make clean
/usr/bin/make -j 8
error_check `echo $?`

# make install
sudo /usr/bin/make install
error_check `echo $?`

# /usr/local/bin/bash del
/bin/rm -f /usr/local/bin/bash
/bin/rm -f /usr/local/bin/bashbug

# backup original bash
/bin/cp -f /bin/bash /bin/bash_ori_$odate

# new bash copy
if [ -f bash ]; then
    /bin/cp -f ./bash /bin/bash
else
    echo "compile error, cannot find compiled bash file";
    exit
fi

# logrotate add. string add a first line #
string_check bash_audit /etc/logrotate.d/syslog
if [ $string != 0 ]; then
    /bin/sed -i -e '1i /var/log/bash_audit' /etc/logrotate.d/syslog
fi


# syslog add & restart
# CentOS 5.x : /etc/syslog.conf
# CentOS 6.x : /etc/rsyslog.conf

if [ -f /etc/rsyslog.conf ]; then
    string_check bash_audit /etc/rsyslog.conf
    if [ $string != 0 ]; then
        echo "# bash command audit" >> /etc/rsyslog.conf
        echo "local1.*                                                /var/log/bash_audit" >> /etc/rsyslog.conf
		echo -e "\e[1;32;40m Rsyslogd restart \e[0m"
        /etc/init.d/rsyslog restart
    fi
fi

if [ -f /etc/syslog.conf ]; then
    string_check bash_audit /etc/syslog.conf
    if [ $string != 0 ]; then
        echo "# bash command audit" >> /etc/syslog.conf
        echo "local1.*                                                /var/log/bash_audit" >> /etc/syslog.conf
		echo -e "\e[1;32;40m syslogd restart \e[0m"
        /etc/rc.d/init.d/syslog restart
    fi
fi

echo -e "\e[1;32;40m bash install completed \e[0m"
