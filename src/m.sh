# detect avx support first, use lscpu, or
# grep -o 'avx[^ ]*' /proc/cpuinfo
# if avx is shown, then use avx=yes else use avx=no in the following line

time make -j3 build ARCH=x86-64 largeboards=yes avx=yes
