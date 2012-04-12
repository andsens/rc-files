#!/bin/sh.exe
if [[ $0 != 'bash' && `uname` == 'MINGW32_NT-6.1' ]]; then
	exec bash
fi