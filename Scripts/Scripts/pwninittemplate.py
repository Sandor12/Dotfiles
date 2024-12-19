#!/usr/bin/env python3

from pwn import *

{bindings}

context.binary = {bin_name}
context.log_level = "DEBUG"


sshuser = "user"
sshhost = "host"
sshport = 22
sshpassword = ""
sshprogramname = ""


def conn():
    if args.LOCAL:
        if args.GDB:
            io = gdb.debug({proc_args})
        else:
            io = process({proc_args})
    elif args.SSH:
        myssh = ssh(user, host, port, password)
        if args.GDB:
            io = gdb.debug("./" + sshprogramname, ssh=myssh)
        else:
            io = myssh.run("./" + sshprogramname)
    else:
        io = remote("addr", 1337)

    return io


def main():
    io = conn()

    io.interactive()


if __name__ == "__main__":
    main()
