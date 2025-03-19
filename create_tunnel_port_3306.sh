#!/bin/bash
# port forward local port 3306 to remote port 3306
ssh i-0cada52cf6dca24b0 -fNT -4 -L 3306:localhost:3306