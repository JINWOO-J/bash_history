# bash history log (command) to rsyslog
- bash 4.4
- LINUX command 감사를 위한 BASH
- BASH에서 입력한 command를 syslog로 전달


##compile
```bash
./compile.sh
```

##syslog output
```c
Aug 11 15:03:56 VM01 -bash[31513]: [ IP:100.100.100.77 LUID=root CUID=root TTY:/dev/pts/0 CWD:/usr/local/src/bash-4.4 ] vi bashhist.c
Aug 11 15:06:05 VM01 -bash[31513]: [ IP:100.100.100.77 LUID=root CUID=root TTY:/dev/pts/0 CWD:/usr/local/src/bash-4.4 ] ls
Aug 11 15:06:52 VM01 -bash[31513]: [ IP:100.100.100.77 LUID=root CUID=root TTY:/dev/pts/0 CWD:/usr/local/src/bash-4.4 ] cat /etc/rsyslog.conf
Aug 11 15:07:56 VM01 -bash[31513]: [ IP:100.100.100.77 LUID=root CUID=root TTY:/dev/pts/0 CWD:/usr/local/src/bash-4.4 ] ls
```
