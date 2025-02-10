#!/usr/bin/env python3

from pwn import *

{bindings}

context.binary = {bin_name}
context.log_level = "DEBUG"

use_ssh = True
sshuser = "user"
sshhost = "host"
sshport = 22
sshpassword = ""
sshprogramname = ""

remoteaddress = "addr"
remoteip = 1337

def conn():
    if args.LOCAL:
        if args.GDB:
            io = gdb.debug({proc_args})
        else:
            io = process({proc_args})
    elif use_ssh and args.SSH:
        myssh = ssh(sshuser, sshhost, sshport, sshpassword)
        if args.GDB:
            io = gdb.debug("./" + sshprogramname, ssh=myssh)
        else:
            io = myssh.run("./" + sshprogramname)
    else:
        io = remote(remoteaddress,remoteip)

    return io

sl = lambda a: sendline(a)
rcvl = lambda a: recvline(a)
rcvu = lambda a: recvuntil(a.encode())


def main():
    io = conn()

    io.interactive()


if __name__ == "__main__":
    main()
