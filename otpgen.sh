#!/bin/bash

# a bash script to generate cryptographic one-time pads
# depends on base64 and md5sum

# USAGE: otpgen.sh

# a one-time-pad file will be generated in the current directory.
# after printing, the computer system that ran otpgen should be 
# sanitized appropriately. 

# copyright 2013 chaz miller

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.


tmpfile=./otp_tmp_$(date +%s%N)$RANDOM
entropy=$(< /proc/sys/kernel/random/entropy_avail)
if [ $entropy -lt 100 ]; then echo "system entropy is low. Pad randomness may be compromised.
Current entroy: $entropy." ; fi
md5hash=$( base64 < /dev/urandom | sed 's/[^A-Z]//g' | tr -d '\n'| fold -30 | awk {'print $0, " "  NR'} | head -1000 | tee $tmpfile | md5sum | sed 's/ .*//' )

mv $tmpfile ./OTP-md5_$md5hash

echo "file OTP-md5_$md5hash created"


