################################################################################
#!/usr/bin/expect -f

#
# simple little expect script that just
# opens up an ftp connection to ftp.cdrom.com
# logs in as anonymous, sets some defualt
# options, and hands the ftp session off to
# the user...
#
# it aborts if it sees 'Connection refused' come back
# after it sends the open command...
#
# created Fri Sep  3 14:02:14 EDT 1999 mortis@voicenet.com
#

#
# set this to a low number to be vicious -- i.e. only succeed if the
# ftp server is very responsive
#
# the default is 10 seconds
#
# set timeout 1

set host "www.ekenmid.com"
#set host "metalab.unc.edu"
set email "pnward@gmail.com"
set passwd "down"

# you could use the following to prompt the user
# for this information...

#send_user "Email: "
#expect_user -re "(.*)\n"
#set email $expect_out(1,string)

#send_user "Host: "
#expect_user -re "(.*)\n"
#set host $expect_out(1,string)


# start the ftp program

spawn ftp;

# when we see the first 'ftp>' prompt, send the open command...
# if we see command not found, then ftp's not on the path...
expect  "ftp>"
send "open $host\n"

# if connection is refused, just exit
expect {
  "Connection refused"   exit
  timeout                {send_user "connection timed out\n";exit}
  "Connected to"

}

# look for the 'Name (host:user):' prompt...
expect {
  timeout {send_user "connection timed out\n";exit}
  "):"
}
send "down\n"

# look for the password prompt...
expect Password:
send "$passwd\n"

# look for a successful login...
expect {
  timeout {send_user "ftp command timed out\n";exit}
  "login ok"
}

# set some ftp options...
expect ftp>
send "passive\n";

expect ftp>
send "bin\n";

expect ftp>
send "prompt\n";

expect ftp>
send "hash\n";

# now, let the user interact with the ftp session we opened...
expect ftp>
interact

exit
